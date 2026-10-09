// Proxy de busca do Spotify (spec 001, FR-014..FR-017).
// Fluxo Client Credentials: o token pertence ao app, não ao usuário final.
// Variáveis de ambiente: SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET.

const TOKEN_URL = 'https://accounts.spotify.com/api/token';
const SEARCH_URL = 'https://api.spotify.com/v1/search';
const MAX_LIMIT = 10; // limite do modo de desenvolvimento

// cache de token por instância quente (válido ~1h; renova 60s antes)
let cached = { token: null, exp: 0 };

async function getToken() {
  if (cached.token && Date.now() < cached.exp) return cached.token;
  const id = process.env.SPOTIFY_CLIENT_ID;
  const secret = process.env.SPOTIFY_CLIENT_SECRET;
  const basic = Buffer.from(`${id}:${secret}`).toString('base64');
  const r = await fetch(TOKEN_URL, {
    method: 'POST',
    headers: { Authorization: `Basic ${basic}`, 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ grant_type: 'client_credentials' }),
  });
  if (!r.ok) throw new Error(`token ${r.status}`);
  const j = await r.json();
  cached = { token: j.access_token, exp: Date.now() + (j.expires_in - 60) * 1000 };
  return cached.token;
}

function send(res, status, body, extra = {}) {
  res.statusCode = status;
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  for (const [k, v] of Object.entries(extra)) res.setHeader(k, v);
  res.end(JSON.stringify(body));
}

module.exports = async function handler(req, res) {
  if (req.method !== 'GET') return send(res, 405, { error: 'method_not_allowed' }, { Allow: 'GET' });

  if (!process.env.SPOTIFY_CLIENT_ID || !process.env.SPOTIFY_CLIENT_SECRET) {
    return send(res, 503, { error: 'not_configured' });
  }

  const url = new URL(req.url, 'http://localhost');
  const q = (url.searchParams.get('q') || '').trim();
  if (q.length < 1 || q.length > 100) return send(res, 400, { error: 'invalid_query' });
  const limit = Math.min(Math.max(parseInt(url.searchParams.get('limit') || '8', 10) || 8, 1), MAX_LIMIT);

  try {
    const token = await getToken();
    const sp = new URL(SEARCH_URL);
    sp.searchParams.set('q', q);
    sp.searchParams.set('type', 'track');
    sp.searchParams.set('limit', String(limit));
    const r = await fetch(sp, { headers: { Authorization: `Bearer ${token}` } });

    if (r.status === 429) {
      const retry = r.headers.get('Retry-After') || '30';
      return send(res, 429, { error: 'rate_limited' }, { 'Retry-After': retry });
    }
    if (!r.ok) return send(res, 502, { error: 'upstream', status: r.status });

    const data = await r.json();
    const items = (data.tracks?.items || []).map((t) => ({
      id: t.id,
      title: t.name,
      artist: (t.artists || []).map((a) => a.name).join(', '),
      cover: t.album?.images?.[t.album.images.length - 1]?.url || null, // menor imagem
      url: t.external_urls?.spotify || null,
    }));
    return send(res, 200, { items, attribution: 'Dados do Spotify' }, { 'Cache-Control': 'private, max-age=30' });
  } catch (e) {
    // não vaza detalhes internos ao cliente
    return send(res, 502, { error: 'unavailable' });
  }
};

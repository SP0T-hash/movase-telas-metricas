# Documentação: Telas Movase (Prototipos Web/Mobile)

Este documento descreve como cada tela deve funcionar, o comportamento de cada botão/elemento, estados, navegação, dados e considerações de privacidade/UX para manter fidelidade ao app nativo Movase (tokens, estilo e padrões).

## Observações Gerais
- Padrão mobile-first (viewport-fit-cover). Telas otimizadas para iPhone/Android (testadas em 390x844).
- Design System: tokens nativos Movase (light/dark via `color-scheme` + `light-dark()`/dataset `data-theme`). Contrastes corrigidos seguindo design-system.md.
- Navegação SPA por seções (`.screen[data-s]`) com hash (#mapa, #lista, #matches, #pedidos, #favoritos, #chat, #convite, #andamento, #finalizar, #perfil, #checkin, #feito, #avaliar).
- Navegação com pilha (`stack`) + botão Voltar, título dinâmico (`TITLES`), tabs com `aria-current="page"`.
- Acessibilidade: foco visível (`:focus-visible`), alvos touch >= 44x44, contraste AA, `prefers-reduced-motion` respeitado.
- Privacidade: nunca expor localização exata (distâncias aproximadas), ocultar início/fim do percurso por padrão (quando mapa presente), não compartilhar dados de terceiros sem autorização explícita. Registro de percurso ocorre apenas durante atividade iniciada (não antes/depois).
- Limitações: protótipos client-side (HTML/JS/CSS). Sem backend/tempo real entre participantes. Dados simulados para demonstração. Funcionalidades com GPS dependem de permissão do navegador/dispositivo.

## 1. movase-app.html
Tela principal do app (Mapa, Lista, Matches, Pedidos, Favoritos + fluxos Check-in/Avaliar).

### Tela: Mapa (data-s="mapa")
- Mapa SVG estilizado com pins dinâmicos (PINS). Exibe academias/partners próximos.
- Botões mapa: "Recentralizar", "Buscar nesta área" (placeholders funcionais, sem API).
- CTA "Treinar Junto" (#treinar): ao clicar, envia pedido (estado "Enviando..." → "Pedido enviado ✓", feedback com animação sutil). Após ~3.4s volta ao texto original. Não inicia rastreio aqui (abre fluxo de convite/chat).
- Lista "Perto de você agora": itens com foto inicial (av), nome, descrição, distância aproximada (privacidade). Ao clicar, vai para Chat com aquele parceiro (preenche partner/init).

Comportamento: navegação entre tabs (Mapa/Lista/Matches/Pedidos/Favoritos). Hash #mapa.

### Tela: Lista (data-s="lista")
- Lista de pessoas próximas (mesmos dados). Cada linha leva a Chat com parceiro.

### Tela: Matches (data-s="matches")
- Itens com tag "Deu Match!". Cada item navega para `#chat` com dados do parceiro (data-partner/data-init). Botão "Explorar o mapa" volta a #mapa. Seção informativa sobre avaliações.

### Tela: Chat (data-s="chat") — dentro do fluxo app (convite)
- Cabeçalho com avatar/nome do parceiro, meta (ex.: "Convite aceito • Corrida"), tag "Juntos".
- Mensagem de exemplo do convite/aceite.
- Botão "Iniciar treino junto" → direciona para tela de treino (em protótipos separados: movase-treino*.html). No app atual, esse botão pode ser usado para navegar ao fluxo de treino.
- Botão "Voltar" → volta à tela anterior (stack).

Estados de convite (visão UI): pendente/aceito/recusado/cancelado/concluído/expirado podem ser representados por texto/meta/tag (ex.: "Convite pendente", "Convite aceito", "Convite recusado", "Convite cancelado", "Expirado", "Concluído"). No estado atual são apenas visuais/textuais (client-side).

### Tela: Pedidos (data-s="pedidos")
- Card com pedido recebido: mostra avatar, nome, mensagem ("Quer treinar junto amanhã, 19h"), ações "Aceitar" / "Recusar". Texto de fallback/erro exibido abaixo.
- Estados: pendente (mostra ações), aceito/recusado (deveriam atualizar card sem recarregar). Protótipo demonstra layout; lógica de estado não persiste entre reloads.

### Tela: Favoritos (data-s="favoritos")
- Lista de favoritos. Itens clicáveis (navegam para avaliar/perfil conforme fluxo).

### Tela: Check-in (data-s="checkin")
- Segmentado por modalidade (Musculação/Calistenia/Corrida), academia do dia (opcional) ou "Sem academia". Botões primários para registrar check-in/compartilhar card (placeholders).

### Tela: Feito (data-s="feito")
- Confirmação "Treino registrado!". Exibe card de passe (código MOVASE-7K2Q) com CTA "Compartilhar card".

### Tela: Avaliar (data-s="avaliar")
- Avaliação por estrelas (halteres) 1–5. Seleção define `aria-pressed` e habilita botão "Avaliar treino". Badges opcionais (multi-seleção). Ao salvar: texto muda para "Salvo ✓", desabilita, redireciona para #matches após 900ms (com reset após 1.6s).

### Navegação/Tabs
- Tabs: Mapa, Lista, Matches, Pedidos, Favoritos. `aria-current="page"` no ativo. Chat/Convite não aparecem na tabbar (fluxos contextuais).

## 2. movase-treino.html
Versão simplificada do treino (sem Mapbox). Foco em UX de convite/chat/andamento/finalizar/perfil.

### Mapa/Convite (data-s="mapa")
- Segmentado por modalidade (Corrida/Musculação/Calistenia/Ciclismo). Seleção atual com `aria-pressed=true`.
- Lista "Matches" com botão "Chamar" → vai para #chat.

### Chat (data-s="chat")
- Exibe parceiro, estado "Rafa aceitou o convite", modalidade selecionada.
- Botão "Iniciar treino junto" → vai para #andamento.
- Botão "Voltar" → volta ao mapa/convite.

### Treino em andamento (data-s="andamento")
- Cronômetro simples (setInterval 1s). Exibe Tempo (HH:MM:SS) e Km (calculado ~t/600). "Pace"/"Ritmo atual" são placeholders.
- Botão "Finalizar treino" → vai para #finalizar.
- Ao entrar em andamento, cronômetro reseta e inicia. Ao sair para finalizar/perfil, para.

### Finalizar (data-s="finalizar")
- Comparação lado a lado Você x Parceiro com Distância/Tempo/Pace. Valores simulados (6,84 km / 38m12s / 5'35"/km vs parceiro).
- Botões: "Salvar no histórico" (navega para #perfil), "Compartilhar" (placeholder), "Voltar" (volta a andamento).

### Perfil (data-s="perfil")
- Avatar, nome, stats (km totais, treinos, parceiros). Lista "Histórico de treinos em conjunto" vazia/placeholder. Botão "Editar perfil" (placeholder).

### Navegação/Tabs
- Tabs: Mapa, Chat, Treino, Perfil. `aria-current` dinâmico.

### Detalhes técnicos
- Tema toggle (light/dark) com persistência em `localStorage` movase-theme (herda prefers-color-scheme).
- Estados visuais mínimos, sem mapa real (apenas placeholder "Mapa (simulado)").

## 3. movase-treino-mapbox.html
Fluxo completo "Treinar Junto" com rastreio GPS em tempo real + MapLibre + histórico.

### Mapa/Convite (data-s="mapa")
- Segmentado por modalidade (Corrida/Musculação/Calistenia/Ciclismo). Seleção atualiza `#chatMod`, `#runMod`. Estado `aria-pressed`.
- Lista "Matches" com botões "Chamar" (data-goto="chat" com partner/init). Ao clicar, preenche Chat (nome/avatar/mod).

### Chat (data-s="chat")
- Cabeçalho dinâmico (#chatAv, #chatName, #chatMod, #chatTag). Mensagem exemplo.
- Botão "Iniciar treino junto" (#btnStart) → inicia rastreamento e vai para #andamento.
- Botão "Voltar" → #mapa.

### Treino em andamento (data-s="andamento")
- Mapa ao vivo (MapLibre GL). Inicialização: style `https://demotiles.maplibre.org/style.json`, centro em localização atual ou fallback, `geolocate` com alta precisão. Camada `loc` (círculo azul) atualizada a cada posição.
- Painel topo: Status (#status: Pronto/Rastreando/Pausado/Finalizado), Precisão (#acc em metros).
- Métricas ao vivo: Distância (#kmLive em km), Tempo (#timeLive HH:MM:SS), Pace (#paceLive min/km).
- Ações: "Pausar"/"Retomar" (#btnPause), "Finalizar" (#btnStop).
- Lógica GPS:
  - `navigator.geolocation.watchPosition` com `enableHighAccuracy:true`, `maximumAge:1000`, `timeout:15000`. Em erro exibe "Permissão de localização necessária".
  - Só registra movimento quando `running && !paused`. Filtra saltos irreais: distância entre pontos entre 2m e 80m (evita ruídos/jumps). Primeiro ponto adicionado direto.
  - `coords[]` armazena [lng, lat]. `distM` acumula em metros (Haversine). `elapsed` em segundos (incrementado via setInterval 1s).
  - Desenha/atualiza polyline no mapa ao vivo (`route`) a cada atualização válida.
  - Ao pausar/retomar atualiza status e rótulo botão. Ao finalizar: para watch, desabilita running, atualiza status, calcula métricas finais, popula tela Finalizar e vai para #finalizar.

Cálculos: `hav()` Haversine (metros). `fmtKm(m)=m/1000.toFixed(2)`. `fmtTime(s)=HH:MM:SS`. `paceMinPerKm(m,s)=min/km` ou `--'--` se s<=0 ou m<=0. `spdKmh(m,s)=km/h`.

### Finalizar (data-s="finalizar")
- Mapa final (#mapFinal) com polyline completo (`routeF`), marcadores Start (accent) e End (place-blue). Aplica `fitBounds` ao bbox do trajeto (padding 40, duration 500). Carrega após DOMContentLoaded.
- Comparação lado a lado Você x Parceiro:
  - Você: #fKmYou, #fTimeYou, #fPaceYou, #fSpdYou (preenchidos com dados reais: distM/elapsed)
  - Parceiro: #fKmB, #fTimeB, #fPaceB, #fSpdB (simulados coerentes: tB ~ elapsed*0.94, dB ~ distM*0.995)
- CTA "Salvar no histórico" (#btnSaveHist): cria item `{ts, mod, partner, distM, coords:[...], tYou, dYou, tB, dB}` e salva em `localStorage.movase_hist_v1` (mantém últimos 50). Então navega para #perfil.
- Botões "Compartilhar treino" (placeholder) e "Voltar ao mapa" (#mapa).

Privacidade no compartilhamento (UI): "Ocultar início e fim do percurso" aparece como opção (checkbox) — por padrão não expõe local exato; percurso pode ser ocultado. Não há compartilhamento automático de dados de terceiros.

### Perfil (data-s="perfil")
- Cabeçalho com avatar "VC", nome "Você", meta "Movase • N treinos" (#histCount).
- Lista histórico (#histList) renderizada por `renderHist()`:
  - Para cada item: mini-mapa estático com polyline do trajeto (usa MapLibre com `interactive:false`, style demo, `fitBounds` com padding 20). Mostra mod, distância, data/hora pt-BR, parceiro, comparação Você vs Parceiro (tempo + pace).
  - Tag "VS".
  - Se vazio, exibe mensagem (#histEmpty).
- Botão "Editar perfil" (placeholder).

Persistência: `movase_hist_v1` (JSON). Ao carregar, renderiza histórico. Mini-mapas criados dinamicamente por item.

### Navegação/Tabs
- Tabs: Mapa, Chat, Andamento, Finalizar, Perfil. `aria-current` dinâmico. Hash suporta #mapa/#chat/#andamento/#finalizar/#perfil.

## 4. movase-treino.html (comparação)
Sem mapa; foca em fluxo de convite+treino com cronômetro simulado. Estados de convite visíveis no chat ("Rafa aceitou o convite", modalidade). Botões seguem mesma lógica data-goto (mapa/chat/andamento/finalizar/perfil). Tabs Mapa/Chat/Treino/Perfil.

## 5. movase-strava-native.html
Card "Compartilhar treino" estilo Strava mas 100% fiel ao design system Movase. Split VS (Você x Parceiro), métricas (Distância/Tempo/Pace/Vel. média), percurso com mapa estático (placeholder SVG), opções de privacidade (ex.: "Ocultar início e fim do percurso"), CTA "Compartilhar". Dark/light respeita tokens.

## 6. movase-duo.html
Comparativo multiesporte (Corrida/Musculação/Calistenia/Ciclismo). Navegação por segmento, gráficos/barras, mapa por esporte, CTA contextual. Responsivo mobile-first, foco acessível, animações condicionais a prefers-reduced-motion.

## Estados de Convite (UI)
Cartão de convite no chat deve suportar estados: pendente, aceito, recusado, cancelado, concluído, expirado.
- Pendente: exibe "Convite pendente", botões Aceitar/Recusar (quando recebido), ou "Aguardando resposta" (quando enviado).
- Aceito: "Convite aceito • [Modalidade]".
- Recusado: "Convite recusado".
- Cancelado: "Convite cancelado".
- Expirado: "Convite expirado".
- Concluído: "Treino concluído".

Implementação atual: majoritariamente visual/textual (client-side). Em app nativo real, estes estados vêm do servidor com autorização/permissões.

## Registro Individual x Dupla
- Cada participante mantém seu próprio registro (distância/tempo/pace calculados individualmente). No resumo conjunto (Finalizar) diferenciam-se Você x Parceiro (não idênticos).
- Suporte a iniciar individual sem convite/match (fluxo Check-in/registrar treino em movase-app.html).
- Considerações: GPS indisponível, permissões negadas (mensagem clara), pausas/retomadas, perda de conexão, horários diferentes, não rastrear antes de iniciar nem após encerrar.

## Privacidade (Obrigatória)
- Não expor percurso/local exato por padrão.
- Opção de ocultar início/fim do percurso (UI presente em compartilhamento).
- Não compartilhar nome/perfil/imagem/métricas de terceiros sem autorização explícita.
- Compartilhamento de uma pessoa não autoriza publicação dos dados da outra.
- Respeitar controles existentes; apagar atividades/dados conforme regras.

## Testes/Validação
- WebKit (iPhone): checagens já executadas (check-webkit.js) — sem erros críticos.
- Light/Dark, prefers-color-scheme, prefers-reduced-motion, foco visível, overflow, alvos >=32–44px, contraste AA.
- Navegação por hash, voltar com stack, persistência tema/localStorage (movase-theme, movase_hist_v1).

## Notas de Implementação (Limitações)
- Protótipos HTML não possuem backend (auth, matches realtime, servidor de atividades). Apenas UI + lógica client-side.
- MapLibre usa tiles demo (https://demotiles.maplibre.org/style.json) — para produção usar estilo próprio + chaves válidas.
- Simulações (métricas parceiro) são apenas para demonstração visual.

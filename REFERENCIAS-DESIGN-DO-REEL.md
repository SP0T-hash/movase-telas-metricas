# Referências de design encontradas no Reel

O vídeo do perfil `@sujeitoprogramador` apresenta o título “Top 5 sites pra desenvolver design profissional com IA”, mas mostra apenas quatro referências numeradas.

| Referência | Utilidade prática | Como usar com OpenCode |
|---|---|---|
| [MotionSites.ai](https://motionsites.ai/) | Galeria de sites 3D animados; o vídeo destaca prompts prontos para copiar e adaptar. | Usar para escolher direção visual, motion e prompts de referência antes de pedir a implementação. |
| [CTA Gallery](https://www.cta.gallery/) | Inspiração para CTAs, botões, banners e seções de conversão. | Consultar ao desenhar hero, pricing, cadastro, checkout e chamadas de ação. |
| [Unsection](https://unsection.com/) | Biblioteca de seções de sites, como hero, features e pricing. | Escolher referências por seção e descrevê-las para a Taste Skill ou Impeccable. |
| [60fps.design](https://60fps.design/) | Coleção de animações e microinterações de interfaces iOS e web. | Consultar para definir transições, hover, feedback e motion; depois pedir ao Emil Kowalski skill para implementar com moderação. |

## O que é relevante para o setup

Esses quatro endereços **não são skills, plugins nem MCPs**. São sites de pesquisa visual. Portanto, não precisam ser instalados no OpenCode e não alteram o `opencode.jsonc`.

O fluxo recomendado é:

1. Pesquisar referências no MotionSites, CTA Gallery, Unsection e 60fps.design.
2. Copiar links ou screenshots das referências escolhidas para o projeto.
3. Pedir à `design-taste-frontend` uma direção visual própria, sem copiar literalmente a referência.
4. Usar `impeccable` para revisar hierarquia, tipografia, espaçamento, layout e conversão.
5. Usar `emil-design-eng` para decidir quais interações merecem animação e como implementá-las.
6. Usar o Playwright MCP para abrir a aplicação, testar responsividade e capturar screenshots.

## Inconsistência do vídeo

O título promete cinco sites, mas a sequência exibida termina em `04 / 04`. Não há um quinto site identificável no material acessível.

Os quatro endereços responderam com HTTP 200 quando verificados em 22/09/2026.

# Creative UI Workflow

Estas regras orientam o agente quando a tarefa envolver frontend, UI, UX, landing page, dashboard, protótipo, redesign, branding visual ou qualquer pedido criativo.

## Princípio geral

Não produzir uma interface genérica por padrão. Antes de codificar, definir uma direção visual explícita: público, objetivo, tom, densidade, contraste, tipografia, paleta, ritmo de espaçamento, componentes-chave e comportamento em telas pequenas.

## Skills a usar

Carregar as skills conforme a tarefa:

- `design-taste-frontend`: usar para definir uma direção original, evitar padrões genéricos de IA, escolher variação visual e revisar a composição geral.
- `impeccable`: usar para auditar ou melhorar tipografia, hierarquia, layout, espaçamento, cor, acessibilidade, responsividade e qualidade visual.
- `emil-design-eng`: usar para decisões de motion, microinterações, transições, easing, duração e polimento de componentes. Não adicionar animação sem propósito.
- `ponytail`: usar para evitar overengineering, reduzir código desnecessário e revisar diffs por complexidade excessiva. Não sacrificar clareza, segurança ou testes para economizar tokens.
- `using-agent-skills`: usar para mapear a tarefa às skills de engenharia de Addy Osmani.
- `spec-driven-development` e `idea-refine`: usar antes de projetos novos ou briefings vagos.
- `planning-and-task-breakdown` e `incremental-implementation`: usar para mudanças que envolvam vários arquivos.
- `frontend-ui-engineering`: usar em interfaces e sistemas de design.
- `test-driven-development`, `test` e `review` equivalentes do pacote: usar para verificar comportamento e qualidade antes de concluir.
- `graphify`: usar em codebases grandes ou quando for útil criar um mapa estrutural persistente antes de navegar repetidamente pelos arquivos.

Em um trabalho novo de interface, usar pelo menos `design-taste-frontend` e `impeccable`. Usar `emil-design-eng` quando houver interação, animação ou estados de componente.

Para uma feature de produção, preferir o ciclo: especificar → planejar → implementar em fatias → testar → revisar → simplificar → publicar. O pacote de Agent Skills de Addy Osmani fornece essas etapas e deve ser carregado conforme o tipo de tarefa, não necessariamente inteiro em cada prompt.

## Sites de referência

Consultar estes sites somente quando a tarefa precisar de inspiração ou benchmark visual. Eles são referências, não dependências:

- MotionSites.ai — https://motionsites.ai/ — experiências 3D, motion e prompts de referência.
- CTA Gallery — https://www.cta.gallery/ — CTAs, botões e conversão.
- Unsection — https://unsection.com/ — referências por seção de página.
- 60fps.design — https://60fps.design/ — microinterações e animações web/iOS.

Graphify não é uma biblioteca de UI: é uma ferramenta opcional de contexto para mapear o código, a documentação e outros artefatos do projeto. Use `/graphify .` somente quando o repositório justificar o custo de gerar o mapa.

Se houver Playwright MCP disponível, abrir o site e capturar referências; caso contrário, usar os links como contexto e pedir ao usuário screenshots ou exemplos. Nunca copiar literalmente um design protegido: extrair princípios, estrutura e comportamento e criar uma solução original.

## Processo recomendado

1. Interpretar o briefing e declarar a direção visual escolhida.
2. Se necessário, consultar uma ou duas referências relevantes, não todas indiscriminadamente.
3. Carregar as skills apropriadas antes de implementar.
4. Criar primeiro a estrutura e o sistema visual; evitar componentes isolados sem contexto.
5. Implementar estados de hover, foco, erro, vazio, carregamento e responsividade.
6. Usar Playwright MCP para testar a aplicação local, verificar console e capturar screenshots.
7. Fazer uma revisão final com Impeccable e corrigir os problemas encontrados.

## Regras de qualidade

- Não usar gradientes, glassmorphism, roxo neon, cards arredondados ou fontes genéricas apenas porque são defaults comuns de IA.
- Não inventar referências, URLs, plugins ou capacidades que não estejam disponíveis.
- Preferir uma hierarquia tipográfica clara e tokens consistentes.
- Motion deve melhorar orientação, feedback ou narrativa; respeitar `prefers-reduced-motion`.
- Preservar funcionalidade existente durante redesigns.
- Antes de concluir, verificar contraste, teclado, mobile, estados de interação e ausência de placeholders.

## Como pedir uma revisão

Se slash commands não estiverem disponíveis, usar linguagem natural:

> Use a skill Impeccable para auditar esta interface e corrija tipografia, espaçamento, hierarquia, responsividade e sinais de design genérico.

> Use a skill do Emil Kowalski para revisar as animações desta interface. Adicione motion apenas onde houver benefício claro e respeite reduced motion.

> Use a Taste Skill para propor uma direção visual original para este briefing antes de escrever o código.

# Feature Specification: Perfil de Usuário Personalizável

**Feature Branch**: `001-perfil-personalizavel`

**Created**: 2026-10-09

**Status**: Draft

**Input**: "Quero fazer o perfil de usuário mais personalizável. O Tinder tem uma boa referência com os dados, até a opção de colocar música que você gosta de ouvir para treinar."

## Referências consultadas

Pesquisa pública (Tinder, 2026) usada como referência de padrões, não de identidade visual:

- Fotos (até 9), bio (até 500 caracteres) e prompts (até 3 de ~18 opções, 124 caracteres cada).
- Interesses: seleção de 3 a 5 itens a partir de uma lista.
- Anthem: uma música do Spotify no perfil, escolhida por busca.
- Music Mode: conexão por gosto musical compartilhado, com até 20 músicas.
- Profile completion: orientação para completar o perfil; perfis completos recebem mais matches.
- Visual Interests: mostrar séries, filmes e jogos favoritos com imagens.
- Tinder Connect: integrações com apps externos (Spotify, Duolingo, Beli).

Adaptação para o Movase: o foco é treino, não namoro. Os campos são pensados para parceiros de treino (modalidade, nível, horários, local aproximado, música para treinar, metas).

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Editar dados básicos e foto do perfil (Priority: P1)

Como usuário, quero editar meu nome, foto, bio curta e cidade/bairro (aproximado) para que outros treinos me reconheçam antes de combinar um treino.

**Why this priority**: sem identidade mínima o usuário não é confiável para treinar junto. É a base de todas as outras funções.

**Independent Test**: abrir "Editar perfil", alterar nome e bio, salvar e verificar que o perfil exibido e o cartão do convite refletem a mudança.

**Acceptance Scenarios**:

1. **Given** um usuário no perfil, **When** toca em "Editar perfil" e altera o nome, **Then** o novo nome aparece no perfil e no cabeçalho de chat após salvar.
2. **Given** a bio com mais de 300 caracteres, **When** o usuário tenta salvar, **Then** o sistema bloqueia o salvamento e mostra o limite e o contador.
3. **Given** o usuário não envia foto, **When** salva o perfil, **Then** o avatar mostra as iniciais sem quebrar o layout.

---

### User Story 2 - Música para treinar (Priority: P1)

Como usuário, quero escolher músicas que gosto de ouvir treinando (até 3 para destaque e até 20 na lista) para que outros treinos identifiquem meu gosto e para que eu tenha uma trilha no treino.

**Why this priority**: é o diferencial pedido e o principal sinal de compatibilidade relatado na pesquisa.

**Independent Test**: adicionar uma música, marcar uma como "Música de treino", ver o destaque no perfil e iniciar um treino com a trilha vinculada.

**Acceptance Scenarios**:

1. **Given** o usuário em "Música para treinar", **When** pesquisa e seleciona uma música, **Then** ela entra na lista e pode ser marcada como destaque (máximo 3 destaques).
2. **Given** a lista com 20 músicas, **When** o usuário tenta adicionar outra, **Then** o sistema mostra o limite e não adiciona.
3. **Given** o usuário sem conta de streaming conectada, **When** abre a busca, **Then** pode escolher músicas por título e artista de um catálogo, sem exigir login de terceiro.
4. **Given** o usuário escolhe uma música de treino, **When** inicia um treino, **Then** a trilha aparece no treino com controle de pausar e trocar, respeitando a permissão do serviço de música.

---

### User Story 3 - Modalidades, nível e disponibilidade (Priority: P2)

Como usuário, quero informar modalidades que pratico, nível (iniciante, intermediário, avançado) e dias/horários em que treino, para receber sugestões de parceiros compatíveis.

**Why this priority**: melhora a qualidade dos convites, mas depende de identidade básica (P1).

**Independent Test**: marcar corrida e musculação, nível intermediário e terça/quinta às 19h, salvar e verificar os filtros no mapa.

**Acceptance Scenarios**:

1. **Given** o usuário seleciona 3 modalidades, **When** salva, **Then** as modalidades aparecem no perfil e nos filtros do mapa.
2. **Given** um horário marcado, **When** outro usuário abre o perfil, **Then** vê apenas o dia da semana e a faixa de horário, nunca a agenda completa.

---

### User Story 4 - Prompts e metas de treino (Priority: P2)

Como usuário, quero responder até 3 prompts curtos (ex.: "Meu treino ideal é...", "O que me motiva é...") e definir uma meta (ex.: correr 10 km, ganhar carga), para criar conversa inicial com parceiros.

**Why this priority**: gera conversa e comunica objetivo, sem depender de mídia.

**Independent Test**: responder 2 prompts, definir uma meta e confirmar que aparecem no perfil público.

**Acceptance Scenarios**:

1. **Given** um prompt respondido com mais de 124 caracteres, **When** o usuário tenta salvar, **Then** o sistema bloqueia e mostra o contador.
2. **Given** nenhuma meta definida, **When** o perfil é exibido, **Then** a seção de metas fica oculta (não mostra placeholder vazio).

---

### User Story 5 - Galeria e interesses (Priority: P3)

Como usuário, quero adicionar até 6 fotos de treino e escolher de 3 a 5 interesses (ex.: corrida de rua, yoga, ciclismo, nutrição) para mostrar quem sou fora do treino.

**Why this priority**: enriquece o perfil, mas não é necessário para treinar junto.

**Independent Test**: enviar 3 fotos, reordenar, escolher 4 interesses e verificar a ordem no perfil.

**Acceptance Scenarios**:

1. **Given** 6 fotos enviadas, **When** o usuário tenta enviar a sétima, **Then** o botão fica desabilitado com a mensagem do limite.
2. **Given** o usuário seleciona 2 interesses, **When** tenta salvar, **Then** o sistema pede de 3 a 5 interesses.

---

### User Story 6 - Privacidade e controle do que é público (Priority: P1)

Como usuário, quero escolher o que é visível para outros treinos (foto, música, horário, bairro, histórico) para controlar minha exposição.

**Why this priority**: obrigatório para um app que aproxima pessoas em tempo real e por localização.

**Independent Test**: desmarcar "Mostrar horário" e "Mostrar histórico", abrir o perfil como outro usuário e confirmar que esses dados não aparecem.

**Acceptance Scenarios**:

1. **Given** "Mostrar bairro" desativado, **When** outro usuário vê o perfil, **Then** a distância aparece apenas como faixa (ex.: "até 1 km"), nunca o bairro.
2. **Given** histórico de treinos desativado, **When** outro usuário vê o perfil, **Then** a seção de treinos não é exibida.
3. **Given** o usuário remove uma música ou foto, **When** outro usuário recarrega o perfil, **Then** o item não aparece mais.

---

### Edge Cases

- O que acontece quando o serviço de música está indisponível? A lista mostra o último estado salvo, com aviso "Não foi possível carregar músicas agora".
- Usuário sem permissão de localização: o perfil mostra "Localização desativada" e não tenta obter posição.
- Edição simultânea em dois dispositivos: a última gravação vence, com aviso ao carregar versão mais nova.
- Foto com formato não suportado ou muito grande: rejeitada com mensagem clara antes do upload.
- Conteúdo ofensivo em bio ou prompt: enviado para revisão e ocultado até aprovação.
- Remoção de conta: dados de perfil, fotos e músicas são apagados junto com o histórico.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema DEVE permitir editar nome, foto, bio (máx. 300 caracteres), cidade e bairro aproximado.
- **FR-002**: O sistema DEVE permitir até 20 músicas na lista de treino e até 3 destaques.
- **FR-003**: Ao buscar música, o sistema DEVE retornar título, artista e capa, e DEVE respeitar os termos do serviço de música usado.
- **FR-004**: O sistema DEVE permitir selecionar modalidades (corrida, musculação, calistenia, ciclismo, outras), nível (3 opções) e disponibilidade semanal (dia e faixa de horário).
- **FR-005**: O sistema DEVE permitir até 3 prompts de 124 caracteres cada, escolhidos de uma lista curada.
- **FR-006**: O sistema DEVE permitir definir uma meta de treino com tipo, valor e prazo opcional.
- **FR-007**: O sistema DEVE permitir até 6 fotos, com reordenação e remoção.
- **FR-008**: O sistema DEVE exigir de 3 a 5 interesses para salvar o perfil.
- **FR-009**: O sistema DEVE oferecer controles de privacidade por campo (foto, música, bairro, horário, histórico, metas), com padrão "não público" para horário e bairro.
- **FR-010**: O sistema NUNCA DEVE expor localização exata, endereço ou agenda completa de outro usuário.
- **FR-011**: O sistema DEVE mostrar progresso de completude do perfil (ex.: 4 de 6 etapas) com orientação do próximo passo.
- **FR-012**: O sistema DEVE exibir o perfil público como outro usuário veria, em modo de pré-visualização.
- **FR-013**: O sistema DEVE mostrar a música de treino no cabeçalho do chat e no início de um treino combinado.
- **FR-014**: A busca de músicas DEVE usar a Spotify Web API por meio de um proxy no servidor (função serverless). O client secret NUNCA DEVE ir ao navegador nem ao repositório.
- **FR-015**: A busca DEVE usar o fluxo Client Credentials (token do app, sem login do usuário). O usuário final NÃO precisa ter conta Spotify para escolher músicas.
- **FR-016**: O sistema DEVE limitar os resultados a 10 por busca (limite do modo de desenvolvimento) e DEVE exibir a atribuição "Dados do Spotify" nos resultados.
- **FR-017**: Se o proxy não estiver configurado ou falhar, o sistema DEVE cair para o catálogo de demonstração e informar isso ao usuário, sem quebrar a tela.
- **FR-018**: A reprodução de áudio NÃO faz parte deste escopo: a música é escolhida, exibida com capa e título, e não tocada dentro do app.

### Key Entities *(include if feature involves data)*

- **Perfil**: nome, foto principal, bio, cidade, bairro aproximado, nível, completude, preferências de privacidade.
- **Música de treino**: título, artista, capa, identificador do serviço, destaque (sim/não), ordem.
- **Disponibilidade**: dia da semana, faixa de horário, visível (sim/não).
- **Prompt**: pergunta (da lista curada), resposta, ordem.
- **Meta de treino**: tipo (distância, carga, frequência), valor, prazo opcional.
- **Foto**: referência de armazenamento, ordem, status de revisão.
- **Interesse**: identificador da lista curada.
- **Preferência de privacidade**: campo, visibilidade (público, parceiros de treino, privado).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: O usuário conclui a edição de nome, foto, bio e uma música em menos de 3 minutos na primeira vez.
- **SC-002**: 80% dos usuários com perfil completo (6 etapas) chegam a enviar ou receber um convite de treino na primeira semana.
- **SC-003**: Nenhum campo marcado como privado aparece no perfil público em testes de regressão (0 vazamentos).
- **SC-004**: O formulário de perfil funciona sem erro em iPhone (WebKit) e Android (Chromium) nas larguras 360 px e 390 px, em tema claro e escuro.
- **SC-005**: Todos os alvos de toque têm pelo menos 44x44 px e contraste de texto AA (4.5:1).

## Assumptions

- Spotify Web API em modo de desenvolvimento (gratuito). Restrições verificadas em 2026: o dono do app precisa de Spotify Premium; o limite de usuários (5) e a allowlist valem para tokens de usuário, não para client credentials; a cota é compartilhada por conta de desenvolvedor; `/search` aceita no máximo 10 resultados.
- Publicação para público amplo exige "extended quota", que a Spotify só aceita de organizações com serviço ativo e pelo menos 250 mil usuários ativos por mês. Fora do escopo deste spec; sem isso o app continua limitado no modo de desenvolvimento.
- Se o dono do app perder o Premium, as chamadas param de funcionar até a reativação.
- Moderação de fotos e textos é feita por revisão automática com revisão humana para denúncias. A implementação dessa moderação está fora do escopo deste spec.
- O app já tem autenticação e identificador de usuário. Este spec não cria login.
- O protótipo atual (`movase-treino*.html`) é client-side. Persistência real exige backend, que não existe neste workspace.
- A identidade visual segue os tokens Movase (`design-system.md`): laranja de ação, Roboto, raios de 8/20/pill, light e dark via `light-dark()`.
- Não copiamos interface, textos ou marca de nenhum app de referência.
</content>

# Feature Specification: Perfil de Parceiro de Treino (v2)

**Feature Branch**: `001-perfil-personalizavel`

**Created**: 2026-10-09 · **Revised**: 2026-10-09 (v2, decisões de produto)

**Status**: Draft

**Input**: "Quero o perfil mais personalizável. O Tinder é referência só pela possibilidade de personalizar, incluindo música para treinar. Não pode parecer Tinder: tem que combinar com o Movase e com o design system."

## Princípio de produto

O perfil responde a uma pergunta: **"posso confiar e treinar com essa pessoa?"**. Não é um cartão de atração. Personalização serve para compatibilidade e confiança, não para estética.

## Decisões de produto (v2)

| Item | Decisão | Motivo |
|---|---|---|
| Confiabilidade e avaliações | **P1**. Mostrar presença (treinos combinados concluídos), avaliações de parceiros e badges | Principal sinal de confiança para um desconhecido. Movase já tem o fluxo de avaliação |
| Compatibilidade de treino | **P1**. Modalidades, nível, ritmo, disponibilidade e bairro aproximado | Usado para sugerir parceiros (matching por modalidade, nível, agenda e raio) |
| Segurança | **P1**. Verificação de perfil, bloquear, denunciar, contato de confiança | Encontro presencial com desconhecido |
| Música de treino | **P2**. Trilha de até 20 faixas, 3 destaques, fora do topo do perfil | Personalização pedida. Valor real, mas secundário para confiança |
| Frase de treino | **P2**. 1 frase curta, não 3 prompts | Dá contexto sem virar "perfil de namoro" |
| Meta de treino | **P2** | Motivação intrínseca se associa a retenção (PMC12828317) |
| Galeria de fotos | **Removido**. 1 foto opcional | Galeria de 6 fotos é padrão de app de encontro |
| Interesses 3–5 | **Removido** | Pouco útil para decidir treinar junto |
| Visual interests (filmes, séries, jogos) | **Fora** | Sem relação com treino |

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Identidade de treino (Priority: P1)

Como usuário, quero dizer o que treino, em que nível, com que ritmo e quando, para que sugestões de parceiros sejam compatíveis.

**Independent Test**: marcar corrida (ritmo 5'30"/km), nível intermediário, terça e quinta 19h–21h e verificar o resumo "Treina ter/qui 19–21h · Corrida · Intermediário" no perfil.

**Acceptance Scenarios**:

1. **Given** o usuário marca 3 modalidades, **When** salva, **Then** o perfil mostra as 3 e os filtros de mapa as usam.
2. **Given** ritmo informado para corrida, **When** outro usuário vê o perfil, **Then** vê a faixa de ritmo, não o histórico completo.
3. **Given** horário marcado e "Mostrar horário" desativado, **When** outro usuário vê o perfil, **Then** o horário aparece como "Oculto".

---

### User Story 2 - Confiabilidade e avaliações (Priority: P1)

Como usuário, quero que outros vejam se eu apareço nos treinos combinados, para que confiem em mim antes do primeiro encontro.

**Independent Test**: um treino combinado concluído e uma avaliação recebida; o perfil mostra "1 treino concluído" e a avaliação, com o botão de avaliar desativado para quem não treinou junto.

**Acceptance Scenarios**:

1. **Given** nenhum treino concluído, **When** o perfil é exibido, **Then** o bloco mostra "Ainda sem treinos juntos" (sem zero em destaque).
2. **Given** avaliações recebidas, **When** o perfil é exibido, **Then** mostra média e número de avaliações, e as avaliações com badges escolhidas pelos parceiros.
3. **Given** um cancelamento em cima da hora, **When** o histórico é calculado, **Then** aparece como "cancelado" e não como falta, para não punir imprevistos.

---

### User Story 3 - Segurança e privacidade (Priority: P1)

Como usuário, quero controlar o que é público e ter ferramentas de segurança, para treinar com desconhecidos sem expor minha rotina.

**Independent Test**: desmarcar "Mostrar horário" e "Mostrar histórico"; abrir a pré-visualização pública e confirmar que eles não aparecem.

**Acceptance Scenarios**:

1. **Given** "Mostrar bairro" desativado, **When** outro usuário vê o perfil, **Then** a distância aparece só como faixa ("até 1 km").
2. **Given** um contato de confiança configurado, **When** um treino combinado começa, **Then** o contato pode receber localização compartilhada apenas durante o treino (aceite explícito).
3. **Given** um perfil denunciado, **When** o usuário bloqueia, **Then** o perfil some dos dois lados.
4. **Given** verificação concluída, **When** o perfil é exibido, **Then** mostra o selo "Verificado"; sem verificação, não mostra selo.

---

### User Story 4 - Música de treino (Priority: P2)

Como usuário, quero escolher a trilha do meu treino, para que parceiros conheçam meu gosto antes de treinar.

**Independent Test**: buscar uma música, adicionar, destacar e iniciar um treino combinado com a trilha exibida.

**Acceptance Scenarios**:

1. **Given** lista com 20 músicas, **When** o usuário tenta adicionar outra, **Then** o sistema mostra o limite.
2. **Given** 3 destaques, **When** o usuário tenta um quarto, **Then** o sistema bloqueia e explica.
3. **Given** a busca Spotify indisponível, **When** o usuário busca, **Then** o catálogo de demonstração é usado com aviso.

---

### User Story 5 - Frase e meta (Priority: P2)

Como usuário, quero uma frase curta sobre meu treino e uma meta, para começar uma conversa com contexto.

**Acceptance Scenarios**:

1. **Given** frase com mais de 120 caracteres, **When** o usuário salva, **Then** o sistema bloqueia e mostra o contador.
2. **Given** nenhuma meta, **When** o perfil é exibido, **Then** a seção de meta fica oculta.

---

### Edge Cases

- Sem permissão de localização: perfil mostra "Localização desativada" e não tenta obter posição.
- Edição em dois dispositivos: última gravação vence, com aviso.
- Denúncia de conteúdo ofensivo em frase ou foto: oculta até revisão.
- Remoção de conta: perfil, trilha e histórico são apagados.
- Texto ou nome vindo de fora (ex.: título de música) é sempre escapado; nunca executado como HTML.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema DEVE permitir editar nome, foto opcional (1), bio curta (máx. 300 caracteres), cidade e bairro aproximado.
- **FR-002**: O sistema DEVE permitir selecionar modalidades, nível (3 opções), ritmo (corrida/ciclismo) e disponibilidade semanal (dia e faixa de horário).
- **FR-003**: O sistema DEVE mostrar presença (treinos combinados concluídos), avaliações recebidas e badges, sem métrica falsa quando não há dados.
- **FR-004**: O sistema DEVE permitir verificação de perfil e mostrar o selo somente quando concluída.
- **FR-005**: O sistema DEVE oferecer bloquear e denunciar em qualquer perfil.
- **FR-006**: O sistema DEVE permitir configurar um contato de confiança, com aceite explícito e compartilhamento só durante treino combinado.
- **FR-007**: O sistema DEVE permitir controle de visibilidade por campo (horário, bairro, histórico, trilha, meta), com padrão "restrito" para horário e bairro.
- **FR-008**: O sistema NUNCA DEVE expor localização exata, endereço ou agenda completa de outro usuário.
- **FR-009**: O sistema DEVE permitir até 20 músicas na trilha, com até 3 destaques, e exibir a trilha abaixo das informações de treino.
- **FR-010**: A busca de músicas DEVE usar o proxy Spotify (client credentials), com resultados de até 10, atribuição "Dados do Spotify" e fallback para catálogo demo com aviso (FR-014 a FR-018 da v1 mantidos).
- **FR-011**: O sistema DEVE permitir uma frase de treino (máx. 120 caracteres) e uma meta opcional.
- **FR-012**: O sistema DEVE mostrar a pré-visualização pública (como outro treino vê).
- **FR-013**: O sistema DEVE usar somente os tokens e padrões do design system Movase (`design-system.md`): laranja como ação, `place-blue` para lugares, neutros stone, raios 8/20/pill, Roboto. Não usar galeria, badges de atração ou cartões de "descoberta".

### Key Entities *(include if feature involves data)*

- **Perfil de treino**: nome, foto opcional, bio, cidade, bairro aproximado, modalidades, nível, ritmo, disponibilidade, frase, meta, visibilidades.
- **Presença**: treinos combinados concluídos, cancelamentos em cima da hora (contados à parte).
- **Avaliação**: nota, badges, parceiro que avaliou (identificado só para quem treinou junto).
- **Verificação**: status (não iniciada, em análise, concluída).
- **Contato de confiança**: nome, canal, aceite, status.
- **Música de treino**: título, artista, capa https, link Spotify, destaque, ordem.

## Success Criteria *(mandatory)*

- **SC-001**: Um usuário novo preenche identidade de treino (modalidade, nível, disponibilidade) em menos de 2 minutos.
- **SC-002**: Nenhum campo marcado como restrito aparece na pré-visualização pública (0 vazamentos em testes de regressão).
- **SC-003**: Perfis sem treinos concluídos não exibem métricas zeradas em destaque.
- **SC-004**: Formulário funciona sem erro em WebKit (iPhone 390 px) e Chromium (Android 360 px), claro e escuro.
- **SC-005**: Alvos de toque de 44 px e texto com contraste AA (4.5:1) em todas as telas.
- **SC-006**: Em teste de leitura de 5 segundos, usuários identificam que o perfil é de treino (não de encontro) em 4 de 5 casos.

## Assumptions

- Spotify Web API em modo de desenvolvimento: dono do app com Premium; até 5 usuários autorizados para tokens de usuário (não usados aqui); busca via client credentials; máximo de 10 resultados; cota compartilhada.
- Publicação ampla exige "extended quota" (organizações com 250 mil usuários ativos/mês). Fora de escopo.
- Verificação de perfil e revisão de denúncias dependem de processo humano. A integração com prestador de verificação fica fora deste spec.
- O app já tem autenticação, avaliações e o fluxo de convite/treino (`movase-app.html`, `movase-treino*.html`). Este spec não cria login.
- Persistência real exige backend. O protótipo é client-side.
- Não copiamos interface, textos ou marca de nenhum app de referência.

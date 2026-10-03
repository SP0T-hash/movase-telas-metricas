# Setup de design para OpenCode

Este pacote instala as três skills de design citadas nos Reels, configura o Playwright MCP e deixa um preset criativo persistente no OpenCode:

- **Emil Kowalski:** `emil-design-eng`
- **Impeccable:** `impeccable`
- **Taste Skill:** `design-taste-frontend`
- **Playwright MCP:** ativado no `opencode.jsonc`
- **Figma MCP:** incluído, mas desativado por padrão
- **AGENTS.md:** regras para escolher skills e consultar referências quando a tarefa for criativa
- **Referências:** MotionSites.ai, CTA Gallery, Unsection e 60fps.design
- **Ponytail:** plugin para reduzir overengineering e revisar complexidade
- **Graphify:** mapa de conhecimento do codebase, instalado quando `uv` estiver disponível
- **Agent Skills de Addy Osmani:** ciclo de especificação, planejamento, implementação, testes, revisão e publicação
- **OmniRoute:** documentado como addon opcional; não é skill e não é ativado automaticamente

## Instalação

1. Extraia esta pasta.
2. Abra um terminal dentro dela.
3. Execute no Linux/macOS:

```bash
chmod +x install.sh
./install.sh /caminho/do/seu/projeto
```

No Windows PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1 -ProjectDir "C:\caminho\do\seu\projeto"
```

Se o terminal já estiver aberto na raiz do projeto, basta executar:

```bash
/path/para/opencode-design-setup/install.sh .
```

O script exige **Node.js 20 ou superior**. Ele cria ou substitui o `opencode.jsonc` do projeto e faz backup automático se já existir um arquivo com esse nome. Também copia o `AGENTS.md`, instala Ponytail, copia as Agent Skills de Addy Osmani e tenta instalar Graphify com `uv`.

## Primeiro teste

Reabra o OpenCode na raiz do projeto e peça:

```text
Liste as skills disponíveis e confirme se emil-design-eng, impeccable e design-taste-frontend foram carregadas. Depois use impeccable para auditar a tipografia, o espaçamento e a hierarquia visual desta interface.
```

Para testar o preset criativo:

```text
Crie uma landing page premium para [produto]. Use a Taste Skill para definir uma direção visual original. Consulte CTA Gallery ou Unsection se precisar de referência, use Impeccable para a estrutura visual e a skill do Emil Kowalski para as microinterações. Implemente, teste com Playwright e faça uma revisão final. Não copie nenhuma referência literalmente.
```

Para validar o Playwright:

```text
Use o Playwright MCP para abrir a aplicação local, verificar a responsividade e tirar um screenshot da página inicial.
```

Para usar Graphify em um projeto grande:

```text
Use Graphify para mapear este projeto antes de continuar. Depois consulte o grafo para localizar os módulos relacionados a [tema] e só então planeje a alteração.
```

Para usar Ponytail:

```text
Use Ponytail para revisar este diff e identificar overengineering, código que pode ser removido e complexidade sem benefício. Preserve testes, segurança e clareza.
```

## Figma MCP

A configuração do Figma está no arquivo, mas com `"enabled": false`. A documentação oficial do Figma informa que o servidor remoto só aceita clientes presentes no catálogo oficial; o OpenCode não aparece nessa lista no momento. Por isso, o pacote não promete que o Figma MCP funcione no OpenCode.

Se o OpenCode passar a ser aceito ou se o servidor conectar normalmente, altere:

```json
"enabled": false
```

para:

```json
"enabled": true
```

Depois, no OpenCode, autentique o servidor, se solicitado:

```bash
opencode mcp auth figma
```

URL oficial do servidor: `https://mcp.figma.com/mcp`

## Observações

As skills são portáveis porque usam `SKILL.md`, mas alguns comandos específicos de Claude Code, como `/impeccable polish`, podem não aparecer como slash command no OpenCode. Nesse caso, peça diretamente ao agente para usar a skill e diga qual comando ou objetivo deseja aplicar. Os sites de referência não são instalados nem tratados como dependências; ficam registrados no `AGENTS.md` para serem consultados quando a tarefa pedir inspiração visual, motion, CTAs ou composição de seções.

## OmniRoute — opcional

O vídeo também cita o **OmniRoute**, mas ele é um gateway local de modelos, não uma skill. Ele pode alterar o provedor e a rota das chamadas do agente, portanto não é instalado nem ativado automaticamente pelo pacote. Para avaliar essa opção, consulte [OmniRoute](https://github.com/diegosouzapw/OmniRoute) e use conscientemente:

```bash
npm install -g omniroute
omniroute
```

O servidor local usa `http://localhost:20128/v1`. Não coloque chaves de API em `opencode.jsonc`; configure-as no dashboard do OmniRoute.

Fontes oficiais:

- [OpenCode Agent Skills](https://opencode.ai/docs/skills/)
- [OpenCode MCP servers](https://opencode.ai/docs/mcp-servers/)
- [Emil Kowalski skills](https://github.com/emilkowalski/skills)
- [Impeccable](https://impeccable.style/)
- [Taste Skill](https://github.com/Leonxlnx/taste-skill)
- [Playwright MCP](https://playwright.dev/docs/getting-started-mcp)
- [Figma MCP](https://developers.figma.com/docs/figma-mcp-server/remote-server-installation/)

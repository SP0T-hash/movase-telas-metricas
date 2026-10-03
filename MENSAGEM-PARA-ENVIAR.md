# Mensagem para enviar

Instale este mega pacote no meu projeto OpenCode. Ele deve deixar as skills e o preset criativo ativos para uso futuro:

1. Extraia a pasta do pacote.
2. Abra o terminal na pasta extraída.
3. Execute:

```bash
chmod +x install.sh
./install.sh /caminho/absoluto/do/projeto
```

No Windows PowerShell, use:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1 -ProjectDir "C:\caminho\absoluto\do\projeto"
```

O instalador configura automaticamente:

- Emil Kowalski Design Skill (`emil-design-eng`)
- Impeccable (`impeccable`)
- Taste Skill (`design-taste-frontend`)
- Playwright MCP
- `AGENTS.md` com regras persistentes de criatividade
- Referências MotionSites.ai, CTA Gallery, Unsection e 60fps.design
- Ponytail para reduzir overengineering
- Graphify para mapear codebases grandes
- Agent Skills de Addy Osmani para especificação, planejamento, build, testes e revisão

Depois, abra o OpenCode na raiz do projeto e confirme com:

```text
Liste as skills disponíveis e confirme se emil-design-eng, impeccable e design-taste-frontend estão carregadas. Use a skill Impeccable para auditar a interface atual.
```

O Figma MCP ficou configurado, mas desativado por padrão, porque a documentação oficial do Figma limita o servidor remoto aos clientes presentes no catálogo oficial. Consulte o README antes de ativá-lo.

Depois, abra o OpenCode na raiz do projeto e envie:

```text
Faça um diagnóstico de instalação. Liste as skills emil-design-eng, impeccable e design-taste-frontend, confirme o Playwright MCP e leia o AGENTS.md. Depois explique qual skill você usará para uma tarefa de frontend criativa.
```

O Reel também cita o OmniRoute. Ele não é uma skill: é um gateway local de modelos. Não o instale automaticamente. Se eu decidir usar esse gateway, primeiro confirme a configuração do provedor e só então instale `npm install -g omniroute`.

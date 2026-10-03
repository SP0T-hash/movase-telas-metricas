# Novas skills e ferramentas do Reel

O Reel do perfil `@99hud` cita quatro itens. Eles não têm todos a mesma natureza.

| Item | Natureza | Inclusão no pacote | Uso |
|---|---|---|---|
| [Ponytail](https://github.com/dietrichgebert/ponytail) | Plugin/skills de disciplina e redução de overengineering | Instalado e habilitado no `opencode.jsonc` | Use `/ponytail`, `/ponytail-review` e `/ponytail-audit` quando quiser reduzir complexidade. |
| [Graphify](https://github.com/Graphify-Labs/graphify) | CLI + skill de mapa de conhecimento do codebase | Instalado automaticamente se `uv` estiver disponível | Use `graphify install --platform opencode` e depois `/graphify .` em projetos grandes. |
| [Agent Skills de Addy Osmani](https://github.com/addyosmani/agent-skills) | Pacote de 25 skills: 24 de ciclo de engenharia + uma meta-skill | Copiado para `.opencode/skills/` | Carrega a skill adequada para especificar, planejar, construir, testar, revisar e publicar. |
| [OmniRoute](https://github.com/diegosouzapw/OmniRoute) | Gateway local de modelos/provedores | Não instalado automaticamente | Exige decisão consciente porque altera a rota e o provedor das chamadas do agente. |

## Observações

O Reel fala em “24 skills”; o repositório consultado atualmente descreve **25 no total**, sendo 24 de ciclo de engenharia e uma `using-agent-skills` para descoberta e roteamento.

O OmniRoute pode ser instalado separadamente com:

```bash
npm install -g omniroute
omniroute
```

Não existem credenciais ou chaves do usuário no pacote. Qualquer autenticação de provedor deve ser feita pelo próprio usuário no dashboard do serviço escolhido.

# Instalação rápida

Este é um pacote de configuração para o **OpenCode**. Se você recebeu a pasta ou o ZIP, execute o instalador correspondente dentro da pasta extraída.

## Linux ou macOS

```bash
chmod +x install.sh
./install.sh /caminho/absoluto/do/projeto
```

## Windows PowerShell

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1 -ProjectDir "C:\caminho\do\projeto"
```

O instalador instala as três skills, configura o Playwright MCP, copia o `AGENTS.md` para as instruções persistentes do projeto e cria backup da configuração anterior.

## Teste após a instalação

Abra o OpenCode na raiz do projeto e envie:

```text
Faça um diagnóstico de instalação. Liste as skills emil-design-eng, impeccable e design-taste-frontend, confirme o Playwright MCP e leia o AGENTS.md. Depois explique qual skill você usará para uma tarefa de frontend criativa.
```

## Teste criativo

```text
Preciso criar uma landing page premium para [descreva o produto]. Use a Taste Skill para definir uma direção visual original. Consulte CTA Gallery ou Unsection se precisar de referência, use Impeccable para a estrutura visual e a skill do Emil Kowalski para as microinterações. Implemente a página, teste com Playwright e faça uma revisão final. Não copie nenhuma referência literalmente.
```

## O que o pacote não faz

Os sites MotionSites.ai, CTA Gallery, Unsection e 60fps.design não são instalados. Eles ficam registrados no `AGENTS.md` como referências que o agente deve consultar quando forem úteis.

O Figma MCP fica preparado, porém desativado por padrão, porque a documentação oficial do Figma não garante conexão de clientes fora do catálogo listado. O Playwright MCP fica ativo.

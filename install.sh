#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${1:-$(pwd)}"

if ! command -v node >/dev/null 2>&1 || ! command -v npx >/dev/null 2>&1; then
  echo "Erro: Node.js 20+ e npm/npx são necessários." >&2
  echo "Instale-os em https://nodejs.org/ e execute novamente." >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Erro: Git é necessário para instalar o pacote Agent Skills." >&2
  exit 1
fi

NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
if [ "$NODE_MAJOR" -lt 20 ]; then
  echo "Erro: este setup exige Node.js 20 ou superior. Versão encontrada: $(node -v)" >&2
  exit 1
fi

mkdir -p "$PROJECT_DIR/.opencode"

if [ -f "$PROJECT_DIR/opencode.jsonc" ]; then
  cp "$PROJECT_DIR/opencode.jsonc" "$PROJECT_DIR/opencode.jsonc.backup-$(date +%Y%m%d-%H%M%S)"
  echo "Backup criado para o opencode.jsonc existente."
fi
cp "$ROOT_DIR/opencode.jsonc" "$PROJECT_DIR/opencode.jsonc"
cp "$ROOT_DIR/AGENTS.md" "$PROJECT_DIR/AGENTS.md"

install_skill() {
  local repo="$1"
  local skill="$2"
  echo "Instalando $skill..."
  npx --yes skills@latest add "$repo" --skill "$skill" --agent opencode --copy --yes
}

pushd "$PROJECT_DIR" >/dev/null
install_skill "emilkowalski/skills" "emil-design-eng"
install_skill "pbakaus/impeccable" "impeccable"
install_skill "https://github.com/Leonxlnx/taste-skill" "design-taste-frontend"
install_skill "DietrichGebert/ponytail" "*"
popd >/dev/null

echo "Instalando o pacote Agent Skills de Addy Osmani..."
agent_skills_tmp="$(mktemp -d)"
trap 'rm -rf "$agent_skills_tmp"' EXIT
git clone --depth 1 https://github.com/addyosmani/agent-skills.git "$agent_skills_tmp/agent-skills" >/dev/null 2>&1
mkdir -p "$PROJECT_DIR/.opencode/skills"
cp -R "$agent_skills_tmp/agent-skills/skills/." "$PROJECT_DIR/.opencode/skills/"

if command -v uv >/dev/null 2>&1; then
  echo "Instalando Graphify CLI..."
  uv tool install --upgrade graphifyy
  pushd "$PROJECT_DIR" >/dev/null
  graphify install --platform opencode || echo "Aviso: execute 'graphify install --platform opencode' no projeto para registrar Graphify."
  popd >/dev/null
else
  echo "Aviso: uv não encontrado; Graphify não foi instalado. Instale uv e execute: uv tool install graphifyy && graphify install --platform opencode"
fi

# Fallback: alguns releases do CLI gravam em .agents/skills. O OpenCode também
# lê esse caminho, mas .opencode/skills deixa a instalação explícita e portátil.
if [ -d "$PROJECT_DIR/.agents/skills" ]; then
  mkdir -p "$PROJECT_DIR/.opencode/skills"
  for skill_dir in "$PROJECT_DIR/.agents/skills"/*; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    if [ ! -e "$PROJECT_DIR/.opencode/skills/$skill_name" ]; then
      cp -R "$skill_dir" "$PROJECT_DIR/.opencode/skills/$skill_name"
    fi
  done
fi

echo
printf '%s\n' "Instalação concluída em: $PROJECT_DIR"
printf '%s\n' "Skills esperadas: emil-design-eng, impeccable, design-taste-frontend, ponytail, Graphify e Agent Skills de Addy Osmani"
printf '%s\n' "MCP ativo: Playwright"
printf '%s\n' "Figma MCP: deixado desativado por compatibilidade; veja README.md"
printf '%s\n' "Reabra o OpenCode no projeto e peça: 'liste as skills disponíveis'."

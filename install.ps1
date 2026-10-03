param(
  [string]$ProjectDir = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

$RootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectDir = (Resolve-Path -LiteralPath $ProjectDir).Path

$node = Get-Command node -ErrorAction SilentlyContinue
$npx = Get-Command npx -ErrorAction SilentlyContinue
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $node -or -not $npx -or -not $git) {
  throw "Node.js 20+, npx e Git são necessários. Instale Node em https://nodejs.org/ e execute novamente."
}

$nodeMajor = [int](& node -p 'process.versions.node.split(".")[0]')
if ($nodeMajor -lt 20) {
  throw "Este setup exige Node.js 20 ou superior. Versão encontrada: $(node --version)"
}

New-Item -ItemType Directory -Force -Path (Join-Path $ProjectDir ".opencode") | Out-Null
$config = Join-Path $ProjectDir "opencode.jsonc"
if (Test-Path $config) {
  $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
  Copy-Item $config "$config.backup-$stamp"
  Write-Host "Backup criado para o opencode.jsonc existente."
}
Copy-Item (Join-Path $RootDir "opencode.jsonc") $config -Force
Copy-Item (Join-Path $RootDir "AGENTS.md") (Join-Path $ProjectDir "AGENTS.md") -Force

Push-Location $ProjectDir
try {
  function Install-Skill([string]$Repo, [string]$Skill) {
    Write-Host "Instalando $Skill..."
    & npx --yes skills@latest add $Repo --skill $Skill --agent opencode --copy --yes
    if ($LASTEXITCODE -ne 0) { throw "Falha ao instalar $Skill" }
  }
  Install-Skill "emilkowalski/skills" "emil-design-eng"
  Install-Skill "pbakaus/impeccable" "impeccable"
  Install-Skill "https://github.com/Leonxlnx/taste-skill" "design-taste-frontend"
  Install-Skill "DietrichGebert/ponytail" "*"

  $temp = Join-Path ([System.IO.Path]::GetTempPath()) ("agent-skills-" + [guid]::NewGuid().ToString())
  & git clone --depth 1 https://github.com/addyosmani/agent-skills.git $temp
  if ($LASTEXITCODE -ne 0) { throw "Falha ao baixar Agent Skills de Addy Osmani" }
  $targetSkills = Join-Path $ProjectDir ".opencode\skills"
  New-Item -ItemType Directory -Force -Path $targetSkills | Out-Null
  Copy-Item (Join-Path $temp "skills\*") $targetSkills -Recurse -Force
  Remove-Item $temp -Recurse -Force

  $uv = Get-Command uv -ErrorAction SilentlyContinue
  if ($uv) {
    & uv tool install --upgrade graphifyy
    & graphify install --platform opencode
  } else {
    Write-Warning "uv não encontrado; Graphify não foi instalado. Instale uv e execute: uv tool install graphifyy; graphify install --platform opencode"
  }

  $source = Join-Path $ProjectDir ".agents\skills"
  $target = Join-Path $ProjectDir ".opencode\skills"
  if (Test-Path $source) {
    New-Item -ItemType Directory -Force -Path $target | Out-Null
    Get-ChildItem $source -Directory | ForEach-Object {
      Copy-Item $_.FullName (Join-Path $target $_.Name) -Recurse -Force
    }
  }
}
finally {
  Pop-Location
}

Write-Host ""
Write-Host "Instalação concluída em: $ProjectDir"
Write-Host "Skills: emil-design-eng, impeccable, design-taste-frontend, ponytail, Graphify e Agent Skills de Addy Osmani"
Write-Host "MCP ativo: Playwright"
Write-Host "Figma MCP: desativado por compatibilidade; veja README.md"
Write-Host "Reabra o OpenCode e peça: liste as skills disponíveis."

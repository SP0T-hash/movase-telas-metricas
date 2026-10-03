# Design system Movase — extraído do app Android

Fonte: `fit.movase.app` v2.2.21 (versionCode 36), Redmi Note 11 Pro / Android 15.
Token real: **`res/raw/theme.json`** dentro do `base.apk`.

> O app não usa `res/values/colors.xml` para a marca — `colors.xml` só tem Material/Mapbox.
> A paleta vem do JSON em runtime, por isso não aparece como literal no dex (R8 removeu).

## light

| token | hex | uso | razão no bg |
|---|---|---|---|
| `accent` | `#F58220` | laranja da marca | — |
| `accent-on` | `#FFFFFF` | texto sobre o accent | **2.59:1 — falha AA** |
| `bg` | `#FFFFFF` | fundo | — |
| `fg` | `#0A0A0A` | texto | 19.8:1 |
| `fg-2` | `#57534E` | texto secundário | 7.63:1 |
| `meta` | `#57534E` | metadados | 7.63:1 |
| `muted` | `#F5F5F4` | fundo suave | — |
| `surface` | `#F5F5F4` | cartão | 18.15:1 vs `fg` |
| `surface-warm` | `#FFF4E8` | cartão quente | 18.25:1 vs `fg` |
| `border` | `#E7E5E4` | borda | 1.26:1 — **só decorativo** |
| `place-blue` | `#003399` | azul de lugar | 10.86:1 |

## dark

| token | hex | razão no bg |
|---|---|---|
| `accent` | `#F58220` | — |
| `accent-on` | `#FFFFFF` | **2.59:1 — falha AA** |
| `bg` | `#0C0A09` | — |
| `fg` | `#FAFAF9` | 18.92:1 |
| `fg-2` | `#A8A29E` | 7.83:1 |
| `meta` | `#A8A29E` | 7.83:1 |
| `muted` / `surface` | `#1C1917` | 16.74:1 vs `fg` |
| `surface-warm` | `#2A1A0C` | 16.07:1 vs `fg` |
| `border` | `#292524` | decorativo |
| `place-blue` | `#003399` | **1.82:1 — falha AA** |

## radius

`pill` 9999 · `md` 20 · `sm` 8

## Bugs de acessibilidade no contrato

1. **`accent-on: #FFFFFF` sobre `accent: #F58220` = 2.59:1.** Reprovado em texto normal
   (precisa 4.5) e reprovado como componente de UI (precisa 3). Afeta botão primário
   nos dois temas. Correção usada no protótipo: `--accent-on: #0A0A0A` → **7.62:1**.
2. **`place-blue: #003399` no dark = 1.82:1.** O azul não tem variante clara; sobre
   `#0C0A09` fica ilegível. Falta um `place-blue-dark` (algo como `#7DA7FF`).

Nada mais no contrato: **não há escala de espaçamento nem de tipografia** —
o `source` do próprio JSON aponta para `DESIGN.md` num repo externo
(`user:movase-design-system`), que não vem no APK. Fontes também não são
embutidas: não há `res/font`, o app usa downloadables do Google Fonts.

## Paleta = Tailwind `stone`

`#FAFAF9` `#F5F5F4` `#E7E5E4` `#A8A29E` `#57534E` `#1C1917` `#292524`
são exatamente a escala `stone` do Tailwind. O `bg`/`fg` do dark
(`#0C0A09` / `#FAFAF9`) são `stone-950` / `stone-50`.

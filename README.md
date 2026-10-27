# SAA website (Quarto draft)

Draft relaunch of <https://sequenceanalysis.org> as a Quarto website — no member area, all content public.

## Structure

| Path | Purpose |
|------|---------|
| `_brand.yml`, `_brand-dark.yml` | Brand definition (colours, fonts, logos) — reusable for slides, Typst/PDF, dashboards |
| `_quarto.yml` | Site config: navbar, footer, theme |
| `styles/` | `saa-brand.scss` from the brand package, layout tweaks (`saa.scss`), per-theme navbar colours |
| `logos/`, `favicons/`, `social/` | SAA brand package: logo variants (SVG/PNG), favicons, Open Graph image; plus old 2018 logo, blog placeholder and software logos |
| `index.qmd` | Home |
| `about.qmd` | Mission, history, committees, annual reports, contact |
| `events.qmd` | Webinars, conferences, training |
| `resources.qmd` | Bibliography and software |
| `brand.qmd` | Style guide / logo proposal for discussion |
| `blog/` | Blog listing; one folder per post in `blog/posts/YYYY-MM-DD-slug/index.qmd` |

## Build

```bash
quarto preview   # live preview
quarto render    # output in _site/
```

Two blog posts contain executable R code (ggseqplot, parametric bootstrap). With `execute: freeze: auto` their results are stored in `_freeze/` — commit that folder, so the site can be built without R (e.g. on GitHub). R only runs again when one of these posts is edited; the bootstrap post then takes several minutes. Required packages: TraMineR, WeightedCluster, fastcluster, ggseqplot, ggplot2, colorspace, ggh4x, patchwork. If Quarto does not find R, set `QUARTO_R` to R's `bin` folder.

**Test phase — before going live:** remove the `noindex` meta in `_quarto.yml` (`include-in-header`) and the "Test version" callout at the top of `index.qmd`, and switch `site-url`.

`site-url` in `_quarto.yml` currently points to the test deployment `https://maraab23.github.io/SAA-Website`; switch it to `https://sequenceanalysis.org` when going live. All paths are relative, so the site works under a subpath as well as at a domain root (the favicon links in `favicons/head-snippet.html` are built from Quarto's `quarto:offset`). To test the subpath locally, `.claude/launch.json` has a `site-subpath` server (serves `_site` at `/SAA-Website/`).

Fonts are self-hosted (no Google Fonts requests): `fonts/fonts.css` + `fonts/woff2/` (latin and latin-ext subsets) for the website, `fonts/ttf/` for the Typst PDF (`font-paths` in `statutes.qmd`, not published). In `_brand.yml` the fonts are declared with `source: system`. Licences: `fonts/OFL-*.txt` (SIL Open Font License 1.1).

Blog categories are limited to four: `association`, `events`, `publications`, `software`. An overview of the posts on the old site and what was ported is in `blog-migration-overview.md`.

## Open points

- The 2018 group photo is still hot-linked from the old site; copy it into the repo before going live.
- Verify the 2024 voting-results table (No/Abstain columns) against the original.
- Annual-report PDFs and the statutes still link to the old WordPress site; copy them over before shutting it down.

## Third-party logos

`logos/software/` holds the software logos used on the Resources page, taken from the workshop slides in `material/`:

- `r.svg`, `python.svg` — Font Awesome Free brand icons ([CC BY 4.0](https://fontawesome.com/license/free)), recoloured in the R and Python brand blues.
- `stata.svg` — "file_type_stata" icon from vscode-icons via SVG Repo (MIT).

The R, Python and Stata names and logos are trademarks of their owners and are used here only to identify the software.

## Cover images

`resources/covers/` holds the book and journal covers shown in the literature timeline on the Resources page (sources: SAGE, Springer Nature, Cambridge University Press, and marcelraab.de for the *Social Science Research* cover). They are used only to identify the publications.

## Statutes PDF

`statutes.qmd` renders to both HTML and a branded PDF (`saa-statutes.pdf`, via Typst and `_brand.yml`). A normal `quarto render` builds both; the PDF alone: `quarto render statutes.qmd --to typst`.

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

Three blog posts contain executable R code (ggseqplot 2022, ggseqplot 1.0.0 release, parametric bootstrap). With `execute: freeze: auto` their results are stored in `_freeze/` — commit that folder, so the site can be built without R (e.g. on GitHub). R only runs again when one of these posts is edited; the bootstrap post then takes several minutes. Required packages: TraMineR, TraMineRextras, WeightedCluster, fastcluster, ggseqplot, ggplot2, colorspace, ggh4x, patchwork, paletteer. If Quarto does not find R, set `QUARTO_R` to R's `bin` folder. Line endings are fixed to LF via `.gitattributes`, because freeze hashes the source files (CRLF would invalidate them).

**Test phase — before going live:** remove the `noindex` meta in `_quarto.yml` (`include-in-header`) and the "Test version" callout at the top of `index.qmd`, and switch `site-url`.

`site-url` in `_quarto.yml` currently points to the test deployment `https://maraab23.github.io/SAA-Website`; switch it to `https://sequenceanalysis.org` when going live. All paths are relative, so the site works under a subpath as well as at a domain root (the favicon links in `favicons/head-snippet.html` are built from Quarto's `quarto:offset`). To test the subpath locally, `.claude/launch.json` has a `site-subpath` server (serves `_site` at `/SAA-Website/`).

Fonts are self-hosted (no Google Fonts requests): `fonts/fonts.css` + `fonts/woff2/` (latin and latin-ext subsets) for the website, `fonts/ttf/` for the Typst PDF (`font-paths` in `statutes.qmd`, not published). In `_brand.yml` the fonts are declared with `source: system`. Licences: `fonts/OFL-*.txt` (SIL Open Font License 1.1).

Blog categories are limited to five: `association`, `events`, `publications`, `software`, `tutorials` (posts with R code get `[software, tutorials]`). An overview of the posts on the old site and what was ported is in `blog-migration-overview.md`.

Content posts (tutorials, software) end with an appendix: author with `orcid:` in the YAML, a `citation:` block with `type: post-weblog` (Quarto builds the citation in APA 7 style, `styles/apa.csl` from the official CSL repository, set in `blog/posts/_metadata.yml`; `scripts/cite-download.html` turns the BibTeX into a download button), and the sections `## About the author {.appendix}` and `## Copyright and license {.appendix}` with `© year name\` plus `{{< cc-by >}}` (`shortcodes/cc-by.lua`). Use one of the ggseqplot posts as a template. Other posts get no appendix (`citation: false` in `blog/posts/_metadata.yml`).

## Open points

- The site no longer depends on the old WordPress site: the 2018 group photo (`resources/images/`) and the annual reports 2019–2025 (`resources/reports/`) are copies in the repository; the statutes are a page of their own (`statutes.qmd`).

## Third-party logos

`logos/software/` holds the software logos used on the Resources page, taken from the workshop slides in `material/`:

- `r.svg`, `python.svg` — Font Awesome Free brand icons ([CC BY 4.0](https://fontawesome.com/license/free)), recoloured in the R and Python brand blues.
- `stata.svg` — "file_type_stata" icon from vscode-icons via SVG Repo (MIT).

The R, Python and Stata names and logos are trademarks of their owners and are used here only to identify the software.

## Cover images

`resources/covers/` holds the book and journal covers shown in the literature timeline on the Resources page (sources: SAGE, Springer Nature, Cambridge University Press, and marcelraab.de for the *Social Science Research* cover). They are used only to identify the publications.

## Statutes PDF

`statutes.qmd` renders to both HTML and a branded PDF (`saa-statutes.pdf`, via Typst and `_brand.yml`). A normal `quarto render` builds both; the PDF alone: `quarto render statutes.qmd --to typst`.

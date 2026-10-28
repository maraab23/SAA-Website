-- {{< cc-by >}}: Creative Commons Attribution 4.0 notice with CC/BY icons.
-- The icons are simple inline SVGs (currentColor), so they work in light and
-- dark mode and need no request to creativecommons.org.

local url = "https://creativecommons.org/licenses/by/4.0/"

local icon_cc = [[<svg class="cc-icon" viewBox="0 0 24 24" aria-hidden="true">]] ..
  [[<circle cx="12" cy="12" r="10.5" fill="none" stroke="currentColor" stroke-width="2"/>]] ..
  [[<path d="M10.6 9.6 A3.3 3.3 0 1 0 10.6 14.4 M17.4 9.6 A3.3 3.3 0 1 0 17.4 14.4" ]] ..
  [[fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>]]

local icon_by = [[<svg class="cc-icon" viewBox="0 0 24 24" aria-hidden="true">]] ..
  [[<circle cx="12" cy="12" r="10.5" fill="none" stroke="currentColor" stroke-width="2"/>]] ..
  [[<circle cx="12" cy="6.6" r="2" fill="currentColor"/>]] ..
  [[<path d="M9 9.8 h6 a.8 .8 0 0 1 .8 .8 v4.2 h-1.8 v4.2 h-4 v-4.2 h-1.8 v-4.2 a.8 .8 0 0 1 .8 -.8 z" fill="currentColor"/></svg>]]

return {
  ["cc-by"] = function(args, kwargs, meta)
    if not quarto.doc.is_format("html") then
      return pandoc.Str("License: CC BY 4.0 (" .. url .. ")")
    end
    return pandoc.RawInline("html",
      '<a class="cc-icons" href="' .. url .. '" rel="license" title="CC BY 4.0">' ..
      icon_cc .. icon_by .. '</a> ' ..
      'This post is licensed under a <a href="' .. url .. '" rel="license">' ..
      'Creative Commons Attribution 4.0 International License (CC BY 4.0)</a>.')
  end
}

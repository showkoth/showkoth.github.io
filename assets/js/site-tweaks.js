/**
 * Site-specific presentation tweaks.
 *
 * These live here rather than in overridden theme includes so the starter never
 * owns a core component path (see test/style_contract.js) and al-folio upgrades
 * stay drop-in. Everything below degrades gracefully: without JS the page still
 * shows every news item with the theme's own date format.
 *
 *   1. News dates drop the day: "Jan 15, 2026" -> "Jan 2026".
 *   2. Footer "Last updated" drops the day: "July 29, 2026" -> "July 2026".
 *   3. On pages that opt in via `data-news-collapse`, news entries past the
 *      third are hidden behind a "show older news" button.
 *   4. Light mode swaps the theme's purple accent for the palette's deep blue.
 *   5. Root font-size is raised 16px -> 17px; the theme sizes everything in
 *      rem, so the whole type scale grows proportionally on every page.
 */
(function () {
  "use strict";

  const MONTH_DAY_YEAR = /^([A-Za-z]+)\s+\d{1,2},\s*(\d{4})$/;

  // Default first-time visitors to the light theme. The theme gem hardcodes
  // "system" as the fallback and its assets can't be shadowed (the js
  // pipeline regenerates them), so seed the stored preference instead. Only
  // untouched visitors are affected: anyone who used the toggle has a stored
  // value and is left alone. A system-dark visitor's very first paint may
  // briefly show dark before this runs; every later visit starts light.
  function defaultToLightTheme() {
    // initTheme() has already stored "system" by the time this runs, so a
    // null check can't distinguish first visits; a one-time marker can.
    // After the first visit, whatever the visitor picks (including cycling
    // the toggle back to "system") is left alone.
    if (localStorage.getItem("theme-defaulted")) return;
    localStorage.setItem("theme-defaulted", "1");
    if (typeof setThemeSetting === "function") {
      setThemeSetting("light");
    } else {
      localStorage.setItem("theme", "light");
      document.documentElement.setAttribute("data-theme", "light");
      document.documentElement.setAttribute("data-theme-setting", "light");
    }
  }

  defaultToLightTheme();

  // The light theme hardcodes purple in the theme gem's _sass/_themes.scss,
  // which the starter contract forbids shadowing, so re-declare the variables
  // here. #00369f is the theme's own $blue-color-dark. Dark mode is untouched.
  function quietLightAccent() {
    const style = document.createElement("style");
    style.textContent = [
      'html:not([data-theme="dark"]) {',
      "  --global-theme-color: #00369f;",
      "  --global-hover-color: #00369f;",
      "  --global-code-bg-color: rgba(0, 54, 159, 0.05);",
      "}",
      // 16px reads small at desktop widths; the theme's own Sass can't be
      // shadowed here (see the style contract), so scale the root instead.
      "html {",
      "  font-size: 17px;",
      "}",
      // Site headings are sentence case. Repo-owned text is already edited;
      // this catches theme-rendered lowercase headings (the about page's
      // announcements block renders a hardcoded "news").
      "article h2::first-letter {",
      "  text-transform: uppercase;",
      "}",
      // Section headings trail off into a thin rule. Inline-block + negative
      // margin rather than flex: making the h2 a flex container would stop
      // ::first-letter (above) from applying. Publications year headers are
      // excluded — a rule under the watermark years would look wrong.
      "article h2:not(.bibliography) {",
      "  overflow: hidden;",
      "}",
      "article h2:not(.bibliography)::after {",
      "  content: '';",
      "  display: inline-block;",
      "  width: 100%;",
      "  margin-right: -100%;",
      "  margin-left: 0.75rem;",
      "  border-top: 2px solid var(--global-divider-color);",
      "  vertical-align: middle;",
      "}",
      // The theme renders social icons at 4rem; at that size nine icons
      // outweigh the page. Whisper, don't shout.
      ".social .contact-icons {",
      "  font-size: 2rem;",
      "}",
      // The news table hardcodes an inline 20% date column, stranding the
      // date far from its text; !important is the only way past an inline
      // style. 6.5rem fits 'Jan 2026' with room.
      ".news th[scope='row'] {",
      "  width: 6.5rem !important;",
      "  white-space: nowrap;",
      "}",
      // Match the profile photo's rounding to the callout box.
      ".profile img {",
      "  border-radius: 8px;",
      "}",
      // Bibliography: the venue-badge column is a 16.7% Bootstrap col for a
      // small pill, and the watermark year headers pad a tall empty band;
      // tighten both so the list reads as one body of work.
      "ol.bibliography .abbr {",
      "  flex: 0 0 7.5rem;",
      "  max-width: 7.5rem;",
      "}",
      "h2.bibliography {",
      "  font-size: 1.75rem;",
      "  margin-top: 1rem;",
      "  padding-top: 0;",
      "}",
    ].join("\n");
    document.head.appendChild(style);
  }

  quietLightAccent();

  function trimNewsDates() {
    document.querySelectorAll(".news th[scope='row']").forEach(function (cell) {
      const match = cell.textContent.trim().match(MONTH_DAY_YEAR);
      if (match) {
        cell.textContent = match[1] + " " + match[2];
      }
    });
  }

  function trimFooterDate() {
    const footer = document.querySelector("footer .container");
    if (!footer) return;
    footer.innerHTML = footer.innerHTML.replace(/(Last updated:\s*)([A-Za-z]+)\s+\d{1,2},\s*(\d{4})/, "$1$2 $3");
  }

  function collapseNews() {
    const marker = document.querySelector("[data-news-collapse]");
    const container = document.querySelector(".news");
    if (!marker || !container) return;

    const limit = parseInt(marker.dataset.newsCollapse, 10) || 3;
    const rows = Array.from(container.querySelectorAll("tr"));
    const extra = rows.slice(limit);
    if (extra.length === 0) return;

    extra.forEach(function (row) {
      row.hidden = true;
    });

    const button = document.createElement("button");
    button.type = "button";
    button.className = "btn btn-outline-primary";
    button.textContent = "show older news";
    button.setAttribute("aria-expanded", "false");

    const wrapper = document.createElement("div");
    wrapper.className = "more-news mt-2";
    wrapper.appendChild(button);
    container.appendChild(wrapper);

    button.addEventListener("click", function () {
      const expanded = button.getAttribute("aria-expanded") === "true";
      extra.forEach(function (row) {
        row.hidden = expanded;
      });
      button.setAttribute("aria-expanded", expanded ? "false" : "true");
      button.textContent = expanded ? "show older news" : "hide older news";
    });
  }

  function init() {
    trimNewsDates();
    trimFooterDate();
    collapseNews();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();

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

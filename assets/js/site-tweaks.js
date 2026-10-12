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
 *   4. First-time visitors default to the light theme.
 *
 * Visual styling lives in assets/css/main.scss, not here, so it applies on
 * first paint.
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

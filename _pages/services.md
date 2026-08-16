---
layout: page
permalink: /services/
title: services # kept for the nav label and browser tab; the header itself is hidden below
nav: true
nav_order: 3
---

{% comment %}
Rendered from the Volunteer section of \_data/cv.yml, the same file that feeds
the CV page and the RenderCV PDF, so there is only one copy of these facts.
The page layout's title/description header is a theme file and cannot be
overridden here (see test/style_contract.js), so it is hidden instead.
{% endcomment %}

<style>
  .post-header {
    display: none;
  }

  /* Mute in-content links: many orgs are linked here, and full accent color
     turns the list into a stripe pattern. Accent returns on hover. */
  .post article a {
    color: inherit;
    text-decoration: underline;
    text-decoration-color: var(--global-divider-color);
    text-underline-offset: 2px;
  }

  .post article a:hover {
    color: var(--global-theme-color);
    text-decoration-color: var(--global-theme-color);
  }
</style>

{% assign sections = site.data.cv.cv.sections %}

## academic service

<ul>
  {% for item in sections.Volunteer %}
    <li class="mb-3">
      <strong>{{ item.position }}</strong> — {{ item.company }}
      {% if item.location and item.location != '' %} · {{ item.location }}{% endif %}<br />
      {% assign start_year = item.start_date | date: '%Y' %}
      {% assign end_year = item.end_date | date: '%Y' %}
      <em>{{ start_year }}{% unless end_year == start_year %} – {{ end_year }}{% endunless %}</em>
      {% if item.summary %}<br />{{ item.summary }}{% endif %}
    </li>
  {% endfor %}
</ul>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

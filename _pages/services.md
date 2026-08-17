---
layout: page
permalink: /services/
title: Services # kept for the nav label and browser tab; the header itself is hidden below
nav: true
nav_order: 3
---

{% comment %}
Rendered from the Volunteer section of \_data/cv.yml, the same file that feeds
the CV page and the RenderCV PDF, so there is only one copy of these facts.
`category: community` entries group under their own heading. The page layout's
title/description header is a theme file and cannot be overridden here
(see test/style_contract.js), so it is hidden instead.
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

  /* Air between sections so entries group under their heading. */
  .post article h2 {
    margin-top: 2rem;
  }

  /* Timeline styles matching education & experience. */
  .timeline {
    list-style: none;
    margin-left: 0.4rem;
    padding-left: 1.4rem;
    border-left: 2px solid var(--global-divider-color);
  }

  .timeline > li {
    position: relative;
    margin-bottom: 1.5rem;
  }

  .timeline > li::before {
    content: "";
    position: absolute;
    left: calc(-1.4rem - 7px);
    top: 0.4em;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: var(--global-bg-color);
    border: 2px solid var(--global-theme-color);
  }

  /* Ongoing roles get a filled dot; past ones stay hollow. */
  .timeline > li.current::before {
    background: var(--global-theme-color);
  }

  .timeline strong {
    font-size: 1.0625rem;
  }

  .timeline .entry-detail {
    color: var(--global-text-color-light);
    font-size: 0.875rem;
  }

  .timeline > li > .d-flex > em {
    margin-left: auto;
    white-space: nowrap;
    padding-left: 1rem;
    font-size: 0.875rem;
  }
</style>

{% assign sections = site.data.cv.cv.sections %}
{% assign community = sections.Volunteer | where: 'category', 'community' %}
{% assign academic = sections.Volunteer | where_exp: 'item', "item.category != 'community'" %}

## Academic service

<ul class="timeline">
  {% for item in academic %}
    <li{% if item.current %} class="current"{% endif %}>
      <div class="d-flex flex-wrap justify-content-between align-items-baseline">
        <span><strong>{{ item.position }}</strong> — {{ item.company }}</span>
        <em>
          {% assign start_year = item.start_date | date: '%Y' %}
          {% assign end_year = item.end_date | date: '%Y' %}
          {{ start_year }}{% unless end_year == start_year %} – {{ end_year }}{% endunless %}
        </em>
      </div>
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
    </li>
  {% endfor %}
</ul>

## Community & leadership

<ul class="timeline">
  {% for item in community %}
    <li{% if item.current %} class="current"{% endif %}>
      <div class="d-flex flex-wrap justify-content-between align-items-baseline">
        <span><strong>{{ item.position }}</strong> — {{ item.company }}</span>
        <em>
          {% assign start_year = item.start_date | date: '%Y' %}
          {% assign end_year = item.end_date | date: '%Y' %}
          {{ start_year }}{% unless end_year == start_year %} – {{ end_year }}{% endunless %}
        </em>
      </div>
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
    </li>
  {% endfor %}
</ul>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

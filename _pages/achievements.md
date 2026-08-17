---
layout: page
permalink: /achievements/
title: Achievements # kept for the nav label and browser tab; the header itself is hidden below
nav: true
nav_order: 4
---

{% comment %}
Rendered from the Awards section of \_data/cv.yml, the same file that feeds the
CV page and the RenderCV PDF, so there is only one copy of these facts. The
page layout's title/description header is a theme file and cannot be
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

  /* Air between sections so entries group under their heading. */
  .post article h2 {
    margin-top: 2rem;
  }

  /* Numbered list; scale matches the services page. */
  .service-list > li {
    margin-bottom: 0.5rem;
  }

  .service-list .entry-detail {
    color: var(--global-text-color-light);
    font-size: 0.875rem;
  }
</style>

{% assign sections = site.data.cv.cv.sections %}
{% assign grants = sections.Awards | where: 'category', 'grant' %}
{% assign honors = sections.Awards | where_exp: 'item', "item.category != 'grant'" %}

## Grants & scholarships

<ol class="service-list">
  {% for item in grants %}
    <li>
      {% if item.url %}<a href="{{ item.url }}"><strong>{{ item.title }}</strong></a>{% else %}<strong>{{ item.title }}</strong>{% endif %}, {{ item.awarder }}
      {% if item.date_label %}({{ item.date_label }}){% elsif item.date %}({{ item.date | date: '%Y' }}){% endif %}
      {% if item.summary %}<div class="entry-detail">{{ item.summary }}</div>{% endif %}
    </li>
  {% endfor %}
</ol>

## Honors & awards

<ol class="service-list">
  {% for item in honors %}
    <li>
      {% if item.url %}<a href="{{ item.url }}"><strong>{{ item.title }}</strong></a>{% else %}<strong>{{ item.title }}</strong>{% endif %}, {{ item.awarder }}
      {% if item.date_label %}({{ item.date_label }}){% elsif item.date %}({{ item.date | date: '%Y' }}){% endif %}
      {% if item.summary %}<div class="entry-detail">{{ item.summary }}</div>{% endif %}
    </li>
  {% endfor %}
</ol>

## Certifications

<ol class="service-list">
  {% for item in sections.Certifications %}
    <li><strong>{{ item.issuer }}:</strong> {{ item.name }}</li>
  {% endfor %}
</ol>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

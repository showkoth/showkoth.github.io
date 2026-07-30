---
layout: page
permalink: /achievements/
title: achievements # kept for the nav label and browser tab; the header itself is hidden below
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
</style>

{% assign sections = site.data.cv.cv.sections %}

## honors & awards

<ul>
  {% for item in sections.Awards %}
    <li class="mb-3">
      {% if item.url %}<a href="{{ item.url }}"><strong>{{ item.title }}</strong></a>{% else %}<strong>{{ item.title }}</strong>{% endif %}<br />
      {{ item.awarder }}{% if item.date %} · <em>{{ item.date | date: '%b %Y' }}</em>{% endif %}
      {% if item.summary %}<br />{{ item.summary }}{% endif %}
    </li>
  {% endfor %}
</ul>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

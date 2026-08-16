---
layout: page
permalink: /education-experience/
title: education & experience # kept for the nav label and browser tab; the header itself is hidden below
nav: true
nav_order: 2
---

{% comment %}
The page layout always renders a title + description header. It is a theme
file, so it cannot be overridden here (see test/style_contract.js); hide it
instead. The section headings below carry the page on their own.
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

{% comment %}
Everything on this page is rendered from \_data/cv.yml, the same file that feeds
the CV page and the RenderCV PDF, so there is only one copy of these facts.
{% endcomment %}

{% assign sections = site.data.cv.cv.sections %}
{% assign teaching = sections.Experience | where: 'category', 'teaching' %}
{% assign roles = sections.Experience | where_exp: 'item', "item.category != 'teaching'" %}

## professional experience

<ul>
  {% for item in roles %}
    <li class="mb-3">
      <strong>{{ item.position }}</strong><br />
      {% if item.url %}<a href="{{ item.url }}">{{ item.company }}</a>{% else %}{{ item.company }}{% endif %}
      {% if item.location %} · {{ item.location }}{% endif %}<br />
      <em>
        {{ item.start_date | date: '%b %Y' }} –
        {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
      </em>
      {% if item.summary %}<br />{{ item.summary }}{% endif %}
      {% if item.highlights %}
        <ul>
          {% for highlight in item.highlights %}
            <li>{{ highlight }}</li>
          {% endfor %}
        </ul>
      {% endif %}
    </li>
  {% endfor %}
</ul>

## education

<ul>
  {% for item in sections.Education %}
    <li class="mb-3">
      <strong>{{ item.studyType }} in {{ item.area }}</strong><br />
      {% if item.url %}<a href="{{ item.url }}">{{ item.institution }}</a>{% else %}{{ item.institution }}{% endif %}
      {% if item.location %} · {{ item.location }}{% endif %}<br />
      <em>
        {{ item.start_date | date: '%b %Y' }} –
        {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
      </em>
      {% if item.highlights %}
        <ul>
          {% for highlight in item.highlights %}
            <li>{{ highlight }}</li>
          {% endfor %}
        </ul>
      {% endif %}
    </li>
  {% endfor %}
</ul>

{% if teaching.size > 0 %}

## teaching

<ul>
  {% for item in teaching %}
    <li class="mb-3">
      <strong>{{ item.position }}</strong><br />
      {% if item.url %}<a href="{{ item.url }}">{{ item.company }}</a>{% else %}{{ item.company }}{% endif %}
      {% if item.location %} · {{ item.location }}{% endif %}<br />
      <em>
        {{ item.start_date | date: '%b %Y' }} –
        {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
      </em>
      {% if item.summary %}<br />{{ item.summary }}{% endif %}
    </li>
  {% endfor %}
</ul>

{% endif %}

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

---
layout: page
permalink: /education-experience/
title: education & experience
description: My academic background, research and industry experience, and academic service.
nav: true
nav_order: 2
---

{% comment %}
Everything on this page is rendered from \_data/cv.yml, the same file that feeds
the CV page and the RenderCV PDF, so there is only one copy of these facts.
{% endcomment %}

{% assign sections = site.data.cv.cv.sections %}

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

## experience

<ul>
  {% for item in sections.Experience %}
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

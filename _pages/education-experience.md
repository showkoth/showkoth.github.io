---
layout: page
permalink: /education-experience/
title: Education & experience # kept for the nav label and browser tab; the header itself is hidden below
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

  /* Air between sections so entries group under their heading. */
  .post article h2 {
    margin-top: 2rem;
  }

  /* Cap the measure: full-container lines run far past a readable 65–80ch
     and leave a dead zone between titles and the right-aligned dates. */
  .post article {
    max-width: 56rem;
    margin-inline: auto;
  }

  /* Skills: label column left, keywords right, like the PDF's layout. */
  .skills tr {
    border-bottom: 1px solid var(--global-divider-color);
  }

  .skills th {
    white-space: nowrap;
    padding: 0.4rem 1.5rem 0.4rem 0;
    font-weight: 600;
  }

  .skills td {
    padding: 0.4rem 0;
    color: var(--global-text-color-light);
  }
</style>

{% comment %}
Everything on this page is rendered from \_data/cv.yml, the same file that feeds
the CV page and the RenderCV PDF, so there is only one copy of these facts.
Each experience entry's `blurb` is the one-line web version; the fuller
`highlights` are rendered only by the CV page and PDF.
{% endcomment %}

{% assign sections = site.data.cv.cv.sections %}
{% assign research = sections.Experience | where: 'category', 'research' %}
{% assign teaching = sections.Experience | where: 'category', 'teaching' %}
{% assign industry = sections.Experience | where_exp: 'item', "item.category != 'research' and item.category != 'teaching'" %}

## Education

<ul class="entries">
  {% for item in sections.Education %}
    <li>
      <div class="entry-head d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.studyType }} in {{ item.area }}</strong>,
          {% if item.url %}<a href="{{ item.url }}">{{ item.institution }}</a>{% else %}{{ item.institution }}{% endif %}
        </span>
        <em>
          {{ item.start_date | date: '%b %Y' }} –
          {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
        </em>
      </div>
      {% for highlight in item.highlights %}
        <div class="entry-detail">{{ highlight | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% endfor %}
    </li>
  {% endfor %}
</ul>

## Research experience

<ul class="entries">
  {% for item in research %}
    <li>
      <div class="entry-head d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.position }}</strong>,
          {% if item.url %}<a href="{{ item.url }}">{{ item.company }}</a>{% else %}{{ item.company }}{% endif %}
        </span>
        <em>
          {% if item.date_label %}
            {{ item.date_label }}
          {% else %}
            {{ item.start_date | date: '%b %Y' }} –
            {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
          {% endif %}
        </em>
      </div>
      {% if item.blurb %}
        <div class="entry-detail">{{ item.blurb | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% elsif item.summary %}
        <div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% endif %}
    </li>
  {% endfor %}
</ul>

## Industry experience

<ul class="entries">
  {% for item in industry %}
    <li>
      <div class="entry-head d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.position }}</strong>,
          {% if item.url %}<a href="{{ item.url }}">{{ item.company }}</a>{% else %}{{ item.company }}{% endif %}
        </span>
        <em>
          {% if item.date_label %}
            {{ item.date_label }}
          {% else %}
            {{ item.start_date | date: '%b %Y' }} –
            {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
          {% endif %}
        </em>
      </div>
      {% if item.blurb %}
        <div class="entry-detail">{{ item.blurb | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% elsif item.summary %}
        <div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% endif %}
    </li>
  {% endfor %}
</ul>

{% if teaching.size > 0 %}

## Teaching

<ul class="entries">
  {% for item in teaching %}
    <li>
      <div class="entry-head d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.position }}</strong>,
          {% if item.url %}<a href="{{ item.url }}">{{ item.company }}</a>{% else %}{{ item.company }}{% endif %}
        </span>
        <em>
          {% if item.date_label %}
            {{ item.date_label }}
          {% else %}
            {{ item.start_date | date: '%b %Y' }} –
            {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
          {% endif %}
        </em>
      </div>
      {% if item.blurb %}
        <div class="entry-detail">{{ item.blurb | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% elsif item.summary %}
        <div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% endif %}
    </li>
  {% endfor %}
</ul>

{% endif %}

## Technical skills

<table class="skills">
  {% for skill in sections.Skills %}
    <tr>
      <th scope="row">{{ skill.name }}</th>
      <td>{{ skill.keywords }}</td>
    </tr>
  {% endfor %}
</table>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

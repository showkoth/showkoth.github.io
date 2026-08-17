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

  /* Cap the measure: full-container lines run far past a readable 65–80ch
     and leave a dead zone between titles and the right-aligned dates. */
  .post article {
    max-width: 56rem;
    margin-inline: auto;
  }

  /* Timeline: a rail down the left with a dot per entry. */
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

  /* Scale contrast: titles lifted slightly, secondary info (dates, blurbs)
     stepped down, so entries read as headline + detail instead of flat text. */
  .timeline strong {
    font-size: 1.0625rem;
  }

  .timeline .entry-detail {
    color: var(--global-text-color-light);
    font-size: 0.875rem;
  }

  /* Keep dates on the right edge even when a long title forces a wrap.
     The trailing padding leaves room for the last italic glyph's overhang:
     the theme gives table-bearing articles overflow-x auto, which otherwise
     clips the slanted ink at the article's right edge. */
  .timeline > li > .d-flex > em {
    margin-left: auto;
    white-space: nowrap;
    padding-left: 1rem;
    padding-right: 0.15em;
    font-size: 0.875rem;
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
{% assign teaching = sections.Experience | where: 'category', 'teaching' %}
{% assign roles = sections.Experience | where_exp: 'item', "item.category != 'teaching'" %}

## Professional experience

<ul class="timeline">
  {% for item in roles %}
    <li{% if item.end_date == 'present' %} class="current"{% endif %}>
      <div class="d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.position }}</strong> —
          {% if item.url %}<a href="{{ item.url }}">{{ item.company }}</a>{% else %}{{ item.company }}{% endif %}
        </span>
        <em>
          {{ item.start_date | date: '%b %Y' }} –
          {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
        </em>
      </div>
      {% if item.blurb %}
        <div class="entry-detail">{{ item.blurb | markdownify | remove: '<p>' | remove: '</p>' }}</div>
      {% endif %}
    </li>
  {% endfor %}
</ul>

## Education

<ul class="timeline">
  {% for item in sections.Education %}
    <li{% if item.end_date == 'present' %} class="current"{% endif %}>
      <div class="d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.studyType }} in {{ item.area }}</strong> —
          {% if item.url %}<a href="{{ item.url }}">{{ item.institution }}</a>{% else %}{{ item.institution }}{% endif %}
        </span>
        <em>
          {{ item.start_date | date: '%b %Y' }} –
          {% if item.end_date == 'present' %}Present{% else %}{{ item.end_date | date: '%b %Y' }}{% endif %}
        </em>
      </div>
      {% if item.highlights %}
        {% for highlight in item.highlights %}
          <div class="entry-detail">{{ highlight | markdownify | remove: '<p>' | remove: '</p>' }}</div>
        {% endfor %}
      {% endif %}
    </li>
  {% endfor %}
</ul>

{% if teaching.size > 0 %}

## Teaching

<ul class="timeline">
  {% for item in teaching %}
    <li{% if item.end_date == 'present' %} class="current"{% endif %}>
      <div class="d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.position }}</strong> —
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
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
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

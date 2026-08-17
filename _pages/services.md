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

  .service-list > li {
    margin-bottom: 0.5rem;
  }

  .service-list .entry-detail {
    color: var(--global-text-color-light);
    font-size: 0.875rem;
  }

  /* Mentoring: one row per term, term column fixed and bold. */
  .mentoring-note {
    color: var(--global-text-color-light);
    font-size: 0.875rem;
  }

  .mentoring tr {
    border-bottom: 1px solid var(--global-divider-color);
  }

  .mentoring th {
    white-space: nowrap;
    padding: 0.4rem 1.5rem 0.4rem 0;
    font-weight: 600;
  }

  .mentoring td {
    padding: 0.4rem 0;
  }
</style>

{% assign sections = site.data.cv.cv.sections %}
{% assign review = sections.Volunteer | where: 'category', 'review' %}
{% assign community = sections.Volunteer | where: 'category', 'community' %}
{% assign academic = sections.Volunteer | where_exp: 'item', "item.category != 'community' and item.category != 'review'" %}

## Reviewer

<ol class="service-list">
  {% for item in review %}
    <li>
      <strong>{{ item.company }}</strong>,
      {% assign start_year = item.start_date | date: '%Y' %}
      {% assign end_year = item.end_date | date: '%Y' %}
      {{ start_year }}{% unless end_year == start_year %}–{{ end_year }}{% endunless %}
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
    </li>
  {% endfor %}
</ol>

## Mentoring

<p class="mentoring-note">
  All mentees supervised in conjunction with <a href="https://sites.nd.edu/taeho-jung/">Prof. Taeho Jung</a> (University of Notre Dame).<br />
  * University of Notre Dame &nbsp;|&nbsp; @ Indiana Institute of Technology
</p>

<table class="mentoring">
  {% for row in sections.Mentoring %}
    <tr>
      <th scope="row">{{ row.term }}</th>
      <td>{{ row.mentees }}</td>
    </tr>
  {% endfor %}
</table>

## Community & leadership

<ol class="service-list">
  {% for item in community %}
    <li>
      <strong>{{ item.position }}</strong>, {{ item.company }}
      {% assign start_year = item.start_date | date: '%Y' %}
      {% assign end_year = item.end_date | date: '%Y' %}
      ({{ start_year }}{% unless end_year == start_year %}–{{ end_year }}{% endunless %})
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
    </li>
  {% endfor %}
</ol>

## Other services

<ol class="service-list">
  {% for item in academic %}
    <li>
      <strong>{{ item.position }}</strong>, {{ item.company }}
      {% assign start_year = item.start_date | date: '%Y' %}
      {% assign end_year = item.end_date | date: '%Y' %}
      ({{ start_year }}{% unless end_year == start_year %}–{{ end_year }}{% endunless %})
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
    </li>
  {% endfor %}
</ol>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

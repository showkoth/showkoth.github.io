---
layout: page
permalink: /services/
title: Service # kept for the nav label and browser tab; the header itself is hidden below
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

  /* Air between sections so entries group under their heading. */
  .post article h2 {
    margin-top: 2rem;
  }

  /* Cap the measure, as on the education & experience page. */
  .post article {
    max-width: 56rem;
    margin-inline: auto;
  }

  /* Journals / Conferences labels inside the Reviewer section. */
  .entry-group {
    font-size: 0.95rem;
    font-weight: 600;
    color: var(--global-text-color-light);
    margin: 0.75rem 0 0.4rem;
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
{% assign outreach = sections.Volunteer | where: 'category', 'outreach' | sort: 'end_date' | reverse %}

## Reviewer

<div class="reviewing">
  {% assign venue_groups = "journal,conference" | split: "," %}
  {% assign review_number = 1 %}
  {% for group in venue_groups %}
    {% assign venues = review | where: 'venue', group %}
    {% if venues.size > 0 %}
      <p class="entry-group">{% if group == 'journal' %}Journals{% else %}Conferences{% endif %}</p>
      <ol class="entries compact numbered" start="{{ review_number }}">
        {% for item in venues %}
          <li>
            <div class="entry-head d-flex flex-wrap justify-content-between align-items-baseline">
              <span>{{ item.company }}</span>
              <em>
                {%- assign start_year = item.start_date | date: '%Y' -%}
                {%- assign end_year = item.end_date | date: '%Y' -%}
                {{- start_year -}}
                {%- unless end_year == start_year %}–{{ end_year }}{% endunless -%}
              </em>
            </div>
          </li>
        {% endfor %}
      </ol>
      {% assign review_number = review_number | plus: venues.size %}
    {% endif %}
  {% endfor %}
</div>

## Mentoring

<p class="mentoring-note">
  All mentees supervised in conjunction with <a href="https://sites.nd.edu/taeho-jung/">Prof. Taeho Jung</a> (University of Notre Dame).<br />
  <sup>*</sup>University of Notre Dame &nbsp;|&nbsp; <sup>†</sup>Indiana Institute of Technology
</p>

<table class="mentoring">
  {% for row in sections.Mentoring %}
    <tr>
      <th scope="row">{{ row.term }}</th>
      <td>{{ row.mentees | replace: '*', '<sup>*</sup>' | replace: '†', '<sup>†</sup>' }}</td>
    </tr>
  {% endfor %}
</table>

## Leadership & outreach

<ul class="entries">
  {% for item in outreach %}
    <li>
      <div class="entry-head d-flex flex-wrap justify-content-between align-items-baseline">
        <span>
          <strong>{{ item.position }}</strong>{% if item.company != "" %}, {{ item.company }}{% endif %}
        </span>
        <em>{% assign start_year = item.start_date | date: '%Y' %}{% assign end_year = item.end_date | date: '%Y' %}{{ start_year }}{% unless end_year == start_year %}–{{ end_year }}{% endunless %}</em>
      </div>
      {% if item.summary %}<div class="entry-detail">{{ item.summary | markdownify | remove: '<p>' | remove: '</p>' }}</div>{% endif %}
    </li>
  {% endfor %}
</ul>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

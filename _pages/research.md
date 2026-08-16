---
layout: page
permalink: /research/
title: Research
description: # kept empty; the description tag also feeds meta tags, which strip no HTML — the Scholar link lives in the body below
nav: true
nav_order: 1
---

<!-- _pages/research.md — /publications/ redirects here (see publications-redirect.html) -->

I build systems that let mutually distrusting parties store, share, and compute on data with cryptographic integrity and confidentiality guarantees. Current directions include decentralized data infrastructures ([Web3DB](https://www.web3db.org/), [Web3FS](https://fs.web3db.org/)), secure logging and provenance for data sharing in the age of generative AI.

**Profiles:** [Google Scholar](https://scholar.google.com/citations?user={{ site.data.socials.scholar_userid }}) · [Semantic Scholar](https://www.semanticscholar.org/author/{{ site.data.socials.semanticscholar_id }}) · [DBLP]({{ site.data.socials.dblp_url }}) · [OpenReview]({{ site.data.socials.custom_social.url }}) · [ORCID](https://orcid.org/{{ site.data.socials.orcid_id }})

<!-- Bibsearch Feature -->

{% include bib_search.liquid %}

<div class="publications">

{% bibliography %}

</div>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

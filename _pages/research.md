---
layout: page
permalink: /research/
title: Research
description: # kept empty; the description tag also feeds meta tags, which strip no HTML — the Scholar link lives in the body below
nav: true
nav_order: 1
---

<!-- _pages/research.md — /publications/ redirects here (see publications-redirect.html) -->

I build systems that let mutually distrusting parties store, share, and compute on data with cryptographic integrity and confidentiality guarantees. Current directions include decentralized multi-tenant databases ([Web3DB](https://www.web3db.org/), MtDB), secure logging and provenance for data sharing, and consent and data-ownership mechanisms in the age of generative AI.

Publications below, also on [Google Scholar](https://scholar.google.com/citations?user=kbODGysAAAAJ).

<!-- Bibsearch Feature -->

{% include bib_search.liquid %}

<div class="publications">

{% bibliography %}

</div>

<script src="{{ '/assets/js/site-tweaks.js' | relative_url }}"></script>

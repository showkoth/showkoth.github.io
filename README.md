# showkothossain.com

Personal academic website of **Showkot Hossain** — PhD student, Computer Science and Engineering, University of Notre Dame.

Live at [showkothossain.com](https://showkothossain.com), hosted on GitHub Pages.

Built on [al-folio](https://github.com/alshedivat/al-folio) v1.x, which is a thin Jekyll starter: all runtime (layouts, styles, feature plugins) ships as versioned gems under [al-org-dev](https://github.com/al-org-dev), pinned in the `Gemfile`.

## Development

```bash
bundle install
bundle exec jekyll serve   # http://localhost:4000/al-folio/  (note the baseurl)
```

Or with Docker:

```bash
docker compose up -d       # http://127.0.0.1:8080/al-folio/
```

Deployment is automatic: pushing to `main` triggers the `deploy.yml` workflow, which builds the site and publishes it to the `gh-pages` branch.

## Content map

| What              | Where                                           |
| ----------------- | ----------------------------------------------- |
| About page        | `_pages/about.md`                               |
| Publications      | `_bibliography/papers.bib` + `_data/*.yml`      |
| News items        | `_news/`                                        |
| CV (rendered PDF) | `assets/cv-src/` → `assets/pdf/academic-cv.pdf` |
| Site config       | `_config.yml`                                   |

For maintenance rules, tests, and the starter/gem boundary, see [AGENTS.md](AGENTS.md) and [docs/](docs/README.md).

## License

Template code under the [MIT License](LICENSE). Site content © Showkot Hossain.

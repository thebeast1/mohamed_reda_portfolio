# Mohamed Reda — Flutter Portfolio

Personal portfolio built with Flutter Web and deployed to GitHub Pages.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Update the content

Everything on the page (summary, experience, projects, skills, education, contact)
lives in `lib/data/cv_data.dart`. Edit it, commit, push — the site rebuilds itself.

## Deployment

`.github/workflows/deploy.yml` runs on every push to `main`:

1. Builds with `flutter build web --release --base-href /<repo-name>/`
2. Publishes `build/web` to the `gh-pages` branch

First-time setup: in the repo go to **Settings → Pages**, set **Source** to
"Deploy from a branch", branch **gh-pages**, folder **/ (root)**.

The site is then live at `https://<your-username>.github.io/mohamed_reda_portfolio/`.

## Structure

```
lib/
  main.dart              App entry + theme
  theme.dart             Colors, text styles, button themes
  home_page.dart         Nav bar, drawer, scroll-to-section
  data/cv_data.dart      All portfolio content
  sections/              Hero, About, Experience, Projects, Skills, Education, Contact
  widgets/               Shared UI (cards, chips, responsive grid, nav)
web/                     index.html (loader, SEO tags), favicon, manifest
```

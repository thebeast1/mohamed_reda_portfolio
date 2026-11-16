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
  main.dart              App entry, go_router routes, shared shell (nav + footer)
  theme.dart             Design tokens from the Figma template (colours, type, spacing)
  data/cv_data.dart      All portfolio content
  pages/                 Home, About, Projects, Contact
  widgets/               Design-system widgets (ds.dart), nav bar, footer, cards, screenshot strip
web/                     index.html (loader, SEO tags), favicon, manifest

Design: Figma community template "Full Stack Developer Portfolio – Modern Tech Showcase",
rebuilt in Flutter with Poppins headings and Inter body text (loaded via google_fonts).
```

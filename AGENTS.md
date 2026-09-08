# Project conventions

This is Chris's personal website: Markdown with TOML front matter, rendered by
Hugo into static HTML/CSS and deployed by GitHub Actions to Cloudflare Workers
Static Assets. Read README.md and .skills/README.md before making changes.

- Serve no first-party JavaScript. Live YouTube iframes are explicitly allowed.
- No comments, mailing lists, database, CMS, or custom Worker runtime.
- Keep each post's text in content/posts/<slug>/index.md, with images beside it.
- Give posts an explicit summary and tags. Use draft = true for examples and
  unfinished work. Drafts in this public repository are still publicly readable.
- Never invent autobiographical details. Clearly label demonstration content.
- Use reusable shortcodes for structured prose; keep styling in assets/css/.
- Hugo permits raw HTML to render Markdown shortcodes. Review content changes
  for scripts and use shortcodes for embeds; this is trusted author input.
- Preserve semantic HTML, keyboard focus, image alt text, iframe titles, and
  responsive layouts. Video and commentary sit side by side on wide screens.
- Tags link to prebuilt pages; there is no client-side filtering.
- Run Hugo with --gc --minify --panicOnWarning after template/config changes.
  Also build with --buildDrafts when changing demonstration components. Check
  generated HTML for correct content and absence of script tags/JS assets.
- Never edit public/ or resources/ directly; they are generated and ignored.
- Keep tool versions aligned with .github/workflows/deploy.yml.
- CI builds pull requests; only main pushes or manual main runs deploy when
  deployment configuration is present. Keep credentials in GitHub secrets.
- Record durable project decisions in .skills/README.md. Add focused local
  guidance there as needed; avoid introducing tooling just to maintain notes.

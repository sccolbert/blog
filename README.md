# Chris's website

A small Hugo site with Markdown/TOML content, custom HTML templates, and CSS.
No first-party JavaScript. Live YouTube iframes are supported.

## Local preview

Install Hugo with `brew install hugo`. The version pinned in CI is **0.165.0**;
check your local version with `hugo version`. Then run:

```sh
hugo server --buildDrafts --disableLiveReload
```

Open http://localhost:1313. Live reload is disabled so Hugo does not inject its
development JavaScript. Refresh the browser after edits.

```sh
hugo --gc --minify --panicOnWarning
```

This creates the production site in public/. Drafts are excluded. Preview with
--buildDrafts to see six sample posts plus the component sampler. Samples carry
params.sample = true and visible labels; their prose is fictional design content.
The production homepage has no published posts until real writing is added.

## Write a post

```sh
hugo new content posts/my-new-post/index.md
```

Edit that file's title, date, summary, and tags. Put associated images in the same
directory. Set draft = false when ready to publish. Use a stable folder name or
explicit slug for stable URLs. Future-dated posts are excluded until a later
build after their publication date; there is no scheduled publishing job yet.

Public Git history includes draft source files. Keep private writing outside
this repository.

Regular pages can live at content/<name>.md. The homepage introduction replaces
a separate About page. Homepage text lives at content/_index.md; site settings
live in hugo.toml.

## Structured content

Use Markdown-notation shortcodes so the body remains Markdown:

```markdown
{{% video-commentary id="M7lc1UVf-VE" title="A descriptive video title" %}}
## My thoughts

Write commentary here. The video sits beside it on desktop and above it on mobile.
{{% /video-commentary %}}

{{% columns %}}
{{% column %}}
First column, with **Markdown**.
{{% /column %}}
{{% column %}}
Second column.
{{% /column %}}
{{% /columns %}}

{{% callout title="Worth remembering" %}}
A short aside.
{{% /callout %}}
```

Video IDs and titles are required. Players use youtube-nocookie.com, lazy
loading, fullscreen, and no autoplay. YouTube runs its own scripts inside the
iframe. A direct video link is included as a fallback.

For local images, use Markdown `![Descriptive alt text](photo.jpg)` or Hugo's
built-in figure shortcode for captions:

```markdown
{{< figure src="photo.jpg" alt="Describe the image" caption="Optional caption" >}}
```

Size/compress photos before adding them. Automatic image variants are not yet
implemented. Shared images belong in static/images/ and use /images/name.jpg.
Tags generate normal HTML navigation pages at /tags/<tag>/.

## Deployment setup

1. Create the public GitHub repository and push this project to main.
2. Choose the Cloudflare Worker name in wrangler.toml.
3. Set the GitHub repository variable SITE_URL to the complete public URL,
   including https:// and a trailing slash. Update hugo.toml's baseURL to match.
4. Add CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID as GitHub Actions secrets.
   Use an API token scoped to the target account with Workers Scripts edit
   permission. Configure a custom domain in Cloudflare if desired.
5. Push to main or manually run the workflow on main.

Pull requests build production output and validate draft components. Main
builds deploy once SITE_URL is configured. Before that, CI only builds artifacts.
The production environment may optionally have GitHub approval rules.

CI rebuilds the whole site so indexes and tag pages stay consistent, then
Wrangler uploads assets to Cloudflare. No custom Worker script is needed.
Node-based deployment tooling runs in CI only; it adds no browser JavaScript.

## Project map

- content/: pages and post bundles.
- layouts/: page templates, _partials/, and _shortcodes/.
- assets/css/: site styles, fingerprinted during builds.
- static/: files copied directly into the site.
- archetypes/: templates for new content.
- .github/workflows/: validation and deployment.
- AGENTS.md: agent working conventions.
- .skills/: project knowledge and future local workflow documentation.
- public/ and resources/: generated output, ignored by Git.

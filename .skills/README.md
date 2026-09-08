# Project knowledge

This folder holds repository-local workflows, authoring notes, and decisions.
It is not published by Hugo. It is a documentation folder, not automatically
registered as an agent skill directory.

## Accepted decisions

- Hugo with a custom theme stored directly in layouts/ and assets/.
- Markdown prose and TOML front matter; explicit summaries; flexible tags.
- HTML/CSS only for our site. YouTube's live iframe player is allowed.
- Video commentary renders beside the player, stacking on smaller screens.
- No X integration, comments, mailing lists, or application backend.
- GitHub Actions renders the complete site and Wrangler deploys static assets.
- Generated files stay out of Git. Cloudflare handles asset upload reuse.
- Public GitHub repository: sccolbert/blog, with main as the default branch.

## Places to track work

- README.md: setup, authoring, and deployment instructions.
- AGENTS.md: conventions for coding agents.
- This file: accepted decisions and unresolved project choices.

## Still to choose

- Production domain and Cloudflare Worker name.
- Final visual identity, homepage introduction, and About page copy.
- Real initial posts, images, and videos; the component sampler is a draft.

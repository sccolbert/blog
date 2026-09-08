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
- Deployment is currently hard-disabled in CI with a false job condition. Builds
  and artifact uploads run normally without Cloudflare credentials.
- CI verifies Hugo against a committed SHA-256 and executes it only inside an
  isolated scratch container. Actions are pinned to commit SHAs; checkout does
  not persist credentials. See README.md for the boundaries and upgrade process.
- Generated files stay out of Git. Cloudflare handles asset upload reuse.
- Public GitHub repository: sccolbert/blog, with main as the default branch.
- Initial visual direction: a personal notebook with parchment, forest green,
  clay accents, engineering-inspired sans-serif text, and restrained monospace labels. Aim for
  warmth, mature confidence, and craftsmanship. Precision machining informs the
  details: a dial-caliper drawing in inline SVG and an instrument-style monogram.
- Use a local sans-serif font stack for headings and prose, with no font downloads.
  Keep the handwritten pencil signature as the exception.
- Display name: S. Chris Colbert. Initials: SCC. Chris is a mechanical engineer
  who enjoys precision machining. The homepage introduction replaces About.
- Homepage headline: "Build purposefully. Live thoughtfully." Keep the drawing's
  caption: "Things worth building on."
- The caliper's 3.160-inch dimension and handwritten "- John" signature are an
  intentional reference to John 3:16. The signature uses SVG strokes, not a font.
- The caliper opens once per page load using CSS only: 84 SVG units of jaw travel
  and 31.6 dial revolutions share the same two-second easing and delay. The note
  and dimension fade in afterward. Reduced motion shows the finished drawing.
- Six draft sample posts exercise essays, reflections, short notes, code,
  images, columns, callouts, and YouTube commentary. params.sample labels fiction.

## Places to track work

- README.md: setup, authoring, and deployment instructions.
- AGENTS.md: conventions for coding agents.
- This file: accepted decisions and unresolved project choices.

## Still to choose

- Production domain and Cloudflare Worker name.
- Further refinements to the machining theme and homepage introduction.
- Real initial posts, images, and videos; all sample posts remain drafts.

#!/usr/bin/env bash
set -euo pipefail

# The runner downloads/verifies Hugo, but only the container executes it.
repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
source "$repo_dir/ci/hugo.env"
output_dir=${1:?Usage: bash scripts/ci-build.sh /absolute/new-output-directory}
if [[ "$output_dir" != /* || -e "$output_dir" ]]; then
  printf 'Output must be an absolute path that does not already exist.\n' >&2
  exit 1
fi
build_dir=$(mktemp -d "${TMPDIR:-/tmp}/blog-ci.XXXXXX")
mkdir "$build_dir/context" "$build_dir/source" "$build_dir/drafts" "$output_dir"
output_dir=$(cd "$output_dir" && pwd)

archive="hugo_${HUGO_VERSION}_linux-amd64.tar.gz"
curl --fail --location --retry 3 --proto '=https' --proto-redir '=https' \
  "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${archive}" \
  -o "$build_dir/$archive"
(
  cd "$build_dir"
  if command -v shasum >/dev/null; then
    actual_hash=$(shasum -a 256 "$archive")
  else
    actual_hash=$(sha256sum "$archive")
  fi
  if [[ "${actual_hash%% *}" != "$HUGO_SHA256" ]]; then
    printf 'Hugo archive checksum mismatch; refusing to extract or execute it.\n' >&2
    exit 1
  fi
  printf 'Hugo archive checksum verified.\n'
)
tar -xzf "$build_dir/$archive" -C "$build_dir/context" hugo
chmod 0555 "$build_dir/context/hugo"

# Explicit allowlist: no .git, workflows, runner files, or local .env files.
# Reject symlinks and special files before copying the source snapshot.
for entry in hugo.toml content layouts assets static; do
  if [[ -n $(find "$repo_dir/$entry" ! -type f ! -type d -print -quit) ]]; then
    printf 'Unsupported source file type in %s.\n' "$entry" >&2
    exit 1
  fi
  cp -R "$repo_dir/$entry" "$build_dir/source/$entry"
done

docker build --platform linux/amd64 --network none \
  --file "$repo_dir/ci/Dockerfile.hugo" \
  --iidfile "$build_dir/image-id" "$build_dir/context"
build_image=$(<"$build_dir/image-id")

run_hugo() {
  local destination=$1
  shift
  local status=0
  # Treat Hugo's log output as untrusted. It must not issue runner commands.
  local log_guard
  log_guard=$(openssl rand -hex 32)
  if [[ ${GITHUB_ACTIONS:-} == true ]]; then
    printf '::stop-commands::%s\n' "$log_guard"
  fi
  docker run --rm --platform linux/amd64 --network none \
    --read-only --cap-drop ALL --security-opt no-new-privileges \
    --user "$(id -u):$(id -g)" --pids-limit 64 --memory 512m --cpus 2 \
    --tmpfs /tmp:rw,noexec,nosuid,size=256m,mode=1777 \
    --mount "type=bind,src=$build_dir/source,dst=/src,readonly" \
    --mount "type=bind,src=$destination,dst=/out" \
    --env HUGO_RESOURCEDIR=/tmp/resources \
    "$build_image" --source /src --destination /out --noBuildLock \
    --cacheDir /tmp/cache --panicOnWarning "$@" || status=$?
  if [[ ${GITHUB_ACTIONS:-} == true ]]; then
    printf '::%s::\n' "$log_guard"
  fi
  return "$status"
}

run_hugo "$build_dir/drafts" --buildDrafts
run_hugo "$output_dir" --gc --minify --baseURL "${SITE_URL:-https://example.com/}"

# A compromised renderer could write links that the artifact uploader follows
# outside /out after the container exits. Never hand those to the upload step.
if [[ -n $(find "$output_dir" ! -type f ! -type d -print -quit) ]]; then
  printf 'Refusing build output containing symlinks or special files.\n' >&2
  exit 1
fi
if [[ ! -f "$output_dir/index.html" ]]; then
  printf 'Build did not produce index.html.\n' >&2
  exit 1
fi
printf 'Isolated draft and production builds passed.\n'

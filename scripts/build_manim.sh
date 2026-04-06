#!/usr/bin/env bash
# build_manim.sh – render the SimplePendulum scene and copy it to assets/videos/
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

mkdir -p assets/videos

echo "Rendering SimplePendulum with Manim (high quality)…"
manim -qh manim/pendulum.py SimplePendulum

# Manim writes output under media/videos/<scene_file>/<quality>/
# Use a wildcard so the path is not coupled to the quality flag.
latest_mp4="$(find media/videos/pendulum -name '*.mp4' -printf '%T@ %p\n' 2>/dev/null \
              | sort -rn | head -n 1 | awk '{print $2}' || true)"

# Fallback: search the whole media tree
if [[ -z "$latest_mp4" ]]; then
    latest_mp4="$(find media/videos -name '*.mp4' -printf '%T@ %p\n' 2>/dev/null \
                  | sort -rn | head -n 1 | awk '{print $2}')"
fi

if [[ -z "$latest_mp4" ]]; then
    echo "ERROR: could not find a rendered mp4 under media/videos/." >&2
    exit 1
fi

cp "$latest_mp4" assets/videos/pendulum.mp4
echo "Wrote assets/videos/pendulum.mp4"

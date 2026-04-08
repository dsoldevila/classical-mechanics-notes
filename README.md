# Classical Mechanics Notes

My working notes while studying classical mechanics (Susskind *The Theoretical Minimum*),
built with [Quarto](https://quarto.org/) and Python.

## Local build instructions

### 1 – Prerequisites

| Tool | Install |
|------|---------|
| [uv](https://docs.astral.sh/uv/) | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| [Quarto CLI](https://quarto.org/docs/download/) | Download from quarto.org |
| FFmpeg | `apt install ffmpeg` / `brew install ffmpeg` |

### 2 – Install Python dependencies

```bash
uv sync
```

This creates a `.venv/` folder with all required packages (numpy, scipy, sympy,
matplotlib, jupyter, manim).

### 3 – Build the Manim animation

```bash
./scripts/build_manim.sh
```

The script renders `manim/pendulum.py` and copies the result to
`assets/videos/pendulum.mp4`, which is referenced in chapter 2.

### 4 – Render / preview the Quarto book

```bash
# One-shot render
quarto render

# Live preview (opens in browser, auto-reloads on save)
quarto preview
```

The built site lands in `_site/`.

### 5 – Run Python code cells with uv

Quarto uses the Jupyter kernel.  Make sure it resolves to the uv environment:

```bash
uv run quarto render
# or
uv run quarto preview
```

## GitHub Pages publishing

The site is published to
<https://dsoldevila.github.io/classical-mechanics-notes/> via GitHub Pages.

Publishing is automated with GitHub Actions in
`.github/workflows/publish.yml`.

### One-time setup

1. Push this repository to GitHub (default branch: `main`).
2. Open **Settings → Pages** in GitHub.
3. Set **Source** to **GitHub Actions**.

### Regular publishing flow

Every push to `main` will:

1. Install dependencies (`ffmpeg`, Python packages via `uv sync`).
2. Build Manim assets with `scripts/build_manim.sh`.
3. Render the Quarto book.
4. Deploy `_site/` to GitHub Pages.

You can also trigger a deployment manually from the **Actions** tab
using the `workflow_dispatch` trigger.

If a deploy fails, open the `Publish Quarto Book` workflow logs in GitHub
to inspect the failing step.

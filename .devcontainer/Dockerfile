FROM ubuntu:22.04

ARG QUARTO_VERSION=1.9.36

ENV DEBIAN_FRONTEND=noninteractive \
    UV_PYTHON_PREFERENCE=system \
    UV_LINK_MODE=copy \
    PYTHONUNBUFFERED=1

# System deps:
#   build-essential, pkg-config  — compile Python C extensions
#   python3.11*                  — runtime + dev headers + venv support
#   ffmpeg                       — required by Manim for video rendering
#   libcairo2-dev                — required by pycairo (Manim's renderer)
#   libpango1.0-dev              — required by manimpango (Manim text)
#   libjpeg-dev, libpng-dev      — required by Pillow (used by Manim/matplotlib)
#   git, wget                    — tooling
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        python3.11 \
        python3.11-dev \
        python3.11-venv \
        ffmpeg \
        libcairo2-dev \
        libpango1.0-dev \
        libjpeg-dev \
        libpng-dev \
        git \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install uv — copied from the official image, no curl-pipe-sh
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv
COPY --from=ghcr.io/astral-sh/uv:latest /uvx /usr/local/bin/uvx

# Install Quarto CLI
RUN wget -q \
        "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" \
        -O /tmp/quarto.deb \
    && dpkg -i /tmp/quarto.deb \
    && rm /tmp/quarto.deb

WORKDIR /workspace

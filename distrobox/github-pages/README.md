# Distrobox GitHub Pages Environment

Arch Linux-based container for building and managing GitHub Pages sites with Jekyll or Hugo.

## Quick Start

```bash
podman build -t distrobox-github-pages ~/.dotfiles/distrobox/github-pages/
distrobox create -i distrobox-github-pages -n pages
distrobox enter pages
distrobox-setup
```

## Included Tools

### Static Site Generators
- **Jekyll** - Ruby-based (GitHub Pages native)
- **Hugo** - Go-based (fast builds, via setup.sh)

### Ruby/Jekyll Gems
- github-pages
- jekyll-sitemap
- jekyll-feed
- jekyll-seo-tag
- webrick

### Asset Tools
- **Node.js/npm** - JavaScript tooling
- **imagemagick** - Image manipulation
- **optipng** - PNG optimization
- **jpegoptim** - JPEG optimization

### Development
- **git** - Version control
- **gh** - GitHub CLI
- **lazygit** - Git TUI
- **neovim** - Editor

## Helper Commands

| Command | Description |
|---------|-------------|
| `jekyll-new [name]` | Create new Jekyll site |
| `jekyll-serve` | Serve with live reload (:4000) |
| `jekyll-build` | Production build |
| `gh-pages-deploy` | Build for deployment |

## Workflows

### New Jekyll Site

```bash
jekyll-new my-blog
cd my-blog
jekyll-serve
# Visit http://localhost:4000
```

### New Hugo Site

```bash
hugo new site my-blog
cd my-blog

# Add a theme
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke themes/ananke
echo "theme = 'ananke'" >> hugo.toml

# Create content
hugo new posts/my-first-post.md

# Serve
hugo server -D
# Visit http://localhost:1313
```

### Existing GitHub Pages Site

```bash
cd ~/your-site
bundle install
jekyll-serve
```

### Deploy to GitHub Pages

```bash
# Build production
jekyll-build

# Commit and push
git add .
git commit -m "Update site"
git push

# Or use gh cli
gh repo view --web
```

### Image Optimization

```bash
# Optimize PNGs
optipng -o7 images/*.png

# Optimize JPEGs
jpegoptim --strip-all --max=85 images/*.jpg

# Resize with ImageMagick
convert image.png -resize 800x image-small.png
```

### Common Jekyll Config (_config.yml)

```yaml
title: My Site
description: A blog about things
url: "https://username.github.io"
baseurl: ""

theme: minima

plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag

# Build settings
markdown: kramdown
permalink: /:title/
```

### GitHub Actions Workflow

Create `.github/workflows/pages.yml`:

```yaml
name: Deploy Jekyll

on:
  push:
    branches: ["main"]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/configure-pages@v4
      - uses: actions/jekyll-build-pages@v1
      - uses: actions/upload-pages-artifact@v3

  deploy:
    runs-on: ubuntu-latest
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/deploy-pages@v4
        id: deployment
```

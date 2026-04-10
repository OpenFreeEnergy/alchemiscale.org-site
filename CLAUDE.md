# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the **alchemiscale.org** website, a Hugo-based static site that provides information about the alchemiscale project. Alchemiscale is a distributed execution system for alchemical networks, part of the Open Free Energy (OpenFE) ecosystem. The site is built using the [Blowfish](https://blowfish.page/) Hugo theme.

## Build and Development Commands

The project uses a `justfile` for common tasks. Prefer `just` commands over raw `hugo` commands.

```bash
just serve              # Dev server with live reload
just serve-drafts       # Dev server including draft content
just build              # Build with minification
just build-production   # Build for production (sets baseURL)
just clean              # Remove public/ and resources/_gen/
just new-advancement <name>  # Scaffold a new advancement post directory
```

## Project Structure

### Content Organization

The site uses Hugo's content organization with three main content sections:

- **`content/advancements/`**: Blog-style posts about alchemiscale project releases, updates, and announcements. Each advancement is a directory with an `index.md` file and optional images.
- **`content/opportunities/`**: Posts describing development opportunities, roadmaps, and ways to contribute to the project. Similar structure to advancements.
- **`content/roadmaps/`**: Future planning and roadmap documents.
- **`content/_index.md`**: Homepage content.

### Configuration

Hugo configuration is split across multiple files in `config/_default/`:

- **`hugo.toml`**: Main site configuration including theme, taxonomies, and Hugo-specific settings. Uses the Blowfish theme.
- **`params.toml`**: Theme-specific parameters controlling appearance, layout, and features. The site uses a custom `colorScheme = "alchemiscale"` defined in the theme assets.
- **`languages.en.toml`**: Language-specific configuration.
- **`menus.en.toml`**: Navigation menu structure.
- **`module.toml`**: Hugo module configuration (minimal, just specifies minimum Hugo version).
- **`markup.toml`**: Markdown rendering configuration.

### Theme

The site uses the Blowfish theme located in `themes/blowfish/` as a git submodule. The theme provides layouts, assets, and base styling. Site-specific customizations:

- Custom color scheme: `colorScheme = "alchemiscale"` (defined in theme assets)
- Homepage layout: `layout = "page"` with custom logo
- Header layout: `layout = "fixed-gradient"`

### Authors

Author information is stored as JSON files in `data/authors/`. For example, `data/authors/dotsdl.json` contains author metadata including name, bio, image, and social links. Authors are referenced in post front matter via the `authors` field.

### Static Assets

- **`static/img/`**: Images including favicons and the alchemiscale logo variants.
- **`assets/css/`**: Custom CSS (if needed for theme overrides).

### Generated Output

- **`public/`**: Generated static site (git-ignored, created by `hugo` build command).

## Content Authoring

### Creating New Posts

Advancements and opportunities follow a consistent structure:

**Front matter template:**
```yaml
---
title: "post title"
date: "2025-06-02T00:00:00-00:00"  # ISO 8601 format with timezone
authors: ["dotsdl"]  # must match filenames in data/authors/
tags: ["release"]
showTableOfContents: false
draft: false  # set to true to exclude from builds
---
```

Each post is a directory (e.g., `content/advancements/my-post/`) with an `index.md` file. Images, PDFs, and other assets can be placed in the same directory and referenced relatively in the markdown.

### Hugo Shortcodes

The site uses Hugo/Blowfish shortcodes:
- `{{< figure src="/img/logo.png" title="Title" >}}` for images
- `{{< ref "/opportunities" >}}` for internal cross-references

## Deployment

The site is deployed to GitHub Pages via `.github/workflows/hugo.yml`:

1. Triggered on push to `main` branch or manual workflow dispatch
2. Uses Hugo extended version 0.128.0
3. Checks out code with submodules (for the Blowfish theme)
4. Builds with `hugo --minify`
5. Uploads artifact and deploys to GitHub Pages

## Important Notes

- **Git submodule for theme**: The Blowfish theme is a git submodule in `themes/blowfish/`. When cloning, use `git clone --recurse-submodules` or run `git submodule update --init --recursive` after cloning. If the theme directory is empty, Hugo will fail to build.
- **Hugo version**: Requires Hugo extended version (minimum 0.87.0, deployment uses 0.128.0). The extended version is needed for SCSS/SASS processing.
- **Custom styling**: The site uses a custom `colorScheme = "alchemiscale"` defined in the Blowfish theme's assets. Avoid adding custom CSS unless absolutely necessary; use theme configuration in `params.toml` instead.
- **Content types**: The site has three main content types:
  - Homepage (`content/_index.md`): Project overview
  - Advancements (`content/advancements/`): Release announcements and project updates
  - Opportunities (`content/opportunities/`): Development opportunities and contribution guides

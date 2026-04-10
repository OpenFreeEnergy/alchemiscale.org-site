# alchemiscale.org site commands

# Base URL for production builds
production_url := "https://alchemiscale.org/"

# Run the development server with live reload
serve:
    hugo server

# Run the development server including draft content
serve-drafts:
    hugo server --buildDrafts

# Build the site
build:
    hugo --minify

# Build the site for production
build-production:
    hugo --minify --baseURL "{{ production_url }}"

# Remove generated files
clean:
    rm -rf public resources/_gen

# Create a new advancement post
new-advancement name:
    hugo new content/advancements/{{ name }}/index.md

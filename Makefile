RUBY_BIN := /c/Ruby33-x64/bin
BUNDLE   := $(RUBY_BIN)/bundle
JEKYLL   := $(BUNDLE) exec jekyll

export PATH := $(RUBY_BIN):$(PATH)

.DEFAULT_GOAL := serve

# ── Install dependencies ──────────────────────────────────────────────────────
install:
	gem install bundler
	$(BUNDLE) install

# ── Serve locally with live reload ───────────────────────────────────────────
serve:
	$(JEKYLL) serve --baseurl "" --livereload

# ── Build to _site/ (production) ─────────────────────────────────────────────
build:
	JEKYLL_ENV=production $(JEKYLL) build

# ── Build with drafts visible ─────────────────────────────────────────────────
drafts:
	$(JEKYLL) serve --baseurl "" --livereload --drafts

# ── Remove generated files ────────────────────────────────────────────────────
clean:
	$(JEKYLL) clean

# ── Full reinstall ────────────────────────────────────────────────────────────
reset: clean
	rm -f Gemfile.lock
	$(BUNDLE) install

.PHONY: install serve build drafts clean reset

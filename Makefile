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

# ── Strip UTF-8 BOM from all markdown files (prevents GitHub Pages build failures) ──
fix-bom:
	@python3 -c "\
import os, glob; \
files = glob.glob('**/*.md', recursive=True); \
fixed = []; \
[fixed.append(f) or open(f,'wb').write(open(f,'rb').read()[3:]) for f in files if open(f,'rb').read(3) == b'\xef\xbb\xbf']; \
print('BOM removed from: ' + ', '.join(fixed)) if fixed else print('No BOM found in any .md files') \
"

# ── Full reinstall ────────────────────────────────────────────────────────────
reset: clean
	rm -f Gemfile.lock
	$(BUNDLE) install

.PHONY: install serve build drafts clean reset fix-bom

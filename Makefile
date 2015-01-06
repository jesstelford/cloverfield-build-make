PATH := node_modules/.bin:$(PATH)

source_dir := js
source_files := $(shell find $(source_dir)/ -type f -name '*.js')
sass_dir     := bower_components/todomvc-common
sass_files   := $(wildcard $(sass_dir)/*.css)
css_files    := $(sass_files:$(sass_dir)/%.css=lib/%.css)
test_dir     := test
test_files   := $(shell find $(test_dir)/ -type f -name '*.js')

.PHONY: lint libdir test

all: lint build test

libdir:
	@mkdir -p lib

lib/app.js: $(source_files) libdir
	@uglifyjs $(source_files) -c > $@

lib/%.css: $(sass_dir)/%.css libdir
	@node-sass $< $@

lib/app.css: $(sass_files) libdir
	@./scripts/node-sass $(sass_files) > $@

lint: $(source_files)
	@eslint $(source_dir)

test: lib/app.js
	@./scripts/test-runner $(test_files)

build: lib/app.js $(css_files)

clean:
	@rm -rf lib

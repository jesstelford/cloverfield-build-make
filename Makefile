# node modules in executable path
PATH := node_modules/.bin:$(PATH)

# OSX requires this variable exported so that PATH is also exported.
SHELL := /bin/bash

source_dir := js
test_dir   := test
sass_dir   := bower_components/todomvc-common

# Get a list by searching for files in given directories
source_files := $(shell find $(source_dir)/ -type f -name '*.js')
sass_files   := $(wildcard $(sass_dir)/*.css)
test_files   := $(shell find $(test_dir)/ -type f -name '*.js')

# Get a list by changing the directory of files
css_files    := $(sass_files:$(sass_dir)/%.css=lib/%.css)


# These targets don't produce any output
.PHONY: lint test

# first / default target to perform all other targets
all: lint build test

# Other targets rely on this directory being created
libdir:
	@mkdir -p lib

# Concat + compress js files into lib/app.js
lib/app.js: $(source_files) libdir
	@uglifyjs $(source_files) -c > $@

# Process Sass files into css files, saved in lib/
lib/%.css: $(sass_dir)/%.css libdir
	@node-sass $< $@

# A shorthand target for compiling lib/app.js
js: lib/app.js

# A shorthand target for compiling all the css files into lib/
css: $(css_files)

# Shorthand for building all js and css targets
build: js css

watch-js: js
	@watch "make js" $(source_dir)

watch-css: css
	@watch "make css" $(sass_dir)

watch-build:
	@./scripts/parallel.sh "make watch-js" "make watch-css"

# Lint the found .js files with eslint
lint: $(source_files)
	@eslint $(source_dir)

# tape tests first require the js files be built (so we're testing what would be
# run, and not what we're developing on as it's possibile subtle differences may
# be introduced after compilation / transpilation)
test: js
	@./scripts/test-runner $(test_files)

# Clean up after all other targets / start fresh
clean:
	@rm -rf lib

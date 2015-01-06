PATH := node_modules/.bin:$(PATH)

source_dir := js
source_files := $(shell find $(source_dir)/ -type f -name '*.js')

.PHONY: lint

all: lint build

lint: $(source_files)
	@eslint $(source_dir)

lib/app.js: $(source_files)
	@mkdir -p lib
	@uglifyjs $(source_files) -c > $@

build: lib/app.js

clean:
	@rm -rf lib

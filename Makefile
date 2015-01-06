PATH := node_modules/.bin:$(PATH)

source_dir := js
source_files := $(shell find $(source_dir)/ -type f -name '*.js')

.PHONY: lint

lint: $(source_files)
	@eslint $(source_dir)

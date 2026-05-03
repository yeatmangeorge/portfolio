SRC=src/Main.elm
OUTPUT=dist/main.js
HTML=public/index.html
HOOK=hook

.PHONY: setup-hooks
setup-hooks:
	git config core.hooksPath $(HOOK)
	chmod +x $(HOOK)/*

.PHONY: format
format:
	elm-format src/ --yes

.PHONY: build
build: format
	mkdir -p dist
	elm make $(SRC) --optimize --output=$(OUTPUT)

.PHONY: run
run: build
	@echo "Open $(HTML) in your browser"

.PHONY: watch
watch:
	elm-live $(SRC) \
		--open \
		-- \
		--output=$(OUTPUT) \

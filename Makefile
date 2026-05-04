SRC=src/Main.elm
OUTPUT=dist/main.js
OUTPUT_FOLDER=dist
PUBLIC_FOLDER=public
HTML=$(PUBLIC_FOLDER)/index.html
HOOK=hook
RSYNC_CMD=rsync -a --delete --exclude "main.js" $(PUBLIC_FOLDER)/ $(OUTPUT_FOLDER)/

.PHONY: setup-hooks
setup-hooks:
	git config core.hooksPath $(HOOK)
	chmod +x $(HOOK)/*

.PHONY: format
format:
	elm-format src/ --yes

.PHONY: build
build: format
	mkdir -p $(OUTPUT_FOLDER)
	$(RSYNC_CMD)
	elm make $(SRC) --optimize --output=$(OUTPUT)

.PHONY: run
run: build
	@echo "Open $(HTML) in your browser"

watch:
	mkdir -p $(OUTPUT_FOLDER)
	$(RSYNC_CMD) && \
	(elm-live $(SRC) --dir=$(OUTPUT_FOLDER) --open -- --output=$(OUTPUT) & pid=$$!; \
	trap "kill $$pid" EXIT; \
	while inotifywait -qq -r -e modify,create,delete $(PUBLIC_FOLDER); do \
		$(RSYNC_CMD); \
	done)
default: build build/assets build/elm.app.js build/index.html

.PHONY: clean
clean:
	rm -rf build/

build:
	mkdir -p build

build/assets:
	cp -r assets build/assets

build/elm.app.js: $(shell find src/ -name '*.elm')
	elm make Main.elm --output build/elm.app.js

build/index.html:
	cp main.html build/index.html
	sed -i'.bak' 's/".*_compile.*"/"elm.app.js"/' build/index.html

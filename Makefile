all:
	yarn
	npm run format
	npm run build
	npm run package

.PHONY: test
test:
	yarn
	npm run lint
	npm run build
	npm test

.PHONY: once-mac
once-mac:
	brew reinstall npm
	brew reinstall yarn

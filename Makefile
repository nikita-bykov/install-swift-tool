.PHONY: build
build:
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
 
 .PHONY: clean
 clean:
	rm -f tsconfig.tsbuildinfo
	rm -rf dist
	rm -rf lib
	rm -rf types

.PHONY: git-status
git-status:
	@[ "$$(git status --porcelain)" = "" ] || ( echo "\033[0;31mError:\033[0m Working directory is dirty."; exit 1 )

.PHONY: publish
publish: clean build git-status
	@[ "$$(git tag --points-at HEAD)" != "" ] || ( echo "\033[0;31mError:\033[0m No tag found."; exit 1 )
	$$(sed -i '' -e 's/"version": "0.0.0",/"version": "$(shell git tag --points-at HEAD | tr -d 'v')",/g' package.json)
	@echo ================================================================================
	git --no-pager diff
	@echo ================================================================================
	@echo "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	npm publish
	git reset HEAD --hard

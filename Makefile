.PHONY: bootstrap
bootstrap:
	@brew update && (brew upgrade carthage 2> /dev/null) || true
	@carthage bootstrap --platform iOS --cache-builds --use-ssh

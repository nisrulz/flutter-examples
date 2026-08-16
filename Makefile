SHELL := /bin/bash

.PHONY: help packages clean-builds gradle-update

help: ## Show available commands
	@echo "Available commands:"
	@echo ""
	@echo "  make help             Show this help"
	@echo "  make packages         Run 'flutter packages get' for all apps"
	@echo "  make clean-builds     Move all build folders to trash"
	@echo "  make gradle-update    Upgrade Gradle wrappers"
	@echo ""
	@echo "gradle-update options:"
	@echo "  VERSION=<x.y.z>   Target Gradle version (default: latest from GitHub)"
	@echo "  FORCE=1           Upgrade even when already on the target version"
	@echo ""
	@echo "Examples:"
	@echo "  make gradle-update                              # latest version"
	@echo "  make gradle-update VERSION=9.7.0                # specific version"
	@echo "  make gradle-update FORCE=1                      # latest, force update"
	@echo "  make gradle-update VERSION=9.7.0 FORCE=1        # specific version, force update"

packages: ## Run flutter packages get for all apps
	./scripts/get_packages.sh

clean-builds: ## Move all build folders to trash
	./scripts/delete_build_folder.sh

gradle-update: ## Upgrade Gradle wrappers
	@args=""; \
	if [ -n "$(VERSION)" ]; then args="--version $(VERSION)"; fi; \
	if [ -n "$(FORCE)" ]; then args="$$args -f"; fi; \
	./scripts/update_gradle_wrapper.sh $$args

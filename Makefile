.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: base
base: ## Load a base part of the lab.
	sudo containerlab deploy --node-filters s1-pe03,s1-pe04,s1-p01,s1-p02,s1-ce03,s1-ce04

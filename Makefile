.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: info
info: ## Display lab information
	sudo containerlab inspect

.PHONY: clean
clean:  ## Clea containerlab eviroment.
	sudo rm -rf clab-atd-mpls-isis-sr/

.PHONY: base
base: ## Load a base part of the lab.
	sudo containerlab deploy --node-filter s1-pe03,s1-pe04,s1-p01,s1-p02,s1-ce03,s1-ce04

.PHONY: small-sh
small-sh: ## Load a base part of the lab. Single homed devices oriented.
	sudo containerlab deploy --node-filter s1-pe03,s1-pe04,s1-p01,s1-ce03,s1-ce04

.PHONY: small-mh
small-mh: ## Load a base part of the lab. Multi homed devices oriented.
	sudo containerlab deploy --node-filter s1-pe03,s1-pe01,s1-pe02,s1-p01,s1-ce01,s1-ce03,

.PHONY: large
base: ## Load a base part of the lab.
	sudo containerlab deploy --reconfigure

PHONY: down
down: ## Stop and remove the lab
	sudo containerlab destroy

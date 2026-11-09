COMPOSE ?= docker compose

.DEFAULT_GOAL := help

.PHONY: help up down build ps logs shell-server shell-client migrate keys submodules

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

up: ## Start the aggregate stack in the background
	$(COMPOSE) up -d --build

down: ## Stop the aggregate stack
	$(COMPOSE) down

build: ## Build all images
	$(COMPOSE) build

ps: ## Show container status
	$(COMPOSE) ps

logs: ## Follow logs of the aggregate stack
	$(COMPOSE) logs -f

shell-server: ## Open a shell in the server php container
	$(COMPOSE) exec server sh

shell-client: ## Open a shell in the client container
	$(COMPOSE) exec client sh

migrate: ## Apply Doctrine migrations (server)
	$(COMPOSE) exec server php bin/console doctrine:migrations:migrate -n

keys: ## Generate the JWT keypair (server)
	$(COMPOSE) exec server php bin/console lexik:jwt:generate-keypair --overwrite

submodules: ## Pull latest main of every submodule
	git submodule update --remote --merge

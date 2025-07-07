COMPOSE     = docker compose
COMPOSE_FILE= ./src/docker-compose.yml
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m

all: up

up:
	@echo "$(GREEN)[Makefile] Building and starting containers...$(NC)"
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	@echo "$(GREEN)[Makefile] Stopping containers...$(NC)"
	@$(COMPOSE) -f $(COMPOSE_FILE) down

fdown: 
	@echo "$(GREEN)[Makefile] Stopping containers, removing images and volumes...$(NC)"
	@$(COMPOSE) -f $(COMPOSE_FILE) down --rmi all --volumes

re: fdown up

logs:
	@if [ -z "$(SERVICE)" ]; then \
		echo "$(RED)[Makefile] Please specify a service name with 'make logs SERVICE=<name>'$(NC)"; \
		exit 1; \
	else \
		echo "$(GREEN)[Makefile] Showing logs for service: $(SERVICE)$(NC)"; \
		$(COMPOSE) -f $(COMPOSE_FILE) logs $(SERVICE); \
	fi

# Catch-all for unknown targets
.DEFAULT:
	@echo "$(RED)[Makefile] Unknown target: '$@'$(NC)"
	@echo "$(GREEN)Valid targets are:$(NC)"
	@echo "  make up           # Build and start containers"
	@echo "  make down         # Stop containers"
	@echo "  make fdown        # Stop containers and remove images/volumes"
	@echo "  make re           # Rebuild containers"
	@echo "  make logs SERVICE=<name>  # Show logs for a specific service"

.PHONY: all up down fdown re logs

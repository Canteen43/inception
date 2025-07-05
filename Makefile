COMPOSE     = docker compose
COMPOSE_FILE= ./src/docker-compose.yml

# Colors (optional)
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m

all: up

up:
	@echo "$(GREEN)[+] Building and starting containers...$(NC)"
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	@echo "$(GREEN)[+] Stopping containers...$(NC)"
	@$(COMPOSE) -f $(COMPOSE_FILE) down

fdown: 
	@echo "$(GREEN)[+] Stopping containers, removing images and volumes...$(NC)"
	@$(COMPOSE) -f $(COMPOSE_FILE) down --rmi all --volumes

re: fdown up

# Catch-all for unknown targets
.DEFAULT:
	@echo "$(RED)[!] Unknown target: '$@'$(NC)"
	@echo "$(GREEN)Valid targets are:$(NC)"
	@echo "  make up      # Build and start containers"
	@echo "  make down    # Stop containers"
	@echo "  make fdown   # Stop containers and remove images/volumes"
	@echo "  make re      # Rebuild containers"

.PHONY: all up down fdown re

# Inception

> ⚠️ This project is currently under development and not yet fully functional.

## Overview

**Inception** is a system administration project designed to deepen your understanding of Docker and infrastructure management. You will build a secure, containerized environment using Docker Compose inside a Virtual Machine.

## Project Structure

- **Docker Compose** orchestrates all containers.
- **Services**:
  - `nginx`: TLS-enabled entry point (TLSv1.2 or v1.3 only).
  - `wordpress`: Uses php-fpm, no web server.
  - `mariadb`: Dedicated database container.
- **Volumes**: Separate volumes for WordPress files and database.
- **Networking**: Custom Docker network; only HTTPS on port 443 is exposed.
- **Environment**: Configuration through `.env` and Docker secrets; no hardcoded passwords.

All containers are built from scratch (Alpine/Debian base only) and must follow best practices — no infinite loops, no `tail -f`, no `sleep infinity`.

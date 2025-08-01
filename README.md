# Inception

A Docker and Docker Compose project that sets up a complete web infrastructure with NGINX, WordPress, and MariaDB services running in separate containers within a custom network.

## Overview

This project builds a complete web infrastructure using Docker containers, each running a specific service, orchestrated with Docker Compose. The infrastructure consists of NGINX (web server with SSL), WordPress (CMS with PHP-FPM), and MariaDB (database).
Check out `en.subject.pdf` to learn more about the requirements of the exercise.

## Features

- **Containerization:** Each service runs in its own Docker container
- **SSL/TLS Security:** NGINX configured with SSL certificates
- **Data Persistence:** Volumes for database and WordPress files
- **Custom Configuration:** Hand-crafted Dockerfiles (no pre-built images)
- **Environment Variables:** Secure configuration through .env files

## Requirements

- Docker Engine
- Docker Compose
- Make

## Setup

1. **Clone the repository:**
   ```bash
   git clone [repository-url]
   cd inception
   ```

2. **Configure environment variables:**
   ```bash
   # Edit .env with your configuration (changing values is advised)
   vim .env
   ```

3. **Build and start services:**
   ```bash
   make
   ```

4. **Access the application:**
   - Navigate to `https://127.0.0.1:8081/`
   - If you change HOST_NAME or HOST_PORT in `.env`, access via `https://<your_hostname>:<your_hostport>/`
   - It you change HOST_NAME to a custom name, you might need to add it to your hosts file (e.g. /etc/hosts)
   - If you change HOST_PORT to 443, you can skip the port and navigate to `https://<your_hostname>`

## Available Commands

```bash
make        # Build and start all services
make up     # Start services
make down   # Stop services
make fdown  # Stop services and removes images/volumes
make re     # Rebuild everything
make logs   # View container logs
```

## Architecture

- **NGINX** - Web server with SSL/TLS termination
- **WordPress** - Content management system with PHP-FPM
- **MariaDB** - Database server for WordPress data storage

All services run in a custom Docker network with volume persistence and secure internal communication.

---

*This project is part of the 42 School curriculum.*

*README generated by Claude (Anthropic)*

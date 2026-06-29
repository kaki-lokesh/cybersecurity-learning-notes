#!/bin/bash

# DOCKER
  Docker is a platform that packages applications and their dependencies into containers - isolated, portable environments that run identically on any system.
  Every production web service, every security tool distributed as a container, every CI/CD pipeline uses Docker.
  Security engineers need Docker knowledge for three reasons:
   1. DevSecOps - securing CI/CD pipelines requires understanding how containers are built and deployed.
   2. Vulnerability assessment - container images are a major attack surface with their own vulnerability class (CVEs in base images, secrets in layers).
   3. Tool portability - distributing your own security tools as Docker images is the professional standard.
# DOCKER ARCHITECTURE
  'A Docker Image = Stacked Read-Only Layers'
    Your App  -> COPY . /app && RUN pip install -r requirements.txt
    Config    -> ENV PYTHONPATH=/app WORKDIR /app
    Libraries -> RUN apt-get install -y libssl-dev build-essential
    Base OS   -> python:3.11-slim-bullseye (Debian Linux minimal)
    Kernel    -> Host Linux kernel (shared - not inside the container)
  Each RUN/COPY/ADD instruction in a Dockerfile creates a new layer.
  Layers are cached and shared between images - making builds fast.
  Security implication: secrets written in one layer and deleted in the next are still in the image history.
  'Container = Image + Writable Layer'
    Image: Read-only blueprint. Can be pulled from Docker Hub, built locally, or scanned for vulnerabilities.
    Container: A running instance of an image. Has a writable layer on top for runtime changes. Isolated via Linux namespaces (PID, network, mount, user).
    Docker Hub: Public registry of images.
                 Pull python:3.11-slim -> 40MB base
                 Pull ubuntu:22.04     -> 77MB
    Registry: Where images are stored. Docker Hub is public. GitHub Container Registry (ghcr.io) is free for public repos.
    Volume: Persistent storage that survives container restart. Mounted from host into container at a specified path.
# IMAGE COMMANDS
1. docker pull python:3.11-slim : Download newer image for python:3.11-slim
2. docker images : To view docker images
    FORMAT - REPOSITORY TAG IMAGE ID CREATED SIZE
3. docker history python:3.11-slim : Inspect image layers- security: check what each layer does
    FORMAT - IMAGE CREATED BY SIZE
# CONTAINER COMMANDS
1. docker run -it python:3.11-slim bash : Run a container interactively
    -it = interactive + pseudo-TTY (gives you a terminal inside the container)
2. docker run -d -p 80:80 --name myapp nginx : Run in background (detached)
    -d = detached (run in background) -p 80:80 = host:container port mapping
    --name = give the container a memorable name
3. docker ps : List running containers
    FORMAT - CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
4. docker exec -it myapp bash : Execute a command in a running container (like SSH into it)
5. docker logs -f myapp : View container logs
    -f = follow (real-time log streaming- like tail -f)
6. docker stop myapp && docker rm myapp : Stop, remove
   docker rmi python:3.11-slim : Start
7. docker run -v /host/path:/container/path python:3.11-slim python3 script.py : Mount a volume (persist data between container runs)
# WRITING A DOCKERFILE
  A Dockerfile is a text file containing the instructions to build a Docker image.
  "Stage 1: Base image selection"
    ALWAYS use a specific version tag - never 'latest'
    'slim' variants are smaller and have fewer pre-installed packages (smaller attack surface)
   FROM python:3.11-slim-bullseye
  "Metadata - good practice, shows professionalism"
   LABEL maintainer="yourname@email.com"
   LABEL description="OSINT Threat Intelligence Tool"
   LABEL version="1.0"
  "SECURITY: Create a non-root user early"
    Never run applications as root inside containers.
    If container is compromised, attacker gets limited-privilege user, not root
   RUN groupadd -r appgroup && useradd -r -g appgroup appuser
  "Set working directory - all subsequent commands run from here"
   WORKDIR /app
  "Install dependencies BEFORE copying code"
    Why: Docker caches this layer. If only code changes, deps layer is reused (fast builds)
    If code changes too, the deps layer has to rebuild (slow)
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
  "Copy application code"
   COPY . .
  "SECURITY: Change ownership of app files to non-root user"
   RUN chown -R appuser:appgroup /app
  "SECURITY: Switch to non-root user for all subsequent commands"
   USER appuser
  "What to run when the container starts"
    Use ENTRYPOINT for fixed commands, CMD for default arguments (overridable)
   ENTRYPOINT ["python3", "osint_ti_tool.py"]
   CMD ["--help"]
  "Build and run"
   docker build -t osint-tool:1.0 .
   docker run osint-tool:1.0 --ip 8.8.8.8
   docker run -e SHODAN_API_KEY=xxx osint-tool:1.0 --ip 8.8.8.8
# DOCKER SECURITY - Attacker & Defender Perspectives
  "Security Issue             Risk                              Prevention"
   Running as root	      Container breakout amplification  Always USER nonroot in Dockerfile. Use --user  flag at runtime
   Secrets in image layers    Credential exposure	        Never put secrets in Dockerfiles. Use environment variables at runtime: -e API_KEY=xxx
   Outdated base images	      Known CVEs                        Scan images with Trivy. Rebuild regularly. Pin to specific digest for reproducibility
   Over-privileged containers Capability                        --cap-drop=ALL --cap-add=NET_BIND_SERVICE - drop all caps, add back only what's needed
   Exposed Docker socket      Full host compromise              Never mount the Docker socket unless absolutely required
   No resource limits         DoS from within                   --memory=512m --cpus=0.5 - limit resources at container level
   Vulnerable dependencies    Supply chain attack               Run Safety check and pip-audit. Pin all dependency versions


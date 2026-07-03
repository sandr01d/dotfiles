#!/bin/bash

# Docker rootless
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# Start ssh-agent
eval "$(ssh-agent)" > /dev/null

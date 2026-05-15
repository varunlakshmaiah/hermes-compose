#!/bin/bash
# hermes-exec.sh — Run any Hermes CLI command inside the running container.
#
# Usage:
#   ./hermes-exec.sh setup          # Run the interactive setup wizard
#   ./hermes-exec.sh status         # Check component status
#   ./hermes-exec.sh doctor         # Run diagnostics
#   ./hermes-exec.sh <any command>  # Any valid hermes subcommand
#
# If no arguments are provided, an interactive shell is opened with the
# Hermes virtual environment already activated, so you can run multiple
# commands without repeating the activation step.

set -e

CONTAINER_NAME="${HERMES_CONTAINER:-hermes}"
ACTIVATE="source /opt/hermes/.venv/bin/activate"

# Check if the container is running
if ! docker ps --format '{{.Names}}' | grep -qw "$CONTAINER_NAME"; then
    echo "❌ Error: Container '$CONTAINER_NAME' is not running."
    echo "   Start it first with: docker compose up -d"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "🔌 Opening interactive shell inside '$CONTAINER_NAME'..."
    echo "   The Hermes venv is pre-activated. Type 'hermes --help' to get started."
    echo ""
    docker exec -it "$CONTAINER_NAME" bash -c "$ACTIVATE && exec bash"
else
    echo "⚡ Running: hermes $*"
    docker exec -it "$CONTAINER_NAME" bash -c "$ACTIVATE && hermes $*"
fi

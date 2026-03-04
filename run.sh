#!/bin/bash
# Standalone runner for locus-scripts generators.
# Usage:
#   ./run.sh src/algebra1_linear_equations_easy.py
#   ./run.sh src/some_script.jl --count 5

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT="$1"
shift || { echo "Usage: ./run.sh <script> [args...]"; exit 1; }

if [ ! -f "$SCRIPT" ]; then
    echo "Error: script not found: $SCRIPT"
    exit 1
fi

case "$SCRIPT" in
    *.py)
        PYTHONPATH="$REPO_DIR/python" exec python3 "$SCRIPT" "$@"
        ;;
    *.jl)
        JULIA_ARGS=()
        SYSIMAGE="$REPO_DIR/julia/sysimage.so"
        if [ -f "$SYSIMAGE" ]; then
            JULIA_ARGS+=(--sysimage="$SYSIMAGE")
        fi
        JULIA_ARGS+=(--project="$REPO_DIR/julia")
        exec julia "${JULIA_ARGS[@]}" "$SCRIPT" "$@"
        ;;
    *)
        echo "Error: unsupported file type (must be .py or .jl)"
        exit 1
        ;;
esac

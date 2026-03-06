#!/usr/bin/env bash

# Deploy script for nix-config
# Usage: ./scripts/deploy.sh <hostname>

set -euo pipefail

HOSTNAME="${1:-}"
if [ -z "$HOSTNAME" ]; then
    echo "Usage: $0 <hostname>"
    echo "Available hosts:"
    echo "  - m1max (Darwin)"
    echo "  - work-mac (Darwin)"
    echo "  - nix-server (NixOS)"
    echo "  - ubuntu-server (Ubuntu)"
    exit 1
fi

echo "Deploying to $HOSTNAME..."

# Use deploy-rs for remote deployment
nix run .#deploy-rs -- .#$HOSTNAME

echo "Deployment to $HOSTNAME completed!"

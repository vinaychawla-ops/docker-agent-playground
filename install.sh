#!/usr/bin/env bash
# Installs the docker-agent binary into ./bin (or $INSTALL_DIR).
# The binary is ~145MB, so it is downloaded, never committed.
set -euo pipefail

VERSION="${DOCKER_AGENT_VERSION:-v1.150.0}"
INSTALL_DIR="${INSTALL_DIR:-$(cd "$(dirname "$0")" && pwd)/bin}"

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo "unsupported arch: $ARCH" >&2; exit 1 ;;
esac
case "$OS" in
  linux|darwin) ;;
  *) echo "unsupported os: $OS" >&2; exit 1 ;;
esac

ASSET="docker-agent-${OS}-${ARCH}"
URL="https://github.com/docker/docker-agent/releases/download/${VERSION}/${ASSET}"

mkdir -p "$INSTALL_DIR"
echo "Downloading docker-agent ${VERSION} (${OS}/${ARCH})..."
curl -fsSL -o "${INSTALL_DIR}/docker-agent" "$URL"
chmod +x "${INSTALL_DIR}/docker-agent"
"${INSTALL_DIR}/docker-agent" version 2>&1 | head -3
echo "Installed to ${INSTALL_DIR}/docker-agent"

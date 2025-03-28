#!/usr/bin/env bash
set -e

script_path="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
export PATH=$PATH:$script_path

echo "Installation complete. You can now run '$SCRIPT_NAME'."
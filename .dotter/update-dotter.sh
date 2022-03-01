#!/bin/bash
TARGET=$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")

DOWNLOAD_URL=$(curl -s https://api.github.com/repos/SuperCuber/dotter/releases/latest | grep browser_download_url | grep dotter\" | cut -d '"' -f 4)

curl -s -L -o "$TARGET"/dotter "${DOWNLOAD_URL}"

chmod +x "$TARGET"/dotter

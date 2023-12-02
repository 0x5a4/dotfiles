#!/usr/bin/env bash

set -euo pipefail

readonly DEFAULT=""
readonly DONOTDISTURB=""
readonly SHUTUP=""

dbus-monitor interface='fr.emersion.Mako',member='SetModes' --profile |
while read -r _; do
    mako-query-mode do-not-disturb && { echo ${DONOTDISTURB}; continue; }
    mako-query-mode shut-up && { echo ${SHUTUP}; continue; }

    echo ${DEFAULT}
done

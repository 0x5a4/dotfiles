#!/bin/bash
cd $1
current_path="$(git rev-parse --show-toplevel 2> /dev/null || pwd)"
echo $current_path | rev | cut -d"/" -f1-2 | rev

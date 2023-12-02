#!/usr/bin/env bash

cd $1
current_path="$(git rev-parse --show-toplevel 2> /dev/null || pwd)"
trim_home="$(echo ${current_path} | sed "s?/home/$(whoami)\+?~?")"
echo ${trim_home} | rev | cut -d/ -f1-2 | rev

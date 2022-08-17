#!/bin/bash
cd $1

basename "$(git rev-parse --show-toplevel 2> /dev/null || pwd)"

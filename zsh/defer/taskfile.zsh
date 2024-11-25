#!/bin/bash

# Skip if task is not available
if ! command -v task &> /dev/null; then
    return
fi

eval "$(task --completion zsh)"

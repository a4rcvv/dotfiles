#!/bin/bash

# Skip if not on macOS
if [ "$(uname)" != "Darwin" ]; then
    exit 0
fi

export IP=$(ipconfig getifaddr en0)
export DISPLAY=$IP:0
/usr/X11/bin/xhost + $IP
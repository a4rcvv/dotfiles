#!/bin/bash

# skip if drawio is not available
DRAWIO_PATH = "/Applications/draw.io.app/Contents/MacOS/draw.io"
if [ ! -f "${DRAWIO_PATH}" ]; then
    return
fi

alias drawio="${DRAWIO_PATH}"

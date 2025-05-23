#!/bin/bash

# Load .env variables into the current shell
export $(grep -v '^#' .env | xargs)

# Confirm they're loaded (optional)
echo "Starting app with:"
echo "SECRET_KEY_BASE=${SECRET_KEY_BASE:0:8}..."
echo "SIGNING_SALT=${SIGNING_SALT:0:8}..."

# Start your Phoenix app
iex -S mix phx.server

#!/bin/bash

echo "🔄 Cleaning up Phoenix boilerplate..."

# Remove web interface layer
rm -rf lib/task_queue_web
rm -rf test/task_queue_web

# Remove unused modules
rm -f lib/task_queue/mailer.ex
rm -f lib/task_queue/repo.ex

# Remove unused config files (optional)
rm -f config/dev.exs
rm -f config/test.exs
rm -f config/runtime.exs

# Remove web-specific test support
rm -rf test/support

# Optional: remove frontend assets
rm -rf assets
rm -rf priv/static
rm -f priv/static/robots.txt

# Optional: cleanup HTML-related templates
rm -rf priv/gettext
rm -rf priv/repo

echo "✅ Phoenix cleanup complete."

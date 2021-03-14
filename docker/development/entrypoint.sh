#!/bin/bash
set -e

if [ ! -f ./config/config.yml ]; then
  cp ./config/config.example.yml ./config/config.yml
fi

mkdir -p tmp/pids

script/export_routes_js.sh
script/export_translations.sh

bundle check || bundle install
npm install

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

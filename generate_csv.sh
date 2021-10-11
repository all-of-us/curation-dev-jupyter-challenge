#!/usr/bin/env bash

set -e
set +x

cmd_args=()

compose_exec="docker-compose"
if ! command -v "${compose_exec}" &> /dev/null; then
  compose_exec="docker"
  cmd_args+=("compose")
fi

if ! command -v "${compose_exec}" &> /dev/null; then
  echo "Unable to locate or docker."
  echo "Please follow the instructios present here: https://docs.docker.com/get-docker/"
  exit 1
fi

build_args=("${cmd_args[@]}")
build_args+=(
  'build'
  '--build-arg'
  "UID=$(id -u)"
  '--build-arg'
  "GID=$(id -g)"
  '--progress'
   'plain'
   '--no-cache'
   'download-csv'
)

run_args=("${cmd_args[@]}")
run_args+=(
  'run'
  '-u'
  "$(id -u):$(id -g)"
  '-v'
  "$(pwd)/repos-csv-output:/repos-csv-output:rw"
  'download-csv'
  )

echo "Ensuring image is up to date"

"${compose_exec[*]}" "${build_args[@]}"

echo "Executing CSV generation..."
exec "${compose_exec[*]}" "${run_args[@]}"
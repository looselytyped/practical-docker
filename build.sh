#!/usr/bin/env bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail

function finish {
  docker rm -f builder
}
trap finish EXIT

# ——— BUILD/TEST CODE —————————————————————————————————————————————————————————
# build/test our code
docker build -t build-img -f Dockerfile.build .

# ——— CREATE A TEMP DIRECTORY —————————————————————————————————————————————————
mkdir -p target

# ——— GET THE JAR OUT —————————————————————————————————————————————————————————
# start a temporary container from our "build-img"
# so we can get to its filesystem
docker create --name builder build-img
docker cp builder:/code/build/libs/docker-olp-0.0.1-SNAPSHOT.jar \
./target/

# ——— BUILD OUR FINAL IMAGE ———————————————————————————————————————————————————
docker build -t final-img -f Dockerfile.final .

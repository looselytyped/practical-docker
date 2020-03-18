#!/usr/bin/env bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail

last=alpine:3.9
for i in `seq 200`; do
  rm -f cid
  docker run --cidfile=cid $last touch file$i;
  docker commit `cat cid` tag$i;
  docker rm `cat cid`;
  last=tag$i;
done

# Error response from daemon: max depth exceeded
# Unable to find image 'tag125:latest' locally
# docker: Error response from daemon: pull access denied for tag125, repository does not exist or may require 'docker login'.
# See 'docker run --help'.

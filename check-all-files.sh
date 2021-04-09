#!/usr/bin/env bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail



docker build -t demo -f Dockerfile . \
&& docker build -t demo -f 010-Dockerfile.from.sample . \
&& docker build -t demo -f 020-Dockerfile.arg.sample . \
&& docker build -t demo -f 030-Dockerfile.env.sample . \
&& docker build -t demo -f 040-Dockerfile.label.sample . \
&& docker build -t demo -f 050-Dockerfile.run.sample . \
&& docker build -t demo -f 060-Dockerfile.add.sample . \
&& docker build -t demo -f 070-Dockerfile.user.sample . \
&& docker build -t demo -f 080-Dockerfile.entrypoint.sample . \
&& docker build -t demo -f 090-Dockerfile.healthcheck.sample . \
&& docker build -t demo -f Dockerfile . \
&& docker build -t demo -f Dockerfile.sample .\
&& docker build -t demo -f Dockerfile.build . \
&& docker build -t demo -f Dockerfile.final . \
&& docker build -t demo -f Dockerfile.multi . \
&& ./build.sh \
&& cat << "EOF"
#####################################
8888888b.
888  "Y88b
888    888
888    888  .d88b.  88888b.   .d88b.
888    888 d88""88b 888 "88b d8P  Y8b
888    888 888  888 888  888 88888888
888  .d88P Y88..88P 888  888 Y8b.
8888888P"   "Y88P"  888  888  "Y8888
#####################################
EOF

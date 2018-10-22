#!/bin/bash

YELLOW='\033[1;33m'
RED='\033[1;31m'
CYAN='\033[0;36m'
NOCOL='\033[0m'
UNDERLINE='\033[4m'
NOUNDERLINE='\033[24m'

set -e

build() {
  docker build -t loreanvictor/connect-platform .
}

run() {
  kill
  if [ -z "$1" ]; then
    docker run -dit \
          --name connect-platform \
          -p 4000:4000 \
          -v $(pwd)/panel-generated:/app/panel-generated \
          -v $(pwd)/secure:/app/secure \
          --env CONNECT_INSTALL_EXTERNAL_PACKAGES=true \
          loreanvictor/connect-platform
  else
    docker run -dit \
          --name connect-platform \
          -p 4000:4000 \
          -v $(pwd)/panel-generated:/app/panel-generated \
          -v $(pwd)/secure:/app/secure \
          --env CONNECT_INSTALL_EXTERNAL_PACKAGES=true \
          --env CONNECT_PANEL_SECRET=$1 \
          loreanvictor/connect-platform
  fi
  echo -e "${CYAN}server operational.${NOCOL}"
  echo -e "${UNDERLINE}localhost:4000/panel/${NOUNDERLINE}"
}

kill() {
  set +e
  docker kill connect-platform
  docker rm connect-platform
  set -e
}

shell() {
  docker exec -it connect-platform bash
}

logs() {
  docker logs connect-platform
}

clean() {
  kill
  docker rmi loreanvictor/connect-platform -f
}

push() {
  build
  docker push loreanvictor/connect-platform
}

if [[ "$1" =~ ^(build|run|kill|shell|logs|clean|push)$ ]]; then
  echo -e "${YELLOW}WARNING: ${CYAN} this is for development/testing purposes. ${NOCOL}"
  $1 $2
else
  echo -e "${RED}ERROR: ${NOCOL} couldn't understand $1"
  echo -e "try ${CYAN}build | run | kill | shell | logs | clean${NOCOL}"
fi

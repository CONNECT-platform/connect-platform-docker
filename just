#!/bin/bash

YELLOW='\033[1;33m'
RED='\033[1;31m'
CYAN='\033[0;36m'
NOCOL='\033[0m'
UNDERLINE='\033[4m'
NOUNDERLINE='\033[24m'

build() {
  docker build -t loreanvictor/connect-platform .
}

run() {
  kill
  docker run -dit --name connect-platform -p 4000:4000 loreanvictor/connect-platform
  echo -e "${CYAN}server operational.${NOCOL}"
  echo -e "${UNDERLINE}localhost:4000/panel/${NOUNDERLINE}"
}

kill() {
  docker kill connect-platform
  docker rm connect-platform
}

shell() {
  docker exec -it connect-platform bash
}

clean() {
  kill
  docker rmi loreanvictor/connect-platform -f
}

push() {
  build
  docker push loreanvictor/connect-platform
}

if [[ "$1" =~ ^(build|run|kill|shell|clean|push)$ ]]; then
  echo -e "${YELLOW}WARNING: ${CYAN} this is for development/testing purposes. ${NOCOL}"
  $1
else
  echo -e "${RED}ERROR: ${NOCOL} couldn't understand $1"
  echo -e "try ${CYAN}build | run | kill | shell | clean${NOCOL}"
fi

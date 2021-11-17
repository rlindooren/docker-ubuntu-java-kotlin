#!/usr/bin/env bash

if [ -z "${VERSION}" ]; then
  echo "Please provide a version! (e.g. VERSION=0.0.1 ./deploy-to-docker.sh)"
  exit 1
fi

docker build -t ubuntu-java:"${VERSION}" .

docker tag ubuntu-java:"${VERSION}" rlindooren/ubuntu-java:"${VERSION}"
docker tag ubuntu-java:"${VERSION}" rlindooren/ubuntu-java:latest

docker push rlindooren/ubuntu-java:"${VERSION}"
docker push rlindooren/ubuntu-java:latest

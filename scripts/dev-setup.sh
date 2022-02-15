#!/bin/bash

FILE_PATH=$(
  cd "$(dirname "$0")" || exit
  pwd
)

cd "$FILE_PATH/../" || exit
docker-compose -p trampoline-chatbot -f docker-compose.yml up -d --build

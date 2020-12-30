#!/bin/bash

echo

chmod +x killall.sh

if [[ $(docker ps -a -q) ]]; then
    echo "Killing previous containers."
    docker container stop $(docker ps -a -q)
    docker container rm $(docker ps -a -q)
    echo "Container down. >:D"
else
    echo "No containers to kill."
fi
docker system prune -f

echo
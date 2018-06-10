#!/usr/bin/env bash

docker_clean() {
    # Remove stopped containers
    docker ps -aq --no-trunc | xargs docker rm

    # Remove dangling/untagged images
    docker images -q filter dangling=true | xargs docker rmi
}

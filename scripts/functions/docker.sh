#!/usr/bin/env bash

docker_clean() {
    # Remove stopped containers
    echo "Removing stopped containers..."
    docker ps -aq --no-trunc | xargs docker rm

    # Remove dangling/untagged images
    echo "Removing untagged images..."
    docker images --quiet --filter=dangling=true | xargs docker rmi

    # Remove unused docker networks
    echo "Removing unused Docker networks..."
    docker network prune -f

    # Remove unused docker volumes
    echo "Removing unused Docker volumes..."
    docker network prune -f
}

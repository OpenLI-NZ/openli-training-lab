#!/bin/bash

echo "Creating networks for OpenLI lab..."
docker network inspect openli-lab > /dev/null 2>&1 || \
        docker network create --driver bridge \
        openli-lab


docker network inspect openli-agency > /dev/null 2>&1 || \
        docker network create --driver bridge \
        -o "com.docker.network.bridge.enable_icc=true" \
        openli-agency

docker network inspect openli-lab-replay > /dev/null 2>&1 || \
        docker network create --driver bridge \
        -o "com.docker.network.driver.mtu=9000" \
        -o "com.docker.network.bridge.enable_icc=true" \
        openli-lab-replay

echo "Networks created!"

echo "Halting existing running containers..."

if [ "$( docker ps -q -f name=openli-agency )" ]; then
        docker container stop openli-agency
fi

if [ "$( docker ps -q -f name=openli-provisioner )" ]; then
        docker container stop openli-provisioner
fi

if [ "$( docker ps -q -f name=openli-mediator )" ]; then
        docker container stop openli-mediator
fi

if [ "$( docker ps -q -f name=openli-collector )" ]; then
        docker container stop openli-collector
fi

echo "All done!"

echo "Starting docker containers..."
docker run -d -P --rm -it --name openli-agency quay.io/openli/training:openli-lab-agency

docker run -d -P --rm -it --name openli-provisioner  quay.io/openli/training:openli-lab-provisioner

docker run -d -P --rm -it --name openli-mediator quay.io/openli/training:openli-lab-mediator

docker run -d -P --rm -it --name openli-collector quay.io/openli/training:openli-lab-collector


docker network connect openli-lab openli-provisioner
docker network connect openli-lab openli-mediator
docker network connect openli-lab openli-collector

docker network connect openli-lab-replay openli-collector

docker network connect openli-agency openli-mediator
docker network connect openli-agency openli-agency
echo "Containers started!"

echo "OpenLI lab setup complete!"

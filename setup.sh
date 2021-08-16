#!/bin/bash

echo "Creating networks for OpenLI lab..."
docker network inspect openli-lab > /dev/null 2>&1 || \
        docker network create --driver bridge \
        openli-lab

docker network inspect openli-upstream > /dev/null 2>&1 || \
        docker network create --driver bridge \
        -o "com.docker.network.bridge.enable_ip_masquerade=true" \
        -o "com.docker.network.bridge.enable_icc=false" \
        -o "com.docker.network.bridge.host_binding_ipv4=0.0.0.0" \
        openli-upstream


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

echo "Downloading docker images..."
# docker pull openlinz/openli-lab-agency
echo "Images downloaded!"

echo "Starting docker containers..."
docker run -d -P --rm -it --name openli-agency --network=openli-agency openli/training:openli-lab-agency

docker run -d -P --rm -it --name openli-provisioner  --network=openli-lab openli/training:openli-lab-provisioner

docker run -d -P --rm -it --name openli-mediator  --network=openli-lab openli/training:openli-lab-mediator

docker run -d -P --rm -it --name openli-collector --network=openli-lab openli/training:openli-lab-collector


docker network connect openli-upstream openli-collector
docker network connect openli-upstream openli-mediator
docker network connect openli-upstream openli-provisioner
docker network connect openli-upstream openli-agency

docker network connect openli-lab-replay openli-collector

docker network connect openli-agency openli-mediator
echo "Containers started!"

echo "OpenLI lab setup complete!"

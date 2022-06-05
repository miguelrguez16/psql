#!/bin/bash


docker run --name wildfly --network host \
    -e WILDFLY_USERNAME=USERNAME \
    -e WILDFLY_PASSWORD=PASSWORD \
    bitnami/wildfly:latest &

echo "Status wildfly $?"

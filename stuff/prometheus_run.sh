#!/bin/bash

docker run --rm --name prometheus -p 9090:9090 --network host \
        -v /home/miguel/prometheus.yml:/etc/prometheus/prometheus.yml:Z prom/prometheus:latest \
        --config.file=/etc/prometheus/prometheus.yml

echo "Status prometheus $?"

#!/bin/bash

while ! echo "GET /notvalid HTTP1.1" | nc localhost 8080 | grep HTTP
  do
    echo "ATS has not been started yet - `date`"
    sleep 3
done

# temporary hardcode for testing purposes. waiting when traffic_server will create access.log
while [ ! -f /opt/trafficserver/var/log/trafficserver/access.log ]; do
    echo "squid.blog bin log file does not exist yet. Waiting..."
    sleep 5
done

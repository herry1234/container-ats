#!/bin/bash

while ! echo -e "GET /disregard HTTP/1.1\n\n" | nc localhost 8080 | grep HTTP
  do
    echo "ATS has not been started yet - `date`"
    sleep 3
done

# temporary hardcode for testing purposes. waiting when traffic_server will create access.log
while [ ! -f $TS_PATH/var/log/trafficserver/access.log ]; do
    echo "access.log does not exist yet. Waiting..."
    sleep 5
done

#exec tail -f /opt/trafficserver/var/log/trafficserver/access.log
tail -f $TS_PATH/var/log/trafficserver/access.log

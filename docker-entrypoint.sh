#!/bin/bash

/opt/trafficserver/bin/trafficserver start

exec "$@"

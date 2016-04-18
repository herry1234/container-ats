## docker container for Apache Traffic Server
ATS is configured as forward proxy.

Supervisord as supervisor for traffic_cop and process with tail of access.log
to stdout

### Run

```
docker run -d -p 8080:8080 --log-driver=gelf --log-opt gelf-address=udp://localhost:12201 --name trafficserver container-ats
```
or
```
docker-compose up
```

### Todo
 - we run ATS container with `gelf` log output, so we need separate process which will output access log to stdout. May be it will be better to mount volume on the host, turn on rolling of the logs. So the init process will be traffic_cop and no supervisord.

## docker container for Apache Traffic Server
ATS is configured as forward proxy.

Supervisord as supervisor for traffic_cop and process with tail of access.log
to stdout

### Run

```
docker run -d -p 8080:8080 --name trafficserver container-ats
```
or
```
docker-compose up
```

### Todo
 storage usage. maybe mount log dir to host.

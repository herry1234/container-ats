

## source

[medium article](https://medium.com/devoops-and-universe/caching-web-content-with-apache-traffic-server-172fda263bee)
## docker container for Apache Traffic Server
ATS is configured as forward proxy.

Supervisord as supervisor for  process with tail of access.log
to stdout

### Run

```
docker run -d -p 8080:8080 --log-driver=gelf --log-opt gelf-address=udp://localhost:12201 --name trafficserver ts
```
or
```
docker-compose up
```

### Todo


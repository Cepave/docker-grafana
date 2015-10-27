# docker-grafana

Dockerfile for Grafana

## Build

Enter the following command in the repo directory.

```
$sudo docker build --force-rm=true -t grafana .
```

## Run

Use default configuration.

```
$sudo docker run -dti --name grafana -p 3000:3000 -p 4001:4001 grafana
```

### Advanced Run

+ Self-defined configuration

    Replace file **cfg.json** in the volume */config*.

For example, **cfg.json** in /tmp/config,

```
$sudo docker run -dti --name grafana -v /tmp/config/cfg.json:/config/cfg.json -p 3000:3000 -p 4001:4001 grafana
```

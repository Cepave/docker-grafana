FROM golang:1.4.2

MAINTAINER Don Hsieh <don@cepave.com>
MAINTAINER minimum@cepave.com

ENV GRAFANADIR=/go/src/github.com/Cepave/grafana CONFIGDIR=/config CONFIGFILE=cfg.json

# Volume
VOLUME $CONFIGDIR

# Environment
RUN \
  apt-get update && \
  apt-get -y install nodejs npm && \
  ln -s /usr/bin/nodejs /usr/bin/node && \
  npm config set registry="http://registry.npmjs.org/" && \
  npm install -g grunt-cli

# Install Grafana
COPY grafana $GRAFANADIR
WORKDIR $GRAFANADIR
RUN \
  go run build.go setup && \
  godep restore && \
  go get github.com/toolkits/file && \
  go build . && \
  npm install && \
  npm install -g grunt-cli && \
  grunt

COPY $CONFIGFILE $CONFIGDIR/
COPY run.sh /run.sh

# Port
EXPOSE 3000 4001

# Start
CMD /run.sh

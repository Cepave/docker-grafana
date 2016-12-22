FROM golang:1.5

MAINTAINER Don Hsieh <don@cepave.com>
MAINTAINER minimum@cepave.com

ENV GRAFANADIR=/go/src/github.com/Cepave/grafana CONFIGDIR=/config CONFIGFILE=cfg.json GO15VENDOREXPERIMENT=0

# Volume
VOLUME $CONFIGDIR

# Environment
RUN \
  apt-get -qq update && \
  apt-get -qq -y install nodejs npm && \
  ln -s /usr/bin/nodejs /usr/bin/node && \
  npm config set color false && \
  npm config set registry="http://registry.npmjs.org/" && \
  npm install -g --silent grunt-cli

# Install Grafana
COPY grafana $GRAFANADIR
WORKDIR $GRAFANADIR
RUN \
  go run build.go setup && \
  godep restore && \
  go get github.com/toolkits/file && \
  go build . && \
  npm config set color false && \
  npm install --silent && \
  npm install -g --silent grunt-cli && \
  grunt build && \
  apt-get autoremove && \
  apt-get autoclean

COPY $CONFIGFILE $CONFIGDIR/
COPY run.sh /run.sh

# Port
EXPOSE 3000 4001

# Start
CMD /run.sh

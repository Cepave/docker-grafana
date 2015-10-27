FROM golang:1.4.2

MAINTAINER Don Hsieh <don@cepave.com>
MAINTAINER minimum@cepave.com

ENV GRAFANADIR=/go/src/github.com/Cepave/grafana CONFIGDIR=/config CONFIGFILE=cfg.json

# Volume
VOLUME $CONFIGDIR

# Install Grafana
RUN \
  apt-get update && \
  apt-get -y install nodejs npm && \
  ln -s /usr/bin/nodejs /usr/bin/node && \
  git clone https://github.com/Cepave/grafana.git $GRAFANADIR

WORKDIR $GRAFANADIR

RUN \
  npm config set registry="http://registry.npmjs.org/" && \
  npm install -g grunt-cli && \
  npm i express request body-parser && \
  npm i && \
  grunt && \
  go get ./... && \
  go build && \
  (find $GOPATH -name ".git" | xargs rm -fR)

COPY $CONFIGFILE $CONFIGDIR/
COPY run.sh /run.sh

# Port
EXPOSE 3000 4001

# Start
CMD /run.sh

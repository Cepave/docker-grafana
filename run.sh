#!/bin/bash
cp $CONFIGDIR/$CONFIGFILE $GRAFANADIR/
node $GRAFANADIR/open-falcon/server.js &
$GRAFANADIR/grafana

#!/usr/bin/env bash

mkdir -p $MOUNTPOINT
s3fs $BUCKET $MOUNTPOINT &&  echo $BUCKET mounted on $MOUNTPOINT...
trap : TERM INT; (while true; do sleep 10; done) & wait

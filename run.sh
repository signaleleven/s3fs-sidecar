#!/usr/bin/env bash

mkdir -p $MOUNTPOINT

[[ -z "${S3UID}" ]] || FUSE_OPTS="$FUSE_OPTS -o uid=${S3UID}"
[[ -z "${S3GID}" ]] || FUSE_OPTS="$FUSE_OPTS -o gid=${S3GID}"


s3fs  $BUCKET $MOUNTPOINT  $FUSE_OPTS &&  echo $BUCKET mounted on $MOUNTPOINT...
trap : TERM INT; (while true; do sleep 10; done) & wait

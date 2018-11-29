#!/usr/bin/env bash

mkdir -p $MOUNTPOINT

[[ -z "${S3UID}" ]] || FUSE_OPTS="$FUSE_OPTS -o uid=${S3UID}"
[[ -z "${S3GID}" ]] || FUSE_OPTS="$FUSE_OPTS -o gid=${S3GID}"


s3fs $FUSE_OPTS $BUCKET $MOUNTPOINT  &&  echo $BUCKET mounted on $MOUNTPOINT...
trap : TERM INT;  wait

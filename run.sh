#!/bin/bash

mkdir -p $MOUNTPOINT

[[ -z "${S3UID}" ]] || FUSE_OPTS="$FUSE_OPTS -o uid=${S3UID}"
[[ -z "${S3GID}" ]] || FUSE_OPTS="$FUSE_OPTS -o gid=${S3GID}"


s3fs  $BUCKET $MOUNTPOINT  $FUSE_OPTS -ouse_cache=/tmp &&  echo $BUCKET mounted on $MOUNTPOINT...


sleep infinity & PID=$! ; trap "kill $PID" TERM STOP INT ;wait ;echo exited

#!/bin/bash

mkdir -p $MOUNTPOINT

[[ -z "${S3UID}" ]] || FUSE_OPTS="$FUSE_OPTS -o uid=${S3UID}"
[[ -z "${S3GID}" ]] || FUSE_OPTS="$FUSE_OPTS -o gid=${S3GID}"
[[ -z "${AUTOROLE}" ]] || FUSE_OPTS="$FUSE_OPTS -o iam_role=auto"
[[ -z "${ALLOWEMPTY}" ]] || FUSE_OPTS="$FUSE_OPTS -o nonempty"

echo Mounting $BUCKET  on $MOUNTPOINT...
exec s3fs  $BUCKET $MOUNTPOINT  $FUSE_OPTS -o use_cache=/tmp -f

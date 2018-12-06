#!/bin/bash


mkdir -p $MOUNTPOINT

[[ -z "${S3UID}" ]] || FUSE_OPTS="$FUSE_OPTS -o uid=${S3UID}"
[[ -z "${S3GID}" ]] || FUSE_OPTS="$FUSE_OPTS -o gid=${S3GID}"
[[ -z "${AUTOROLE}" ]] || FUSE_OPTS="$FUSE_OPTS -o iam_role=auto"
[[ -z "${ALLOWEMPTY}" ]] || FUSE_OPTS="$FUSE_OPTS -o nonempty"
[[ -z "${ALLOWOTHERS}" ]] || FUSE_OPTS="$FUSE_OPTS -o allow_other"
[[ -z "${S3URL}" ]] || FUSE_OPTS="$FUSE_OPTS -o url=${S3URL}"

echo Mounting $BUCKET  on $MOUNTPOINT with $FUSE_OPTS...
exec s3fs  $BUCKET $MOUNTPOINT  $FUSE_OPTS -o use_cache=/tmp -f

#!/usr/bin/env bash

mkdir -p $MOUNTPOINT
s3fs $BUCKET $MOUNTPOINT && cat 

FROM ubuntu:18.04

RUN apt-get update && apt-get install -y s3fs

COPY run.sh /run.sh
CMD /run.sh

FROM ubuntu:20.04

COPY . /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install gfortran gcc g++ build-essential m4 csh time vim python3 libhdf5-serial-dev python-dev libcurl4-openssl-dev libxml2 libxml2-dev python3-pip; \
    cd /tmp && sh ./setup.sh && rm -r /tmp/*


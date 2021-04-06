FROM debian:buster

RUN apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y bsdmainutils gcc git lcab make dos2unix curl bzip2

RUN mkdir /build
COPY . orig
COPY build_shim UOS-UEFI-RSA.cer sbat.uos.csv  /build/
    
WORKDIR /build

RUN chmod +x build_shim && \
    ./build_shim

WORKDIR /



FROM debian:buster
ADD --chown=root:root uos.origins /etc/dpkg/origins/uos
RUN echo "deb http://deb.debian.org/debian buster main contrib non-free" > /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential devscripts git
RUN apt-get build-dep -y shim
RUN git clone https://github.com/uos-secureboot/shim.git shim-15+dev76.f60ba43-13
WORKDIR /shim-15+dev76.f60ba43-13
RUN git config user.email "secureboot@uniontech.com"
RUN git merge --allow-unrelated-histories -m "Import the packaging bits into master" origin/debian-master
RUN echo "1.0" > debian/source/format
RUN echo "--compression=gzip" > debian/source/options
RUN dch -v 15+dev76.f60ba43-13 -D eos --force-distribution 'Automatic release from git (15+dev76.f60ba43-13)'
RUN rm -rf .git
RUN DEB_VENDOR=uos dpkg-buildpackage -us -uc
WORKDIR /
RUN dpkg-deb -x shim-efi-image_15+dev76.f60ba43-13_amd64.deb shim-efi-image
RUN cp shim-efi-image/boot/efi/EFI/uos/shimx64.efi .
RUN sha256sum shimx64.efi

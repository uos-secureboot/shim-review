FROM debian:buster
ADD --chown=root:root endless.origins /etc/dpkg/origins/endless
RUN echo "deb-src http://deb.debian.org/debian buster main" > /etc/apt/sources.list.d/deb-src.list
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential devscripts git
RUN apt-get build-dep -y shim
RUN git clone https://github.com/endlessm/shim.git shim-15+dev16.b59aab6
WORKDIR /shim-15+dev16.b59aab6
RUN git config user.email "root@example.com"
RUN git merge --allow-unrelated-histories -m "Import the packaging bits into master" origin/debian-master
RUN echo "1.0" > debian/source/format
RUN echo "--compression=gzip" > debian/source/options
RUN dch -v 15+dev16.b59aab6-5 -D eos --force-distribution 'Automatic release from git (15+dev16.b59aab6-5)'
RUN rm -rf .git
RUN DEB_VENDOR=endless dpkg-buildpackage -us -uc
WORKDIR /
RUN dpkg-deb -x shim-efi-image_15+dev16.b59aab6-5_amd64.deb shim-efi-image
RUN cp shim-efi-image/boot/efi/EFI/endless/shimx64.efi .
RUN sha256sum shimx64.efi

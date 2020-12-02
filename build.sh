#!/bin/bash -e

sudo docker build -t uos-shim-review .

id=$(sudo docker create uos-shim-review)
sudo docker cp $id:shimx64.efi .
sudo docker rm -v $id

sha256sum -c shimx64.efi.sha256sum

echo "To remove the container image used for this build: sudo docker image rm uos-shim-review"

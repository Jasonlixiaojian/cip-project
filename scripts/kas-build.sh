#!/bin/sh

# kas 2.0
KAS_COMMIT=141476203d59bf57a2c6d8531050e467b2e7127e

# kas docker image version
export KAS_IMAGE_VERSION=0.13.0

if [ -z "${1}" ]; then
	echo "Usage: ${0} kas-xxx.yml"
	exit 1
fi

rm -f kas-docker
wget https://raw.githubusercontent.com/siemens/kas/${KAS_COMMIT}/kas-docker
if [ ${?} != 0 ]; then
	echo "Failed to download kas-docker script"
	exit 1
fi
chmod a+x kas-docker

./kas-docker build ${1}

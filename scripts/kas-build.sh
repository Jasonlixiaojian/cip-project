#!/bin/sh

KAS_RELEASE=2.0

# kas docker image version
export KAS_IMAGE_VERSION=${KAS_RELEASE}

if [ -z "${1}" ]; then
	echo "Usage: ${0} kas-xxx.yml"
	exit 1
fi

rm -f kas-docker
wget https://raw.githubusercontent.com/siemens/kas/${KAS_RELEASE}/kas-docker
if [ ${?} != 0 ]; then
	echo "Failed to download kas-docker script"
	exit 1
fi
chmod a+x kas-docker

./kas-docker build ${1}

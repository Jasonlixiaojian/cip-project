#!/bin/sh

wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker
if [ ${?} != 0 ]; then
	echo "Failed to download kas-docker script"
	exit 1
fi
chmod a+x kas-docker

echo "done"

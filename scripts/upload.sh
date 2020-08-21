#!/bin/sh

# The following must be set in GitLab CI variables:
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

S3_URI="s3://download.cip-project.org/cip-core/deby"
CODENAME="buster"

usage() {
	echo "Usage: ${0} <board> <files...>"
	exit 1
}

if [ -z "${2}" ]; then
	usage
fi

BOARD="${1}"
BBTARGET="${2}"
KERNEL="${3}"
ROOTFS="${4}"
DTB="${5}"

FILES="build/tmp/deploy/images/${BBTARGET}/${KERNEL} \
       build/tmp/deploy/images/${BBTARGET}/${ROOTFS}"

if [ "$DTB" != "none" ]; then
	FILES="${FILES} build/tmp/deploy/images/${BBTARGET}/${DTB}"
fi

# Install aws command
PATH=$PATH:~/.local/bin
if ! which aws 2>&1 >/dev/null; then
	echo "Installing awscli"
	pip3 install --user awscli
fi

echo "Uploading artifacts to ${S3_URI}/${CODENAME}/${BOARD}"
for file in ${FILES}; do
	# Set ACL so that LAVA jobs can download these files
	aws s3 cp --acl public-read --no-progress \
		${file} ${S3_URI}/${CODENAME}/${BOARD}/
done

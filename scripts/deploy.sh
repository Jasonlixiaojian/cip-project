#!/bin/sh

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
shift
FILES="${@}"

echo "Uploading artifacts to ${S3_URI}/${CODENAME}/${BOARD}"
for file in ${FILES}; do
	aws s3 cp --no-progress ${file} ${S3_URI}/${CODENAME}/${BOARD}
done
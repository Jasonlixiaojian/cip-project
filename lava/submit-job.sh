#!/bin/sh

# The following must be set in GitLab CI variables:
# LAVA_USER
# LAVA_TOKEN

set -e

LAVA_URI="https://${LAVA_USER}:${LAVA_TOKEN}@lava.ciplatform.org/RPC2"

usage() {
	echo "Usage: ${0} <device_type> <test>"
	exit 1
}

if [ -z "${2}" ]; then
	usage
fi
device_type="${1}"
test="${2}"
job_name="cip-core-buster-deby-${device_type}-${test}"

#if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
#	exit 0
#fi

# Install lavacli
PATH=$PATH:~/.local/bin
if ! which lavacli 2>&1 >/dev/null; then
	echo "Installing lavacli"
	pip3 install --user wheel
	pip3 install --user lavacli
fi

echo "Compiling job ${job_name}"
cat lava/jobs/common.yml \
    lava/jobs/device_${device_type}.yml \
    lava/jobs/test_${test}.yml \
    > ${job_name}.yml
sed -i "s|device_type|${device_type}|g" ${job_name}.yml
sed -i "s|job_name|${job_name}|g" ${job_name}.yml
echo "${job_name}.yml:"
cat ${job_name}.yml

echo "Submitting job ${job_name}"
lavacli --uri ${LAVA_URI} jobs submit ${job_name}.yml

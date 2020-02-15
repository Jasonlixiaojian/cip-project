#!/bin/sh

set -e

usage() {
	echo "Usage: ${0} <job>"
	exit 1
}

if [ -z "${1}" ]; then
	usage
fi
JOB=${1}

#if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
#	exit 0
#fi

# Install lavacli
PATH=$PATH:~/.local/bin
if ! which lavacli 2>&1 >/dev/null; then
	echo "Installing lavacli"
	pip3 install wheel
	pip3 install lavacli
fi

# The following must be set in GitLab CI variables:
# LAVA_USER
# LAVA_TOKEN
echo "Submitting job ${JOB}"
lavacli --uri https://${LAVA_USER}:${LAVA_TOKEN}@lava.ciplatform.org/RPC2 jobs submit ${JOB}

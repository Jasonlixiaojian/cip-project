#
# CIP Security, tiny profile
#
# Copyright (c) Toshiba Corporation, 2020
#
# SPDX-License-Identifier: MIT
#

DESCRIPTION = "CIP Security customizations for ssh"

SSH_CLIENT_ALIVE_INTERVAL ?= "120"
SSH_CLIENT_ALIVE_COUNT_MAX ?= "0"

pkg_postinst_${PN}_append() {
	# CR2.6: Remote session termination
	# Terminate remote session after inactive time period
	SSHD_CONFIG="$D${sysconfdir}/ssh/sshd_config"
	alive_interval=$(sed -n '/ClientAliveInterval/p' "${SSHD_CONFIG}")
	alive_countmax=$(sed -n '/ClientAliveCountMax/p' "${SSHD_CONFIG}")
	sed -i "/${alive_interval}/c ClientAliveInterval ${SSH_CLIENT_ALIVE_INTERVAL}"  "${SSHD_CONFIG}"
	sed -i "/${alive_countmax}/c ClientAliveCountMax ${SSH_CLIENT_ALIVE_COUNT_MAX}" "${SSHD_CONFIG}"
}

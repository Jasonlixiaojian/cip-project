#
# CIP Security, tiny profile
#
# Copyright (c) Toshiba Corporation, 2020
#
# SPDX-License-Identifier: MIT
#

DESCRIPTION = "CIP Security customizations for audit"


AUDIT_SPACE_LEFT ?= "75"
AUDIT_ADMIN_SPACE_LEFT ?= "50"

pkg_postinst_audit_append() {
	# CR2.9: Audit storage capacity
	# CR2.9 RE-1: Warn when audit record storage capacity threshold reached
	AUDIT_CONF_FILE="$D${sysconfdir}/audit/auditd.conf"
	sed -i 's/space_left = .*/space_left = ${AUDIT_SPACE_LEFT}/'  $AUDIT_CONF_FILE
	sed -i 's/space_left_action = .*/space_left_action = SYSLOG/'  $AUDIT_CONF_FILE
	sed -i 's/admin_space_left = .*/admin_space_left = ${AUDIT_ADMIN_SPACE_LEFT}/' $AUDIT_CONF_FILE
	sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT_CONF_FILE

	# CR2.10: Response to audit processing failures
	sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
}

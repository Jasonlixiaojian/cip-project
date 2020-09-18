#
# CIP Security, tiny profile
#
# Copyright (c) Toshiba Corporation, 2020
#
# SPDX-License-Identifier: MIT
#

DESCRIPTION = "CIP Security customizations for PAM"

PAM_PASSWD_MINLEN ?= "3"
PAM_LOCK_FAILED_ATTEMPTS ?= "3"
PAM_UNLOCK_TIME ?= "60"
PAM_LIMIT_CONCURRENT_LOGINS ?= "2"


pkg_postinst_pam-plugin-cracklib_append() {
	# CR1.7: Strength of password-based authentication
	# Pam configuration to  enforce password strength
	PAM_PWD_FILE="$D${sysconfdir}/pam.d/common-password"
	CRACKLIB_CONFIG="password  requisite    pam_cracklib.so retry=3 \
	minlen=${PAM_PASSWD_MINLEN} maxrepeat=3 ucredit=-1 \
	lcredit=-1 dcredit=-1 ocredit=-1 difok=3 gecoscheck=1 \
	reject_username enforce_for_root"
	if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
		sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
	fi
	sed -i "0,/^password.*/s/^password.*/${CRACKLIB_CONFIG}\n&/" "${PAM_PWD_FILE}"
}

pkg_postinst_pam-plugin-tally2_append() {
	# CR1.11: Unsuccessful login attempts
	# Lock user account after unsuccessful login attempts
	PAM_AUTH_FILE="$D${sysconfdir}/pam.d/common-auth"
	pam_tally="auth   required  pam_tally2.so  deny=${PAM_LOCK_FAILED_ATTEMPTS} \
	even_deny_root unlock_time=${PAM_UNLOCK_TIME} root_unlock_time=${PAM_UNLOCK_TIME}"
	if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
		sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
	fi
	sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
}


pkg_postinst_libpam_append() {
	# CR2.7: Concurrent session control
	# Limit the concurrent login sessions
	LIMITS_CONFIG="$D${sysconfdir}/security/limits.conf"
	echo "* hard maxlogins ${PAM_LIMIT_CONCURRENT_LOGINS}" >> ${LIMITS_CONFIG}
}

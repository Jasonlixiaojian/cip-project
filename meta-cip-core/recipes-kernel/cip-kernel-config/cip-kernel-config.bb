PR = "r0"

LICENSE = "MIT"
LIC_FILE_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config;branch=master;protocol=https"
SRCREV = "0f2302dc745c66465564ff59be9662c3ba00d0f3"
PV = "git${SRCPV}"

inherit allarch

# Specify a kernel config in the repository
CIP_KERNEL_CONFIG ?= ""

do_configure() {
	:
}

do_compile() {
	:
}

do_install() {
	if [ -z "${CIP_KERNEL_CONFIG}" ]; then
		bbnote "CIP_KERNEL_CONFIG not set, nothing to do"
	else
		if [ ! -f ${S}/${CIP_KERNEL_CONFIG} ]; then
			bbfatal "${CIP_KERNEL_CONFIG} not found"
		fi
		install -d ${datadir}/${BPN}
		install -m 0644 ${S}/${CIP_KERNEL_CONFIG} ${datadir}/${BPN}
	fi
}

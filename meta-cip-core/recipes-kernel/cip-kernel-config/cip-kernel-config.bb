PR = "r0"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config;branch=master;protocol=https"
SRCREV = "0f2302dc745c66465564ff59be9662c3ba00d0f3"
PV = "git${SRCPV}"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

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
	fi

	if [ ! -f ${S}/${CIP_KERNEL_CONFIG} ]; then
		bbfatal "${S}/${CIP_KERNEL_CONFIG} not found"
	fi
	install_dir=${D}/${datadir}/${BPN}/$(dirname ${CIP_KERNEL_CONFIG})
	install -d ${install_dir}
	install -m 0644 ${S}/${CIP_KERNEL_CONFIG} ${install_dir}
}

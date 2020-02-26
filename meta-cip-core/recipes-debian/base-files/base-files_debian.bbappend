do_install_append() {
	echo "${MACHINE}" > ${D}${sysconfdir}/hostname
}

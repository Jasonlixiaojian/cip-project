CIP Core (Tiny Profile) with Debian 10 buster
=============================================

This branch provides recipes to generate CIP core tiny profile images
based on Debian 10 buster userland packages.

Supported Software
==================

The build targets of this branch are the following kernel and userland versions.

* Kernel:
    * [linux-4.19.y-cip](https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip)
    * [linux-4.19.y-cip-rt](https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-cip-rt)
* Userland: Debian 10 buster

All recipes in this branch are compatible with the following Yocto Project version.

* Yocto Project 2.7 (warrior)

Supported Hardware
==================

The following boards are supported in this branch.

* `qemux86-64`: QEMU x86 64bit (Q35 machine)
* `bbb`: BeagleBone Black
* `iwg20m`: iWave RZ/G1M Qseven Development Kit
* `hihope-rzg2m`: Hoperun Technology HiHope RZ/G2M platform
* `hihope-rzg2n`: Hoperun Technology HiHope RZ/G2N platform
* `r8a774c0-ek874`: Silicon Linux RZ/G2E evaluation kit EK874
* `simatic-ipc227e`: Siemens SIMATIC IPC227E

Build Target Images
===================

Select the target board from [Supported Hardware](#supported-hardware)
and set it to `MACHINE` variable.

Example:

    $ MACHINE=qemux86-64

Build images with `kas-build.sh` helper script.

    $ ./scripts/kas-build.sh kas/board/${MACHINE}.yml

Run Images on the target board
==============================

QEMU
----

    $ ./scripts/start-qemu.sh ${MACHINE}

Create test image for CIP's LAVA
================================

base image for QEMU x86-64
--------------------------

    $ ./scripts/kas-build.sh kas/board/qemux86-64.yml:kas/opt/deby.yml:kas/opt/dhcp.yml:kas/opt/smc.yml

LTP test image for QEMU x86-64
------------------------------

    $ ./scripts/kas-build.sh kas/board/qemux86-64.yml:kas/opt/deby.yml:kas/opt/dhcp.yml:kas/opt/ltp.yml

base image for QEMU arm (armhf) / iwg20m
-------------------------

    $ ./scripts/kas-build.sh kas/board/qemuarm.yml:kas/opt/deby.yml:kas/opt/dhcp.yml:kas/opt/smc.yml

LTP test image for QEMU arm (armhf) / iwg20m
------------------------------

    $ ./scripts/kas-build.sh kas/board/qemuarm.yml:kas/deby.yml:kas/opt/dhcp.yml:kas/opt/ltp.yml

base image for QEMU arm64 / hihope-rzg2m
--------------------------

    $ ./scripts/kas-build.sh kas/board/qemuarm64.yml:kas/opt/deby.yml:kas/opt/dhcp.yml:kas/opt/smc.yml

LTP test image for QEMU arm64 / hihope-rzg2m
------------------------------

    $ ./scripts/kas-build.sh kas/board/qemuarm64.yml:kas/opt/deby.yml:kas/opt/dhcp.yml:kas/opt/ltp.yml


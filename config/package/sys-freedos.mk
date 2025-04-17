## wmfd-de package configuration - sys-freedos

# Homepage: via ibiblio.org pc-stuff

# sys-freedos.pl describes itself as "a Perl script to SYS the boot
# sector of a disk image or a device for FreeDOS". It uses 'nasm'
# to build code for the boot sector.


SYS_FREEDOS_VERSION=1.1
SYS_FREEDOS_TARBALL=${DOWNLOAD_DIR}/sys-freedos-linux.zip
SYS_FREEDOS_URL=http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/dos/kernel/sys-freedos-linux/$(notdir ${SYS_FREEDOS_TARBALL})


## Rules

.PHONY: download-toolchain-sys-freedos
download-toolchain-sys-freedos:
	make download-file DOWNLOAD_URL=${SYS_FREEDOS_URL} DOWNLOAD_OUTFILE=${SYS_FREEDOS_TARBALL}

.PHONY: verify-toolchain-sys-freedos
verify-toolchain-sys-freedos: download-toolchain-sys-freedos
	make download-verify FILE=${SYS_FREEDOS_TARBALL} EXPECTED_CHECKSUM=13477740ce349e10c1753b113be41b94

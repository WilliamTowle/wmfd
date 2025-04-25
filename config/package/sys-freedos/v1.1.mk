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
	${MAKE} -f $(firstword $(MAKEFILE_LIST)) download-file DOWNLOAD_URL=${SYS_FREEDOS_URL} DOWNLOAD_OUTFILE=${SYS_FREEDOS_TARBALL}

.PHONY: verify-toolchain-sys-freedos
verify-toolchain-sys-freedos: download-toolchain-sys-freedos
	${MAKE} -f $(firstword $(MAKEFILE_LIST)) download-verify FILE=${SYS_FREEDOS_TARBALL} EXPECTED_CHECKSUM=13477740ce349e10c1753b113be41b94

.PHONY: install-toolchain-sys-freedos
install-toolchain-sys-freedos: verify-toolchain-sys-freedos \
	install-toolchain-unzip install-toolchain-nasm
	[ -r ${TOOLCHAIN_DIR}/bin/sys-freedos.pl ] || { \
		mkdir -p ${STAGING_DIR}/temp && \
		cd ${STAGING_DIR}/temp && unzip ${SYS_FREEDOS_TARBALL} && \
		mkdir -p ${TOOLCHAIN_DIR}/etc/bootsecs || exit 1 ;\
		cp -ar bootsecs/* ${TOOLCHAIN_DIR}/etc/bootsecs/ || exit 1 ;\
		mkdir -p ${TOOLCHAIN_DIR}/usr/bin || exit 1 ;\
		sed 's%/bootsecs/%/../etc/bootsecs/%' sys-freedos.pl > ${TOOLCHAIN_DIR}/bin/sys-freedos.pl || exit 1 ;\
		chmod a+x ${TOOLCHAIN_DIR}/bin/sys-freedos.pl || exit 1 ;\
		cd ${STAGING_DIR} && rm -rf ./temp ;\
		}

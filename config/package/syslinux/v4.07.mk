# wmfd-de package configuration - syslinux
# Homepage: https://syslinux.sourceforge.net/

SYSLINUX_VERSION=4.07

SYSLINUX_TARBALL=${DOWNLOAD_DIR}/syslinux-${SYSLINUX_VERSION}.tar.bz2
SYSLINUX_URL=https://www.kernel.org/pub/linux/utils/boot/syslinux/$(notdir ${SYSLINUX_TARBALL})


## Rules

.PHONY: download-toolchain-syslinux
download-toolchain-syslinux:
	${MAKE} -f $(firstword $(MAKEFILE_LIST)) download-file DOWNLOAD_URL=${SYSLINUX_URL} DOWNLOAD_OUTFILE=${SYSLINUX_TARBALL}

.PHONY: verify-toolchain-syslinux
verify-toolchain-syslinux: download-toolchain-syslinux
	${MAKE} -f $(firstword $(MAKEFILE_LIST)) download-verify FILE=${SYSLINUX_TARBALL} EXPECTED_CHECKSUM=9ff6e1b94efab931fb4717b600d88779

.PHONY: install-toolchain-syslinux
install-toolchain-syslinux: verify-toolchain-syslinux
	[ -r ${TOOLCHAIN_DIR}/bin/syslinux ] || { \
		mkdir -p ${STAGING_DIR}/temp && \
		cd ${STAGING_DIR}/temp && tar xvjf ${SYSLINUX_TARBALL} && \
		cd ${STAGING_DIR}/temp/syslinux-${SYSLINUX_VERSION} && \
		mv mk/syslinux.mk mk/syslinux.mk.OLD && \
		cat mk/syslinux.mk.OLD \
			| sed '/^[A-Z]*DIR/	s%/usr%'${TOOLCHAIN_DIR}'%' \
			| sed '/^SBINDIR/	s%/sbin%'${TOOLCHAIN_DIR}'/sbin%' \
			| sed '/^CC/	s%$$% -I$$(INCDIR)%' \
			| sed '/^CC/	s%$$% -L$$(LIBDIR)%' \
			| sed '/^NASM/	s%nasm%'${TOOLCHAIN_DIR}'/bin/nasm%' \
			> mk/syslinux.mk && \
		\
		make -C libinstaller && \
		make -C linux && \
		\
		mkdir -p ${TOOLCHAIN_DIR}/bin && \
		mkdir -p ${TOOLCHAIN_DIR}/lib/syslinux && \
		cp com32/chain/chain.c32 com32/menu/menu.c32 ${TOOLCHAIN_DIR}/lib/syslinux/ && \
		cp mbr/*.bin ${TOOLCHAIN_DIR}/lib/syslinux/ && \
		cp linux/syslinux linux/syslinux-nomtools ${TOOLCHAIN_DIR}/bin/ && \
		\
		cd ${STAGING_DIR} && rm -rf ./temp ;\
		}

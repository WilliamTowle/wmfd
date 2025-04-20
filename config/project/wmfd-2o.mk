## wmfd-de project configuration - wmfd-2o

TOOLCHAIN_WITH_SYSLINUX?=n

include ${CONFIG_DIR}/download.mk

ifneq (${TOOLCHAIN_WITH_SYSLINUX},n)
include ${CONFIG_DIR}/toolchain/freedos-syslinux.mk
else
include ${CONFIG_DIR}/toolchain/freedos-sys-freedos.mk
endif
include ${CONFIG_DIR}/staging/wmfd-2o.mk

MEDIA_FILENAME=wmfd-2o.img


## Rules

.PHONY: prepare
prepare: download-prepare toolchain-prepare staging-prepare

.PHONY: download-all
download-all: download-toolchain-all download-staging-all

.PHONY: verify-all
verify-all: verify-toolchain-all verify-staging-all

.PHONY: deploy-media
deploy-media: build-staging | ${STAGING_DIR}
	mformat -C -f 1440 -i ${STAGING_DIR}/${MEDIA_FILENAME} ::
ifneq (${TOOLCHAIN_WITH_SYSLINUX},n)
	( mkdir -p ${STAGING_DIR}/rootfs/boot/syslinux && printf '%s\n' 'prompt 1' 'timeout 120' 'default dos' '' 'label dos' '    COM32 /boot/syslinux/chain.c32' '    APPEND freedos=/kernel.sys' > ${STAGING_DIR}/rootfs/boot/syslinux/syslinux.cfg )
	sudo sh -c "PATH=${PATH} syslinux --install ${STAGING_DIR}/${MEDIA_FILENAME}"
	mmd -i ${STAGING_DIR}/${MEDIA_FILENAME} ::/boot ::/boot/syslinux && mcopy -i ${STAGING_DIR}/${MEDIA_FILENAME} ${TOOLCHAIN_DIR}/lib/syslinux/chain.c32 ${STAGING_DIR}/rootfs/boot/syslinux/syslinux.cfg ::/boot/syslinux/
else
	sys-freedos.pl --disk=${STAGING_DIR}/${MEDIA_FILENAME} --offset=0 --drive=0
endif
	mcopy -i ${STAGING_DIR}/${MEDIA_FILENAME} ${STAGING_DIR}/rootfs/*.* ::

.PHONY: clean
clean: toolchain-clean staging-clean

.PHONY: distclean
distclean: clean download-clean

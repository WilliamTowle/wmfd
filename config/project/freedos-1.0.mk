## wmfd-de project configuration - freedos-1.0

TOOLCHAIN_WITH_SYSLINUX?=n

include ${CONFIG_DIR}/download.mk

ifneq (${TOOLCHAIN_WITH_SYSLINUX},n)
include ${CONFIG_DIR}/toolchain/freedos-syslinux.mk
else
include ${CONFIG_DIR}/toolchain/freedos-sys-freedos.mk
endif
include ${CONFIG_DIR}/staging/freedos-1.0.mk


MEDIA_TYPE=floppy
MEDIA_FILENAME=freedos-1.0-${MEDIA_TYPE}.img
MEDIA_OUTFILE=${STAGING_DIR}/${MEDIA_FILENAME}

ifneq (${TOOLCHAIN_WITH_SYSLINUX},n)
include ${CONFIG_DIR}/media/floppy-syslinux.mk
include ${CONFIG_DIR}/media/zip-syslinux.mk
else
include ${CONFIG_DIR}/media/floppy-sys-freedos.mk
endif


## Rules

.PHONY: prepare
prepare: download-prepare toolchain-prepare staging-prepare

.PHONY: download-all
download-all: download-toolchain-all download-staging-all

.PHONY: verify-all
verify-all: verify-toolchain-all verify-staging-all


##

.PHONY: deploy-media

.PHONY: deploy-media-prepare
deploy-media-prepare: build-toolchain prepare-media-${MEDIA_TYPE}

.PHONY: deploy-media-install
deploy-media-install: deploy-media-prepare build-staging
ifneq (${MEDIA_TYPE},floppy)
	MTOOLSRC=${MEDIA_MTOOLSRC} mcopy ${STAGING_DIR}/rootfs/*.* z:
else
	mcopy -i ${MEDIA_OUTFILE} ${STAGING_DIR}/rootfs/*.* ::
endif

deploy-media: deploy-media-prepare deploy-media-install


##

.PHONY: clean
clean: toolchain-clean staging-clean

.PHONY: distclean
distclean: clean download-clean

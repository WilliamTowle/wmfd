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
MEDIA_OUTFILE=${STAGING_DIR}/${MEDIA_FILENAME}

ifneq (${TOOLCHAIN_WITH_SYSLINUX},n)
include ${CONFIG_DIR}/media/floppy-syslinux.mk
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
deploy-media-prepare: build-toolchain prepare-media-floppy

.PHONY: deploy-media-install
deploy-media-install: deploy-media-prepare build-staging
	mcopy -i ${MEDIA_OUTFILE} ${STAGING_DIR}/rootfs/*.* ::


deploy-media: deploy-media-prepare deploy-media-install


##

.PHONY: clean
clean: toolchain-clean staging-clean

.PHONY: distclean
distclean: clean download-clean

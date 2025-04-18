## wmfd-de project configuration - wmfd-2o

include ${CONFIG_DIR}/download.mk

include ${CONFIG_DIR}/toolchain/wmfd-simple.mk
include ${CONFIG_DIR}/staging/wmfd-2o.mk


## Rules

.PHONY: prepare
prepare: download-prepare toolchain-prepare staging-prepare

.PHONY: download-all
download-all: download-toolchain-all download-staging-all

.PHONY: verify-all
verify-all: verify-toolchain-all verify-staging-all

.PHONY: deploy-media
deploy-media: build-staging | ${STAGING_DIR}
	mformat -C -f 1440 -i ${STAGING_DIR}/x1440a.img ::
	sys-freedos.pl --disk=${STAGING_DIR}/x1440a.img --offset=0 --drive=0
	mcopy -i ${STAGING_DIR}/x1440a.img ${STAGING_DIR}/rootfs/* ::

.PHONY: clean
clean: toolchain-clean staging-clean

.PHONY: distclean
distclean: clean download-clean

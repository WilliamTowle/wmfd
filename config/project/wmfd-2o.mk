## wmfd-de project configuration - wmfd-2o

include ${CONFIG_DIR}/download.mk

include ${CONFIG_DIR}/toolchain/wmfd-simple.mk
include ${CONFIG_DIR}/staging/wmfd-2o.mk


## Rules

.PHONY: prepare
prepare: download-prepare toolchain-prepare staging-prepare

.PHONY: deploy-media
deploy-media: build-staging | ${STAGING_DIR}

.PHONY: clean
clean: toolchain-clean staging-clean

.PHONY: distclean
distclean: clean download-clean

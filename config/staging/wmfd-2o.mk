## wmfd-de staging tree configuration - wmfd-2o

include ${CONFIG_DIR}/staging.mk


## Rules

.PHONY: build-staging
build-staging: download-prepare staging-prepare build-toolchain | ${DOWNLOAD_DIR} ${STAGING_DIR}

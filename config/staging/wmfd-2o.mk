## wmfd-de staging tree configuration - wmfd-2o

include ${CONFIG_DIR}/staging.mk

include ${CONFIG_DIR}/package/freedos-kernel/v2.0.35.mk
include ${CONFIG_DIR}/package/freecom/v0.82pl3.mk

STAGING_PACKAGES=kernel freecom

## Rules

.PHONY: download-staging-all
download-staging-all: download-prepare \
	$(patsubst %,download-staging-%,${STAGING_PACKAGES})

.PHONY: verify-staging-all
verify-staging-all: download-staging-all \
	$(patsubst %,verify-staging-%,${STAGING_PACKAGES})

.PHONY: build-staging
build-staging: download-prepare staging-prepare build-toolchain \
	$(patsubst %,install-staging-%,${STAGING_PACKAGES}) \
	| ${DOWNLOAD_DIR} ${STAGING_DIR}

all: build-staging

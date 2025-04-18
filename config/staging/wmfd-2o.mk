## wmfd-de staging tree configuration - wmfd-2o

include ${CONFIG_DIR}/staging.mk

include ${CONFIG_DIR}/package/freedos-kernel.mk
include ${CONFIG_DIR}/package/freedos-command.mk


## Rules

.PHONY: download-staging-all
download-staging-all: download-prepare
ifneq (${KERNEL_VERSION},)
	make download-staging-kernel
endif
ifneq (${COMMAND_VERSION},)
	make download-staging-command
endif

.PHONY: verify-staging-all
verify-staging-all: download-staging-all
ifneq (${KERNEL_VERSION},)
	make verify-staging-kernel
endif
ifneq (${COMMAND_VERSION},)
	make verify-staging-command
endif

.PHONY: build-staging
build-staging: download-prepare staging-prepare build-toolchain | ${DOWNLOAD_DIR} ${STAGING_DIR}
ifneq (${KERNEL_VERSION},)
	make install-staging-kernel
endif
ifneq (${COMMAND_VERSION},)
	make install-staging-command
endif

## wmfd-de toolchain tree configuration - freedos-sys-freedos.mk

include ${CONFIG_DIR}/toolchain.mk
include ${CONFIG_DIR}/package/mtools.mk
include ${CONFIG_DIR}/package/nasm.mk
include ${CONFIG_DIR}/package/sys-freedos.mk
include ${CONFIG_DIR}/package/unzip.mk

TOOLCHAIN_PACKAGES=mtools nasm sys-freedos unzip

## Rules

.PHONY: download-toolchain-all
download-toolchain-all: download-prepare \
	$(patsubst %,download-toolchain-%,${TOOLCHAIN_PACKAGES})

.PHONY: verify-toolchain-all
verify-toolchain-all: download-toolchain-all \
	$(patsubst %,verify-toolchain-%,${TOOLCHAIN_PACKAGES})

.PHONY: build-toolchain
build-toolchain: config-sanity download-prepare toolchain-prepare \
	$(patsubst %,install-toolchain-%,${TOOLCHAIN_PACKAGES})

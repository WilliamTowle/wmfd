## wmfd-de toolchain tree configuration - freedos-syslinux

include ${CONFIG_DIR}/toolchain.mk
include ${CONFIG_DIR}/package/mtools/v4.0.48.mk
include ${CONFIG_DIR}/package/syslinux/v4.07.mk
include ${CONFIG_DIR}/package/unzip/v6.0.mk

TOOLCHAIN_PACKAGES=mtools syslinux unzip


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

all: build-toolchain

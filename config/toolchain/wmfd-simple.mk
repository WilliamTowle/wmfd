## wmfd-de toolchain tree configuration - wmfd-simple

include ${CONFIG_DIR}/toolchain.mk


## Rules

.PHONY: build-toolchain
build-toolchain: config-sanity download-prepare toolchain-prepare

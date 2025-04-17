## wmfd-de toolchain tree configuration - wmfd-simple

include ${CONFIG_DIR}/toolchain.mk
include ${CONFIG_DIR}/package/mtools.mk
include ${CONFIG_DIR}/package/nasm.mk
include ${CONFIG_DIR}/package/sys-freedos.mk
include ${CONFIG_DIR}/package/unzip.mk


## Rules

.PHONY: download-toolchain-all
download-toolchain-all: download-prepare
ifneq (${MTOOLS_VERSION},)
	make download-toolchain-mtools
endif
ifneq (${NASM_VERSION},)
	make download-toolchain-nasm
endif
ifneq (${SYS_FREEDOS_VERSION},)
	make download-toolchain-sys-freedos
endif
ifneq (${UNZIP_VERSION},)
	make download-toolchain-unzip
endif

.PHONY: verify-toolchain-all
verify-toolchain-all: download-toolchain-all
ifneq (${MTOOLS_VERSION},)
	make verify-toolchain-mtools
endif
ifneq (${NASM_VERSION},)
	make verify-toolchain-nasm
endif
ifneq (${SYS_FREEDOS_VERSION},)
	make verify-toolchain-sys-freedos
endif
ifneq (${UNZIP_VERSION},)
	make verify-toolchain-unzip
endif

.PHONY: build-toolchain
build-toolchain: config-sanity download-prepare toolchain-prepare

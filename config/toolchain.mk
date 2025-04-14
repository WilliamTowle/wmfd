# wmfd-de configuration - toolchain tree

TOOLCHAIN_DIR?=${TOPLEV}/toolchain

${TOOLCHAIN_DIR}: ; @mkdir -p $@

.PHONY: toolchain-prepare
toolchain-prepare: ${TOOLCHAIN_DIR}

.PHONY: toolchain-clean
toolchain-clean:
	rm -rf ${TOOLCHAIN_DIR}

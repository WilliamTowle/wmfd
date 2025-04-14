# wmfd-de configuration - staging tree

STAGING_DIR?=${TOPLEV}/staging

${STAGING_DIR}: ; @mkdir -p $@

.PHONY: staging-prepare
staging-prepare: ${STAGING_DIR}

.PHONY: staging-clean
staging-clean:
	rm -rf ${STAGING_DIR}

# wmfd-de configuration - download tree

DOWNLOAD_DIR?=${TOPLEV}/download

${DOWNLOAD_DIR}: ; @mkdir -p $@

.PHONY: download-prepare
download-prepare: ${DOWNLOAD_DIR}

.PHONY: download-file
download-file:
	[ -s ${DOWNLOAD_OUTFILE} ] || { wget --spider ${DOWNLOAD_URL} && wget ${DOWNLOAD_URL} -O ${DOWNLOAD_OUTFILE} ; }

.PHONY: download-verify
download-verify:
	if [ "${EXPECTED_CHECKSUM}" ] ; then \
		export CURRENT_CHECKSUM=`md5sum ${FILE} | awk '{ print $$1 }'` && \
		if [ "${EXPECTED_CHECKSUM}" != "$${CURRENT_CHECKSUM}" ] ; then \
			printf '%s %s: %s\n' $(lastword ${MAKEFILE_LIST}) $@ "EXPECTED_CHECKSUM ${EXPECTED_CHECKSUM} does not match CURRENT_CHECKSUM $${CURRENT_CHECKSUM}" && \
			false ;\
		fi ;\
	else \
		printf '%s %s: %s\n' $(lastword ${MAKEFILE_LIST}) $@ "Configuration error - expected package md5sum unset, current file has $${CURRENT_CHECKSUM}" && \
		false ;\
	fi


.PHONY: download-clean
download-clean:
	rm -rf ${DOWNLOAD_DIR}

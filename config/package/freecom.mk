## wmfd-de package configuration - FreeCOM (FreeDOS command shell)

COMMAND_VERSION=082pl3
COMMAND_ZIPFILE=${DOWNLOAD_DIR}/com082pl3.zip
COMMAND_URL=https://sourceforge.net/projects/freedos/files/FreeCOM/082pl3%20%28use%20xmsswap%20for%20386%2B%20PC%29/$(notdir ${COMMAND_ZIPFILE})/download


## Rules:

.PHONY: download-staging-freecom
download-staging-freecom:
	make download-file DOWNLOAD_URL=${COMMAND_URL} DOWNLOAD_OUTFILE=${COMMAND_ZIPFILE}

.PHONY: verify-staging-freecom
verify-staging-freecom: download-staging-freecom
	make download-verify FILE=${COMMAND_ZIPFILE} EXPECTED_CHECKSUM=0e2e501d1f9d8ffa9bdbbd08b019f2a4

.PHONY: install-staging-freecom
install-staging-freecom: verify-staging-freecom
	[ -r ${STAGING_DIR}/rootfs/command.com ] || { \
		mkdir -p ${STAGING_DIR}/temp && \
		cd ${STAGING_DIR}/temp && \
		unzip ${COMMAND_ZIPFILE} && \
		unzip freecom.zip && \
		cp freecom/command.com ${STAGING_DIR}/rootfs && \
		cd ${STAGING_DIR} && rm -rf ./temp ;\
		}

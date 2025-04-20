## wmfd-de package configuration - FreeCOM (FreeDOS command shell)

# FreeDOS v1.0 lsm file (v0.84pre2):
# https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.0/pkgs/commands.lsm

COMMAND_VERSION=0.84pre2
#COMMAND_ZIPFILE=${DOWNLOAD_DIR}/com082pl3.zip
COMMAND_ZIPFILE=${DOWNLOAD_DIR}/com084pre2.zip
#COMMAND_URL=https://sourceforge.net/projects/freedos/files/FreeCOM/082pl3%20%28use%20xmsswap%20for%20386%2B%20PC%29/$(notdir ${COMMAND_ZIPFILE})/download
COMMAND_URL=https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.0/pkgs/commandx.zip


## Rules:

.PHONY: download-staging-freecom
download-staging-freecom:
	${MAKE} -f $(firstword $(MAKEFILE_LIST)) download-file DOWNLOAD_URL=${COMMAND_URL} DOWNLOAD_OUTFILE=${COMMAND_ZIPFILE}

.PHONY: verify-staging-freecom
verify-staging-freecom: download-staging-freecom
	${MAKE} -f $(firstword $(MAKEFILE_LIST)) download-verify FILE=${COMMAND_ZIPFILE} EXPECTED_CHECKSUM=30817e0e4cda5e821913966ebc91a708

.PHONY: install-staging-freecom
install-staging-freecom: verify-staging-freecom \
	install-toolchain-unzip
	[ -r ${STAGING_DIR}/rootfs/command.com ] || { \
		mkdir -p ${STAGING_DIR}/temp && \
		cd ${STAGING_DIR}/temp && \
		unzip ${COMMAND_ZIPFILE} && \
		cp bin/command.com ${STAGING_DIR}/rootfs && \
		cd ${STAGING_DIR} && rm -rf ./temp ;\
		}

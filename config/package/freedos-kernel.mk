## wmfd-de package configuration - freedos-kernel

KERNEL_VERSION=2036
KERNEL_ZIPFILE=${DOWNLOAD_DIR}/kernel${KERNEL_VERSION}-binary.zip
KERNEL_URL=https://sourceforge.net/projects/freedos/files/Kernel/${KERNEL_VERSION}test/$(notdir ${KERNEL_ZIPFILE})/download


## Rules

.PHONY: download-staging-kernel
download-staging-kernel:
	make download-file DOWNLOAD_URL=${KERNEL_URL} DOWNLOAD_OUTFILE=${KERNEL_ZIPFILE}

.PHONY: verify-staging-kernel
verify-staging-kernel: download-staging-kernel
	make download-verify FILE=${KERNEL_ZIPFILE} EXPECTED_CHECKSUM=4a03a49f8373b165256f6c85cc3b82df

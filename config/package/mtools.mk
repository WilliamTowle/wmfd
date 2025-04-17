## wmfd-de package configuration - mtools

# Homepage: https://www.gnu.org/software/mtools/

#MTOOLS_VERSION=4.0.15
MTOOLS_VERSION=4.0.48
MTOOLS_TARBALL=${DOWNLOAD_DIR}/mtools-${MTOOLS_VERSION}.tar.gz
MTOOLS_URL=http://ftp.gnu.org/gnu/mtools/$(notdir ${MTOOLS_TARBALL})


## Rules

.PHONY: download-toolchain-mtools
download-toolchain-mtools:
	make download-file DOWNLOAD_URL=${MTOOLS_URL} DOWNLOAD_OUTFILE=${MTOOLS_TARBALL}

.PHONY: verify-toolchain-mtools
verify-toolchain-mtools: download-toolchain-mtools
	make download-verify FILE=${MTOOLS_TARBALL} EXPECTED_CHECKSUM=1bc100883e42462d5c10d93b489f4323

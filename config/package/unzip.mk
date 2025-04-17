## wmfd-de package configuration - UnZip

# Homepage: http://www.info-zip.org/UnZip.html

UNZIP_VERSION=6.0
UNZIP_TARBALL=${DOWNLOAD_DIR}/unzip60.tar.gz
UNZIP_URL=https://downloads.sourceforge.net/infozip/$(notdir ${UNZIP_TARBALL})


## Rules

.PHONY: download-toolchain-unzip
download-toolchain-unzip:
	make download-file DOWNLOAD_URL=${UNZIP_URL} DOWNLOAD_OUTFILE=${UNZIP_TARBALL}

.PHONY: verify-toolchain-unzip
verify-toolchain-unzip: download-toolchain-unzip
	make download-verify FILE=${UNZIP_TARBALL} EXPECTED_CHECKSUM=62b490407489521db863b523a7f86375

## wmfd-de package configuration - Netwide Assembler (NASM)

# Homepage: https://www.nasm.us/

#|NASM_VERSION=2.16
#|NASM_TARBALL=${DOWNLOAD_DIR}/nasm-${NASM_VERSION}.tar.bz2
#|NASM_URL=https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/$(notdir ${NASM_TARBALL})
NASM_VERSION=2.16.01
NASM_TARBALL=${DOWNLOAD_DIR}/nasm_${NASM_VERSION}.orig.tar.xz
NASM_URL=https://snapshot.debian.org/archive/debian/20221231T090612Z/pool/main/n/nasm/$(notdir ${NASM_TARBALL})


## Rules

.PHONY: download-toolchain-nasm
download-toolchain-nasm:
	make download-file DOWNLOAD_URL=${NASM_URL} DOWNLOAD_OUTFILE=${NASM_TARBALL}

.PHONY: verify-toolchain-nasm
verify-toolchain-nasm: download-toolchain-nasm
	make download-verify FILE=${NASM_TARBALL} EXPECTED_CHECKSUM=d755ba0d16f94616c2907f8cab7c748b

## wmfd-de package configuration - FreeCOM (FreeDOS command shell)

# SourceForge FreeDOS page recommends com082pl3-xmsswap.zip for 386+

COMMAND_VERSION=082pl3
#|COMMAND_ZIPFILE=${DOWNLOAD_DIR}/com082pl3.zip
COMMAND_ZIPFILE=${DOWNLOAD_DIR}/com082pl3-xmsswap.zip
COMMAND_URL=https://sourceforge.net/projects/freedos/files/FreeCOM/082pl3%20%28use%20xmsswap%20for%20386%2B%20PC%29/$(notdir ${COMMAND_ZIPFILE})/download


## Rules:

.PHONY: download-staging-freecom
download-staging-freecom:
	make download-file DOWNLOAD_URL=${COMMAND_URL} DOWNLOAD_OUTFILE=${COMMAND_ZIPFILE}

.PHONY: verify-staging-freecom
verify-staging-freecom: download-staging-freecom
	case `basename ${COMMAND_ZIPFILE}` in \
	com082pl3.zip) make download-verify FILE=${COMMAND_ZIPFILE} EXPECTED_CHECKSUM=0e2e501d1f9d8ffa9bdbbd08b019f2a4 ;; \
	com082pl3-xmsswap.zip) make download-verify FILE=${COMMAND_ZIPFILE} EXPECTED_CHECKSUM=48cfb02bc87aa0e2deb73b8f5ae30653 ;; \
	*) exit 1 ;; \
	esac

.PHONY: install-staging-freecom
install-staging-freecom: verify-staging-freecom
	[ -r ${STAGING_DIR}/rootfs/command.com ] || { \
		mkdir -p ${STAGING_DIR}/temp && \
		cd ${STAGING_DIR}/temp && \
		case `basename ${COMMAND_ZIPFILE}` in \
		com082pl3.zip) \
			unzip ${COMMAND_ZIPFILE} && \
			unzip freecom.zip && \
			cp freecom/command.com ${STAGING_DIR}/rootfs \
			;; \
		com082pl3-xmsswap.zip) \
			unzip ${COMMAND_ZIPFILE} && \
			cp command.com ${STAGING_DIR}/rootfs \
			;; \
		*) exit 1 ;; \
		esac && \
		cd ${STAGING_DIR} && rm -rf ./temp ;\
		}

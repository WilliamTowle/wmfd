## sys-freeDOS floppy build


ifeq (${MEDIA_TYPE},floppy)
${MEDIA_OUTFILE}: | ${STAGING_DIR}
	mformat -C -f 1440 -i $@
endif


.PHONY: prepare-media-floppy

prepare-media-floppy: ${MEDIA_OUTFILE}
	sys-freedos.pl --disk=${MEDIA_OUTFILE} --offset=0 --drive=0

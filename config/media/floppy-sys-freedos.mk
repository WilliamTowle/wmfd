## sys-freeDOS floppy build


${MEDIA_OUTFILE}: | ${STAGING_DIR}
	mformat -C -f 1440 -i $@


.PHONY: prepare-media-floppy

prepare-media-floppy: ${MEDIA_OUTFILE}
	sys-freedos.pl --disk=${MEDIA_OUTFILE} --offset=0 --drive=0

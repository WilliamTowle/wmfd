## syslinux floppy build


ifeq (${MEDIA_TYPE},floppy)
${MEDIA_OUTFILE}: | ${STAGING_DIR}
	mformat -C -f 1440 -i $@
endif


.PHONY: prepare-media-floppy

prepare-media-floppy: ${MEDIA_OUTFILE} | ${STAGING_DIR}
	( mkdir -p ${STAGING_DIR}/rootfs/boot/syslinux && printf '%s\n' 'prompt 1' 'timeout 120' 'default dos' '' 'label dos' '    COM32 /boot/syslinux/chain.c32' '    APPEND freedos=/kernel.sys' > ${STAGING_DIR}/rootfs/boot/syslinux/syslinux.cfg )
	sudo sh -c "PATH=${PATH} syslinux --install ${MEDIA_OUTFILE}"
	mmd -i ${MEDIA_OUTFILE} ::/boot ::/boot/syslinux && mcopy -i ${MEDIA_OUTFILE} ${TOOLCHAIN_DIR}/lib/syslinux/chain.c32 ${STAGING_DIR}/rootfs/boot/syslinux/syslinux.cfg ::/boot/syslinux/

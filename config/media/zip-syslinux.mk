## syslinux zip disk build

# Per https://aeb.win.tue.nl/linux/zip/zip-1.html - geometries:
#	Zip100: 96/64/32
#	Zip250: 239/64/32

MEDIA_GEOM_CYLS=96
MEDIA_GEOM_HEADS=64
MEDIA_GEOM_SPT=32


# From https://en.wikipedia.org/wiki/Logical_block_addressing
#	ATA CHS scheme (16:4:8 bits) supports 1<=H<16 and 1<=SPT<256
#	INT 13h scheme (10:8:6) supports 1024 cyls, 256 heads, SPT 63
# If lowest common denominator of 10:4:6 applies, 64 heads is invalid

calc=$(shell expr $(patsubst %,'%',$1))
MEDIA_MBR_CYLS=$(call calc, ${MEDIA_GEOM_CYLS} * 4)
MEDIA_MBR_HEADS=$(call calc, ${MEDIA_GEOM_HEADS} / 4)
MEDIA_MBR_SPT=${MEDIA_GEOM_SPT}
MEDIA_SECTORS=$(call calc,${MEDIA_GEOM_CYLS} * ${MEDIA_GEOM_HEADS} * ${MEDIA_GEOM_SPT})
MEDIA_MTOOLSRC=${STAGING_DIR}/mtoolsrc-${MEDIA_TYPE}

${MEDIA_MTOOLSRC}: | ${STAGING_DIR}
	printf '%s\n' 'drive z: file="'${MEDIA_OUTFILE}'" partition=4' \
		> $@

ifneq (${MEDIA_TYPE},floppy)
# syslinux MBR is just the boot code, so we avoid mpartition -B
${MEDIA_OUTFILE}: | ${STAGING_DIR}
	truncate --size=$(call calc,${MEDIA_SECTORS} * 512) $@
	dd if=${TOOLCHAIN_DIR}/lib/syslinux/mbr.bin of=$@ bs=440 count=1 conv=notrunc
	MTOOLSRC=${MEDIA_MTOOLSRC} mpartition -Ica -t ${MEDIA_MBR_CYLS} -h ${MEDIA_MBR_HEADS} -s ${MEDIA_MBR_SPT} z:
	MTOOLSRC=${MEDIA_MTOOLSRC} mformat z:
endif


.PHONY: prepare-media-zip

prepare-media-zip: ${MEDIA_MTOOLSRC} ${MEDIA_OUTFILE} | ${STAGING_DIR}
	( mkdir -p ${STAGING_DIR}/rootfs/boot/syslinux && printf '%s\n' 'prompt 1' 'timeout 120' 'default dos' '' 'label dos' '    COM32 /boot/syslinux/chain.c32' '    APPEND freedos=/kernel.sys' > ${STAGING_DIR}/rootfs/boot/syslinux/syslinux.cfg )
	sudo sh -c "PATH=${PATH} syslinux --install --offset $(call calc, 32 * 512) ${MEDIA_OUTFILE}"
	MTOOLSRC=${MEDIA_MTOOLSRC} mmd z:/boot z:/boot/syslinux
	MTOOLSRC=${MEDIA_MTOOLSRC} mcopy ${TOOLCHAIN_DIR}/lib/syslinux/chain.c32 ${STAGING_DIR}/rootfs/boot/syslinux/syslinux.cfg z:/boot/syslinux/

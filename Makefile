#!/usr/bin/make
## wmfd-de - FreeDOS toolchain/image builder


## Configuration

.PHONY: help
default: help

TOPLEV=${CURDIR}
CONFIG_DIR?=${TOPLEV}/config
PROJECT_CONFIG=

include ${PROJECT_CONFIG}

ifneq (${TOOLCHAIN_DIR},)
export PATH:=${TOOLCHAIN_DIR}/bin:${PATH}
endif


## Rules

help:
	@printf '%s: %s\n' \
		$(firstword ${MAKEFILE_LIST}) 'configuration status'
	@printf '%s\n' \
		"	CONFIG_DIR: ${CONFIG_DIR}" \
		"	PROJECT_CONFIG: $${PROJECT_CONFIG:-unset}"


#

.PHONY: config-sanity
config-sanity:
ifeq (${PROJECT_CONFIG},)
	@printf '%s: %s\n' \
		$(firstword ${MAKEFILE_LIST}) "PROJECT_CONFIG unset" 1>&2
	@exit 1
endif


.PHONY: all
all: config-sanity

#!/bin/bash

set -e

rm -rf out
mkdir -p out

build_variant() {
    local config_text="$1"
    local output_name="$2"
    shift 2

    rm -rf BadWDSD/build
    mkdir -p BadWDSD/build
    printf "%b
" "$config_text" > BadWDSD/build/Config.h

    ./build.sh "$@"

    cp -a BadWDSD/build/BadWDSD.uf2 "out/$output_name"
}

build_variant '#define PICO_TYPE PICO_TYPE_E_PICO
#define SC_IS_SW 1
#define XDR_IS_X32 1' 'BadWDSD_SW_x32_Pico.uf2'

build_variant '#define PICO_TYPE PICO_TYPE_E_RP2040_ZERO
#define SC_IS_SW 1
#define XDR_IS_X32 1' 'BadWDSD_SW_x32_RP2040_Zero.uf2'

build_variant '#define PICO_TYPE PICO_TYPE_E_PICO
' 'BadWDSD_CXRF_x16_Pico.uf2'

build_variant '#define PICO_TYPE PICO_TYPE_E_PICO_W
#define SC_IS_SW 1
#define XDR_IS_X32 1' 'BadWDSD_SW_x32_Pico_W.uf2' -DIS_PICO_W=1

build_variant '#define PICO_TYPE PICO_TYPE_E_PICO_2
#define SC_IS_SW 1
#define XDR_IS_X32 1' 'BadWDSD_SW_x32_Pico_2.uf2' -DIS_PICO_2=1

build_variant '#define PICO_TYPE PICO_TYPE_E_PICO_2_W
#define SC_IS_SW 1
#define XDR_IS_X32 1' 'BadWDSD_SW_x32_Pico_2_W.uf2' -DIS_PICO_2_W=1

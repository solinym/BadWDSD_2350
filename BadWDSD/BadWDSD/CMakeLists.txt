cmake_minimum_required(VERSION 3.13)

if (IS_PICO_2_W)
    set(PICO_BOARD pico2_w)
elseif (IS_PICO_2)
    set(PICO_BOARD pico2)
elseif (IS_PICO_W)
    set(PICO_BOARD pico_w)
endif()

include ($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(BadWDSD CXX C ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_executable(BadWDSD
    Main.c Hold.c Led.c Timer.c Xdr.c Gpio.c Uart.c Sc.c DebugUart.c Aes.c
)

target_link_libraries(BadWDSD
    pico_stdlib
    hardware_resets
    hardware_irq
    pico_multicore
    pico_rand
    pico_sync
)

pico_generate_pio_header(BadWDSD ${CMAKE_CURRENT_LIST_DIR}/ws2812.pio OUTPUT_DIR ${CMAKE_CURRENT_LIST_DIR}/build/generated)
target_link_libraries(BadWDSD hardware_pio)

if (IS_PICO_W OR IS_PICO_2_W)
    target_link_libraries(BadWDSD pico_cyw43_arch_none)
endif()

pico_add_extra_outputs(BadWDSD)

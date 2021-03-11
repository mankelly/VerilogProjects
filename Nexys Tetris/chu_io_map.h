/*********************************************************************
 * @file chu_io_map.h
 * *
 * @brief define io map and system frequency
 *
 * file contains constants to specify io and video configuration:
 *   - base address the subsystem
 *   - slot # with a symbolic constant
 *   - definitions must match the io_cfg.vhd of the hardware platform
 *   - file should be updated when io subsystem changes
 *   - if desired, include multiple configuration and
 *     use #ifdef to select desired one
 *
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

#ifndef _CHU_IO_MAP_INCLUDED
#define _CHU_IO_MAP_INCLUDED

#ifdef __cplusplus
extern "C" {
#endif

/**********************************************************************
 * Xilinx nexys4 ddr board "sampler/daisy" configuration
 *********************************************************************/
// #ifdef _NEXYS4

// system clock rate in MHz; used for timer and uart
#define SYS_CLK_FREQ 100

//io base address for microBlaze MCS
#define BRIDGE_BASE 0xc0000000

// slot module definition
// format: Slot#_ModuleType_Name
#define S0_SYS_TIMER  0
#define S1_UART1      1
#define S2_LED        2
#define S3_SW         3
#define S4_USER       4
#define S5_XDAC       5
#define S6_PWM        6
#define S7_BTN        7
#define S8_SSEG       8
#define S9_SPI        9
#define S10_I2C      10
#define S11_PS2      11
#define S12_DDFS     12
#define S13_ADSR     13

// video module definition
#define V0_SYNC      0
#define V1_MOUSE     1
#define V2_OSD       2
#define V3_GHOST     3
#define V4_BLOCK1    4
#define V5_BLOCK2    5
#define V6_GRAY      6
#define V7_BAR       7

// video frame buffer
#define FRAME_OFFSET 0x00c00000
#define FRAME_BASE  BRIDGE_BASE+FRAME_OFFSET

// #endif    // _NEXYS4
/*********************************************************************/

#ifdef __cplusplus
} // extern "C"
#endif


#endif  // _CHU_IO_MAP_INCLUDED

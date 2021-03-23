## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
#======================================================================================================================
# To facilitate Quad-SPI flash programming 
#======================================================================================================================
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
	
##Bank = 35, Pin name = IO_L7P_T1_AD6P_35,					Sch name = UART_TXD_IN
set_property PACKAGE_PIN C4 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]
##Bank = 35, Pin name = IO_L11N_T1_SRCC_35,					Sch name = UART_RXD_OUT
set_property PACKAGE_PIN D4 [get_ports tx]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx]
 
## Switches
##Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
##Bank = 34, Pin name = IO_25_34,							Sch name = SW1
set_property PACKAGE_PIN U8 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
##Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
set_property PACKAGE_PIN R7 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
##Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = SW3
set_property PACKAGE_PIN R6 [get_ports {sw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
##Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = SW4
set_property PACKAGE_PIN R5 [get_ports {sw[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
##Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = SW5
set_property PACKAGE_PIN V7 [get_ports {sw[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
##Bank = 34, Pin name = IO_L20N_T3_34,						Sch name = SW6
set_property PACKAGE_PIN V6 [get_ports {sw[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
##Bank = 34, Pin name = IO_L10P_T1_34,						Sch name = SW7
set_property PACKAGE_PIN V5 [get_ports {sw[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
##Bank = 34, Pin name = IO_L8P_T1-34,						Sch name = SW8
set_property PACKAGE_PIN U4 [get_ports {sw[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
##Bank = 34, Pin name = IO_L9N_T1_DQS_34,					Sch name = SW9
set_property PACKAGE_PIN V2 [get_ports {sw[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
##Bank = 34, Pin name = IO_L9P_T1_DQS_34,					Sch name = SW10
set_property PACKAGE_PIN U2 [get_ports {sw[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
##Bank = 34, Pin name = IO_L11N_T1_MRCC_34,					Sch name = SW11
set_property PACKAGE_PIN T3 [get_ports {sw[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
##Bank = 34, Pin name = IO_L17N_T2_34,						Sch name = SW12
set_property PACKAGE_PIN T1 [get_ports {sw[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
##Bank = 34, Pin name = IO_L11P_T1_SRCC_34,					Sch name = SW13
set_property PACKAGE_PIN R3 [get_ports {sw[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
##Bank = 34, Pin name = IO_L14N_T2_SRCC_34,					Sch name = SW14
set_property PACKAGE_PIN P3 [get_ports {sw[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
##Bank = 34, Pin name = IO_L14P_T2_SRCC_34,					Sch name = SW15
set_property PACKAGE_PIN P4 [get_ports {sw[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 


## LEDs
##Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {led[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
##Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {led[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
##Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {led[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
##Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {led[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
##Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {led[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
##Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN T4 [get_ports {led[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
##Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {led[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
##Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {led[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
##Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
set_property PACKAGE_PIN V4 [get_ports {led[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
##Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
set_property PACKAGE_PIN U3 [get_ports {led[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
##Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
set_property PACKAGE_PIN V1 [get_ports {led[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
##Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
set_property PACKAGE_PIN R1 [get_ports {led[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
##Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
set_property PACKAGE_PIN P5 [get_ports {led[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
##Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
set_property PACKAGE_PIN U1 [get_ports {led[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
##Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
set_property PACKAGE_PIN R2 [get_ports {led[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
##Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
set_property PACKAGE_PIN P2 [get_ports {led[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]

##Bank = 34, Pin name = IO_L5P_T0_34,						Sch name = LED16_R
set_property PACKAGE_PIN K5 [get_ports {rgb_led1[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb_led1[0]}]
##Bank = 15, Pin name = IO_L5P_T0_AD9P_15,					Sch name = LED16_G
set_property PACKAGE_PIN F13 [get_ports {rgb_led1[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb_led1[1]}]
##Bank = 35, Pin name = IO_L19N_T3_VREF_35,					Sch name = LED16_B
set_property PACKAGE_PIN F6 [get_ports {rgb_led1[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb_led1[2]}]
##Bank = 34, Pin name = IO_0_34,								Sch name = LED17_R
set_property PACKAGE_PIN K6 [get_ports {rgb_led2[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb_led2[0]}]
##Bank = 35, Pin name = IO_24P_T3_35,						Sch name =  LED17_G
set_property PACKAGE_PIN H6 [get_ports {rgb_led2[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb_led2[1]}]
##Bank = CONFIG, Pin name = IO_L3N_T0_DQS_EMCCLK_14,			Sch name = LED17_B
set_property PACKAGE_PIN L16 [get_ports {rgb_led2[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb_led2[2]}]



##7 segment display
##Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = CA
set_property PACKAGE_PIN L3 [get_ports {sseg[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[0]}]
##Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = CB
set_property PACKAGE_PIN N1 [get_ports {sseg[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[1]}]
##Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = CC
set_property PACKAGE_PIN L5 [get_ports {sseg[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[2]}]
##Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = CD
set_property PACKAGE_PIN L4 [get_ports {sseg[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[3]}]
##Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = CE
set_property PACKAGE_PIN K3 [get_ports {sseg[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[4]}]
##Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = CF
set_property PACKAGE_PIN M2 [get_ports {sseg[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[5]}]
##Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = CG
set_property PACKAGE_PIN L6 [get_ports {sseg[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[6]}]

##Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = DP
set_property PACKAGE_PIN M4 [get_ports {sseg[7]}]							
	set_property IOSTANDARD LVCMOS33 [get_ports {sseg[7]}]

##Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = AN0
set_property PACKAGE_PIN N6 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
##Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = AN1
set_property PACKAGE_PIN M6 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
##Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = AN2
set_property PACKAGE_PIN M3 [get_ports {an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
##Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = AN3
set_property PACKAGE_PIN N5 [get_ports {an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
##Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = AN4
set_property PACKAGE_PIN N2 [get_ports {an[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[4]}]
##Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = AN5
set_property PACKAGE_PIN N4 [get_ports {an[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[5]}]
##Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = AN6
set_property PACKAGE_PIN L1 [get_ports {an[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[6]}]
##Bank = 34, Pin name = IO_L1N_T034,							Sch name = AN7
set_property PACKAGE_PIN M1 [get_ports {an[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[7]}]



##Buttons
##Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
set_property PACKAGE_PIN C12 [get_ports reset_n]				
	set_property IOSTANDARD LVCMOS33 [get_ports reset_n]
##Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports {btn[4]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btn[4]}]
##Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
set_property PACKAGE_PIN F15 [get_ports {btn[0]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btn[0]}]
##Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports {btn[3]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btn[3]}]
##Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports {btn[1]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btn[1]}]
##Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
set_property PACKAGE_PIN V10 [get_ports {btn[2]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {btn[2]}]
 


##Pmod Header JA
##Bank = 15, Pin name = IO_L1N_T0_AD0N_15,					Sch name = JA1
set_property PACKAGE_PIN B13 [get_ports {ja_top[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_top[1]}]
##Bank = 15, Pin name = IO_L5N_T0_AD9N_15,					Sch name = JA2
set_property PACKAGE_PIN F14 [get_ports {ja_top[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_top[2]}]
##Bank = 15, Pin name = IO_L16N_T2_A27_15,					Sch name = JA3
set_property PACKAGE_PIN D17 [get_ports {ja_top[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_top[3]}]
##Bank = 15, Pin name = IO_L16P_T2_A28_15,					Sch name = JA4
set_property PACKAGE_PIN E17 [get_ports {ja_top[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_top[4]}]
##Bank = 15, Pin name = IO_0_15,								Sch name = JA7
set_property PACKAGE_PIN G13 [get_ports {ja_btm[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_btm[7]}]
##Bank = 15, Pin name = IO_L20N_T3_A19_15,					Sch name = JA8
set_property PACKAGE_PIN C17 [get_ports {ja_btm[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_btm[8]}]
##Bank = 15, Pin name = IO_L21N_T3_A17_15,					Sch name = JA9
set_property PACKAGE_PIN D18 [get_ports {ja_btm[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_btm[9]}]
##Bank = 15, Pin name = IO_L21P_T3_DQS_15,					Sch name = JA10
set_property PACKAGE_PIN E18 [get_ports {ja_btm[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ja_btm[10]}]



##Pmod Header JB
##Bank = 15, Pin name = IO_L15N_T2_DQS_ADV_B_15,				Sch name = JB1
set_property PACKAGE_PIN G14 [get_ports {jb_top[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_top[1]}]
##Bank = 14, Pin name = IO_L13P_T2_MRCC_14,					Sch name = JB2
set_property PACKAGE_PIN P15 [get_ports {jb_top[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_top[2]}]
##Bank = 14, Pin name = IO_L21N_T3_DQS_A06_D22_14,			Sch name = JB3
set_property PACKAGE_PIN V11 [get_ports {jb_top[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_top[3]}]
##Bank = CONFIG, Pin name = IO_L16P_T2_CSI_B_14,				Sch name = JB4
set_property PACKAGE_PIN V15 [get_ports {jb_top[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_top[4]}]
##Bank = 15, Pin name = IO_25_15,							Sch name = JB7
set_property PACKAGE_PIN K16 [get_ports {jb_btm[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_btm[7]}]
##Bank = CONFIG, Pin name = IO_L15P_T2_DQS_RWR_B_14,			Sch name = JB8
set_property PACKAGE_PIN R16 [get_ports {jb_btm[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_btm[8]}]
##Bank = 14, Pin name = IO_L24P_T3_A01_D17_14,				Sch name = JB9
set_property PACKAGE_PIN T9 [get_ports {jb_btm[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_btm[9]}]
##Bank = 14, Pin name = IO_L19N_T3_A09_D25_VREF_14,			Sch name = JB10 
set_property PACKAGE_PIN U11 [get_ports {jb_btm[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jb_btm[10]}]
 


##Pmod Header JC
##Bank = 35, Pin name = IO_L23P_T3_35,						Sch name = JC1
set_property PACKAGE_PIN K2 [get_ports {jc_top[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_top[1]}]
##Bank = 35, Pin name = IO_L6P_T0_35,						Sch name = JC2
set_property PACKAGE_PIN E7 [get_ports {jc_top[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_top[2]}]
##Bank = 35, Pin name = IO_L22P_T3_35,						Sch name = JC3
set_property PACKAGE_PIN J3 [get_ports {jc_top[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_top[3]}]
##Bank = 35, Pin name = IO_L21P_T3_DQS_35,					Sch name = JC4
set_property PACKAGE_PIN J4 [get_ports {jc_top[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_top[4]}]
##Bank = 35, Pin name = IO_L23N_T3_35,						Sch name = JC7
set_property PACKAGE_PIN K1 [get_ports {jc_btm[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_btm[7]}]
##Bank = 35, Pin name = IO_L5P_T0_AD13P_35,					Sch name = JC8
set_property PACKAGE_PIN E6 [get_ports {jc_btm[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_btm[8]}]
##Bank = 35, Pin name = IO_L22N_T3_35,						Sch name = JC9
set_property PACKAGE_PIN J2 [get_ports {jc_btm[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_btm[9]}]
##Bank = 35, Pin name = IO_L19P_T3_35,						Sch name = JC10
set_property PACKAGE_PIN G6 [get_ports {jc_btm[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jc_btm[10]}]
 

 
##Pmod Header JD
##Bank = 35, Pin name = IO_L21N_T2_DQS_35,					Sch name = JD1
set_property PACKAGE_PIN H4 [get_ports {jd_top[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_top[1]}]
##Bank = 35, Pin name = IO_L17P_T2_35,						Sch name = JD2
set_property PACKAGE_PIN H1 [get_ports {jd_top[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_top[2]}]
##Bank = 35, Pin name = IO_L17N_T2_35,						Sch name = JD3
set_property PACKAGE_PIN G1 [get_ports {jd_top[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_top[3]}]
##Bank = 35, Pin name = IO_L20N_T3_35,						Sch name = JD4
set_property PACKAGE_PIN G3 [get_ports {jd_top[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_top[4]}]
##Bank = 35, Pin name = IO_L15P_T2_DQS_35,					Sch name = JD7
set_property PACKAGE_PIN H2 [get_ports {jd_btm[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_btm[7]}]
##Bank = 35, Pin name = IO_L20P_T3_35,						Sch name = JD8
set_property PACKAGE_PIN G4 [get_ports {jd_btm[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_btm[8]}]
##Bank = 35, Pin name = IO_L15N_T2_DQS_35,					Sch name = JD9
set_property PACKAGE_PIN G2 [get_ports {jd_btm[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_btm[9]}]
##Bank = 35, Pin name = IO_L13N_T2_MRCC_35,					Sch name = JD10
set_property PACKAGE_PIN F3 [get_ports {jd_btm[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {jd_btm[10]}]


##Pmod Header JXADC
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {adc_n[0]}]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {adc_p[0]}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {adc_n[1]}]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {adc_p[1]}]
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {adc_n[2]}]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {adc_p[2]}]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {adc_n[3]}]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {adc_p[3]}]


##VGA Connector
##Bank = 35, Pin name = IO_L8N_T1_AD14N_35,					Sch name = VGA_R0
set_property PACKAGE_PIN A3 [get_ports {rgb[8]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[8]}]
##Bank = 35, Pin name = IO_L7N_T1_AD6N_35,					Sch name = VGA_R1
set_property PACKAGE_PIN B4 [get_ports {rgb[9]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[9]}]
##Bank = 35, Pin name = IO_L1N_T0_AD4N_35,					Sch name = VGA_R2
set_property PACKAGE_PIN C5 [get_ports {rgb[10]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[10]}]
##Bank = 35, Pin name = IO_L8P_T1_AD14P_35,					Sch name = VGA_R3
set_property PACKAGE_PIN A4 [get_ports {rgb[11]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[11]}]
##Bank = 35, Pin name = IO_L2P_T0_AD12P_35,					Sch name = VGA_B0
set_property PACKAGE_PIN B7 [get_ports {rgb[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[0]}]
##Bank = 35, Pin name = IO_L4N_T0_35,						Sch name = VGA_B1
set_property PACKAGE_PIN C7 [get_ports {rgb[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[1]}]
##Bank = 35, Pin name = IO_L6N_T0_VREF_35,					Sch name = VGA_B2
set_property PACKAGE_PIN D7 [get_ports {rgb[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[2]}]
##Bank = 35, Pin name = IO_L4P_T0_35,						Sch name = VGA_B3
set_property PACKAGE_PIN D8 [get_ports {rgb[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[3]}]
##Bank = 35, Pin name = IO_L1P_T0_AD4P_35,					Sch name = VGA_G0
set_property PACKAGE_PIN C6 [get_ports {rgb[4]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[4]}]
##Bank = 35, Pin name = IO_L3N_T0_DQS_AD5N_35,				Sch name = VGA_G1
set_property PACKAGE_PIN A5 [get_ports {rgb[5]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[5]}]
##Bank = 35, Pin name = IO_L2N_T0_AD12N_35,					Sch name = VGA_G2
set_property PACKAGE_PIN B6 [get_ports {rgb[6]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[6]}]
##Bank = 35, Pin name = IO_L3P_T0_DQS_AD5P_35,				Sch name = VGA_G3
set_property PACKAGE_PIN A6 [get_ports {rgb[7]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[7]}]
##Bank = 15, Pin name = IO_L4P_T0_15,						Sch name = VGA_HS
set_property PACKAGE_PIN B11 [get_ports hsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports hsync]
##Bank = 15, Pin name = IO_L3N_T0_DQS_AD1N_15,				Sch name = VGA_VS
set_property PACKAGE_PIN B12 [get_ports vsync]						
	set_property IOSTANDARD LVCMOS33 [get_ports vsync]



##Micro SD Connector
##Bank = 35, Pin name = IO_L14P_T2_SRCC_35,					Sch name = SD_RESET
set_property PACKAGE_PIN E2 [get_ports sd_reset]					
	set_property IOSTANDARD LVCMOS33 [get_ports sd_reset]
##Bank = 35, Pin name = IO_L9N_T1_DQS_AD7N_35,				Sch name = SD_CD
#set_property PACKAGE_PIN A1 [get_ports sdCD]						
	#set_property IOSTANDARD LVCMOS33 [get_ports sdCD]
##Bank = 35, Pin name = IO_L9P_T1_DQS_AD7P_35,				Sch name = SD_SCK
set_property PACKAGE_PIN B1 [get_ports sd_sclk]						
	set_property IOSTANDARD LVCMOS33 [get_ports sd_sclk]
##Bank = 35, Pin name = IO_L16N_T2_35,						Sch name = SD_CMD
set_property PACKAGE_PIN C1 [get_ports sd_mosi]						
	set_property IOSTANDARD LVCMOS33 [get_ports sd_mosi]
##Bank = 35, Pin name = IO_L16P_T2_35,						Sch name = SD_DAT0
set_property PACKAGE_PIN C2 [get_ports sd_miso]				
	set_property IOSTANDARD LVCMOS33 [get_ports sd_miso]
##Bank = 35, Pin name = IO_L18N_T2_35,						Sch name = SD_DAT1
#set_property PACKAGE_PIN E1 [get_ports {sdData[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {sdData[1]}]
##Bank = 35, Pin name = IO_L18P_T2_35,						Sch name = SD_DAT2
#set_property PACKAGE_PIN F1 [get_ports {sdData[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {sdData[2]}]
##Bank = 35, Pin name = IO_L14N_T2_SRCC_35,					Sch name = SD_DAT3
set_property PACKAGE_PIN D2 [get_ports sd_ss_n]				
	set_property IOSTANDARD LVCMOS33 [get_ports sd_ss_n]



##Accelerometer
##Bank = 15, Pin name = IO_L6N_T0_VREF_15,					Sch name = ACL_MISO
set_property PACKAGE_PIN D13 [get_ports acl_miso]					
	set_property IOSTANDARD LVCMOS33 [get_ports acl_miso]
##Bank = 15, Pin name = IO_L2N_T0_AD8N_15,					Sch name = ACL_MOSI
set_property PACKAGE_PIN B14 [get_ports acl_mosi]					
	set_property IOSTANDARD LVCMOS33 [get_ports acl_mosi]
##Bank = 15, Pin name = IO_L12P_T1_MRCC_15,					Sch name = ACL_SCLK
set_property PACKAGE_PIN D15 [get_ports acl_sclk]					
	set_property IOSTANDARD LVCMOS33 [get_ports acl_sclk]
##Bank = 15, Pin name = IO_L12N_T1_MRCC_15,					Sch name = ACL_CSN
set_property PACKAGE_PIN C15 [get_ports acl_ss_n]						
	set_property IOSTANDARD LVCMOS33 [get_ports acl_ss_n]
##Bank = 15, Pin name = IO_L20P_T3_A20_15,					Sch name = ACL_INT1
#set_property PACKAGE_PIN C16 [get_ports aclInt1]					
	#set_property IOSTANDARD LVCMOS33 [get_ports aclInt1]
##Bank = 15, Pin name = IO_L11P_T1_SRCC_15,					Sch name = ACL_INT2
#set_property PACKAGE_PIN E15 [get_ports aclInt2]					
	#set_property IOSTANDARD LVCMOS33 [get_ports aclInt2]



##Temperature Sensor
##Bank = 15, Pin name = IO_L14N_T2_SRCC_15,					Sch name = TMP_SCL
set_property PACKAGE_PIN F16 [get_ports tmp_i2c_scl]					
	set_property IOSTANDARD LVCMOS33 [get_ports tmp_i2c_scl]
##Bank = 15, Pin name = IO_L13N_T2_MRCC_15,					Sch name = TMP_SDA
set_property PACKAGE_PIN G16 [get_ports tmp_i2c_sda]					
	set_property IOSTANDARD LVCMOS33 [get_ports tmp_i2c_sda]
##Bank = 15, Pin name = IO_L1P_T0_AD0P_15,					Sch name = TMP_INT
#set_property PACKAGE_PIN D14 [get_ports tmpInt]					
	#set_property IOSTANDARD LVCMOS33 [get_ports tmpInt]
##Bank = 15, Pin name = IO_L1N_T0_AD0N_15,					Sch name = TMP_CT
#set_property PACKAGE_PIN C14 [get_ports tmpCT]						
	#set_property IOSTANDARD LVCMOS33 [get_ports tmpCT]



##Omnidirectional Microphone
##Bank = 35, Pin name = IO_25_35,							Sch name = M_CLK
#set_property PACKAGE_PIN J5 [get_ports micClk]						
	#set_property IOSTANDARD LVCMOS33 [get_ports micClk]
##Bank = 35, Pin name = IO_L24N_T3_35,						Sch name = M_DATA
#set_property PACKAGE_PIN H5 [get_ports micData]					
	#set_property IOSTANDARD LVCMOS33 [get_ports micData]
##Bank = 35, Pin name = IO_0_35,								Sch name = M_LRSEL
#set_property PACKAGE_PIN F5 [get_ports micLRSel]					
	#set_property IOSTANDARD LVCMOS33 [get_ports micLRSel]



##PWM Audio Amplifier
##Bank = 15, Pin name = IO_L4N_T0_15,						Sch name = AUD_PWM
set_property PACKAGE_PIN A11 [get_ports audio_pdm]					
	set_property IOSTANDARD LVCMOS33 [get_ports audio_pdm]
##Bank = 15, Pin name = IO_L6P_T0_15,						Sch name = AUD_SD
set_property PACKAGE_PIN D12 [get_ports audio_on]						
	set_property IOSTANDARD LVCMOS33 [get_ports audio_on]


##USB-RS232 Interface
##Bank = 35, Pin name = IO_L7P_T1_AD6P_35,					Sch name = UART_TXD_IN
#set_property PACKAGE_PIN C4 [get_ports rx]						
	#set_property IOSTANDARD LVCMOS33 [get_ports rx]
##Bank = 35, Pin name = IO_L11N_T1_SRCC_35,					Sch name = UART_RXD_OUT
#set_property PACKAGE_PIN D4 [get_ports tx]						
	#set_property IOSTANDARD LVCMOS33 [get_ports tx]
##Bank = 35, Pin name = IO_L12N_T1_MRCC_35,					Sch name = UART_CTS
#set_property PACKAGE_PIN D3 [get_ports RsCts]						
	#set_property IOSTANDARD LVCMOS33 [get_ports RsCts]
##Bank = 35, Pin name = IO_L5N_T0_AD13N_35,					Sch name = UART_RTS
#set_property PACKAGE_PIN E5 [get_ports RsRts]						
	#set_property IOSTANDARD LVCMOS33 [get_ports RsRts]
#set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports tx]
#set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports rx]


##USB HID (PS/2)
##Bank = 35, Pin name = IO_L13P_T2_MRCC_35,					Sch name = PS2_CLK
set_property PACKAGE_PIN F4 [get_ports ps2c]						
	set_property IOSTANDARD LVCMOS33 [get_ports ps2c]
	set_property PULLUP true [get_ports ps2c]
##Bank = 35, Pin name = IO_L10N_T1_AD15N_35,					Sch name = PS2_DATA
set_property PACKAGE_PIN B2 [get_ports ps2d]					
	set_property IOSTANDARD LVCMOS33 [get_ports ps2d]	
	set_property PULLUP true [get_ports ps2d]


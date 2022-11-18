## Generated SDC file "MAP.out.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Full Version"

## DATE    "Sun Mar 21 18:50:11 2021"

##
## DEVICE  "EP4CGX30CF23C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 9.580 -waveform { 0.000 4.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
set_output_delay -clock { clk1 } -max 8.9 [get_ports {out[0] out[1] out[2] out[3] out[4] out[5] out[6] out[7] out[8] out[9] out[10] out[11] out[12] out[13] out[14] out[15] out[16] out[17] out[18] out[19] out[20] out[21] out[22] out[23] out[24] out[25] out[26] out[27] out[28] out[29] out[30] out[31]}]
set_output_delay -clock { clk1 } -min 8.9 [get_ports {out[0] out[1] out[2] out[3] out[4] out[5] out[6] out[7] out[8] out[9] out[10] out[11] out[12] out[13] out[14] out[15] out[16] out[17] out[18] out[19] out[20] out[21] out[22] out[23] out[24] out[25] out[26] out[27] out[28] out[29] out[30] out[31]}]
set_input_delay -clock { clk2 }  -min 9.1 [get_ports {A[0] A[1] A[2] A[3] A[4] A[5] A[6] A[7] A[8] A[9] A[10] A[11] A[12] A[13] A[14] A[15] A[16] A[17] A[18] A[19] A[20] A[21] A[22] A[23] A[24] A[25] A[26] A[27] A[28] A[29] A[30] A[31] cont[0] cont[1] cont[2] rstn}]  
set_input_delay -clock { clk2 }  -max 9.5 [get_ports {A[0] A[1] A[2] A[3] A[4] A[5] A[6] A[7] A[8] A[9] A[10] A[11] A[12] A[13] A[14] A[15] A[16] A[17] A[18] A[19] A[20] A[21] A[22] A[23] A[24] A[25] A[26] A[27] A[28] A[29] A[30] A[31] cont[0] cont[1] cont[2] rstn}] 
set_input_delay -clock { clk2 } -min 8.523 [get_ports {B[0] B[1] B[2] B[3] B[4] B[5] B[6] B[7] B[8] B[9] B[10] B[11] B[12] B[13] B[14] B[15] B[16] B[17] B[18] B[19] B[20] B[21] B[22] B[23] B[24] B[25] B[26] B[27] B[28] B[29] B[30] B[31] C[0] C[1] C[2] C[3] C[4] C[5] C[6] C[7] C[8] C[9] C[10] C[11] C[12] C[13] C[14] C[15] C[16] C[17] C[18] C[19] C[20] C[21] C[22] C[23] C[24] C[25] C[26] C[27] C[28] C[29] C[30] C[31]}]
set_input_delay -clock { clk2 } -max 9.53 [get_ports {B[0] B[1] B[2] B[3] B[4] B[5] B[6] B[7] B[8] B[9] B[10] B[11] B[12] B[13] B[14] B[15] B[16] B[17] B[18] B[19] B[20] B[21] B[22] B[23] B[24] B[25] B[26] B[27] B[28] B[29] B[30] B[31] C[0] C[1] C[2] C[3] C[4] C[5] C[6] C[7] C[8] C[9] C[10] C[11] C[12] C[13] C[14] C[15] C[16] C[17] C[18] C[19] C[20] C[21] C[22] C[23] C[24] C[25] C[26] C[27] C[28] C[29] C[30] C[31]}]
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************


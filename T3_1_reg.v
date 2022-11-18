`include "conf.v"
module T3_1_reg(
	//输入
	input										clk,
	input										rstn,
	input				[287:0]				L3_level,
	input										S_A_T2,
	input										S_B_T2,
	input										S_C_T2,
	input										S_A_H_T2,
	input										S_B_H_T2,
	input										S_C_H_T2,
	input			[2:0]						cont,
	input			[11:0]					d_T2,
	input			[11:0]					E_T2,
	//输出
	output	reg							S_A_T3_1,
	output	reg							S_B_T3_1,
	output	reg							S_C_T3_1,
	output	reg							S_A_H_T3_1,
	output	reg							S_B_H_T3_1,
	output	reg							S_C_H_T3_1,
	output	reg[2:0]						cont_T3_1,
	output   reg[11:0]               d_T3_1,
	output	reg[11:0]					E_T3_1,
	output	reg	[287:0]				Level_out
);
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			Level_out		<= #`PERIOD 48'b0;
			S_A_T3_1 			<= #`PERIOD			'b0;
			S_B_T3_1 			<= #`PERIOD			'b0;
			S_C_T3_1 			<= #`PERIOD			'b0;
			S_A_H_T3_1 			<=	#`PERIOD			'b0;
			S_B_H_T3_1 			<= #`PERIOD			'b0;
			S_C_H_T3_1 			<= #`PERIOD			'b0;
			cont_T3_1 			<= #`PERIOD			3'b0;
			d_T3_1				<= #`PERIOD    	12'b0;
			E_T3_1				<=	#`PERIOD			12'b0;
		end else begin
			Level_out		<= #`PERIOD L3_level;
			S_A_T3_1 			<= #`PERIOD			S_A_T2;
			S_B_T3_1 			<= #`PERIOD			S_B_T2;
			S_C_T3_1 			<= #`PERIOD			S_C_T2;
			S_A_H_T3_1 			<=	#`PERIOD			S_A_H_T2;
			S_B_H_T3_1 			<= #`PERIOD			S_B_H_T2;
			S_C_H_T3_1 			<= #`PERIOD			S_C_H_T2;
			cont_T3_1 			<= #`PERIOD			cont;
			d_T3_1            <= #`PERIOD    	d_T2;
			E_T3_1				<=	#`PERIOD			E_T2;
		end
	end
endmodule
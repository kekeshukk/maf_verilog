`include "conf.v"
module T4_2_reg(
	//输入
	input										clk,
	input										rstn,
	input			[2:0]						cont,
	input			[9:0]						P,
	input			[1:0]						V,
	input			[74:0]					p_reg_temp,
//	input			[1:0]						revising,
	input			[11:0]					levelp_4_in,
	input			[11:0]					leveln_4_in,
	input										S_A_T4_1,
	input										S_B_T4_1,
	input										S_C_T4_1,
	input										S_A_H_T4_1,
	input										S_B_H_T4_1,
	input										S_C_H_T4_1,
	input			[11:0]					E_T4_1,
	input			[11 : 0]					d_T4_1,
	//输出
	output	reg[11:0]					E_T4_2,
	output	reg							S_A_T4_2,
	output	reg							S_B_T4_2,
	output	reg							S_C_T4_2,
	output	reg							S_A_H_T4_2,
	output	reg							S_B_H_T4_2,
	output	reg							S_C_H_T4_2,
	output	reg[2:0]						cont_T4_2,
	output	reg[11:0]					d_T4_2,
	output	reg[11:0]					levelp_4_out,
	output	reg[11:0]					leveln_4_out,
	output	reg[9:0]						sh_num,
	output	reg[1:0]						esh,
	output	reg[74:0]					p_reg
//	output	reg[1:0]						revi
);
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			sh_num				<=			#`PERIOD 10'b0;
			p_reg					<=			#`PERIOD 75'b0;
			esh					<= 		#`PERIOD 2'b0;
//			revi					<=			#`PERIOD 2'b0;
			levelp_4_out		<=			#`PERIOD 3'b0;
			leveln_4_out		<=			#`PERIOD 3'b0;
			S_A_H_T4_2			<=			#`PERIOD	'b0;
			S_B_H_T4_2			<=			#`PERIOD	'b0;
			S_C_H_T4_2			<=			#`PERIOD 'b0;
			S_A_T4_2				<=			#`PERIOD	'b0;
			S_B_T4_2				<=			#`PERIOD	'b0;
			S_C_T4_2				<=			#`PERIOD	'b0;
			cont_T4_2			<=			#`PERIOD	3'b0;
			d_T4_2				<=			#`PERIOD 12'b0;
			E_T4_2				<=			#`PERIOD 12'b0;
		end else begin
			p_reg					<=			#`PERIOD p_reg_temp;
			sh_num				<=			#`PERIOD P;
			esh					<=			#`PERIOD V;
//			revi					<=			#`PERIOD revising;
			levelp_4_out		<=			#`PERIOD levelp_4_in;
			leveln_4_out		<=			#`PERIOD leveln_4_in;
			S_A_H_T4_2			<=			#`PERIOD	S_A_H_T4_1;
			S_B_H_T4_2			<=			#`PERIOD S_B_H_T4_1;
			S_C_H_T4_2			<=			#`PERIOD	S_C_H_T4_1;
			S_A_T4_2				<=			#`PERIOD	S_A_T4_1;
			S_B_T4_2				<=			#`PERIOD	S_B_T4_1;
			S_C_T4_2				<=			#`PERIOD	S_C_T4_1;
			cont_T4_2			<=			#`PERIOD cont;
			d_T4_2				<=			#`PERIOD d_T4_1;
			E_T4_2				<=			#`PERIOD E_T4_1;
		end
	end 
endmodule
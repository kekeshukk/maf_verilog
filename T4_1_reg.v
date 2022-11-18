`include "conf.v"
module T4_1_reg(
	//输入
	input										clk,
	input										rstn,
	input			[2:0]						cont,
	input			[55:0]					GP_n_in,
	input			[55:0]					GP_p_in,
	input			[55:0]					GP_z_in,
	input			[55:0]					GN_n_in,
	input			[55:0]					GN_p_in,
	input			[55:0]					GN_z_in,
	input			[55:0]					F_in,
	input			[48:0]					Carry_in,
	input			[47:0]					Sum_in,
	input										S_A_T3_2,
	input										S_B_T3_2,
	input										S_C_T3_2,
	input										S_A_H_T3_2,
	input										S_B_H_T3_2,
	input									S_C_H_T3_2,
	input			[73:0]					sh_reg_T3_2,
	input			[11:0]					d_T3_2,
	input			[11 : 0]					E_T3_2,
	//输出
	output	reg[47:0]					Sum_out,
	output	reg[48:0]					Carry_out,
	output	reg[55:0]					GP_n_out,
	output	reg[55:0]					GP_p_out,
	output	reg[55:0]					GP_z_out,
	output	reg[55:0]					GN_n_out,
	output	reg[55:0]					GN_p_out,
	output	reg[55:0]					GN_z_out,
//	output	reg[73:0]					p_reg,
	output	reg[73:0]					sh_reg_T4_1,
	output	reg[55:0]					F_out,
	//control
	output	reg[11:0]					E_T4_1,
	output	reg							S_A_T4_1,
	output	reg							S_B_T4_1,
	output	reg							S_C_T4_1,
	output	reg							S_A_H_T4_1,
	output	reg							S_B_H_T4_1,
	output	reg							S_C_H_T4_1,
	output	reg[2:0]						cont_T4_1,
	output	reg[11:0]					d_T4_1
);
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
//			sh_num	<=	#`PERIOD 10'b0;
//			p_reg		<=	#`PERIOD 74'b0;
//			esh		<= #`PERIOD 2'b0;
//			revi		<=	#`PERIOD 2'b0;
			GP_n_out			<=	#`PERIOD 56'b0;
			GP_p_out			<=	#`PERIOD 56'b0;
			GP_z_out			<=	#`PERIOD 56'b0;
			GN_n_out			<=	#`PERIOD 56'b0;
			GN_p_out			<=	#`PERIOD 56'b0;
			GN_z_out			<=	#`PERIOD 56'b0;
			F_out				<=	#`PERIOD 56'b0;
			Sum_out  		<= #`PERIOD 48'b0;
			Carry_out		<= #`PERIOD 49'b0;
			S_A_H_T4_1		<=	#`PERIOD	'b0;
			S_B_H_T4_1		<=	#`PERIOD	'b0;
			S_C_H_T4_1		<=	#`PERIOD 'b0;
			S_A_T4_1			<=	#`PERIOD	'b0;
			S_B_T4_1			<=	#`PERIOD	'b0;
			S_C_T4_1			<=	#`PERIOD	'b0;
			cont_T4_1		<=	#`PERIOD	3'b0;
			d_T4_1			<=	#`PERIOD 12'b0;
			E_T4_1			<=	#`PERIOD 12'b0;
			sh_reg_T4_1		<=	#`PERIOD 74'b0;
		end else begin
//			p_reg		<=	#`PERIOD p_reg_temp;
//			sh_num	<=	#`PERIOD P;
//			esh		<=	#`PERIOD V;
//			revi		<=	#`PERIOD revising;
			GP_n_out			<=	#`PERIOD GP_n_in;
			GP_p_out			<=	#`PERIOD GP_p_in;
			GP_z_out			<=	#`PERIOD GP_z_in;
			GN_n_out			<=	#`PERIOD GN_n_in;
			GN_p_out			<=	#`PERIOD GN_p_in;
			GN_z_out			<=	#`PERIOD GN_z_in;
			F_out				<=	#`PERIOD F_in;
			Sum_out			<=	#`PERIOD Sum_in;
			Carry_out		<= #`PERIOD Carry_in;
			S_A_H_T4_1		<=	#`PERIOD	S_A_H_T3_2;
			S_B_H_T4_1		<=	#`PERIOD	S_B_H_T3_2;
			S_C_H_T4_1		<=	#`PERIOD S_C_H_T3_2;
			S_A_T4_1			<=	#`PERIOD	S_A_T3_2;
			S_B_T4_1			<=	#`PERIOD	S_B_T3_2; 
			S_C_T4_1			<=	#`PERIOD	S_C_T3_2;
			cont_T4_1		<=	#`PERIOD	cont;
			d_T4_1			<=	#`PERIOD d_T3_2;
			E_T4_1			<=	#`PERIOD E_T3_2;
			sh_reg_T4_1		<=	#`PERIOD sh_reg_T3_2;
		end
	end
endmodule
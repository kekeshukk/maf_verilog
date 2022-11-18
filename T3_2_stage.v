//第三级流水线后半部分
`include "conf.v"
module T3_2_stage(
	/*输入*/
	input										clk,
	input										rstn,
	input			[2:0]						cont_T3_1,
	input										S_A_T3_1,
	input										S_B_T3_1,
	input										S_C_T3_1,
	input										S_A_H_T3_1,
	input										S_B_H_T3_1,
	input										S_C_H_T3_1,
	input			[3:0]						trap_T3_1_0,
	input			[3:0]						trap_T3_1_1,
	input			[2:0]						trap_ans_T3_1_0,
	input			[2:0]						trap_ans_T3_1_1,
	input			[73:0]					sh_rev_reg_in,
	input			[3:0]						sti,
	input			[287:0]					Level3_in,
	input			[11:0]					d_T3_1,
	input			[11:0]					E_T3_1,
	/*输出*/
	output	reg[73:0]					sh_rev_reg_out,
	output		[47:0]					Carry,
	output		[47:0]					Sum,
	output	reg[3:0]						trap_T3_2_0,
	output	reg[3:0]						trap_T3_2_1,
	output	reg[2:0]						trap_ans_T3_2_0,
	output	reg[2:0]						trap_ans_T3_2_1,
	output	reg							S_A_T3_2,
	output	reg							S_B_T3_2,
	output	reg							S_C_T3_2,
	output	reg							S_A_H_T3_2,
	output	reg							S_B_H_T3_2,
	output	reg							S_C_H_T3_2,
	output	reg[2:0]						cont_T3_2,
	output   reg[11:0]               d_T3_2,
	output	reg[11:0]					E_T3_2,
	output	reg[3:0]						sti_out
);	
	wire			[47:0]					Carry_lin;
	wire			[47:0]					Sum_lin;
	Wallace_L4_L5 wallace_l3(
		.Level_in								(Level3_in),
		.Carry									(Carry_lin),
		.Sum										(Sum_lin)
	);
	T3_2_reg t3_1_reg(
		.clk										(clk),
		.rstn										(rstn),
		.Carry_in								(Carry_lin),
		.Sum_in									(Sum_lin),
		.Sum_out									(Sum),
		.Carry_out								(Carry)
	);
	/*控制信号*/
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			trap_T3_2_0			<=	#`PERIOD			4'b0;
			trap_T3_2_1			<= #`PERIOD			4'b0;
			trap_ans_T3_2_0 	<= #`PERIOD			3'b0;
			trap_ans_T3_2_1 	<= #`PERIOD			3'b0;
			S_A_T3_2 			<= #`PERIOD			'b0;
			S_B_T3_2 			<= #`PERIOD			'b0;
			S_C_T3_2 			<= #`PERIOD			'b0;
			S_A_H_T3_2 			<=	#`PERIOD			'b0;
			S_B_H_T3_2 			<= #`PERIOD			'b0;
			S_C_H_T3_2 			<= #`PERIOD			'b0;
			cont_T3_2 			<= #`PERIOD			3'b0;
			d_T3_2				<= #`PERIOD    	12'b0;
			E_T3_2				<=	#`PERIOD			12'b0;
			sh_rev_reg_out		<= #`PERIOD			74'b0;
			sti_out					<=	#`PERIOD			4'b0;
		end else begin
			trap_T3_2_0 		<= #`PERIOD			trap_T3_1_0;
			trap_T3_2_1 		<= #`PERIOD			trap_T3_1_1;
			trap_ans_T3_2_0 	<= #`PERIOD			trap_ans_T3_1_0;
			trap_ans_T3_2_1 	<= #`PERIOD			trap_ans_T3_1_1;
			S_A_T3_2 			<= #`PERIOD			S_A_T3_1;
			S_B_T3_2 			<= #`PERIOD			S_B_T3_1;
			S_C_T3_2 				<= #`PERIOD			S_C_T3_1;
			S_A_H_T3_2 			<=	#`PERIOD			S_A_H_T3_1;
			S_B_H_T3_2 			<= #`PERIOD			S_B_H_T3_1;
			S_C_H_T3_2 			<= #`PERIOD			S_C_H_T3_1;
			cont_T3_2 			<= #`PERIOD			cont_T3_1;
			d_T3_2            <= #`PERIOD    	d_T3_1;
			E_T3_2				<=	#`PERIOD			E_T3_1;
			sh_rev_reg_out		<=	#`PERIOD			sh_rev_reg_in;
			sti_out				<=	#`PERIOD			sti;
		end
	end
endmodule
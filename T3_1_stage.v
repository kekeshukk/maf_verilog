//第三级流水线前面半部分
`include "conf.v"
module T3_1_stage(
	/*输入*/
	input										clk,
	input										rstn,
	input			[2:0]						cont,
	input			[575:0]					M_out_plain_in,
	input										S_A_T2,
	input										S_B_T2,
	input										S_C_T2,
	input										S_A_H_T2,
	input										S_B_H_T2,
	input										S_C_H_T2,
	input			[3:0]						trap_T2_0,
	input			[3:0]						trap_T2_1,
	input			[2:0]						trap_ans_T2_0,
	input			[2:0]						trap_ans_T2_1,
	input			[75:0]					sh_reg_T2,
	input			[11:0]					d_T2,
	input			[11:0]					E_T2,
	input			[11:0]					sh_num_T2,
	/*输出*/
	output		[73:0]					sh_rev_reg,
	output		[3:0]						sti,
	output		[287:0]					Level3_out,
	output	reg[3:0]						trap_T3_1_0,
	output	reg[3:0]						trap_T3_1_1,
	output	reg[2:0]						trap_ans_T3_1_0,
	output	reg[2:0]						trap_ans_T3_1_1,
	output	reg							S_A_T3_1,
	output	reg							S_B_T3_1,
	output	reg							S_C_T3_1,
	output	reg							S_A_H_T3_1,
	output	reg							S_B_H_T3_1,
	output	reg							S_C_H_T3_1,
	output	reg[2:0]						cont_T3_1,
	output   reg[11:0]               d_T3_1,
	output	reg[11:0]					E_T3_1
);
//	wire										ena;//高有效
	wire			[75:0]					sh_reg_l; 
//	wire			[47:0]					Carry_lin;
//	wire			[47:0]					Sum_lin;
//	assign			ena			=			(trap_T2_0 != 4'b0 && cont == 3'b0)
//														| (trap_T2_0 != 4'b0 && trap_T2_1 != 4'b0 && cont == 3'b001)
//																							|(trap_T2_0 != 4'b0 && cont == 3'b010) ? 1'b0 : 1'b1;
	wire			[287:0]					L3_level_lin;
	Shifting	 shifting(
		.cont										(cont),
		//更改
		.sh_in_reg								(sh_reg_T2),
		.sh_num									(sh_num_T2),
		.sh_out_reg								(sh_reg_l)
	);
	Reverse reverse(
		.clk										(clk),
		.rstn										(rstn),
		.cont										(cont),
		.sh_reg									(sh_reg_l),
		.S_A									   (S_A_T2),
		.S_B										(S_B_T2),
		.S_C										(S_C_T2),
		.S_A_H									(S_A_H_T2),
		.S_B_H									(S_B_H_T2),
		.S_C_H									(S_C_H_T2),
		.sh_rev_reg								(sh_rev_reg),
		.sti										(sti)
	);
	Wallace_L3 wallace(
		.M_out_plain_in						(M_out_plain_in),
//		.ena										(ena),
		.L3_level								(L3_level_lin)
	);
	T3_1_reg t3_1_reg(
		.clk										(clk),
		.rstn										(rstn),
		.L3_level								(L3_level_lin),
		.Level_out								(Level3_out)
	);
	/*控制信号*/
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			trap_T3_1_0			<=	#`PERIOD			4'b0;
			trap_T3_1_1			<= #`PERIOD			4'b0;
			trap_ans_T3_1_0 	<= #`PERIOD			3'b0;
			trap_ans_T3_1_1 	<= #`PERIOD			3'b0;
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
			trap_T3_1_0 		<= #`PERIOD			trap_T2_0;
			trap_T3_1_1 		<= #`PERIOD			trap_T2_1;
			trap_ans_T3_1_0 	<= #`PERIOD			trap_ans_T2_0;
			trap_ans_T3_1_1 	<= #`PERIOD			trap_ans_T2_1;
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
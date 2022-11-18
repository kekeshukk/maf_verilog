`include "conf.v"
module T3_2_reg(
	//输入
	input										clk,
	input										rstn,
	input				[47:0]				Carry_in,
	input				[47:0]				Sum_in,
	input										S_A_T3_1,
	input										S_B_T3_1,
	input										S_C_T3_1,
	input										S_A_H_T3_1,
	input										S_B_H_T3_1,
	input										S_C_H_T3_1,
	input				[2:0]					cont_T3_1,
	input				[11:0]				d_T3_1,
	input				[11:0]				E_T3_1,
	input				[73:0]				sh_rev_reg_in,
	input				[3:0]					sti,
	//输出
	output	reg[73:0]					sh_rev_reg_out,
	output	reg	[47:0]				Carry_out,
	output	reg							S_A_T3_2,
	output	reg							S_B_T3_2,
	output	reg							S_C_T3_2,
	output	reg							S_A_H_T3_2,
	output	reg							S_B_H_T3_2,
	output	reg							S_C_H_T3_2,
	output	reg[2:0]						cont_T3_2,
	output   reg[11:0]               d_T3_2,
	output	reg[11:0]					E_T3_2,
	output	reg[3:0]						sti_out,
	output	reg	[47:0]				Sum_out
);
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			Carry_out	<= #`PERIOD 48'b0;
			Sum_out		<= #`PERIOD 48'b0;
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
			Carry_out	<= #`PERIOD Carry_in;
			Sum_out		<= #`PERIOD Sum_in;
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
module T5_stage(
	/*input*/
	input										clk,
	input										rstn,
	input			[2:0]						cont_T4,
	input			[73:0]					p_reg,
	input										S_A_T4,
	input										S_B_T4,
	input										S_C_T4,
	input										S_A_H_T4,
	input										S_B_H_T4,
	input										S_C_H_T4,
	input			[3:0]						trap_T4_0,
	input			[3:0]						trap_T4_1,
	input			[2:0]						trap_ans_T4_0,
	input			[2:0]						trap_ans_T4_1,
	input			[9:0]						sh_num_T4,
	input			[11:0]					d_T4,
	input			[1:0]						esh_T4,
	input										s2_T4,
	input										s2h_T4,
	input			[1:0]						revising_T4,
	input			[11:0]					E_T4,
	/*out*/
/*	output	reg							S_A_T5,
	output	reg							S_B_T5,
	output	reg							S_C_T5,
	output	reg							S_A_H_T5,
	output	reg							S_B_H_T5,
	output	reg							S_C_H_T5,
	output	reg	[3:0]					trap_T5_0,
	output	reg	[3:0]					trap_T5_1,
	output	reg	[2:0]					trap_ans_T5_0,
	output	reg	[2:0]					trap_ans_T5_1,
	output	reg	[2:0]					cont_T5,*/
	output	wire	[31:0]				calculation	
);
	wire				[1:0]					d_s; 
	wire				[73:0]				con_sh;
	wire				[23:0]				M_result;
	assign			d_s			=			d_T4[1:0];
	Con_shift con_shift(
		.d										(d_s),
		.p_reg								(p_reg),
		.con_sh								(con_sh),
		.cont									(cont_T4)
	);
	Vari_shift varis_reduce(
		.cont									(cont_T4),
		.sh_num								(sh_num_T4),
		.esh									(esh_T4),
		.con_sh								(con_sh),
		.revise 								(revising_T4),
		.M_result							(M_result)
	);
	MaF maf(
		.cont									(cont_T4),
		.M_in									(M_result),
		.clk									(clk),
		.rstn									(rstn),
		.E										(E_T4),
		.s2_T4								(s2_T4),
		.s2h_T4									(s2h_T4),
		.result								(calculation)
	);
endmodule
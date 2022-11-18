//前半部分
module LeadingZeroAnt_1(

	input			[25:0]					M_C_A,
	input			[47:0]					Sum,
	input			[48:0]					Carry,
	input										S_A,
	input										S_B,
	input										S_C,
	input										S_A_H,
	input										S_B_H,
	input										S_C_H,
	input			[1:0]						d,
	input			[2:0]						cont,
	//输出
	output		[55:0]					GP_n,
	output		[55:0]					GP_p,
	output		[55:0]					GP_z,
	output		[55:0]					GN_n,
	output		[55:0]					GN_p,
	output		[55:0]					GN_z,
	output		[55:0]					F
);
	wire			[55:0]					num_p_0;
	wire			[55:0]					num_p_1;
	wire			[55:0]					num_n_0;
	wire			[55:0]					num_n_1;
//	wire			[9:0]						p_temp;
//	wire			[1:0]						v_temp;
	/*得到操作数*/
	wire			[55:0]					op0;
	wire			[55:0]					op1;
	Get_operator get_operator(
		.cont										(cont),
		.M_C_A									(M_C_A),
		.Sum										(Sum),
		.Carry									(Carry),
		.num_p_0									(num_p_0),
		.num_p_1									(num_p_1),
		.num_n_0									(num_n_0),
		.num_n_1									(num_n_1)
	);
	Select_operator select_operator(
		.cont										(cont),
		.num_p_0									(num_p_0),
		.num_p_1									(num_p_1),
		.num_n_0									(num_n_0),
		.num_n_1									(num_n_1),
		.d											(d),
		.op_0										(op0),
		.op_1										(op1)
	);
	Precode precode(
		.op0										(op0),
		.op1										(op1),
		.cont										(cont),
		.S_A										(S_A),
		.S_B										(S_B),
		.S_C										(S_C),
		.S_A_H									(S_A_H),
		.S_B_H									(S_B_H),
		.S_C_H									(S_C_H),
		.GP_n										(GP_n),
		.GP_p										(GP_p),
		.GP_z										(GP_z),
		.GN_n										(GN_n),
		.GN_p										(GN_p),
		.GN_z										(GN_z),
		.F											(F)
	);
endmodule
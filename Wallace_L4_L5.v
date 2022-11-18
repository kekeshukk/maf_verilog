module Wallace_L4_L5(
	input			[287:0]					Level_in,
	output		[47:0]					Carry,
	output		[47:0]					Sum
);
	wire			[47:0]					L4_level[3:0];
	/*第三级传播*/
	Tr_Tw_CSA_file tr_tw_csa_file_3t4_0(
		.in1										(Level_in[47:0]),
		.in2										(Level_in[95:48]),
		.in3										(Level_in[143:96]),
		.carry									(L4_level[0]),
		.sum										(L4_level[1])
	);
	Tr_Tw_CSA_file tr_tw_csa_file_3t4_1(
		.in1										(Level_in[191:144]),
		.in2										(Level_in[239:192]),
		.in3										(Level_in[287:240]),
		.carry									(L4_level[2]),
		.sum										(L4_level[3])
	);
	/*第4级传播*/
	F_t_file f_t_file_4to(
		.P_1										(L4_level[0]),
		.P_2										(L4_level[1]),
		.P_3										(L4_level[2]),
		.P_4										(L4_level[3]),
		.Sum										(Sum),
		.Carry									(Carry)
	);
endmodule
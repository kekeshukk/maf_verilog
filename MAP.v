module MAP(
	input						clk,
	input						rstn,
	input				[31:0]		A,
	input				[31:0]		B,
	input				[31:0]		C,
	input				[2:0]			cont,
	output 			[31:0]		out
	/*测试用例*/
);
	wire				[13:0]		e_a;
	wire				[13:0]		e_b;
	wire				[13:0]		e_c;
	wire				[11:0]		sh_num;
	wire				[23:0]		m_c;
	wire				[23:0]		m_a;
	wire				[23:0]		m_b;
	wire								s_a;
	wire								s_b;
	wire								s_c;
	wire								s_a_h;
	wire								s_b_h;
	wire								s_c_h;
	wire				[75:0]		sh_reg;
	wire				[75:0]		sh_reg_out;
	/*1-2 level*/
	wire								S_A_1t2;
	wire								S_B_1t2;
	wire								S_C_1t2;
	wire								S_A_H_1t2;
	wire								S_B_H_1t2;
	wire								S_C_H_1t2;
	wire				[3:0]			trap_0_1t2;
	wire				[2:0]			trap_ans_0_1t2;
	wire				[2:0]			trap_ans_1_1t2;
	wire				[3:0]			trap_1_1t2;
	wire				[2:0]			cont_1t2;
	/*2-3 level*/
	wire								S_A_2t3;
	wire								S_B_2t3;
	wire								S_C_2t3;
	wire								S_A_H_2t3;
	wire								S_B_H_2t3;
	wire								S_C_H_2t3;
	wire				[3:0]			trap_0_2t3;
	wire				[2:0]			trap_ans_0_2t3;
	wire				[2:0]			trap_ans_1_2t3;
	wire				[3:0]			trap_1_2t3;
	wire				[2:0]			cont_2t3;
	wire				[575:0]		M_out_plain_2t3;
	wire				[75:0]		sh_reg_2t3;
	wire				[11:0]		sh_num_2t3;
	wire				[11:0]		E_2t3;
	wire				[11:0]		d_2t3;
	wire				[575:0]		M_out_lin;
	wire				[11:0]		d_lin;
	/*3_1-3_2 level*/
	wire								S_A_3_1t3_2;
	wire								S_B_3_1t3_2;
	wire								S_C_3_1t3_2;
	wire								S_A_H_3_1t3_2;
	wire								S_B_H_3_1t3_2;
	wire								S_C_H_3_1t3_2;
	wire				[3:0]			trap_0_3_1t3_2;
	wire				[2:0]			trap_ans_0_3_1t3_2;
	wire				[2:0]			trap_ans_1_3_1t3_2;
	wire				[3:0]			trap_1_3_1t3_2;
	wire				[73:0]		sh_rev_reg_3_1t3_2;
	wire				[3:0]			sti_3_1t3_2;
	wire 				[287:0]		Level3_lin_3_1t3_2;
	wire				[11:0]		d_3_1t3_2;
	wire				[11:0]		E_3_1t3_2;
	wire				[2:0]			cont3_1t3_2;
	wire				[75:0]		sh_reg_l; 
	wire				[287:0]			L3_level_lin;
	/*3_2-4_1 level*/
	//数据信号
	wire				[3:0]			sti_3_2t4_1;
	wire 				[47:0]		Carry_3_2t4_1;
	wire				[73:0]		sh_rev_reg_3_2t4_1;
	wire				[47:0]		Sum_3_2t4_1;
	wire				[47:0]			Carry_lin;
	wire				[47:0]			Sum_lin;
	//控制信号
	wire								S_A_3_2t4_1;
	wire								S_B_3_2t4_1;
	wire								S_C_3_2t4_1;
	wire								S_A_H_3_2t4_1;
	wire								S_B_H_3_2t4_1;
	wire								S_C_H_3_2t4_1;
	wire				[3:0]			trap_0_3_2t4_1;
	wire				[2:0]			trap_ans_0_3_2t4_1;
	wire				[2:0]			trap_ans_1_3_2t4_1;
	wire				[3:0]			trap_1_3_2t4_1;
	wire				[11:0]		d_3_2t4_1;
	wire				[11:0]		E_3_2t4_1;
	wire				[2:0]			cont_3_2t4_1;
	/*4_1 - 4_2 level*/
	//数据信号
	wire				[73:0]		sh_reg_4_1t42;
	wire				[48:0]		Carry_4_1t4_2;
	wire				[47:0]		Sum_4_1t4_2;
	wire				[55:0]		GP_n_4_1t4_2;
	wire				[55:0]		GP_p_4_1t4_2;
	wire				[55:0]		GP_z_4_1t4_2;
	wire				[55:0]		GN_n_4_1t4_2;
	wire				[55:0]		GN_p_4_1t4_2;
	wire				[55:0]		GN_z_4_1t4_2;
	//控制信号
	wire								S_A_4_1t4_2;
	wire								S_B_4_1t4_2;
	wire								S_C_4_1t4_2;
	wire								S_A_H_4_1t4_2;
	wire								S_B_H_4_1t4_2;
	wire								S_C_H_4_1t4_2;
	wire				[3:0]			trap_0_4_1t4_2;
	wire				[2:0]			trap_ans_0_4_1t4_2;
	wire				[2:0]			trap_ans_1_4_1t4_2;
	wire				[3:0]			trap_1_4_1t4_2;
	wire				[2:0]			cont_4_1t4_2;
	wire				[55:0]		F_4_1t4_2;
	wire				[11:0]		d_4_1t4_2;
	wire				[11:0]		E_4_1t4_2;
	wire				[25:0]		sh_left_lin_T4_1;
	wire				[47:0]		sh_right_lin_T4_1;
	wire								signal_lin_T4_1;
	wire								signal_h_lin_T4_1;
	wire				[1:0]			d_s_T4_1;

	wire				[48:0]		Carryp;
	wire				[47:0]		Sump;
	wire				[55:0]		GP_n_lin;
	wire				[55:0]		GP_p_lin;
	wire				[55:0]		GP_z_lin;
	wire				[55:0]		GN_n_lin;
	wire				[55:0]		GN_p_lin;
	wire				[55:0]		GN_z_lin;
	wire				[55:0]		F_lin;	
	/*4_2-4_3 level*/
	//数据信号
	wire				[74:0]		p_reg;
	wire				[9:0]			sh_num_4_2t4_3;
	wire				[1:0]			esh_4_2t4_3;
	wire				[1:0]			revising_4_2t;
	wire				[9:0]			P;
	wire				[1:0]			V;
	wire								cin;
	wire				[74:0]		p_reg_temp;
	wire				[47:0]		sum_cal;
	//控制信号	
	wire								S_A_4_2t4_3;
	wire								S_B_4_2t4_3;
	wire								S_C_4_2t4_3;
	wire								S_A_H_4_2t4_3;
	wire								S_B_H_4_2t4_3;
	wire								S_C_H_4_2t4_3;
	wire				[3:0]			trap_0_4_2t4_3;
	wire				[2:0]			trap_ans_0_4_2t4_3;
	wire				[2:0]			trap_ans_1_4_2t4_3;
	wire				[3:0]			trap_1_4_2t4_3;
	wire				[2:0]			cont_4_2t4_3;
	wire				[11:0]		d_4_2t4_3;
	wire				[11:0]			levelp_4_4_2t4_3;	
	wire				[11:0]			leveln_4_4_2t4_3;
	wire				[11:0]		E_4_2t4_3;
	wire				[11:0]		levelp_4_lin_T4_2;
	wire				[11:0]		leveln_4_lin_T4_2;
	wire				[73:0]		sh_reg_4_1t4_2;
	/*4_3 - 5 level*/
	//数据信号
	wire				[73:0]		p_reg_4_3t5;
	wire				[9:0]			sh_num_4_3t5;
	wire				[1:0]			esh_4_3t5;
	wire				[1:0]			revising_4_3t5;
	//控制信号
	wire								S_A_4_3t5;
	wire								S_B_4_3t5;
	wire								S_C_4_3t5;
	wire								S_A_H_4_3t5;
	wire								S_B_H_4_3t5;
	wire								S_C_H_4_3t5;
	wire				[3:0]			trap_0_4_3t5;
	wire				[2:0]			trap_ans_0_4_3t5;
	wire				[2:0]			trap_ans_1_4_3t5;
	wire				[3:0]			trap_1_4_3t5;
	wire				[2:0]			cont_4_3t5;
	wire				[11:0]		d_4_3t5;
	wire								s2_4_3t5;
	wire								s2h_4_3t5;
	wire				[1:0]			revising_lin_T4_3;
	wire				[73:0]		p_reg_lin;
	wire								s2_lin_T4_3;
	wire								s2h_lin_T4_3;
	wire				[11:0]		E_4_3t5;
	wire				[11:0]		e_pre_c;
	/*5 - 6 level*/
/*	wire								S_A_5t6;
	wire								S_B_5t6;
	wire								S_C_5t6;
	wire								S_A_H_5t6;
	wire								S_B_H_5t6;
	wire								S_C_H_5t6;
	wire				[3:0]			trap_0_5t6;
	wire				[2:0]			trap_ans_0_5t6;
	wire				[2:0]			trap_ans_1_5t6;
	wire				[3:0]			trap_1_5t6;
	wire				[2:0]			cont_5t6;
	wire				[73:0]		sh_rev_reg_5t6;
	wire				[3:0]			sti_5t6;
	wire				[47:0]		Carry_5t6;
	wire				[47:0]		Sum_5t6;
	wire								s_a;
	wire								s_a_h;
	wire 								s_b;
	wire								s_b_h;
	wire								s_c_h;
	wire								s_c;*/
	wire				[73:0]		con_sh;
	wire				[23:0]		M_result;
	/*test*/
	Pretreatment pretreatment(
		.clk										(clk), 
		.rstn										(rstn),
		.A											(A),
		.B											(B),
		.C											(C),
		.cont										(cont),
		.E_A										(e_a),
		.E_B										(e_b),
		.E_C										(e_c),
		.M_C										(m_c),
		.M_A										(m_a),
		.M_B										(m_b),
		.S_A										(s_a),
		.S_A_H									(s_a_h),
		.S_B										(s_b),
		.S_B_H									(s_b_h),
		.S_C										(s_c),
		.S_C_H									(s_c_h),
		.con_state								(cont_1t2)
	);
	/*t_2*/
	ASC	asc(
		.cont										(cont_1t2),
		.clk										(clk),
		.rstn										(rstn),
		.E_A										(e_a),
		.E_B										(e_b),
		.E_C										(e_c),
		.sh_num									(sh_num_2t3),
		.d											(d_lin)	
	);
	Shift_reg shift_reg( 
		.cont										(cont_1t2),
		.M_C										(m_c),
		.clk										(clk),
		.rstn										(rstn),
		.sh_reg									(sh_reg_2t3)
	);
	Multiple multiple(
		.cont										(cont_1t2),
		.M_A										(m_a),
		.M_B										(m_b),
		.M_out_plain							(M_out_lin)
	);
	T2_reg t2_reg		(
		//输入
		.M_out_plain_in						(M_out_lin),
		.clk										(clk),
		.rstn										(rstn),
		.cont										(cont_1t2),
		.S_A_T1									(s_a),
		.S_B_T1									(s_b),
		.S_C_T1									(s_c),
		.S_A_H_T1								(s_a_h),
		.S_B_H_T1								(s_b_h),
		.S_C_H_T1								(s_c_h),
		.d_lin									(d_lin),
		.E_A										(e_a),
		.E_B										(e_b),
		.E_C										(e_c),
		
		//输出
		.S_A_T2									(S_A_2t3),
		.S_B_T2									(S_B_2t3),
		.S_C_T2									(S_C_2t3),
		.S_A_H_T2								(S_A_H_2t3),
		.S_B_H_T2								(S_B_H_2t3),
		.S_C_H_T2								(S_C_H_2t3),
		.cont_T2									(cont_2t3),
		.E_T2										(E_2t3),
		.d_T2										(d_2t3),
		.M_out_plain_out						(M_out_plain_2t3)
	);
/*	T2_stage	t2_stage(
		.clk										(clk),
		.rstn                            (rstn),
		.M_A										(m_a),
		.M_B										(m_b),
		.M_C										(m_c),
		.trap_T1_0								(trap_0_1t2),
		.trap_T1_1								(trap_1_1t2),
		.E_A										(e_a),
		.E_B										(e_b),
		.E_C										(e_c),
		.S_A_T1									(s_a),
		.S_B_T1									(s_b),
		.S_C_T1									(s_c),
		.S_A_H_T1								(s_a_h),
		.S_B_H_T1								(s_b_h),
		.S_C_H_T1								(s_c_h),
		.cont										(cont_1t2),
		.trap_ans_T1_0							(trap_ans_0_1t2),
		.trap_ans_T1_1							(trap_ans_1_1t2),
		.cont_T2									(cont_2t3),
		.S_A_T2									(S_A_2t3),
		.S_B_T2									(S_B_2t3),
		.S_C_T2									(S_C_2t3),
		.S_A_H_T2								(S_A_H_2t3),
		.S_B_H_T2								(S_B_H_2t3),
		.S_C_H_T2								(S_C_H_2t3),
		.sh_reg									(sh_reg_2t3),
		.M_out_plain							(M_out_plain_2t3),
		.trap_T2_0								(trap_0_2t3),
		.trap_ans_T2_0							(trap_ans_0_2t3),
		.trap_T2_1								(trap_1_2t3),
		.trap_ans_T2_1							(trap_ans_1_2t3),
		.E_T2										(E_2t3),
		.d_T2										(d_2t3),
		.sh_num									(sh_num_2t3)
	); */
	/*t3_1*/
	Shifting	 shifting(
		.cont										(cont_2t3),
		//更改
		.sh_in_reg								(sh_reg_2t3),
		.sh_num									(sh_num_2t3),
		.sh_out_reg								(sh_reg_l)
	);
	Reverse reverse(
		.clk										(clk),
		.rstn										(rstn),
		.cont										(cont_2t3),
		.sh_reg									(sh_reg_l),
		.S_A									   (S_A_2t3),
		.S_B										(S_B_2t3),
		.S_C										(S_C_2t3),
		.S_A_H									(S_A_H_2t3),
		.S_B_H									(S_B_H_2t3),
		.S_C_H									(S_C_H_2t3),
		.sh_rev_reg								(sh_rev_reg_3_1t3_2),
		.sti										(sti_3_1t3_2)
	);
	Wallace_L3 wallace(
		.M_out_plain_in						(M_out_plain_2t3),
		.L3_level								(L3_level_lin)
	);
	T3_1_reg t3_1_reg(
		//输入
		.clk										(clk),
		.rstn										(rstn),
		.L3_level								(L3_level_lin),
		.S_A_T2									(S_A_2t3),
		.S_B_T2									(S_B_2t3),
		.S_C_T2									(S_C_2t3),
		.S_A_H_T2								(S_A_H_2t3),
		.S_B_H_T2								(S_B_H_2t3),
		.S_C_H_T2								(S_C_H_2t3),
		.cont										(cont_2t3),
		.d_T2										(d_2t3),
		.E_T2										(E_2t3),
		//输出
		.d_T3_1									(d_3_1t3_2),
		.E_T3_1									(E_3_1t3_2),
		.cont_T3_1								(cont3_1t3_2),
		.S_A_T3_1								(S_A_3_1t3_2),
		.S_B_T3_1								(S_B_3_1t3_2),
		.S_C_T3_1								(S_C_3_1t3_2),
		.S_A_H_T3_1								(S_A_H_3_1t3_2),
		.S_B_H_T3_1								(S_B_H_3_1t3_2),
		.S_C_H_T3_1								(S_C_H_3_1t3_2),
		.Level_out								(Level3_lin_3_1t3_2)
	);
/*	T3_1_stage t3_1_stage(
		.clk										(clk),
		.rstn										(rstn),
		.cont										(cont_2t3),
		.M_out_plain_in						(M_out_plain_2t3),
		.d_T2										(d_2t3),
		.sh_reg_T2								(sh_reg_2t3),
		.sh_num_T2									(sh_num_2t3),
		.S_A_T2									(S_A_2t3),
		.S_B_T2									(S_B_2t3),
		.S_C_T2									(S_C_2t3),
		.S_A_H_T2								(S_A_H_2t3),
		.S_B_H_T2								(S_B_H_2t3),
		.S_C_H_T2								(S_C_H_2t3),
		.trap_T2_0								(trap_0_2t3),
		.trap_T2_1								(trap_1_2t3),
		.trap_ans_T2_0							(trap_ans_0_2t3),
		.trap_ans_T2_1							(trap_ans_1_2t3),
		.E_T2										(E_2t3),
		//输出
		.S_A_T3_1								(S_A_3_1t3_2),
		.S_B_T3_1								(S_B_3_1t3_2),
		.S_C_T3_1								(S_C_3_1t3_2),
		.S_A_H_T3_1								(S_A_H_3_1t3_2),
		.S_B_H_T3_1								(S_B_H_3_1t3_2),
		.S_C_H_T3_1								(S_C_H_3_1t3_2),
		.trap_T3_1_0							(trap_0_3_1t3_2),
		.trap_T3_1_1							(trap_1_3_1t3_2),
		.trap_ans_T3_1_0						(trap_ans_0_3_1t3_2),
		.trap_ans_T3_1_1						(trap_ans_1_3_1t3_2),
		.sh_rev_reg								(sh_rev_reg_3_1t3_2),
		.sti										(sti_3_1t3_2),
		.d_T3_1									(d_3_1t3_2),
		.E_T3_1									(E_3_1t3_2),
		.cont_T3_1								(cont3_1t3_2),
		.Level3_out								(Level3_lin_3_1t3_2)
	);*/
	/*3-2*/
	Wallace_L4_L5 wallace_l3(
		.Level_in								(Level3_lin_3_1t3_2),
		.Carry									(Carry_lin),
		.Sum										(Sum_lin)
	);
	T3_2_reg t3_2_reg(
		//输入
		.clk										(clk),
		.rstn										(rstn),
		.Carry_in								(Carry_lin),
		.Sum_in									(Sum_lin),
		.cont_T3_1								(cont3_1t3_2),
		.E_T3_1									(E_3_1t3_2),
		.d_T3_1									(d_3_1t3_2),
		.sh_rev_reg_in							(sh_rev_reg_3_1t3_2),
		.sti										(sti_3_1t3_2),
		.S_A_T3_1								(S_A_3_1t3_2),
		.S_B_T3_1								(S_B_3_1t3_2),
		.S_C_T3_1								(S_C_3_1t3_2),
		.S_A_H_T3_1								(S_A_H_3_1t3_2),
		.S_B_H_T3_1								(S_B_H_3_1t3_2),
		.S_C_H_T3_1								(S_C_H_3_1t3_2),
		//输出
		.Sum_out									(Sum_3_2t4_1),
		.sh_rev_reg_out						(sh_rev_reg_3_2t4_1),
		.S_A_T3_2								(S_A_3_2t4_1),
		.S_B_T3_2								(S_B_3_2t4_1),
		.S_C_T3_2								(S_C_3_2t4_1),
		.S_A_H_T3_2								(S_A_H_3_2t4_1),
		.S_B_H_T3_2								(S_B_H_3_2t4_1),
		.S_C_H_T3_2								(S_C_H_3_2t4_1),
		.cont_T3_2								(cont_3_2t4_1),
		.d_T3_2									(d_3_2t4_1),
		.E_T3_2									(E_3_2t4_1),
		.sti_out									(sti_3_2t4_1),
		.Carry_out								(Carry_3_2t4_1)
	);
	/*	T3_2_stage t3_2_stage(
		.clk										(clk),
		.rstn										(rstn),
		.cont_T3_1								(cont3_1t3_2),
		.sh_rev_reg_in							(sh_rev_reg_3_1t3_2),
		.S_A_T3_1								(S_A_3_1t3_2),
		.S_B_T3_1								(S_B_3_1t3_2),
		.S_C_T3_1								(S_C_3_1t3_2),
		.S_A_H_T3_1								(S_A_H_3_1t3_2),
		.S_B_H_T3_1								(S_B_H_3_1t3_2),
		.S_C_H_T3_1								(S_C_H_3_1t3_2),
		.trap_T3_1_0							(trap_0_3_1t3_2),
		.trap_T3_1_1							(trap_1_3_1t3_2),
		.trap_ans_T3_1_0						(trap_ans_0_3_1t3_2),
		.trap_ans_T3_1_1						(trap_ans_1_3_1t3_2),
		.E_T3_1									(E_3_1t3_2),
		.d_T3_1									(d_3_1t3_2),
		.Level3_in								(Level3_lin_3_1t3_2),
		.sti										(sti_3_1t3_2),
		//输出
		.S_A_T3_2								(S_A_3_2t4_1),
		.S_B_T3_2								(S_B_3_2t4_1),
		.S_C_T3_2								(S_C_3_2t4_1),
		.S_A_H_T3_2								(S_A_H_3_2t4_1),
		.S_B_H_T3_2								(S_B_H_3_2t4_1),
		.S_C_H_T3_2								(S_C_H_3_2t4_1),
		.trap_T3_2_0							(trap_0_3_2t4_1),
		.trap_T3_2_1							(trap_1_3_2t4_1),
		.trap_ans_T3_2_0						(trap_ans_0_3_2t4_1),
		.trap_ans_T3_2_1						(trap_ans_1_3_2t4_1),
		.d_T3_2									(d_3_2t4_1),
		.E_T3_2									(E_3_2t4_1),
		.cont_T3_2								(cont_3_2t4_1),
		.sti_out									(sti_3_2t3_1),
		.Carry									(Carry_3_2t4_1),
		.Sum										(Sum_3_2t4_1),
		.sh_rev_reg_out						(sh_rev_reg_3_2t4_1)
	);*/
	/*t4_1*/
	T4_CSA_file t4_csa(
		.in1										(Sum_3_2t4_1),
		.in2										(Carry_3_2t4_1),
		.in3										(sh_right_lin_T4_1),
		.signal									(signal_lin_T4_1),
		.signal_h								(signal_h_lin_T4_1),
		.cont										(cont_3_2t4_1),
		.Carry									(Carryp),
		.Sum										(Sump)
	);
	LeadingZeroAnt_1 leadingzeroant_1(
		//输入
		.cont										(cont_3_2t4_1),
		.Sum										(Sump),
		.Carry									(Carryp),
		.d											(d_s_T4_1),
		.S_A										(S_A_3_2t4_1),
		.S_B										(S_B_3_2t4_1),
		.S_C										(S_C_3_2t4_1),
		.S_A_H									(S_A_H_3_2t4_1),
		.S_B_H									(S_B_H_3_2t4_1),
		.S_C_H									(S_C_H_3_2t4_1),
		.M_C_A									(sh_left_lin_T4_1),
		//输出
		.GP_n										(GP_n_lin),
		.GP_p										(GP_p_lin),
		.GP_z										(GP_z_lin),
		.GN_n										(GN_n_lin),
		.GN_p										(GN_p_lin),
		.GN_z										(GN_z_lin),
		.F											(F_lin)
	);
	T4_1_addit t4_1_a(
		//输入
		.cont_T3_2								(cont_3_2t4_1),
		.sh_reg_T3_2							(sh_rev_reg_3_2t4_1),
		.S_A_T3_2								(S_A_3_2t4_1),
		.S_B_T3_2								(S_B_3_2t4_1),
		.S_C_T3_2								(S_C_3_2t4_1),
		.S_A_H_T3_2								(S_A_H_3_2t4_1),
		.S_B_H_T3_2								(S_B_H_3_2t4_1),
		.S_C_H_T3_2								(S_C_H_3_2t4_1),
		.d_T3_2									(d_3_2t4_1),
		
		//输出
		.sh_left									(sh_left_lin_T4_1),
		.sh_right								(sh_right_lin_T4_1),
		.signal									(signal_lin_T4_1),
		.signal_h								(signal_h_lin_T4_1),
		.d_s										(d_s_T4_1)
	);
	T4_1_reg t4_1_reg( 
		//输入
		.clk										(clk),
		.rstn										(rstn),
		.cont										(cont_3_2t4_1),
		.GP_n_in									(GP_n_lin),
		.GP_p_in									(GP_p_lin),
		.GP_z_in									(GP_z_lin),
		.GN_n_in									(GN_n_lin),
		.GN_p_in									(GN_p_lin),
		.GN_z_in									(GN_z_lin),
		.F_in										(F_lin),
		.Carry_in								(Carryp),
		
		.Sum_in									(Sump),
		.S_A_T3_2								(S_A_3_2t4_1),
		.S_B_T3_2								(S_B_3_2t4_1),
		.S_C_T3_2								(S_C_3_2t4_1),
		.S_A_H_T3_2								(S_A_H_3_2t4_1),
		.S_B_H_T3_2								(S_B_H_3_2t4_1),
		.S_C_H_T3_2							(S_C_H_3_2t4_1),
		.sh_reg_T3_2							(sh_rev_reg_3_2t4_1),
		.E_T3_2									(E_3_2t4_1),
		.d_T3_2									(d_3_2t4_1),
		//输出
		.sh_reg_T4_1 							(sh_reg_4_1t4_2),
		
		.Carry_out								(Carry_4_1t4_2),
		.Sum_out									(Sum_4_1t4_2),
		.GP_n_out								(GP_n_4_1t4_2),
		.GP_p_out								(GP_p_4_1t4_2),
		.GP_z_out								(GP_z_4_1t4_2),
		.GN_z_out								(GN_z_4_1t4_2),
		.GN_p_out								(GN_p_4_1t4_2),
		.GN_n_out								(GN_n_4_1t4_2),
		.S_A_T4_1								(S_A_4_1t4_2),
		.S_B_T4_1								(S_B_4_1t4_2),
		.S_C_T4_1								(S_C_4_1t4_2),
		.S_A_H_T4_1								(S_A_H_4_1t4_2),
		.S_B_H_T4_1								(S_B_H_4_1t4_2),
		.S_C_H_T4_1								(S_C_H_4_1t4_2),
		.cont_T4_1								(cont_4_1t4_2),
		.d_T4_1									(d_4_1t4_2),
		.E_T4_1									(E_4_1t4_2),
		.F_out									(F_4_1t4_2)
	);
/*	T4_1_stage t4_1stage(
		.clk										(clk),
		.rstn										(rstn),
		.cont_T3_2   							(cont_3_2t4_1),
		.sh_reg_T3_2							(sh_rev_reg_3_2t4_1),
		.E_T3_2									(E_3_2t4_1),
		.Sum										(Sum_3_2t4_1),
		.Carry									(Carry_3_2t4_1),
		.S_A_T3_2								(S_A_3_2t4_1),
		.S_B_T3_2								(S_B_3_2t4_1),
		.S_C_T3_2								(S_C_3_2t4_1),
		.S_A_H_T3_2								(S_A_H_3_2t4_1),
		.S_B_H_T3_2								(S_B_H_3_2t4_1),
		.S_C_H_T3_2							(S_C_H_3_2t4_1),
		.trap_T3_2_0							(trap_0_3_2t4_1),
		.trap_T3_2_1							(trap_1_3_2t4_1),
		.trap_ans_T3_2_0						(trap_ans_0_3_2t4_1),
		.trap_ans_T3_2_1						(trap_ans_1_3_2t4_1),
		.d_T3_2										(d_3_2t4_1),
		//输出
		//control
		.S_A_T4_1								(S_A_4_1t4_2),
		.S_B_T4_1								(S_B_4_1t4_2),
		.S_C_T4_1								(S_C_4_1t4_2),
		.S_A_H_T4_1								(S_A_H_4_1t4_2),
		.S_B_H_T4_1								(S_B_H_4_1t4_2),
		.S_C_H_T4_1								(S_C_H_4_1t4_2),
		.trap_T4_1_0							(trap_0_4_1t4_2),
		.trap_T4_1_1							(trap_1_4_1t4_2),
		.trap_ans_T4_1_0						(trap_ans_0_4_1t4_2),
		.trap_ans_T4_1_1						(trap_ans_1_4_1t4_2),
		.cont_T4_1								(cont_4_1t4_2),
		.d_T4_1										(d_4_1t4_2),
		.E_T4_1									(E_4_1t4_2),
		//data
		.GP_n										(GP_n_4_1t4_2),
		.GP_p										(GP_p_4_1t4_2),
		.GP_z										(GP_z_4_1t4_2),
		.GN_n										(GN_n_4_1t4_2),
		.GN_p										(GN_p_4_1t4_2),
		.GN_z										(GN_z_4_1t4_2),
		.F											(F_4_1t4_2),
		.sh_reg_T4_1 							(sh_reg_4_1t42),
		.Carry_out								(Carry_4_1t4_2),
		.Sum_out									(Sum_4_1t4_2)
	);*/
	/*4_2*/
	LeadingZeroAnt_2 leadingzeroant_2(
		//输入
		.cont									(cont_4_1t4_2), 
		.S_A									(S_A_4_1t4_2),
		.S_B									(S_B_4_1t4_2),
		.S_C									(S_C_4_1t4_2),
		.GP_n									(GP_n_4_1t4_2),
		.GP_p									(GP_p_4_1t4_2),
		.GP_z									(GP_z_4_1t4_2),
		.GN_p									(GN_p_4_1t4_2),
		.GN_n									(GN_n_4_1t4_2),
		.GN_z									(GN_z_4_1t4_2),
		.F										(F_4_1t4_2),
		.S_A_H								(S_A_H_4_1t4_2),
		.S_B_H								(S_B_H_4_1t4_2),
		.S_C_H								(S_C_H_4_1t4_2),
		//输出
		.P										(P),
		.V										(V),
		.levelp_4							(levelp_4_lin_T4_2),
		.leveln_4							(leveln_4_lin_T4_2)
	);
	Adder		add(
		.x										(Carry_4_1t4_2),
		.y										(Sum_4_1t4_2),
		.cout									(cin),
		.sum									(sum_cal)
	);
	CAL cal(
		.sh_reg_T4_1						(sh_reg_4_1t4_2),
		.sum									(sum_cal),
		.cont									(cont_4_1t4_2),
		.S_A									(S_A_4_1t4_2),
		.S_B									(S_B_4_1t4_2),
		.S_C									(S_C_4_1t4_2),
		.S_A_H								(S_A_H_4_1t4_2),
		.S_B_H								(S_B_H_4_1t4_2),
		.S_C_H								(S_C_H_4_1t4_2),
		.cin									(cin),
		.p_reg_temp							(p_reg_temp)
	);
	T4_2_reg t4_2_reg(
		//in
		.clk									(clk),
		.rstn									(rstn),
		.cont									(cont_4_1t4_2),
		.P										(P),
		.V										(V),
		.p_reg_temp							(p_reg_temp),
		.levelp_4_in							(levelp_4_lin_T4_2),
		.leveln_4_in						(leveln_4_lin_T4_2),
		.S_A_T4_1							(S_A_4_1t4_2),
		.S_B_T4_1							(S_B_4_1t4_2),
		.S_C_T4_1							(S_C_4_1t4_2),
		.S_A_H_T4_1							(S_A_H_4_1t4_2),
		.S_B_H_T4_1							(S_B_H_4_1t4_2),
		.S_C_H_T4_1							(S_C_H_4_1t4_2),
		.d_T4_1								(d_4_1t4_2),
		.E_T4_1								(E_4_1t4_2),
//		.revi									(revising_T4_2),
		//out
		.sh_num								(sh_num_4_2t4_3),
		.esh									(esh_4_2t4_3),
		.cont_T4_2							(cont_4_2t4_3),
		.levelp_4_out						(levelp_4_4_2t4_3),
		.leveln_4_out						(leveln_4_4_2t4_3),
		.S_A_T4_2							(S_A_4_2t4_3),
		.S_B_T4_2							(S_B_4_2t4_3),
		.S_C_T4_2							(S_C_4_2t4_3),
		.S_A_H_T4_2							(S_A_H_4_2t4_3),
		.S_B_H_T4_2							(S_B_H_4_2t4_3),
		.S_C_H_T4_2							(S_C_H_4_2t4_3),
		.E_T4_2								(E_4_2t4_3),
		.d_T4_2								(d_4_2t4_3),
		.p_reg								(p_reg)					
	);
/*	T4_2_stage t4_2_stage(
		//输入
		//contol
		.clk										(clk),
		.rstn										(rstn),
		.cont_T4_1								(cont_4_1t4_2),
		.S_A_T4_1								(S_A_4_1t4_2),
		.S_B_T4_1								(S_B_4_1t4_2),
		.S_C_T4_1								(S_C_4_1t4_2),
		.S_A_H_T4_1								(S_A_H_4_1t4_2),
		.S_B_H_T4_1								(S_B_H_4_1t4_2),
		.S_C_H_T4_1								(S_C_H_4_1t4_2),
		.trap_T4_1_0							(trap_0_4_1t4_2),
		.trap_T4_1_1							(trap_1_4_1t4_2),
		.trap_ans_T4_1_0						(trap_ans_0_4_1t4_2),
		.trap_ans_T4_1_1						(trap_ans_1_4_1t4_2),
		.d_T4_1									(d_4_1t4_2),
		.E_T4_1									(E_4_1t4_2),
		//data
		.GP_n										(GP_n_4_1t4_2),
		.GP_p										(GP_p_4_1t4_2),
		.GP_z										(GP_z_4_1t4_2),
		.GN_n										(GN_n_4_1t4_2),
		.GN_p										(GN_p_4_1t4_2),
		.GN_z										(GN_z_4_1t4_2),
		.F											(F_4_1t4_2),
		.sh_reg_T4_1 							(sh_reg_4_1t42),
		.Carryp									(Carry_4_1t4_2),
		.Sump										(Sum_4_1t4_2),
		
		//control
		.cont_T4_2								(cont_4_2t4_3),
		.S_A_T4_2								(S_A_4_2t4_3),
		.S_B_T4_2								(S_B_4_2t4_3),
		.S_C_T4_2								(S_C_4_2t4_3),
		.S_A_H_T4_2								(S_A_H_4_2t4_3),
		.S_B_H_T4_2								(S_B_H_4_2t4_3),
		.S_C_H_T4_2								(S_C_H_4_2t4_3),
		.trap_T4_2_0							(trap_0_4_2t4_3),
		.trap_T4_2_1							(trap_1_4_2t4_3),
		.trap_ans_T4_2_0						(trap_ans_0_4_2t4_3),
		.trap_ans_T4_2_1						(trap_ans_1_4_2t4_3),
		.E_T4_2									(E_4_2t4_3),
		.d_T4_2									(d_4_2t4_3),
		//data
		.p_reg									(p_reg),
		.sh_num									(sh_num_4_2t4_3),
		.esh										(esh_4_2t4_3),
		.leveln_4_T4_2							(leveln_4_4_2t4_3),
		.levelp_4_T4_2							(levelp_4_4_2t4_3)
//		.revising_T4_2							(revising_4_2t5)
	);*/
	/*t4_3*/
	LeadingZeroAnt_3 leadingZeroAnt_3(
		.S_A									(S_A_4_2t4_3),
		.S_B									(S_B_4_2t4_3),
		.S_C									(S_C_4_2t4_3),
		.S_A_H								(S_A_H_4_2t4_3),
		.S_B_H								(S_B_H_4_2t4_3),
		.S_C_H								(S_C_H_4_2t4_3),
		.cont									(cont_4_2t4_3), 
		.levelp_4							(levelp_4_4_2t4_3),
		.leveln_4							(leveln_4_4_2t4_3),
		.revising							(revising_lin_T4_3)
	);
	Abso abso(
		.cont									(cont_4_2t4_3),
		.p_reg_temp							(p_reg),
		.s2									(s2_lin_T4_3),//
		.s2_h									(s2h_lin_T4_3),//
		.S_A									(S_A_4_2t4_3),
		.S_B									(S_B_4_2t4_3),
		.S_A_H								(S_A_H_4_2t4_3),
		.S_B_H								(S_B_H_4_2t4_3),
		.p_reg								(p_reg_lin)
	);
	T4_3_reg t4_3_reg(
		//输入
		.clk									(clk),
		.rstn									(rstn),
		.cont_T4_2							(cont_4_2t4_3),
		.P										(sh_num_4_2t4_3),
		.V										(esh_4_2t4_3),
		.p_reg_temp							(p_reg_lin),
		.revising							(revising_lin_T4_3),
		.S_A_T4_2							(S_A_4_2t4_3),
		.S_B_T4_2							(S_B_4_2t4_3),
		.S_C_T4_2							(S_C_4_2t4_3),
		.S_A_H_T4_2							(S_A_H_4_2t4_3),
		.S_B_H_T4_2							(S_B_H_4_2t4_3),
		.S_C_H_T4_2							(S_C_H_4_2t4_3),
		.d_T4_2								(d_4_2t4_3),
		.E_PRE_C								(e_pre_c),
		.s										(s2_lin_T4_3),
		.s_h									(s2h_lin_T4_3),
		//输出
		.revi									(revising_4_3t5),
		.sh_num								(sh_num_4_3t5),
		.esh									(esh_4_3t5),
		.p_reg								(p_reg_4_3t5),
		.cont_T4_3							(cont_4_3t5),
		.S_A_T4_3							(S_A_4_3t5),
		.S_B_T4_3							(S_B_4_3t5),
		.S_C_T4_3							(S_C_4_3t5),
		.S_A_H_T4_3							(S_A_H_4_3t5),
		.S_B_H_T4_3							(S_B_H_4_3t5),
		.S_C_H_T4_3							(S_C_H_4_3t5),
		.E_T4_3								(E_4_3t5),
		.d_T4_3								(d_4_3t5),
		.s2_T4_3								(s2_4_3t5),
		.s2h_T4_3							(s2h_4_3t5)
	);
	Pre_calculation pre_cal(
		//输入
		.cont_T_4_2							(cont_4_3t5),
		.E_T_4_2								(E_4_2t4_3),
		.d_T_4_2								(d_4_2t4_3),
		.P										(sh_num_4_2t4_3),
		.V										(esh_4_2t4_3),
		//输出
		.E_PRE_C								(e_pre_c)
	);
/*			T4_3_stage t4_3_stage( 
		//输入
		//contol
		.clk										(clk),
		.rstn										(rstn),
		.cont_T4_2								(cont_4_2t4_3),
		.S_A_T4_2								(S_A_4_2t4_3),
		.S_B_T4_2								(S_B_4_2t4_3),
		.S_C_T4_2								(S_C_4_2t4_3),
		.S_A_H_T4_2								(S_A_H_4_2t4_3),
		.S_B_H_T4_2								(S_B_H_4_2t4_3),
		.S_C_H_T4_2								(S_C_H_4_2t4_3),
		.trap_T4_2_0							(trap_0_4_2t4_3),
		.trap_T4_2_1							(trap_1_4_2t4_3),
		.trap_ans_T4_2_0						(trap_ans_0_4_2t4_3),
		.trap_ans_T4_2_1						(trap_ans_1_4_2t4_3),
		.d_T4_2									(d_4_2t4_3),
		.E_T4_2									(E_4_2t4_3),
		//data
		.esh_T4_2									(esh_4_2t4_3),
		.p_reg_in	 							(p_reg),
		.levelp_4_T4_2							(levelp_4_4_2t4_3),
		.leveln_4_T4_2							(leveln_4_4_2t4_3),
		.sh_num_T4_2							(sh_num_4_2t4_3),
		//control
		.cont_T4_3								(cont_4_3t5),
		.S_A_T4_3								(S_A_4_3t5),
		.S_B_T4_3								(S_B_4_3t5),
		.S_C_T4_3								(S_C_4_3t5),
		.S_A_H_T4_3								(S_A_H_4_3t5),
		.S_B_H_T4_3								(S_B_H_4_3t5),
		.S_C_H_T4_3								(S_C_H_4_3t5),
		.trap_T4_3_0							(trap_0_4_3t5),
		.trap_T4_3_1							(trap_1_4_3t5),
		.trap_ans_T4_3_0						(trap_ans_0_4_3t5),
		.trap_ans_T4_3_1						(trap_ans_1_4_3t5),
		.E_T4_3									(E_4_3t5),
		.d_T4_3									(d_4_3t5),
		.s2_T4_3									(s2_4_3t5),
		.s2h_T4_3								(s2h_4_3t5),
		//data
		.p_reg									(p_reg_4_3t5),
		.sh_num									(sh_num_4_3t5),
		.esh										(esh_4_3t5),
		.revising_T4_3							(revising_4_3t5)
	);*/
	/*5*/
	Con_shift con_shift(
		.d_temp								(d_4_3t5),
		.p_reg								(p_reg_4_3t5),
		.con_sh								(con_sh),
		.cont									(cont_4_3t5)
	);
	Vari_shift varis_reduce(
		.cont									(cont_4_3t5),
		.sh_num								(sh_num_4_3t5),
		.esh									(esh_4_3t5),
		.con_sh								(con_sh),
		.revise 								(revising_4_3t5),
		.M_result							(M_result)
	);
	MaF maf(
		.cont									(cont_4_3t5),
		.M_in									(M_result),
		.clk									(clk),
		.rstn									(rstn),
		.E										(E_4_3t5),
		.s2_T4								(s2_4_3t5),
		.s2h_T4									(s2h_4_3t5),
		.result								(out)
	);
/*	T5_stage t5_stage(
		.clk										(clk),
		.rstn										(rstn),
		.cont_T4									(cont_4_3t5),
		.E_T4										(E_4_3t5),
		.p_reg									(p_reg),
		.S_A_T4									(S_A_4_3t5),
		.S_B_T4									(S_B_4_3t5),
		.S_C_T4									(S_C_4_3t5),
		.S_A_H_T4								(S_A_H_4_3t5),
		.S_B_H_T4								(S_B_H_4_3t5),
		.S_C_H_T4								(S_C_H_4_3t5),
		.trap_T4_0								(trap_0_4_3t5),
		.trap_T4_1								(trap_1_4_3t5),
		.trap_ans_T4_0							(trap_ans_0_4_3t5),
		.trap_ans_T4_1							(trap_ans_1_4_3t5),
		.sh_num_T4								(sh_num_4_3t5),
		.revising_T4							(revising_4_3t5),
		.esh_T4									(esh_4_3t5),
		.d_T4										(d_4_3t5),
		.s2_T4									(s2_4_3t5),
		.s2h_T4									(s2h_4_3t5),
		.calculation							(out) 
	);*/
	//给输出先存入
endmodule

	
	
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

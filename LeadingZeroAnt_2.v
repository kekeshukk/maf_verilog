//后半部分之一
module LeadingZeroAnt_2(
	//输入
	input										S_A,
	input										S_B,
	input										S_C,
	input										S_A_H,
	input										S_B_H,
	input										S_C_H,
	input			[2:0]						cont,
	input			[55:0]					GP_n,
	input			[55:0]					GP_p,
	input			[55:0]					GP_z,
	input			[55:0]					GN_n,
	input			[55:0]					GN_p,
	input			[55:0]					GN_z,
	input			[55:0]					F,
	//输出
	output		[11:0]						levelp_4,
	output		[11:0]						leveln_4,
	output	reg[1:0]						V,//左侧高位
	output	reg[9:0]						P//左侧高位
);
//	wire			[55:0]					num_p_0;
//	wire			[55:0]					num_p_1;
//	wire			[55:0]					num_n_0;
//	wire			[55:0]					num_n_1;
	wire			[9:0]						p_temp;
	wire			[1:0]						v_temp;
	wire			[31:0]					F_left;
	assign			F_left			=			{F[23:0],8'b0};
	Revising_1	revising_1_instance(
		.cont										(cont),
		.GP_n										(GP_n),
		.GP_p										(GP_p),
		.GP_z										(GP_z),
		.GN_n										(GN_n),
		.GN_p										(GN_p),
		.GN_z										(GN_z),
//		.revising								(revising),
		.S_A										(S_A),
		.S_B										(S_B),
		.S_C										(S_C),
		.S_A_H									(S_A_H),
		.S_B_H									(S_B_H),
		.S_C_H									(S_C_H),
		//输出
		.levelp_4_out								(levelp_4),
		.leveln_4_out								(leveln_4)
	);
	/*高位位置*/
	First_one first_one_high(
		.F											(F[55:24]),
		.P											(p_temp[9:5]),
		.V											(v_temp[1])
	);
	/*低位位置*/
	First_one first_one_low(
		.F											(F_left),
		.P											(p_temp[4:0]),
		.V											(v_temp[0])
	);
	always@(*)begin
		if(cont == 3'b000 || cont == 3'b010)begin
			V[0] 		=			v_temp[1] | v_temp[0];
			V[1]		=	'b0;
			P[9:6]	=			4'b0;
			P[5]		=			v_temp[1] == 1'b1 ? 1'b0 : v_temp == 1'b1 ? 1'b1 : 1'bx;
			P[4:0]	=			v_temp[1] == 1'b1 ? p_temp[9:5] : v_temp[0] == 1'b1 ?p_temp[4:0] : 5'bx;
		end else if (cont == 3'b001)begin
			V[1]		=			v_temp[1];
			V[0]		=			v_temp[0];
			P[9:5]   =  		p_temp[9:5];
			P[4:0]	=			p_temp[4:0];
		end else begin
			V[1]		=			1'b0;
			V[0]		=			1'b0;
			P[9:5]   =        5'b0;
			P[4:0]   =        5'b0;
		end
	end 
endmodule
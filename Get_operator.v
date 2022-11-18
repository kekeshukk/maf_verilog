//LZD中获得两类操作数的一个模块
module Get_operator(
	input			[25:0]					M_C_A, //加了两位附加的M_C
	input			[47:0]					Sum,
	input			[48:0]					Carry,
	input			[2:0]						cont,
	output		[55:0]					num_p_0,//d>0时的第一op
	output		[55:0]					num_p_1,//d>0时的第二op
	output		[55:0]					num_n_0,//d<=0时的第一op
	output		[55:0]					num_n_1 //d<=0时第二op
);
	wire			[12:0]					M_C_A_H;
	wire			[12:0]					M_C_A_L;
	/*获得高位与低位的数据*/
	assign			M_C_A_H			=			M_C_A[25:13];
	assign			M_C_A_L			=			M_C_A[12:0];
	assign			num_p_0			=			(cont == 3'b000) ? {M_C_A,Sum[47:24],6'b0} : (cont == 3'b1)  
															? {M_C_A_H,Sum[44:34],8'b0,M_C_A_L,Sum[21:11]} : (cont == 3'b010) 
																							? {M_C_A,Sum[21:0],8'b0} : {56'b0};
	assign			num_p_1			=			(cont == 3'b000) ? {25'b0,Carry[48:24],6'b0} : (cont == 3'b001)
															? {12'b0,Carry[45:34],8'b0,12'b0,Carry[22:11]} : (cont == 3'b010)
																							? {24'b0,1'b0,Carry[22:0],8'b0} : {56'b0};
	assign			num_n_0			=			(cont == 3'b000) ? {M_C_A[1:0],Sum,6'b0}   : (cont == 3'b001) 
															? {M_C_A[14:13],Sum[44:23],8'b0,M_C_A[1:0],Sum[21:0]} :{56 * {1'b0}};
	assign			num_n_1			=			(cont == 3'b0)    ? {1'b0,Carry,6'b0} :       (cont == 3'b001)
															? {1'b0, Carry[45:23], 8'b0, 1'b0, Carry[22:0]}       : {56 * {1'b0}};
endmodule
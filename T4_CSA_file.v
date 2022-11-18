//第4级流水线的结果

module		T4_CSA_file(
	input			[47:0]				in1,
	input			[47:0]				in2,//要加1修正
	input			[47:0]				in3,
	input									signal,//低位反相信号传递
	input									signal_h,//高位反相信号传递
	input			[2:0]					cont,
	output	   [48:0]				Carry,
	output		[47:0]				Sum
);
	wire			[47:0]				temp;
	wire			[47:0]				c_temp;
//	wire			[49:0]				c_temp;
	assign			temp			=			((cont == 3'b000 && signal == 1'b1)||(cont == 3'b001 && signal == 1'b1 && signal_h == 1'b0)) 
														? in2 + 1'b1 : (cont == 3'b001 && signal == 1'b0 && signal_h == 1'b1)? (in2 + (1'b1 << 5'd23)) 
																	:(cont == 3'b001 && signal == 1'b1 && signal == 1'b1) ? (in2 + (1'b1 << 5'd23 | 24'b1))
																								: (cont == 3'b010 && signal == 1'b1) ? in2 + 'b1 : in2;
	assign			Carry[0]    =        'b0;
	assign			Carry[48:1] =        c_temp[47:0];
	parameter		PSIZE 		= 			48;//乘积尾数的size
	genvar i;
	generate
		for(i = 0; i < PSIZE; i = i + 1)begin:csa_0
			Tr_Tw_CSA_chip tr_tw_csa(
			.x									(in1[i]),
			.y									(temp[i]),
			.z									(in3[i]),
			.s									(Sum[i]),
			.c									(c_temp[i])
			);
		end
	endgenerate

endmodule
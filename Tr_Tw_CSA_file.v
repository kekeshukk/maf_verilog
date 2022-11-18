//CSA堆
module Tr_Tw_CSA_file(
	input			[47:0]				in1,
	input			[47:0]				in2,
	input			[47:0]				in3,
	output		[47:0]				carry,//已左移
	output		[47:0]				sum
);
	wire			[47:0]				temp;//存储进位
	assign			carry[0]			=			'b0;
	assign			carry[47:1]		=			temp[46:0];
	genvar i;
	parameter	SIZE = 48;
	generate
		for(i = 0; i < SIZE; i = i + 1)begin:csa_file
			Tr_Tw_CSA_chip tr_tw_csa_chip(
				.x										(in1[i]),
				.y										(in2[i]),
				.z										(in3[i]),
				.s										(sum[i]),
				.c										(temp[i])
			);
		end
	endgenerate
endmodule
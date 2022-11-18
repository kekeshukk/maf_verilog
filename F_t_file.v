//堆状的4-2压缩器
module F_t_file(
	input				[47:0]				P_1,
	input				[47:0]				P_2,
	input				[47:0]				P_3,
	input				[47:0]				P_4,
	output			[47:0]				Carry,//左移后
	output			[47:0]				Sum
);
	wire				[48:0]				temp;//进位的变量
	wire				[47:0]				carry;//未左移
	assign			Carry[0] = 1'b0;
	assign			Carry[47:1] = carry[46:0];
	F_t_chip f_t_chip(
		.in1									(P_1[0]),
		.in2									(P_2[0]),
		.in3									(P_3[0]),
		.in4									(P_4[0]),
		.cin									(1'b0),
		.carry									(carry[0]),
		.cout									(temp[1]),
		.sum									(Sum[0])
	);
	genvar i;
	parameter	SIZE = 47;
	generate
		for(i=1;i<=SIZE;i=i+1)
		begin:heap
			F_t_chip f_t_chip(
				.in1							(P_1[i]),
				.in2						  (P_2[i]),
				.in3							(P_3[i]),
				.in4							(P_4[i]),
				.cin							(temp[i]),
				.cout							(temp[i + 1]),
				.carry						(carry[i]),
				.sum							(Sum[i])
			);
		end
   endgenerate
endmodule
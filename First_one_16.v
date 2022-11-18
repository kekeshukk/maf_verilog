module First_one_16(
	input										V3_0,
	input										V3_1,
	input			[2:0]						P3_0,
	input			[2:0]						P3_1,
	output		[3:0]						P4_0,
	output									V4_0
);
	assign			V4_0			=			V3_0 | V3_1;
	assign			P4_0			=			(V3_0 != 1'b0) ? {1'b0,P3_0} : (V3_1 == 1'b1) ? {1'b1,P3_1} :4'bx;
endmodule
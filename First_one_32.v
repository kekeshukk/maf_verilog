module First_one_32(
	input										V4_0,
	input										V4_1,
	input			[3:0]						P4_0,
	input			[3:0]						P4_1,
	output		[4:0]						P5_0,
	output									V5_0
);
	assign			V5_0			=			V4_0 | V4_1;
	assign			P5_0			=			(V4_0 != 1'b0) ? {1'b0,P4_0} : (V4_1 == 1'b1) ? {1'b1,P4_1} :5'bx;
endmodule
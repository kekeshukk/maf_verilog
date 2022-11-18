module First_one_8(
	input										V2_0,
	input										V2_1,
	input			[1:0]						P2_0,
	input			[1:0]						P2_1,
	output		[2:0]						P3_0,
	output									V3_0
);
	assign			V3_0			=			V2_0 | V2_1;
	assign			P3_0			=			(V2_0 != 1'b0) ? {1'b0,P2_0} : (V2_1 == 1'b1) ? {1'b1,P2_1} :3'bx;
endmodule
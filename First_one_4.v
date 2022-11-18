module First_one_4(
	input									p1,
	input									p2,
	input									v1,
	input									v2,
	output			[1:0]				P,
	output								V
);
	assign			V			=			v1 | v2;
	assign			P[1]		=			(v1 == 1'b1) ? 1'b0 : (v2 == 1'b1) ? 1'b1 : 1'bx;
	assign			P[0]		=			(v1 == 1'b1) ? p1 : (v2 == 1'b1) ? p2 : 1'bx; 
endmodule
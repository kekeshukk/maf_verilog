//3-2加法器
module Tr_Tw_CSA_chip(
	input										x,
	input										y,
	input										z,
	output									s,
	output									c
);
	assign			s		=			x ^ y ^ z;
	assign			c		=			(x & y) | (x & z) | (y & z);
endmodule
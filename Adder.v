//48位超前进位加法器
module Adder(
	input			[48:0]					x,
	input			[47:0]					y,
	output		[47:0]					sum,
	output									cout
);
	wire			[6:0]					carry;
/*	assign			carry[0]			=			1'b0;
	assign			cout				=			carry[6] | x[48];
	genvar i;
	parameter ASIZE = 5;
	generate
		for(i = 0; i <= ASIZE; i = i + 1)begin:       fasta_final
			fasta fasa(
				.a										(x[(i+1)*8-1:i* 4 * 2]),
				.b										(y[(i+1)*8-1:i* 8]),
				.c_in									(carry[i]),
				.sum									(sum[(i+1)*8-1:i*8]),
				.c_out								(carry[i+1])	
			);
		end
	endgenerate*/
	wire 		[48:0]						temp;
	assign	temp		=	x + y;
	assign	sum 		= 	temp[47:0];
	assign	cout		= 	temp[48];
endmodule
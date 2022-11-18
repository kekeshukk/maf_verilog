module Csa42 #(width=64) (
	input [width-1:0] op1,
	input [width-1:0] op2,
	input [width-1:0] op3,
	input [width-1:0] op4,
	input [width-1:0] op5,
	
	output [width-1:0] S,
	output [width-1:0] Cout,
	output [width-1:0] C
);

genvar i;
generate
	for(i=0; i<width; i=i+1) begin:addr42
		Full_adder u_full_adder(
			.a      (   op1[i]    ),
			.b      (   op2[i]    ),
			.c      (   op3[i]    ),
			.d      (   op4[i]    ),
			.cin    (   op5[i]    ),
			
			.cout   (   Cout[i]	  ),
			.carry      (   C[i]     ),
			.s      (   S[i]      )
		);
	end
endgenerate

endmodule
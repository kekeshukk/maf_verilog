module Wallace_tree (
	 input [1023:0] prod0,
/*	 input [63:0] prod1,
	 input [63:0] prod[2],
	 input [63:0] prod[3],
	 input [63:0] prod[4],
	 input [63:0] prod[5],
	 input [63:0] prod[6],
	 input [63:0] prod[7],
	 input [63:0] prod[8],
	 input [63:0] prod[9],
	 input [63:0] prod[10],
	 input [63:0] prod[11],
	 input [63:0] prod[12],
	 input [63:0] prod[13],
	 input [63:0] prod[14],
	 input [63:0] prod[15],*/
	 input [63:0] spe_component
//    output [63:0] P
);


wire [63:0] s_lev01;
wire [63:0] c_lev01;
wire [63:0] cout_lev01;
wire [63:0] s_lev02;
wire [63:0] c_lev02;
wire [63:0] cout_lev02;
wire [63:0] s_lev03;
wire [63:0] c_lev03;
wire [63:0] cout_lev03;
wire [63:0] s_lev04;
wire [63:0] c_lev04;
wire [63:0] cout_lev04;
wire [63:0] s_lev11;
wire [63:0] c_lev11;
wire [63:0] cout_lev11;
wire [63:0] s_lev12;
wire [63:0] c_lev12;
wire [63:0] cout_lev12;

wire [63:0] s_lev21;
wire [63:0] c_lev21;
wire [63:0] s_lev31;
wire [63:0] c_lev31;

//level 0
Csa42 #(64) csa_lev01(
	  .op1( prod0[63:0]      ),
	  .op2( prod0[127:64] << 2 ),
	  .op3( prod0[191:128] << 4 ),
	  .op4( prod0[255:192] << 6 ),
	  .op5( 64'b0 ),
	  
	  .Cout( cout_lev01 ),
	  .S	( s_lev01      ),
	  .C	( c_lev01      )
);

Csa42 #(64) csa_lev02(
	  .op1( prod0[319:256] << 8 ),
	  .op2( prod0[383:320] << 10 ),
	  .op3( prod0[447:384] << 12 ),
	  .op4( prod0[511:448] << 14 ),
	  .op5( cout_lev01 ),
	  
	  .Cout( cout_lev02 ),
	  .S	( s_lev02      ),
	  .C	( c_lev02      )
);


Csa42 #(64) csa_lev03(
	  .op1( prod0[575:512] << 16  ),
	  .op2( prod0[639:576] << 18  ),
	  .op3( prod0[703:640] << 20 ),
	  .op4( prod0[767:704] << 22 ),
	  .op5( cout_lev02 ),
	  
	  .Cout( cout_lev03 ),
	  .S	( s_lev03      ),
	  .C	( c_lev03      )
);

Csa42 #(64) csa_lev04(
	  .op1( prod0[831:768] << 24 ),
	  .op2( prod0[895:832] << 26),
	  .op3( prod0[959:896] << 28),
	  .op4( prod0[1023:960] << 30 ),
	  .op5( cout_lev03 ),
	  
	  .Cout( cout_lev04 ),
	  .S	( s_lev04      ),
	  .C	( c_lev04      )
);

//level 1
Csa42 #(64) csa_lev11(
	.op1( s_lev01      ),
	.op2( c_lev01 << 1 ),
	.op3( s_lev02      ),
	.op4( c_lev02      ),
	.op5( 64'b0      ),
	
	.Cout( cout_lev11 ),
	.S	( s_lev11      ),
	.C	( c_lev11      )
);

Csa42 #(64) csa_lev12(
	.op1( s_lev03 ),
	.op2( c_lev03 << 1 ),
	.op3( s_lev04 << 1 ),
	.op4( c_lev04      ),
	.op5( cout_lev11   ),
	
	.Cout( cout_lev12 ),
	.S	( s_lev12),
	.C	( c_lev12)
);
//level 2
csa #(64) csa_lev21(
	.op1( spe_component ),
	.op2( s_lev11 << 1 ),
	.op3( c_lev11 << 1 ),
	.S	( s_lev21),
	.C	( c_lev21)
);

csa #(64) csa_lev22(
	.op1( s_lev12 ),
	.op2( c_lev12 << 1 ),
	.op3( spe_component << 1 ),
	.S	( s_lev21),
	.C	( c_lev21)
);
//adder
/*rca #(32) u_rca (
    .op1 ( s_lev31  ), 
    .op2 ( c_lev31 << 1  ),
    .cin ( 1'b0   ),
    .sum ( P      ),
    .cout(        )
);*/

endmodule

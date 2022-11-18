module Booth_top(
	input clk,
	input rst,
	input [22:0] A,
	input [22:0] B,
	input con,
	input error,
	output reg[63:0] P
);
wire [15:0] neg;
wire [15:0] zero;
wire [15:0] one;
wire [15:0] two;
wire [63:0] P0;
reg [31:0] Aw;
reg [31:0] Bw;
always @(posedge clk or negedge rst)begin
  if(!rst)
    P=64'b0;
  else if(!error)begin 
    if(con) begin
	   Aw<={9'b0,A[22:0]};
	   Bw<={9'b0,B[22:0]};
	 end
	 else begin
	   Aw<={22'b0,A[9:0]};
	   Bw<={22'b0,B[9:0]};
	 end
  end
  else P=64'b0;
end

genvar i;
generate 
  for(i=0; i<16; i=i+1)begin:enc1
    if(i==0)
	   Booth_enc u_Booth_enc(
		     .code ({Bw[1:0],1'b0}),
			  .neg  (neg[i]    ),
			  .zero (zero[i]   ),
			  .one  (one[i]	 ),
			  .two  (two[i]	 )
			  );
	 else
	   Booth_enc u_Booth_enc(
		     .code (Bw[i*2+1:i*2-1]),
			  .neg  (neg[i]    ),
			  .zero (zero[i]   ),
			  .one  (one[i]	 ),
			  .two  (two[i]	 )
			  );
  end
endgenerate

wire [63:0] prod[15:0];
generate 
	for(i=0; i<16; i=i+1)begin:gen1
		Gen_prod u_Gen_prod (
			.A    ( Aw       ),
			.neg  ( neg[i]  ),
			.zero ( zero[i] ),
			.one  ( one[i]  ),
			.two  ( two[i]  ),
			.prod ( prod[i] )
		);
	end
endgenerate

wire [1023:0] prod0;
assign prod0={prod[15],prod[14],prod[13],prod[12],prod[11],prod[10],prod[9],prod[8],prod[7],prod[6],prod[5],prod[4],prod[3],prod[2],prod[1],prod[0]};


 Wallace_tree u_watree(
    .prod0 (prod0),
	 .spe_component (spe_component),
    
//	 .P(P)

);

endmodule
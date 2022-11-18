`include"conf.v"
module MaF(
	input										clk,
	input										rstn,
	input			[2:0]						cont,
	input			[23:0]					M_in,
	input										s2_T4,
	output	reg[31:0]					result,
	input			[11:0]					E,
	input										s2h_T4
);
	always @(posedge clk or negedge rstn)begin
		if(!rstn)begin
			result				<=	 'b0;
		end else begin
			if(cont == 3'b0)begin
				result[31]			<=	#`PERIOD s2_T4;
				result[30:23]		<=	#`PERIOD	E[7:0] + 8'd127;
				result[22:0]		<=	#`PERIOD	M_in[22:0];
			end else if(cont == 3'b001)begin
				result[15]			<=	#`PERIOD s2_T4;
				result[31]			<=	#`PERIOD s2h_T4;
				result[30:26]		<=	#`PERIOD E[10:6] + 5'd15;
				result[25:16]		<=	#`PERIOD M_in[21:12];
				result[15]			<=	#`PERIOD s2h_T4;
				result[14:10]		<= #`PERIOD E[5:0] + 5'd15;
				result[9:0]			<=	#`PERIOD M_in[9:0];
			end else if(cont == 3'b010)begin
				result[31]			<=	#`PERIOD s2_T4;
				result[30:23]		<=	#`PERIOD E[7:0] + 8'd127;
				result[22:0]		<=	#`PERIOD M_in[22:0];
			end else begin
				result[31]			<=	#`PERIOD 'b0;
				result[30:23]		<=	#`PERIOD 8'b0;
				result[22:0]		<=	#`PERIOD 8'b0;
			end
		end
	end
endmodule
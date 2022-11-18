`include "conf.v"
module T4_2_reg(
	input										clk,
	input										rstn,
	input			[2:0]						cont,
	input			[9:0]						P,
	input			[1:0]						V,
	input			[73:0]					p_reg_temp,
	input			[1:0]						revising,
	output	reg[9:0]						sh_num,
	output	reg[1:0]						esh,
	output	reg[73:0]					p_reg,
	output	reg[1:0]						revi
);
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			sh_num	<=	#`PERIOD 10'b0;
			p_reg		<=	#`PERIOD 74'b0;
			esh		<= #`PERIOD 2'b0;
			revi		<=	#`PERIOD 2'b0;
		end else begin
			p_reg		<=	#`PERIOD p_reg_temp;
			sh_num	<=	#`PERIOD P;
			esh		<=	#`PERIOD V;
			revi		<=	#`PERIOD revising;
		end
	end
endmodule
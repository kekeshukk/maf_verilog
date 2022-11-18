`include  "conf.v"
//这里移位补符号位应该看的是signal和signal_h,即Sc
module Shifting(
	input					[75:0]			sh_in_reg,
	input					[2:0]				cont,
	input					[11:0]			sh_num,
	output	reg		[75:0]			sh_out_reg
);
//	wire										signal;
//	wire										signal_h;
	always @(/*posedge clk or negedge rstn*/*)begin
		if(cont == 3'b000) begin
			sh_out_reg				=			sh_in_reg >> sh_num;
		end
		else if(cont == 3'b001)begin
			sh_out_reg[75:37]		=			{1'b0,sh_in_reg[74:38]>>sh_num[11:6],1'b0};
			sh_out_reg[36:0]		=				sh_in_reg[36:0] >> sh_num[5:0];
		end
		else if(cont == 3'b010)begin
			sh_out_reg				=			sh_in_reg>>sh_num;
		end
		else begin
			sh_out_reg           =			76'b0;
		end
	end
endmodule
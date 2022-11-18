//c取反
`include "conf.v"
module Reverse(
	input										clk,
	input										rstn,
	input				[2:0]					cont,
	input				[75:0]				sh_reg,
	input										S_A,
	input										S_A_H,
	input										S_B,
	input										S_B_H,
	input										S_C,
	input										S_C_H,
	output	reg	[73:0]				sh_rev_reg,
	output	reg	[3:0]					sti//粘贴位,，模式1，3中后半存储，模式2中前半存高位，后半低
);
	//是否对c取反
	wire										signal;
	wire										signal_h;
	assign		signal   =     (!S_A && !S_B && S_C) || (!S_A && S_B && !S_C) || (S_A && S_B && S_C) || (S_A && !S_B && !S_C);
	assign		signal_h =     (!S_A_H && !S_B_H && S_C_H) || (!S_A_H && S_B_H && !S_C_H) || (S_A_H && S_B_H && S_C_H) || (S_A_H && !S_B_H && !S_C_H);
	always @(posedge clk)begin	
		sh_rev_reg			<=	#`PERIOD	74'b0;
		sti					<=	#`PERIOD	4'b0;
		if(cont == 3'b000)begin
			if(signal == 1'b1)begin
				sh_rev_reg  <= #`PERIOD	~sh_reg[75:2];
				sti[1:0]			<=	#`PERIOD	~sh_reg[1:0];
			end else begin
				sh_rev_reg	<=	#`PERIOD	sh_reg[75:2];
				sti[1:0]			<=	#`PERIOD	sh_reg[1:0];
			end
		end else if(cont == 3'b001) begin
			if(signal == 1'b1)begin
				sh_rev_reg[34:0]	<=	#`PERIOD	~sh_reg[36:2];
				sti[1:0]				<=	#`PERIOD	~sh_reg[1:0];
			end else begin
				sh_rev_reg[34:0]	<=	#`PERIOD	sh_reg[36:2];
				sti[1:0]				<=	#`PERIOD	sh_reg[1:0];
			end
			if(signal_h == 1'b1)begin
				sh_rev_reg[73:35]	<=	#`PERIOD	{4'b0,~sh_reg[74:40]};
				sti[3:2]				<=	#`PERIOD	~sh_reg[39:38];
			end 
			else begin
				sh_rev_reg[73:35]	<=	#`PERIOD	{4'b0,sh_reg[74:40]};
				sti[1:0]					<=	#`PERIOD	sh_reg[39:38];
			end
		end
		else if(cont == 3'b010)begin
			if(signal == 1'b1)begin
				sh_rev_reg			<=	#`PERIOD	{~sh_reg[75:28],26'b0};
				sti[1:0]				<=	#`PERIOD	~sh_reg[27:26];
			end
			else begin
				sh_rev_reg			<=	#`PERIOD	{sh_reg[75:28],26'b0};
				sti[1:0]				<=	#`PERIOD	sh_reg[27:26];
			end
		end else begin
			sh_rev_reg				<=	#`PERIOD	74'b0;
			sti						<=	#`PERIOD	4'b0;
		end
	end
endmodule
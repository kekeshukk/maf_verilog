`include "conf.v" 
module Shift_reg( 
	input				[2:0]					cont,//状态控制变量
	input										clk,
	input										rstn,
	input				[23:0]				M_C,//模式2中靠后的
	output	reg	[75:0]				sh_reg//移位寄存器,每种模式中的最低两位是粘贴位。
	
);
	wire				[10:0]	M_C_H;
	wire				[10:0]	M_C_L;
	assign	M_C_H 	=		M_C[21:11];
	assign	M_C_L    =     M_C[10:0];
	//自己定义的移位寄存器；
	always @(posedge clk or negedge rstn)begin
		if(!rstn)begin
			sh_reg				<=	#`PERIOD 76'b0;
		end else begin
			if(cont == 3'b000)begin
				sh_reg				<= #`PERIOD	{M_C,2'b0,48'b0,2'b0};
			end
			else if(cont == 3'b001) begin
				sh_reg				<=	#`PERIOD	{1'b0,M_C_H,2'b0,11'b0,11'b0,1'b0,1'b0,1'b0,M_C_L,2'b0,11'b0,11'b0,2'b0};
			end	
			else if(cont == 3'b010)begin
				sh_reg				<= #`PERIOD	{M_C,2'b0,11'b0,11'b0,2'b0,26'b0};
			end
			else begin
				sh_reg       		<=	#`PERIOD	{76 * {1'd0}};
			end
		end
	end 
endmodule

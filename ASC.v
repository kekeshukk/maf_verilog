`include "conf.v"
module ASC(
	input				[2:0]					cont,
	input										clk,
	input										rstn,
	input		signed[13:0]				E_A,
	input		signed[13:0]				E_B,
	input		signed[13:0]				E_C,
	output	reg	[11:0]				sh_num,//模式1，模式2，模式3
	output	signed[11:0]				d//阶差的正负,1:0
);
	/*
	h代表高l代表低
	*/
	wire		signed[6:0]					E_A_H;
	wire		signed[6:0]					E_A_L;
	wire		signed[6:0]					E_B_H;
	wire		signed[6:0]					E_B_L;
	wire		signed[6:0]					E_C_H;
	wire		signed[6:0]					E_C_L;
	wire     signed[5:0]					sh_temp_num_0;//模式2的低
	wire		signed[5:0]					sh_temp_num_1;//模式2的高
	wire		signed[13:0]				temp_d;//真的阶差	
	assign	E_A_H = E_A[13:7];
	assign	E_A_L	= E_A[6:0];
	assign	E_B_L = E_B[6:0];
	assign	E_B_H = E_B[13:7];
	assign	E_C_H = E_C[13:7];
	assign   E_C_L = E_C[6:0];
	assign	sh_temp_num_0 = ($signed(E_B_L + E_A_L - E_C_L - $signed({1'b0,1'd1})) > $signed(7'd37)) ? 7'd37 : $signed(E_B_L + E_A_L - E_C_L - $signed({1'b0,1'd1})) >= 0 ? E_B_L + E_A_L - E_C_L - $signed({1'b0,1'd1}) : 7'b0;
	assign	sh_temp_num_1 = ($signed(E_B_H + E_A_H - E_C_H - $signed({1'b0,1'd1})) > $signed(7'd37)) ? 7'd37 : $signed(E_B_H + E_A_H - E_C_H - $signed({1'b0,1'd1})) >= 0 ? E_B_H + E_A_H - E_C_H - $signed({1'b0,1'd1}) : 7'b0;
	assign	temp_d		  =			cont == 3'b001 ? {(E_C_H - E_B_H - E_A_H + $signed(7'd15)),(E_C_L - E_B_L - E_A_L + $signed(7'd15))} 
												 : cont == 3'b000 ? (E_C - E_A - E_B + $signed(10'd127)) : cont == 3'b010 ? (E_C - E_A_L - E_B_L - $signed(10'd97)) : 14'b0; 
	assign   d[0]          =         (cont == 3'b000 || cont == 3'b010) ? (temp_d == 'b0 ? 1'b1 : temp_d[9]) : (temp_d[6:0] == 'b0) ? 1'b1 :temp_d[6];
	assign	d[1]			  =			(cont == 3'b001) ? (temp_d[13:7] == 'b0 ? 1'b1 : temp_d[13] ): 1'b0;
	assign   d[10:2]       =          9'b0;
	assign   d[11]          =          'b0;
	always @(posedge clk or negedge rstn)begin
		if(!rstn)begin
			sh_num			<=			#`PERIOD 12'b0;	
		end else begin
			sh_num			<=	#`PERIOD		12'b0;
			if(cont == 3'b001)begin
				sh_num			<=	#`PERIOD		{sh_temp_num_1,sh_temp_num_0};
			end else if(cont == 3'b000)begin
				if($signed(E_A+E_B-E_C- $signed(10'd100)) > $signed(10'd76))begin
					sh_num			<=	#`PERIOD	12'd76;
				end else if($signed(E_A+E_B-E_C- $signed(10'd100)) >= 2'd0)begin
					sh_num			<=	#`PERIOD $signed(E_A+E_B-E_C- $signed(10'd100));
				end
			end else if(cont == 3'b010)begin
				if($signed(E_A_L + E_B_L - E_C + $signed(10'd124)) > $signed(12'd50))begin
					sh_num			<=	#`PERIOD 12'd50;
				end else if($signed(E_A_L + E_B_L - E_C + $signed(10'd124)) > 2'd0)begin
					sh_num			<=	#`PERIOD $signed(E_A_L + E_B_L - E_C + $signed(10'd124));
				end
			end
		end
	end
endmodule

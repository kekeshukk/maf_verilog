//尾数结果,要符号
module CAL(
	input	signed[73:0]					sh_reg_T4_1,
	input	signed[47:0]					sum,
	input										cin,
	input			[2:0]						cont,
   input										S_A,
	input										S_B,
	input										S_C,
	input										S_A_H,
	input										S_B_H,
	input										S_C_H,
	output	reg[74:0]					p_reg_temp//反相器前身
);
	reg										signal;
	reg										signal_h;
	wire			[25:0]					M_C;
	assign		M_C			=			(cont == 3'b0 || cont == 3'b010) ? sh_reg_T4_1[73:48] : (cont == 3'b001) ? {sh_reg_T4_1[69:57],sh_reg_T4_1[34:22]} : 26'b0;
	always@(*)begin
		signal   =     (!S_A && !S_B && S_C) || (!S_A && S_B && !S_C) || (S_A && S_B && S_C) || (S_A && !S_B && !S_C);
		signal_h =     (!S_A_H && !S_B_H && S_C_H) || (!S_A_H && S_B_H && !S_C_H) || (S_A_H && S_B_H && S_C_H) || (S_A_H && !S_B_H && !S_C_H);
		if(cont == 3'd0)begin
			p_reg_temp[74:48]			=			$signed({signal,M_C}) + $signed({1'b0,cin});
			p_reg_temp[47:0]		 	=			sum; 
		end else 
		if(cont == 3'b001) begin
			p_reg_temp[74:73]       =        2'b0;
			p_reg_temp[72:59]			=			$signed({signal_h,M_C[25:13]}) + $signed({1'b0,sum[45]});
			p_reg_temp[58:37]			=			sum[44:23];
			p_reg_temp[36]			   =			'd0;
		
			p_reg_temp[35:22]       =        $signed({signal,M_C[12:0]}) + $signed({1'b0,sum[22]});
			p_reg_temp[21:0]        =			sum[21:0];
		end else if(cont == 3'b010)begin
			p_reg_temp[74:48]       =	     $signed({signal,M_C}) + $signed({1'b0,sum[22]});
			p_reg_temp[47:26]       =       sum[21:0];
			p_reg_temp[25:0]        =       26'b0;
		end else begin
			p_reg_temp = 75'b0;
		end
	end
endmodule
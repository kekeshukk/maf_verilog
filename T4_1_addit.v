module T4_1_addit(
	//输入
	input			[2:0]						cont_T3_2,
	input			[73:0]					sh_reg_T3_2,
	input										S_A_T3_2,
	input										S_B_T3_2,
	input										S_C_T3_2,
	input										S_A_H_T3_2,
	input										S_B_H_T3_2,
	input										S_C_H_T3_2,
	input			[11:0]					d_T3_2,
	//输出
	output		[25:0]					sh_left,
	output		[47:0]					sh_right,
	output									signal,
	output									signal_h,
	output		[1:0]						d_s
);
	assign		sh_left			=			(cont_T3_2 == 3'b0 || cont_T3_2 == 3'b010) ? sh_reg_T3_2[73:48] : (cont_T3_2 == 3'b001) ? {sh_reg_T3_2[69:57],sh_reg_T3_2[34:22]} : 26'b0;
	assign		sh_right			=			(cont_T3_2 == 3'b0) ? sh_reg_T3_2[47:0] : (cont_T3_2 == 3'b001) ? {3'b0,sh_reg_T3_2[56:35],1'b0,sh_reg_T3_2[21:0]} 
														: (cont_T3_2 == 3'b010) ? {3'b0,22'b0,1'b0,sh_reg_T3_2[47:26]} : {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,40'b0};  
	assign		signal			=			(!S_A_T3_2 && !S_B_T3_2 && S_C_T3_2) || (!S_A_T3_2 && S_B_T3_2 && !S_C_T3_2) || (S_A_T3_2 && S_B_T3_2 && S_C_T3_2) || (S_A_T3_2 && !S_B_T3_2 && !S_C_T3_2);
	assign		signal_h			=			(!S_A_H_T3_2 && !S_B_H_T3_2 && S_C_H_T3_2) || (!S_A_H_T3_2 && S_B_H_T3_2 && !S_C_H_T3_2) || (S_A_H_T3_2 && S_B_H_T3_2 && S_C_H_T3_2) || (S_A_H_T3_2 && !S_B_H_T3_2 && !S_C_H_T3_2);
	assign		d_s[1:0]         =        d_T3_2[1:0];

endmodule
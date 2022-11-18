//纠错树前面
module Revising_1(
	input			[2:0]						cont,
	input			[55:0]					GP_p,
	input			[55:0]					GP_n,
	input			[55:0]					GP_z,
	input			[55:0]					GN_p,
	input			[55:0]					GN_n,
	input			[55:0]					GN_z,
	input										S_A,
	input										S_B,
	input										S_C,
	input										S_A_H,
	input										S_B_H,
	input										S_C_H,
//	output		[1:0]						revising//修正位,修正有效,首1右移1位,左侧高位,右侧低位
	output		[11:0]						levelp_4_out,
	output		[11:0]						leveln_4_out
);
	wire										signal;
	wire										signal_h;
	/* 各种编码情况，主要有：0:Z,1:P,2:N,3:Y,4:U */
	wire			[2:0]						levelp_1[27:0],leveln_1[27:0];//第一级输出
	wire			[2:0]						levelp_2[13:0],leveln_2[13:0];//第二级输出
	wire			[2:0]						levelp_3[6:0],leveln_3[6:0];//第三级输出
	reg			[2:0]						levelp_4[3:0],leveln_4[3:0];//第四级输出//这里直接输出，划分流水线
//	wire			[2:0]						levelp_5[1:0],leveln_5[1:0];//第五级输出
//	reg			[2 : 0]					levelp_6,leveln_6;//第六级输出
	/*最终的检测结果*/
//	reg			[1:0]						Y_P;//左侧表示高位，右侧低位
//	reg			[1:0]						Y_N;
//	reg			[1:0]						N_P;
	reg			[1:0]						index;
	genvar i;
	assign 		levelp_4_out[2:0]			=			levelp_4[0];
	assign 		levelp_4_out[5:3]			=			levelp_4[1];
	assign 		levelp_4_out[8:6]			=			levelp_4[2];
	assign 		levelp_4_out[11:9]		=			levelp_4[3];

	assign 		leveln_4_out[2:0]			=			leveln_4[0];
	assign 		leveln_4_out[5:3]			=			leveln_4[1];
	assign 		leveln_4_out[8:6]			=			leveln_4[2];
	assign 		leveln_4_out[11:9]		=			leveln_4[3];
//	assign		signal   =     (!S_A && !S_B && S_C) || (!S_A && S_B && !S_C) || (S_A && S_B && S_C) || (S_A && !S_B && !S_C);
//	assign		signal_h =     (!S_A_H && !S_B_H && S_C_H) || (!S_A_H && S_B_H && !S_C_H) || (S_A_H && S_B_H && S_C_H) || (S_A_H && !S_B_H && !S_C_H);
//	assign      revising[0] =	(signal & (Y_P[0] | Y_N[0])) | ((~signal) &	N_P[0]);//这里最后加不加z存疑******
//	assign 		revising[1] =  (signal_h & (Y_P[1] | Y_P[0])) | ((~signal_h) & N_P[1]);
	/*positive tree(7 levels)*/
	/*initial level to first level*/
	generate
		for(i = 0; i <= 27; i = i + 1)begin:level_revising_1_p
			assign			levelp_1[i]			=			(GP_n[i * 2 + 1] == 1'b1 || (GP_z[i * 2 + 1] == 1'b1 && GP_n[i * 2] == 1'b1)) ? 3'b010 :
																		(GP_z[i * 2 + 1] == 1'b1 && GP_z[i * 2] == 1'b1) ? 3'b000 : ((GP_z[i * 2 + 1] == 1'b1 && GP_p[i * 2] == 1'b1) 
																			|| (GP_p[i * 2 + 1] == 1'b1 && GP_z[i * 2] == 1'b1)) ? 3'b001 : GP_p[i * 2 + 1] == 1'b1 && GP_n[i * 2] == 1'b1 ? 3'b011 : 3'b 100;
		end
	endgenerate
	/*initial level to second level*/
	generate
		for(i = 0; i <= 13; i = i + 1)begin:level_revising_2_p
			assign		levelp_2[i]          =			(levelp_1[i * 2 + 1] == 3'd0 && levelp_1[i * 2] == 3'd0) ? 3'd0
																		: ((levelp_1[i * 2 + 1] == 3'd0 && levelp_1[i * 2] == 3'd1) || (levelp_1[i * 2 + 1] == 3'd1 && levelp_1[i * 2] == 3'd0))
																						?	3'd1 : ((levelp_1[i * 2 + 1] == 3'd2) || (levelp_1[i * 2 + 1] == 3'b0 && levelp_1[i * 2] == 3'b010)) ? 3'd2
																													: ((levelp_1[i * 2 + 1] == 3'd3) || (levelp_1[i * 2 + 1] == 3'd0 && levelp_1[i * 2] == 3'd3) 
																																			|| (levelp_1[i * 2 + 1] == 3'b001 &&levelp_1[i * 2] == 3'd2)) ? 3'd3 : 3'd4;
		end
	endgenerate
	/*initial level to third level*/
	generate
		for(i = 0; i <= 6; i = i + 1)begin:level_revising_3_p
			assign		levelp_3[i]          =			(levelp_2[i * 2 + 1] == 3'd0 && levelp_2[i * 2] == 3'd0) ? 3'd0
																		: ((levelp_2[i * 2 + 1] == 3'd0 && levelp_2[i * 2] == 3'd1) || (levelp_2[i * 2 + 1] == 3'd1 && levelp_2[i * 2] == 3'd0))
																						?	3'd1 : ((levelp_2[i * 2 + 1] == 3'd2) || (levelp_2[i * 2 + 1] == 3'b0 && levelp_2[i * 2] == 3'b010)) ? 3'd2
																													: ((levelp_2[i * 2 + 1] == 3'd3) || (levelp_2[i * 2 + 1] == 3'd0 && levelp_2[i * 2] == 3'd3) 
																																			|| (levelp_2[i * 2 + 1] == 3'b001 &&levelp_2[i * 2] == 3'd2)) ? 3'd3 : 3'd4;

		end
	endgenerate
	/*initial level to forth level*/
	always@(*)begin
		index = 2'd0;
		if(cont == 3'b000 || cont == 3'b010)begin
			for(index = 2'd0; index <= 2'd2; index = index + 2'd1)begin
				if(levelp_3[index * 2 + 1] == 3'd0 && levelp_3[index * 2] == 3'd0)begin
					levelp_4[index] = 3'd0;
				end else if ((levelp_3[index * 2 + 1] == 3'd1 && levelp_3[index * 2] == 3'd0) 
							|| (levelp_3[index * 2 + 1] == 3'd0 && levelp_3[index * 2] == 3'd1))begin
					levelp_4[index] = 3'd1;
				end else if((levelp_3[index * 2 + 1] == 3'd2) || (levelp_3[index * 2 + 1] == 3'd0 && levelp_3[index * 2] == 3'd2))begin
					levelp_4[index] = 3'd2;
				end else if(levelp_3[index * 2 + 1] == 3'd3 || (levelp_3[index * 2 + 1] == 3'd0 && levelp_3[index * 2] == 3'd3)
																	|| (levelp_3[index * 2 + 1] == 3'd1 && levelp_3[index * 2] == 3'd2))begin
					levelp_4[index] = 3'd3;
				end else begin
					levelp_4[index] = 3'd4;
				end
			end
			levelp_4[3] = levelp_3[6];
		end else begin
			/*处理高位的并行半精度编码，只结合低两位*/
			if(levelp_3[5] == 3'd0 && levelp_3[4] == 3'd0)begin
				levelp_4[2] = 3'd0;
			end else if ((levelp_3[5] == 3'd1 && levelp_3[4] == 3'd0) 
								|| (levelp_3[5] == 3'd0 && levelp_3[4] == 3'd1))begin
				levelp_4[2] = 3'd1;
			end else if((levelp_3[5] == 3'd2) || (levelp_3[5] == 3'd0 && levelp_3[4] == 3'd2))begin
				levelp_4[2] = 3'd2;
			end else if(levelp_3[5] == 3'd3 || (levelp_3[5] == 3'd0 && levelp_3[4] == 3'd3)
																		|| (levelp_3[5] == 3'd1 && levelp_3[4] == 3'd2))begin
				levelp_4[2] = 3'd3;
			end else begin
				levelp_4[2] = 3'd4;
			end
			/*处理低位的并行半精度编码，只结合低两位*/
			if(levelp_3[1] == 3'd0 && levelp_3[0] == 3'd0)begin
				levelp_4[0] = 3'd0;
			end else if ((levelp_3[1] == 3'd1 && levelp_3[0] == 3'd0) 
								|| (levelp_3[1] == 3'd0 && levelp_3[0] == 3'd1))begin
				levelp_4[0] = 3'd1;
			end else if((levelp_3[1] == 3'd2) || (levelp_3[1] == 3'd0 && levelp_3[0] == 3'd2))begin
				levelp_4[0] = 3'd2;
			end else if(levelp_3[1] == 3'd3 || (levelp_3[1] == 3'd0 && levelp_3[0] == 3'd3)
																		|| (levelp_3[1] == 3'd1 && levelp_3[0] == 3'd2))begin
				levelp_4[0] = 3'd3;
			end else begin
				levelp_4[0] = 3'd4;
			end
			/*处理低编码的左侧位置*/
			levelp_4[1] = levelp_3[2];
			/*处理高编码的左侧位置*/
			levelp_4[3] = levelp_3[6];
		end
	end
	
//	/*initial level to fifth level*/
//	generate
//		for(i = 0; i <= 1; i = i + 1)begin:level_revising_5_p
//			assign		levelp_5[i]          =			(levelp_4[i * 2 + 1] == 3'd0 && levelp_4[i * 2] == 3'd0) ? 3'd0
//																		: ((levelp_4[i * 2 + 1] == 3'd0 && levelp_4[i * 2] == 3'd1) || (levelp_4[i * 2 + 1] == 3'd1 && levelp_4[i * 2] == 3'd0))
//																						?	3'd1 : ((levelp_4[i * 2 + 1] == 3'd2) || (levelp_4[i * 2 + 1] == 3'b0 && levelp_4[i * 2] == 3'b010)) ? 3'd2
//																													: ((levelp_4[i * 2 + 1] == 3'd3) || (levelp_4[i * 2 + 1] == 3'd0 && levelp_4[i * 2] == 3'd3) 
//																																			|| (levelp_4[i * 2 + 1] == 3'b001 &&levelp_4[i * 2] == 3'd2)) ? 3'd3 : 3'd4;
//		end
//	endgenerate
//	/*initial level to sixth level && revise*/
//	always@(*)begin
//		levelp_6 = 3'd0;
//		if(cont == 3'b000 || cont == 3'b010)begin
//			if(levelp_5[1] == 3'd0 && levelp_5[0] == 3'd0)begin
//				levelp_6 = 3'd0;
//			end else if ((levelp_5[1] == 3'd1 && levelp_5[0] == 3'd0) 
//							|| (levelp_5[1] == 3'd0 && levelp_5[0] == 3'd1))begin
//				levelp_6 = 3'd1;
//			end else if((levelp_5[1]== 3'd2) || (levelp_5[1] == 3'd0 && levelp_5[0] == 3'd2))begin
//				levelp_6 = 3'd2;
//			end else if(levelp_5[1] == 3'd3 || (levelp_5[1]== 3'd0 && levelp_5[0] == 3'd3)
//																	|| (levelp_5[1] == 3'd1 && levelp_5[0] == 3'd2))begin
//				levelp_6 = 3'd3;
//			end else begin
//				levelp_6 = 3'd4;
//			end
//			Y_P[0] = (levelp_6 == 3'd3);
//			N_P[0]   = (levelp_6 == 3'd2);
//			Y_P[1] = 'b0;N_P[1] = 'b0;
//		end else begin
//			Y_P[1] = (levelp_5[1] == 3'd3);
//			N_P[1]   = (levelp_5[1] == 3'd2);
//			Y_P[0] = (levelp_5[0] == 3'd3);
//			N_P[0]   = (levelp_5[0] == 3'd2);
//		end
//	end
	/*neg tree(7 levels)*/
	/*initial level to first level*/
	generate
		for(i = 0; i <= 27; i = i + 1)begin:level_revising_1_n
			assign			leveln_1[i]			=			(GN_n[i * 2 + 1] == 1'b1 || (GN_z[i * 2 + 1] == 1'b1 && GN_n[i * 2] == 1'b1)) ? 3'b010 :
																		(GN_z[i * 2 + 1] == 1'b1 && GN_z[i * 2] == 1'b1) ? 3'b000 : ((GN_z[i * 2 + 1] == 1'b1 && GN_p[i * 2] == 1'b1) 
																			|| (GN_p[i * 2 + 1] == 1'b1 && GN_z[i * 2] == 1'b1)) ? 3'b001 : GN_p[i * 2 + 1] == 1'b1 && GN_n[i * 2] == 1'b1 ? 3'b011 : 3'b 100;
		end
	endgenerate
	/*initial level to second level*/
	generate
		for(i = 0; i <= 13; i = i + 1)begin:level_revising_2_n
			assign		leveln_2[i]          =			(leveln_1[i * 2 + 1] == 3'd0 && leveln_1[i * 2] == 3'd0) ? 3'd0
																		: ((leveln_1[i * 2 + 1] == 3'd0 && leveln_1[i * 2] == 3'd1) || (leveln_1[i * 2 + 1] == 3'd1 && leveln_1[i * 2] == 3'd0))
																						?	3'd1 : ((leveln_1[i * 2 + 1] == 3'd2) || (leveln_1[i * 2 + 1] == 3'b0 && leveln_1[i * 2] == 3'b010)) ? 3'd2
																													: ((leveln_1[i * 2 + 1] == 3'd3) || (leveln_1[i * 2 + 1] == 3'd0 && leveln_1[i * 2] == 3'd3) 
																																			|| (leveln_1[i * 2 + 1] == 3'b001 &&leveln_1[i * 2] == 3'd2)) ? 3'd3 : 3'd4;
		end
	endgenerate
	/*initial level to third level*/
	generate
		for(i = 0; i <= 6; i = i + 1)begin:level_revising_3_n
			assign		leveln_3[i]          =			(leveln_2[i * 2 + 1] == 3'd0 && leveln_2[i * 2] == 3'd0) ? 3'd0
																		: ((leveln_2[i * 2 + 1] == 3'd0 && leveln_2[i * 2] == 3'd1) || (leveln_2[i * 2 + 1] == 3'd1 && leveln_2[i * 2] == 3'd0))
																						?	3'd1 : ((leveln_2[i * 2 + 1] == 3'd2) || (leveln_2[i * 2 + 1] == 3'b0 && leveln_2[i * 2] == 3'b010)) ? 3'd2
																													: ((leveln_2[i * 2 + 1] == 3'd3) || (leveln_2[i * 2 + 1] == 3'd0 && leveln_2[i * 2] == 3'd3) 
																																			|| (leveln_2[i * 2 + 1] == 3'b001 &&leveln_2[i * 2] == 3'd2)) ? 3'd3 : 3'd4;

		end
	endgenerate
	/*initial level to forth level*/
	always@(*)begin
		if(cont == 3'b000 || cont == 3'b010)begin
			for(index = 2'd0; index <= 2'd2; index = index + 2'd1)begin
				if(leveln_3[index * 2 + 1] == 3'd0 && leveln_3[index * 2] == 3'd0)begin
					leveln_4[index] = 3'd0;
				end else if ((leveln_3[index * 2 + 1] == 3'd1 && leveln_3[index * 2] == 3'd0) 
							|| (leveln_3[index * 2 + 1] == 3'd0 && leveln_3[index * 2] == 3'd1))begin
					leveln_4[index] = 3'd1;
				end else if((leveln_3[index * 2 + 1] == 3'd2) || (leveln_3[index * 2 + 1] == 3'd0 && leveln_3[index * 2] == 3'd2))begin
					leveln_4[index] = 3'd2;
				end else if(leveln_3[index * 2 + 1] == 3'd3 || (leveln_3[index * 2 + 1] == 3'd0 && leveln_3[index * 2] == 3'd3)
																	|| (leveln_3[index * 2 + 1] == 3'd1 && leveln_3[index * 2] == 3'd2))begin
					leveln_4[index] = 3'd3;
				end else begin
					leveln_4[index] = 3'd4;
				end
			end
			leveln_4[3] = leveln_3[6];
		end else begin
			/*处理高位的并行半精度编码，只结合低两位*/
			if(leveln_3[5] == 3'd0 && leveln_3[4] == 3'd0)begin
				leveln_4[2] = 3'd0;
			end else if ((leveln_3[5] == 3'd1 && leveln_3[4] == 3'd0) 
								|| (leveln_3[5] == 3'd0 && leveln_3[4] == 3'd1))begin
				leveln_4[2] = 3'd1;
			end else if((leveln_3[5] == 3'd2) || (leveln_3[5] == 3'd0 && leveln_3[4] == 3'd2))begin
				leveln_4[2] = 3'd2;
			end else if(leveln_3[5] == 3'd3 || (leveln_3[5] == 3'd0 && leveln_3[4] == 3'd3)
																		|| (leveln_3[5] == 3'd1 && leveln_3[4] == 3'd2))begin
				leveln_4[2] = 3'd3;
			end else begin
				leveln_4[2] = 3'd4;
			end
			/*处理低位的并行半精度编码，只结合低两位*/
			if(leveln_3[1] == 3'd0 && leveln_3[0] == 3'd0)begin
				leveln_4[0] = 3'd0;
			end else if ((leveln_3[1] == 3'd1 && leveln_3[0] == 3'd0) 
								|| (leveln_3[1] == 3'd0 && leveln_3[0] == 3'd1))begin
				leveln_4[0] = 3'd1;
			end else if((leveln_3[1] == 3'd2) || (leveln_3[1] == 3'd0 && leveln_3[0] == 3'd2))begin
				leveln_4[0] = 3'd2;
			end else if(leveln_3[1] == 3'd3 || (leveln_3[1] == 3'd0 && leveln_3[0] == 3'd3)
																		|| (leveln_3[1] == 3'd1 && leveln_3[0] == 3'd2))begin
				leveln_4[0] = 3'd3;
			end else begin
				leveln_4[0] = 3'd4;
			end
			/*处理低编码的左侧位置*/
			leveln_4[1] = leveln_3[2];
			/*处理高编码的左侧位置*/
			leveln_4[3] = leveln_3[6];
		end
	end
//	/*initial level to fifth level*/
//	generate
//		for(i = 0; i <= 1; i = i + 1)begin:level_revising_5_n
//			assign		leveln_5[i]          =			(leveln_4[i * 2 + 1] == 3'd0 && leveln_4[i * 2] == 3'd0) ? 3'd0
//																		: ((leveln_4[i * 2 + 1] == 3'd0 && leveln_4[i * 2] == 3'd1) || (leveln_4[i * 2 + 1] == 3'd1 && leveln_4[i * 2] == 3'd0))
//																						?	3'd1 : ((leveln_4[i * 2 + 1] == 3'd2) || (leveln_4[i * 2 + 1] == 3'b0 && leveln_4[i * 2] == 3'b010)) ? 3'd2
//																													: ((leveln_4[i * 2 + 1] == 3'd3) || (leveln_4[i * 2 + 1] == 3'd0 && leveln_4[i * 2] == 3'd3) 
//																																			|| (leveln_4[i * 2 + 1] == 3'b001 &&leveln_4[i * 2] == 3'd2)) ? 3'd3 : 3'd4;
//		end
//	endgenerate
//	/*initial level to sixth level && revise*/
//	always@(*)begin
//		if(cont == 3'b000 || cont == 3'b010)begin
//			if(leveln_5[1] == 3'd0 && leveln_5[0] == 3'd0)begin
//				leveln_6 = 3'd0;
//			end else if ((leveln_5[1] == 3'd1 && leveln_5[0] == 3'd0) 
//							|| (leveln_5[1] == 3'd0 && leveln_5[0] == 3'd1))begin
//				leveln_6 = 3'd1;
//			end else if((leveln_5[1]== 3'd2) || (leveln_5[1] == 3'd0 && leveln_5[0] == 3'd2))begin
//				leveln_6 = 3'd2;
//			end else if(leveln_5[1] == 3'd3 || (leveln_5[1]== 3'd0 && leveln_5[0] == 3'd3)
//																	|| (leveln_5[1] == 3'd1 && leveln_5[0] == 3'd2))begin
//				leveln_6 = 3'd3;
//			end else begin
//				leveln_6 = 3'd4;
//			end
//			Y_N[0] = (leveln_6 == 3'd3);Y_N[1] = 1'b0;
//		end else begin
//			Y_N[1] = (leveln_5[1] == 3'd3);
//			Y_N[0] = (leveln_5[0] == 3'd3);
//		end
//	end
endmodule
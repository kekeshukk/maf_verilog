//后半部分之二
module LeadingZeroAnt_3(
	//输入
	input										S_A,
	input										S_B,
	input										S_C,
	input										S_A_H,
	input										S_B_H,
	input										S_C_H,
	input			[2:0]						cont,
	input			[11:0]					levelp_4,
	input			[11:0]					leveln_4,
	//输出
	output		[1:0]						revising
);

//	wire			[9:0]						p_temp;
//	wire			[1:0]						v_temp;
//	wire			[31:0]					F_left;
	wire										signal;
	wire										signal_h;
	reg			[1:0]						Y_P;
	reg			[1:0]						Y_N;
	reg			[1:0]						N_P;
	wire			[2:0]						levelp_5[1:0],leveln_5[1:0];//第五级输出
	reg			[2 : 0]					levelp_6,leveln_6;//第六级输出
	assign		signal   =     (!S_A && !S_B && S_C) || (!S_A && S_B && !S_C) || (S_A && S_B && S_C) || (S_A && !S_B && !S_C);
	assign		signal_h =     (!S_A_H && !S_B_H && S_C_H) || (!S_A_H && S_B_H && !S_C_H) || (S_A_H && S_B_H && S_C_H) || (S_A_H && !S_B_H && !S_C_H);
	assign      revising[0] =	(signal & (Y_P[0] | Y_N[0])) | ((~signal) &	N_P[0]);//这里最后加不加z存疑******
	assign 		revising[1] =  (signal_h & (Y_P[1] | Y_P[0])) | ((~signal_h) & N_P[1]);
	genvar i;
	//positive tree of revising
	/*initial level to fifth level*/
	generate
		for(i = 0; i <= 1; i = i + 1)begin:level_revising_5_p
			assign		levelp_5[i]          =			(levelp_4[i * 6 + 5:i * 6 + 3] == 3'd0 && levelp_4[i*6+2 : i * 6] == 3'd0) ? 3'd0
																		: ((levelp_4[i * 6 + 5:i * 6 + 3] == 3'd0 && levelp_4[i*6+2 : i * 6] == 3'd1) || (levelp_4[i * 6 + 5:i * 6 + 3] == 3'd1 && levelp_4[i*6+2 : i * 6] == 3'd0))
																						?	3'd1 : ((levelp_4[i * 6 + 5:i * 6 + 3] == 3'd2) || (levelp_4[i * 6 + 5:i * 6 + 3] == 3'b0 && levelp_4[i*6+2 : i * 6] == 3'b010)) ? 3'd2
																													: ((levelp_4[i * 6 + 5:i * 6 + 3] == 3'd3) || (levelp_4[i * 6 + 5:i * 6 + 3] == 3'd0 && levelp_4[i*6+2 : i * 6] == 3'd3) 
																																			|| (levelp_4[i * 6 + 5:i * 6 + 3] == 3'b001 &&levelp_4[i*6+2 : i * 6] == 3'd2)) ? 3'd3 : 3'd4;
		end
	endgenerate
	/*initial level to sixth level && revise*/
	always@(*)begin
		levelp_6 = 3'd0;
		if(cont == 3'b000 || cont == 3'b010)begin
			if(levelp_5[1] == 3'd0 && levelp_5[0] == 3'd0)begin
				levelp_6 = 3'd0;
			end else if ((levelp_5[1] == 3'd1 && levelp_5[0] == 3'd0) 
							|| (levelp_5[1] == 3'd0 && levelp_5[0] == 3'd1))begin
				levelp_6 = 3'd1;
			end else if((levelp_5[1]== 3'd2) || (levelp_5[1] == 3'd0 && levelp_5[0] == 3'd2))begin
				levelp_6 = 3'd2;
			end else if(levelp_5[1] == 3'd3 || (levelp_5[1]== 3'd0 && levelp_5[0] == 3'd3)
																	|| (levelp_5[1] == 3'd1 && levelp_5[0] == 3'd2))begin
				levelp_6 = 3'd3;
			end else begin
				levelp_6 = 3'd4;
			end
			Y_P[0] = (levelp_6 == 3'd3);
			N_P[0]   = (levelp_6 == 3'd2);
			Y_P[1] = 'b0;N_P[1] = 'b0;
		end else begin
			Y_P[1] = (levelp_5[1] == 3'd3);
			N_P[1]   = (levelp_5[1] == 3'd2);
			Y_P[0] = (levelp_5[0] == 3'd3);
			N_P[0]   = (levelp_5[0] == 3'd2);
		end
	end
	//negative tree
	/*initial level to fifth level*/
	generate
		for(i = 0; i <= 1; i = i + 1)begin:level_revising_5_n
			assign		leveln_5[i]          =			(leveln_4[i * 6 + 5:i * 6 + 3] == 3'd0 && leveln_4[i*6+2 : i * 6] == 3'd0) ? 3'd0
																		: ((leveln_4[i * 6 + 5:i * 6 + 3] == 3'd0 && leveln_4[i*6+2 : i * 6] == 3'd1) || (leveln_4[i * 6 + 5:i * 6 + 3] == 3'd1 && leveln_4[i*6+2 : i * 6] == 3'd0))
																						?	3'd1 : ((leveln_4[i * 6 + 5:i * 6 + 3] == 3'd2) || (leveln_4[i * 6 + 5:i * 6 + 3] == 3'b0 && leveln_4[i*6+2 : i * 6] == 3'b010)) ? 3'd2
																													: ((leveln_4[i * 6 + 5:i * 6 + 3] == 3'd3) || (leveln_4[i * 6 + 5:i * 6 + 3] == 3'd0 && leveln_4[i*6+2 : i * 6] == 3'd3) 
																																			|| (leveln_4[i * 6 + 5:i * 6 + 3] == 3'b001 &&leveln_4[i*6+2 : i * 6] == 3'd2)) ? 3'd3 : 3'd4;
		end
	endgenerate
	/*initial level to sixth level && revise*/
	always@(*)begin
		if(cont == 3'b000 || cont == 3'b010)begin
			if(leveln_5[1] == 3'd0 && leveln_5[0] == 3'd0)begin
				leveln_6 = 3'd0;
			end else if ((leveln_5[1] == 3'd1 && leveln_5[0] == 3'd0) 
							|| (leveln_5[1] == 3'd0 && leveln_5[0] == 3'd1))begin
				leveln_6 = 3'd1;
			end else if((leveln_5[1]== 3'd2) || (leveln_5[1] == 3'd0 && leveln_5[0] == 3'd2))begin
				leveln_6 = 3'd2;
			end else if(leveln_5[1] == 3'd3 || (leveln_5[1]== 3'd0 && leveln_5[0] == 3'd3)
																	|| (leveln_5[1] == 3'd1 && leveln_5[0] == 3'd2))begin
				leveln_6 = 3'd3;
			end else begin
				leveln_6 = 3'd4;
			end
			Y_N[0] = (leveln_6 == 3'd3);Y_N[1] = 1'b0;
		end else begin
			Y_N[1] = (leveln_5[1] == 3'd3);
			Y_N[0] = (leveln_5[0] == 3'd3);
		end
	end
endmodule
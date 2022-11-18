`include	"conf.v"
module T4_3_stage(
	/*输入*/
	/*control*/
	input										clk,
	input										rstn,
	input			[2:0]						cont_T4_2,
	input										S_A_T4_2,
	input										S_B_T4_2,
	input										S_C_T4_2,
	input										S_A_H_T4_2,
	input										S_B_H_T4_2,
	input										S_C_H_T4_2,
	input			[11:0]					E_T4_2,
	input			[3:0]						trap_T4_2_0,
	input			[3:0]						trap_T4_2_1,
	input			[2:0]						trap_ans_T4_2_0,
	input			[2:0]						trap_ans_T4_2_1,
	input			[11 : 0]					d_T4_2,
	/*data*/
	input			[9:0]						sh_num_T4_2,
	input			[1:0]						esh_T4_2,
	input			[74:0]					p_reg_in,
	input			[11:0]					leveln_4_T4_2,
	input			[11:0]					levelp_4_T4_2,
	/*输出*/
	/*absoluate value*/
	output		[73:0]					p_reg,
	/*leadingZeroAnticipate*/
	output		[9:0]						sh_num,
	output		[1:0]						esh,
	output		[1:0]						revising_T4_3,
	/*control*/
	output	reg[11:0]					E_T4_3,
	output	reg							S_A_T4_3,
	output	reg							S_B_T4_3,
	output	reg							S_C_T4_3,
	output	reg							S_A_H_T4_3,
	output	reg							S_B_H_T4_3,
	output	reg							S_C_H_T4_3,
	output	reg							s2_T4_3,//最终符号位低位
	output	reg							s2h_T4_3,//高位
	output	reg[3:0]						trap_T4_3_0,
	output	reg[3:0]						trap_T4_3_1,
	output	reg[2:0]						trap_ans_T4_3_0,
	output	reg[2:0]						trap_ans_T4_3_1,
	output	reg[2:0]						cont_T4_3,

	output	reg[11:0]					d_T4_3
);
//	wire			[1:0]						d_s;
//	wire			[25:0]					sh_left;
	wire			[1:0]						revising;
	wire			[9:0]						P;
	wire			[1:0]						V;
	assign			P	 		= 			sh_num_T4_2;
	assign   	   V  		= 			esh_T4_2;
	wire										s;
	wire										s_h;
	wire			[73:0]					p_reg_lin;
	LeadingZeroAnt_3 leadingZeroAnt_3(
		.S_A									(S_A_T4_2),
		.S_B									(S_B_T4_2),
		.S_C									(S_C_T4_2),
		.S_A_H								(S_A_H_T4_2),
		.S_B_H								(S_B_H_T4_2),
		.S_C_H								(S_C_H_T4_2),
		.cont									(cont_T4_2), 
		.levelp_4							(levelp_4_T4_2),
		.leveln_4							(leveln_4_T4_2),
		.revising							(revising)
	);
	Abso abso(
		.cont									(cont_T4_2),
		.p_reg_temp							(p_reg_in),
		.s2									(s),
		.s2_h									(s_h),
		.S_A									(S_A_T4_2),
		.S_B									(S_B_T4_2),
		.S_A_H								(S_A_H_T4_2),
		.S_B_H								(S_B_H_T4_2),
		.p_reg								(p_reg_lin)
	);
	T4_3_reg t4_3_reg(
		.clk									(clk),
		.rstn									(rstn),
		.cont									(cont_T4_2),
		.P										(P),
		.V										(V),
		.p_reg_temp							(p_reg_lin),
		.revising							(revising),
		.revi									(revising_T4_3),
		
		.sh_num								(sh_num),
		.esh									(esh),
		.p_reg								(p_reg)					
	);
	/*传递控制信号*/
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			trap_T4_3_0 		<=			#`PERIOD 4'b0000;
			trap_T4_3_1 		<=			#`PERIOD	4'b0000;
			trap_ans_T4_3_0	<=		   #`PERIOD 3'b000;
			trap_ans_T4_3_1  	<=			#`PERIOD 3'b000;
			S_A_H_T4_3			<=			#`PERIOD	'b0;
			S_B_H_T4_3			<=			#`PERIOD	'b0;
			S_C_H_T4_3			<=			#`PERIOD 'b0;
			S_A_T4_3				<=			#`PERIOD	'b0;
			S_B_T4_3				<=			#`PERIOD	'b0;
			S_C_T4_3				<=			#`PERIOD	'b0;
			cont_T4_3			<=			#`PERIOD	3'b0;
			s2_T4_3				<=			#`PERIOD 'b0;
			s2h_T4_3				<=		   #`PERIOD 'b0;
			d_T4_3				<=			#`PERIOD 12'b0;
			E_T4_3				<=			#`PERIOD 12'b0;
		end else begin
			trap_T4_3_0			<=			#`PERIOD trap_T4_2_0;
			trap_T4_3_1			<=			#`PERIOD	trap_T4_2_1;
			trap_ans_T4_3_0	<=			#`PERIOD	trap_ans_T4_2_0;
			trap_ans_T4_3_1	<=			#`PERIOD	trap_ans_T4_2_1;
			S_A_H_T4_3			<=			#`PERIOD	S_A_H_T4_2;
			S_B_H_T4_3			<=			#`PERIOD S_B_H_T4_2;
			S_C_H_T4_3			<=			#`PERIOD	S_C_H_T4_2;
			S_A_T4_3				<=			#`PERIOD	S_A_T4_2;
			S_B_T4_3				<=			#`PERIOD	S_B_T4_2;
			S_C_T4_3				<=			#`PERIOD	S_C_T4_2;
			cont_T4_3			<=			#`PERIOD cont_T4_2;
			s2_T4_3           <=       #`PERIOD s;
			s2h_T4_3        	<=       #`PERIOD s_h;
			d_T4_3				<=			#`PERIOD d_T4_2;
			if(cont_T4_2 == 3'd0)begin
				if(d_T4_2[0] != 1'b0)begin
					if(V[0] == 1'b0)begin
						E_T4_3	<=			#`PERIOD	E_T4_2 + 12'b00_0011 - {1'b0,revising[0]};
					end else begin
						E_T4_3	<=			#`PERIOD	E_T4_2 + 12'b00_0011 - {1'b0,P[5:0]} - {1'b0,revising[0]}; 
					end
				end else begin
					if(V[0] == 'b0)begin
						E_T4_3	<=			#`PERIOD	E_T4_2;
					end else begin
						E_T4_3	<= 		#`PERIOD E_T4_2 - {1'b0,P[5:0]} - {1'b0,revising[0]} + 12'b011011;
					end
				end
			end else if(cont_T4_2 == 3'd1)begin
				if(d_T4_2[1] != 1'b0) begin
					if(V[1] == 'b0)begin
						E_T4_3[11:6]	<= #`PERIOD E_T4_2[11:6] + 6'b0011 - {1'b0,revising[1]};
					end else begin
						E_T4_3[11:6] 	<= #`PERIOD E_T4_2[11:6] + 6'd3 - {1'b0,P[9:5]} - {1'b0,revising[1]};
					end
				end else begin
					if(V[1] == 'b0)begin
						E_T4_3[11:6]	<=	#`PERIOD	E_T4_2[11:6] + 6'b00_1110 - {1'b0,revising[1]};
					end else begin
						E_T4_3[11:6] 	<= #`PERIOD E_T4_2[11:6] - {1'b0,P[9:5]} - {1'b0,revising[1]} + 6'b0_1110;
					end
				end
				if(d_T4_2[0] != 1'b0)begin
					if(V[0] == 1'b0)begin
						E_T4_3[5:0]  	<= #`PERIOD	E_T4_2[5:0] + 6'b00_0011 - {1'b0,revising[0]};
					end else begin
						E_T4_3[5:0] 	<=	#`PERIOD E_T4_2[5:0] + 6'b0_0011 - {1'b0,P[4:0]} - {1'b0,revising[0]};
					end
				end else begin
					if(V[0] == 1'b0)begin
						E_T4_3[5:0]	<=	#`PERIOD E_T4_2[5:0] + 6'b00_1110 - {1'b0,revising[0]};
					end else begin
						E_T4_3[5:0]   <= #`PERIOD E_T4_2[5:0] + 5'b00_1110 - {1'b0,P[4:0]} - {1'b0,revising[0]};
					end
				end
			end else if(cont_T4_2 == 3'b010)begin
				E_T4_3			<=	#`PERIOD	E_T4_2 + 6'b01_1011 - {1'b0,P[5:0]} - {1'b0,revising[0]};
			end else begin
				E_T4_3			<=	#`PERIOD	12'b0;
			end
		end
	end 
endmodule

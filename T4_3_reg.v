`include"conf.v"
module T4_3_reg(
	//输入
	input										clk,
	input										rstn,
	input			[2:0]						cont_T4_2,
	input			[9:0]						P,
	input			[1:0]						V,
	input			[73:0]					p_reg_temp,
	input			[1:0]						revising,
	input										S_A_T4_2,
	input										S_B_T4_2,
	input										S_C_T4_2,
	input										S_A_H_T4_2,
	input										S_B_H_T4_2,
	input										S_C_H_T4_2,
	input			[11:0]					E_PRE_C,
	input			[11 : 0]					d_T4_2,
	input										s,
	input										s_h,
	//输出
	output	reg[9:0]						sh_num,
	output	reg[1:0]						esh,
	output	reg[73:0]					p_reg,
	output	reg[1:0]						revi,
	output	reg[11:0]					E_T4_3,
	output	reg							S_A_T4_3,
	output	reg							S_B_T4_3,
	output	reg							S_C_T4_3,
	output	reg							S_A_H_T4_3,
	output	reg							S_B_H_T4_3,
	output	reg							S_C_H_T4_3,
	output	reg							s2_T4_3,//最终符号位低位
	output	reg							s2h_T4_3,//高位
	output	reg[2:0]						cont_T4_3,

	output	reg[11:0]					d_T4_3
);
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			sh_num			<=	#`PERIOD 10'b0;
			p_reg				<=	#`PERIOD 75'b0;
			esh				<= #`PERIOD 2'b0;
			revi				<=	#`PERIOD 2'b0;
			S_A_H_T4_3		<= #`PERIOD	'b0;
			S_B_H_T4_3		<=	#`PERIOD	'b0;
			S_C_H_T4_3		<=	#`PERIOD 'b0;
			S_A_T4_3			<=	#`PERIOD	'b0;
			S_B_T4_3			<=	#`PERIOD	'b0;
			S_C_T4_3			<=	#`PERIOD	'b0;
			cont_T4_3		<=	#`PERIOD	3'b0;
			s2_T4_3			<= #`PERIOD 'b0;
			s2h_T4_3			<= #`PERIOD 'b0;
			d_T4_3			<=	#`PERIOD 12'b0;
			E_T4_3			<=	#`PERIOD 12'b0;
		end else begin
			p_reg				<=	#`PERIOD p_reg_temp;
			sh_num			<=	#`PERIOD P;
			esh				<=	#`PERIOD V;
			revi				<=	#`PERIOD revising;
			S_A_H_T4_3		<=	#`PERIOD	S_A_H_T4_2;
			S_B_H_T4_3		<=	#`PERIOD S_B_H_T4_2;
			S_C_H_T4_3		<=	#`PERIOD	S_C_H_T4_2;
			S_A_T4_3			<=	#`PERIOD	S_A_T4_2;
			S_B_T4_3			<=	#`PERIOD	S_B_T4_2;
			S_C_T4_3			<=	#`PERIOD	S_C_T4_2;
			cont_T4_3		<=	#`PERIOD cont_T4_2;
			s2_T4_3        <= #`PERIOD s;
			s2h_T4_3       <= #`PERIOD s_h;
			d_T4_3			<= #`PERIOD d_T4_2;
			
/*			if(cont_T4_2 == 3'd0)begin
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
		end*/
		
		/*	if(cont_T4_2[1] == 1'd1)begin//模式3
				E_T4_3			<=	#`PERIOD	E_T4_2 + 6'b01_1011 - {1'b0,P[5:0]} - {1'b0,revising[0]};
			end else if(cont_T4_2[0] == 1'd0)begin//模式1
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
			end else if(cont_T4_2[0] == 1'd1)begin//模式2
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
			end else begin
				E_T4_3			<=	#`PERIOD	12'b0;
			end
		end*/
		if(cont_T4_2[1] == 1'd1)begin//模式3
				E_T4_3			<=	#`PERIOD	E_PRE_C  - {1'b0,revising[0]};
			end else if(cont_T4_2[0] == 1'd0)begin//模式1
				E_T4_3	<=			#`PERIOD	E_PRE_C - {1'b0,revising[0]};
			end else if(cont_T4_2[0] == 1'd1)begin//模式2
				E_T4_3[11:6] 	<= #`PERIOD E_PRE_C[11:6]  - {1'b0,revising[1]} ;
				E_T4_3[5:0]  	<= #`PERIOD	E_PRE_C[5:0]   - {1'b0,revising[0]};
			end else begin
				E_T4_3			<=	#`PERIOD	12'b0;
			end
		end
		
	end 
endmodule
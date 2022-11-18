//并行处理一部分的E
`include "conf.v"
module Pre_calculation(
	//输出信号
	input			[2:0]						cont_T_4_2,
	input			[11:0]					E_T_4_2,
	input			[9:0]						P,
	input			[1:0]						V,
	input			[11:0]					d_T_4_2,
	//输出信号
	output	reg[11:0]					E_PRE_C//提前计算的一部分E
);
	always @(*)begin
		if(cont_T_4_2 [1] == 1'd1)begin//模式3
			E_PRE_C			=			#`PERIOD E_T_4_2 + 6'b01_1011 - {1'b0,P[5:0]};
		end else if(cont_T_4_2[0]  == 1'd0) begin //模式1
			if(d_T_4_2[0] != 1'b0)begin
				if(V[0] == 1'b0)begin
					E_PRE_C			=			#`PERIOD E_T_4_2 + 12'b00_0011;
				end else begin
					E_PRE_C			=			#`PERIOD E_T_4_2 + 12'b00_0011 - {1'b0,P[5:0]};
				end
			
			end else begin
				if(V[0] == 1'b0)begin
					E_PRE_C			=			#`PERIOD E_T_4_2 + 12'b011011 ;
				end else begin
					E_PRE_C			=			#`PERIOD E_T_4_2 + 12'b011011 - {1'b0,P[5:0]};
				end
			end
		end else if(cont_T_4_2[0] == 1'b1)begin//模式2
			if(d_T_4_2[1] != 1'b0)begin
				if(V[1] == 1'b0)begin
					E_PRE_C			=			#`PERIOD E_T_4_2[11:6] + 6'b0011;
				end else begin
					E_PRE_C			=			#`PERIOD E_T_4_2[11:6] + 6'd3 - {1'b0,P[9:5]};
				end
			end else begin
				if(V[1] == 1'b0)begin
					E_PRE_C			=			#`PERIOD E_T_4_2[11:6] + 6'b00_1110;
				end else begin
					E_PRE_C			=			#`PERIOD	E_T_4_2[11:6] + 6'b0_1110 - {1'b0,P[9:5]};
				end
			end
			if(d_T_4_2[0] != 1'b0)begin
				if(V[0] == 1'b0)begin
					E_PRE_C			=			#`PERIOD E_T_4_2[5:0] + 6'b00_0011;
				end else begin
					E_PRE_C			=			#`PERIOD E_T_4_2[5:0] + 6'b0_0011 - {1'b0,P[4:0]};
				end
			end else begin
				if(V[0] == 1'b0)begin
					E_PRE_C   		=			#`PERIOD E_T_4_2[5:0] + 6'b00_1110;
				end else begin
					E_PRE_C			=			#`PERIOD E_T_4_2[5:0] + 5'b0_1110 - {1'b0,P[4:0]};
				end
			end
		end else begin
			E_PRE_C			=			#`PERIOD 12'b0;
		end
	end
endmodule

module Precode(
	input			[2:0]						cont,//控制
	input			[55:0]					op0,//操作数1
	input			[55:0]					op1,//操作数2
	input										S_A,
	input										S_B,
	input										S_C,
	input										S_A_H,
	input										S_B_H,
	input										S_C_H,
	output	reg[55:0]					F,
	output	reg[55:0]					GP_p,
	output	reg[55:0]					GP_n,
	output	reg[55:0]					GP_z,
	output	reg[55:0]					GN_p,
	output	reg[55:0]					GN_n,
	output	reg[55:0]					GN_z
);
	wire										signal;//减有效
	wire										signal_h;//减有效
	wire			[55:0]					G;
	wire			[55:0]					Z;
	wire			[55:0]					T;
	reg			[5:0]						i;
	wire			[55:0]					op_0;
	wire			[55:0]					op_1;
	assign			op_0			=			op0;
	assign			op_1			=			op1;
	assign		signal   =     (!S_A && !S_B && S_C) || (!S_A && S_B && !S_C) || (S_A && S_B && S_C) || (S_A && !S_B && !S_C);
	assign		signal_h =     (!S_A_H && !S_B_H && S_C_H) || (!S_A_H && S_B_H && !S_C_H) || (S_A_H && S_B_H && S_C_H) || (S_A_H && !S_B_H && !S_C_H);
	assign			T			=			op_0 ^ op_1;
	assign			G			=			op_0 & op_1;
	assign			Z			=			~(op_0 | op_1);
	/*前导零编码*/   
	always@(*)begin
		F = 56'b0;
		i = 6'd0;
		if(cont == 3'b000)begin
			for(i = 6'd7; i < 6'd55; i = i + 1'd1)begin
				F[i] =  (T[i + 'b1] & ((G[i] & (~(Z[i - 'b1]))) | (Z[i] & (~(G[i - 'b1]))))) | (~T[i + 'b1] & ((Z[i] & (~Z[i - 'b1])) | (G[i] & (~G[i - 'b1]))));
			end
			F[6] = (T[7] & ((G[6] & signal) | Z[6])) | (~T[7] & ((Z[6] & signal) | G[6]));
			F[55] = (signal & ((G[55] & (~Z[54])) | (Z[55] & (~G[54])))) | (~signal & ((Z[55] & (~Z[54])) | (~Z[55])));
			F[5:0] = 6'b0;
		end else if(cont == 3'b001) begin
			/*处理高位*/
			for(i = 6'd33; i < 6'd55; i = i + 1'd1)begin
				F[i] =  (T[i + 'b1] & ((G[i] & (~(Z[i - 'b1]))) | (Z[i] & (~(G[i - 'b1]))))) | (~T[i + 'b1] & ((Z[i] & (~Z[i - 'b1])) | (G[i] & (~G[i - 'b1]))));
			end
			F[32] = (T[33] & ((G[32] & signal_h) | Z[32])) | (~T[33] & ((Z[32] & signal_h) | G[32]));
			F[55] = (signal_h & ((G[55] & (~Z[54])) | (Z[55] & (~G[54])))) | (~signal_h & ((Z[55] & (~Z[54])) | (~Z[55])));
			F[31:24] = 8'b0;
			/*处理低位*/
			for(i = 6'd1; i <= 6'd22; i = i + 1'd1)begin
				F[i] =  (T[i + 'b1] & ((G[i] & (~(Z[i - 'b1]))) | (Z[i] & (~(G[i - 'b1]))))) | (~T[i + 'b1] & ((Z[i] & (~Z[i - 'b1])) | (G[i] & (~G[i - 'b1]))));
			end
			F[0] = (T[1] & ((G[0] & signal) | Z[0])) | (~T[1] & ((Z[0] & signal) | G[0]));
			F[23] = (signal & ((G[23] & (~Z[22])) | (Z[23] & (~G[22])))) | (~signal & ((Z[23] & (~Z[22])) | (~Z[23])));
		end else if(cont == 3'b010)begin
			/*处理高位*/
//			F[7:0] = 8'b0;
			for(i = 6'd9; i < 6'd55; i = i + 1'd1)begin
				F[i] =  (T[i + 'b1] & ((G[i] & (~(Z[i - 'b1]))) | (Z[i] & (~(G[i - 'b1]))))) | (~T[i + 'b1] & ((Z[i] & (~Z[i - 'b1])) | (G[i] & (~G[i - 'b1]))));
			end
			F[8] = (T[9] & ((G[8] & signal) | Z[8])) | (~T[9] & ((Z[8] & signal) | G[8]));
			F[55] = (signal & ((G[55] & (~Z[54])) | Z[55] & (~G[54]))) | (~signal & ((Z[55] & (~Z[54])) | (~Z[55])));
		end
	end
	/*并行纠错编码*/
	always@(*)begin
		i    = 6'd0;
		GP_p = 56'b0;
		GP_n = 56'b0;
		GP_z = 56'b0; 
		GN_p = 56'b0;
		GN_n = 56'b0;
		GN_z = 56'b0;
		if(cont == 3'b000)begin
			for(i = 6'd6; i <= 6'd54; i = i + 1'b1)begin//没有最高位
				GP_p[i] = G[i];
				GP_n[i] = T[i + 1'b1] & Z[i];
				GP_z[i] = ~(G[i] | (T[i + 1'b1] & Z[i]));
				GN_p[i] = Z[i];
				GN_n[i] = T[i + 1'b1] & G[i];
				GN_z[i] = ~(Z[i] | (T[i + 1'b1] & G[i])); 
			end
			if(signal == 1'b1)//最高位定义 
			begin
				GP_p[55] = G[55];
				GP_n[55] = Z[55];
				GP_z[55] = ~(G[55] | Z[55]);
				GN_p[55] = Z[55];
				GN_n[55] = G[55];
				GN_z[55] = ~(Z[55] | G[55]);
 			end else begin
				GP_p[55] = G[55];
				GP_n[55] = 1'b0;
				GP_z[55] = ~(G[55]);
				GN_p[55] = Z[55];
				GN_n[55] = 1'b0;
				GN_z[55] = ~(Z[55]); 
			end
			GP_p[5:0] = 6'b0;//补充填充位
			GP_n[5:0] = 6'b0;
			GP_z[5:0] = 6'b1111_11;
			GN_p[5:0] = 6'b0;
			GN_n[5:0] = 6'b0;
			GN_z[5:0] = 6'b1111_11; 
		end else if(cont == 3'b001) begin
		/*处理模式2高位*/
			for(i = 6'd32; i <= 6'd54; i = i + 1'b1)begin//没有最高位
				GP_p[i] = G[i];
				GP_n[i] = T[i + 1'b1] & Z[i];
				GP_z[i] = ~(G[i] | (T[i + 1'b1] & Z[i]));
				GN_p[i] = Z[i];
				GN_n[i] = T[i + 1'b1] & G[i];
				GN_z[i] = ~(Z[i] | (T[i + 1'b1] & G[i])); 
			end
			if(signal_h == 1'b1)//最高位定义 
			begin
				GP_p[55] = G[55];
				GP_n[55] = Z[55];
				GP_z[55] = ~(G[55] | Z[55]);
				GN_p[55] = Z[55];
				GN_n[55] = G[55];
				GN_z[55] = ~(Z[55] | G[55]);
			end else begin
				GP_p[55] = G[55];
				GP_n[55] = 1'b0;
				GP_z[55] = ~(G[55]);
				GN_p[55] = Z[55];
				GN_n[55] = 1'b0;
				GN_z[55] = ~(Z[55]); 
			end
		/*处理模式2低位*/
			for(i = 6'd0; i < 6'd23; i = i + 1'b1)begin//没有最高位
				GP_p[i] = G[i];
				GP_n[i] = T[i + 1'b1] & Z[i];
				GP_z[i] = ~(G[i] | (T[i + 1'b1] & Z[i]));
				GN_p[i] = Z[i];
				GN_n[i] = T[i + 1'b1] & G[i];
				GN_z[i] = ~(Z[i] | (T[i + 1'b1] & G[i])); 
			end
			if(signal == 1'b1)//最高位定义 
			begin
				GP_p[23] = G[23];
				GP_n[23] = Z[23];
				GP_z[23] = ~(G[23] | Z[23]);
				GN_p[23] = Z[23];
				GN_n[23] = G[23];
				GN_z[23] = ~(Z[23] | G[23]); 
			end else begin
				GP_p[23] = G[23];
				GP_n[23] = 1'b0;
				GP_z[23] = ~(G[23]);
				GN_p[23] = Z[23];
				GN_n[23] = 1'b0;
				GN_z[23] = ~(Z[23]); 
			end
			GP_p[31:24] = 8'b0;
			GP_n[31:24] = 8'b0;
			GP_z[31:24] = 8'b1111_1111;
			GN_p[31:24] = 8'b0;
			GN_n[31:24] = 8'b0;
			GN_z[31:24] = 8'b1111_1111;
		end else if(cont == 3'b010)begin
			/*处理模式3的情况*/
			for(i = 6'd8; i <= 6'd54; i = i + 1'b1)begin//没有最高位
				GP_p[i] = G[i];
				GP_n[i] = T[i + 1'b1] & Z[i];
				GP_z[i] = ~(G[i] | (T[i + 1'b1] & Z[i]));
				GN_p[i] = Z[i];
				GN_n[i] = T[i + 1'b1] & G[i];
				GN_z[i] = ~(Z[i] | (T[i + 1'b1] & G[i])); 
			end
			if(signal == 1'b1)//最高位定义 
			begin
				GP_p[55] = G[55];
				GP_n[55] = Z[55];
				GP_z[55] = ~(G[55] | Z[55]);
				GN_p[55] = Z[55];
				GN_n[55] = G[55];
				GN_z[55] = ~(Z[55] | G[55]); 
			end else begin
				GP_p[55] = G[55];
				GP_n[55] = 1'b0;
				GP_z[55] = ~(G[55]);
				GN_p[55] = Z[55];
				GN_n[55] = 1'b0;
				GN_z[55] = ~(Z[55]); 
			end
			GP_p[7:0] = 8'b0;//补充填充位
			GP_n[7:0] = 8'b0;
			GP_z[7:0] = 8'b1111_1111;
			GN_p[7:0] = 8'b0;
			GN_n[7:0] = 8'b0;
			GN_z[7:0] = 8'b1111_1111; 
		end 
	end
endmodule
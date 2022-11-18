module First_one(
	input			[31:0]					F,
	output	reg[4:0]						P,
	output	reg							V
);
	wire			[15:0]					level_1_P;
	wire			[15:0]					level_1_V;
	wire			[1:0]						level_2_P[7:0];
	wire			[7:0]						level_2_V;
	wire			[2:0]						level_3_P[3:0];
	wire			[3:0]						level_3_V;
	wire			[3:0]						level_4_P[1:0];
	wire			[1:0]						level_4_V;
	wire			[4:0]						level_5_P;
	wire										level_5_V;
	genvar i;
	generate
		for(i = 0; i < 16; i = i + 1)begin:First_one_one_level_1
			First_one_2 first_one_2(
				.f_0										(F[i * 2 + 1]),
				.f_1										(F[i * 2]),
				.P											(level_1_P[i]),
				.V											(level_1_V[i])
				
			);
		end
	endgenerate
	generate
		for(i = 0; i < 8; i = i + 1)begin:First_one_one_level_2
			First_one_4 first_one_4(
				.p1										(level_1_P[i * 2 + 1]),
				.p2										(level_1_P[i * 2]),
				.v1										(level_1_V[i * 2 + 1]),
				.v2										(level_1_V[i * 2]),
				.P											(level_2_P[i]),
				.V											(level_2_V[i])
				
			);
		end
	endgenerate
	generate
		for(i = 0; i < 4; i = i + 1)begin:First_one_one_level_3
			First_one_8 first_one_8(
				.P2_0										(level_2_P[i * 2 + 1]),
				.P2_1										(level_2_P[i * 2]),
				.V2_0										(level_2_V[i * 2 + 1]),
				.V2_1										(level_2_V[i * 2]),
				.P3_0										(level_3_P[i]),
				.V3_0										(level_3_V[i])
				
			);
		end
	endgenerate
	generate
		for(i = 0; i < 2; i = i + 1)begin:First_one_one_level_4
			First_one_16 first_one_16(
				.P3_0										(level_3_P[i * 2 + 1]),
				.P3_1										(level_3_P[i * 2]),
				.V3_0										(level_3_V[i * 2 + 1]),
				.V3_1										(level_3_V[i * 2]),
				.P4_0										(level_4_P[i]),
				.V4_0										(level_4_V[i])
				
			);
		end
	endgenerate
	First_one_32 first_one_32(
		.P4_0										(level_4_P[1]),
		.P4_1										(level_4_P[0]),
		.V4_0										(level_4_V[1]),
		.V4_1										(level_4_V[0]),
		.P5_0										(level_5_P),
		.V5_0										(level_5_V)
		
	);
	always@(*)begin
		P = level_5_P;
		V = level_5_V;
	end
endmodule
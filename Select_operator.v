module Select_operator( 
	input			[2:0]						cont,
	input			[55:0]					num_p_0,
	input			[55:0]					num_p_1,
	input			[55:0]					num_n_0,
	input			[55:0]					num_n_1,
	input			[1:0]						d,//e_c - e_a - e_b <= 0 有效,0位模式1，模式2，模式3，1位模式2
	output		[55:0]					op_0,//被减数
	output		[55:0]					op_1//减数
);
	reg			[55:0]					temp_op_0;
	reg			[55:0]					temp_op_1;
	assign			op_0			=			temp_op_1;
	assign			op_1			=			temp_op_0;
	always @(*)begin
		temp_op_0 <= 56'b0;
		temp_op_1 <= 56'b0;
		if(cont == 3'b001)begin//模式2
			if(d[1] == 1'b1)begin
				temp_op_0[55:32] <= num_n_0[55:32];
				temp_op_1[55:32] <= num_n_1[55:32];
			end else begin
				temp_op_0[55:32] <= num_p_0[55:32];
				temp_op_1[55:32] <= num_p_1[55:32];
			end
			if(d[0] == 1'b1)begin
				temp_op_0[23:0] <= num_n_0[23:0];
				temp_op_1[23:0] <= num_n_1[23:0];
			end else begin
				temp_op_0[23:0] <= num_p_0[23:0];
				temp_op_1[23:0] <= num_p_1[23:0];
			end
		end else if(cont == 3'b000)begin
			if(d[0] == 1'b1)begin
				temp_op_0 <= num_n_0;
				temp_op_1 <= num_n_1;
			end else begin
				temp_op_0 <= num_p_0;
				temp_op_1 <= num_p_1;
			end
		end else if(cont == 3'b010)begin
			temp_op_0 <= num_p_0;
			temp_op_1 <= num_p_1;
		end
	end
endmodule
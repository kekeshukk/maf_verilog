module Con_shift(
	input			[11:0]					d_temp,
	input			[73:0]					p_reg,
	input			[2:0]						cont,
	output	reg [73:0]					con_sh
);
	wire		[1:0]							d;
	assign 			d			=			d_temp[1:0];
	always @(*)begin
		if(cont == 3'b000)begin
			if(d[0] != 1'b0)begin
				con_sh = p_reg << 5'd24;
			end else begin
				con_sh = p_reg;
			end
		end else if(cont == 3'b001)begin
			con_sh = 74'b0;
			if(d[1] != 1'b0)begin
				con_sh[70:36] = p_reg[70:36] << 5'd11;
			end else begin
				con_sh[70:36] = p_reg[70:36];
		end
			if(d[0] != 1'b0)begin
				con_sh[34:0] = p_reg[34:0] << 5'd11;
			end else begin
				con_sh[34:0] = p_reg[34:0];
			end
		end else begin
				con_sh = p_reg;
			end
	end
endmodule
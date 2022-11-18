//进行取正

module  Abso(
	input			[2:0]						cont,
	input			[74:0]					p_reg_temp,
	input										S_A,
	input										S_B,

	input										S_A_H,
	input										S_B_H,
	output									s2,
	output									s2_h,
	output		[73:0]					p_reg
);
	wire										s_star;//A*B的符号
	wire										s_star_h;
	wire										s_a;//相加后的符号位低位。
	wire										s_a_h;//
	reg			[74:0]					reg_temp;
	assign		s_star   =     S_A ^ S_B;
	assign		s_star_h =     S_A_H ^ S_B_H;
	assign		s_a      =     cont == 3'b000 || cont == 3'b010 ? p_reg_temp[74] : cont == 3'b001 ? p_reg_temp[35] : 1'bz;
	assign		s_a_h    =     cont == 3'b001 ? p_reg_temp[72] : 1'bz;
	assign		s2			= 		(~s_a & s_star) | (s_a & (~s_star));
	assign		s2_h		= 		(~s_a_h & s_star_h) | (s_a_h & (~s_star_h));
	assign		p_reg		=		cont == 3'b000 || cont == 3'b010 ? reg_temp[73:0] : cont == 3'b001 ? {3'b0,reg_temp[71:37],1'b0,reg_temp[34:0]} :74'b0;
	always@(*)begin
		reg_temp = 75'b0;
		if(cont == 3'b000)begin
			if(s_a == 1'b1)begin
				reg_temp			=			~p_reg_temp + 1'b1; 
				end else begin
				reg_temp			=			p_reg_temp;
			end
		end else if(cont == 3'd1)begin
			reg_temp[74:73]	=			2'b0;
			if(s_a_h == 1'b1)begin
				reg_temp[72:37]=			~p_reg_temp[72:37] + 1'b1;
			end else begin
				reg_temp[72:37]=			p_reg_temp[72:37];
			end
		
			reg_temp[36]		=			'b0;
			if(s_a  == 1'b1)begin
				reg_temp[35:0]	=			~p_reg_temp[35:0] + 1'b1;
			end else begin
			   reg_temp[35:0]	=  		p_reg_temp[35:0];
			end
		end else if(cont == 3'd2)begin
			if(s_a == 1'b1)begin
				reg_temp[74:26]			=	~p_reg_temp[74:26] + 1'b1;
				reg_temp[25:0]	=			26'b0;			
			end else begin
				reg_temp[74:26]=			p_reg_temp[74:26];
				reg_temp[25:0]	=			26'b0;
			end
		end
	end
endmodule
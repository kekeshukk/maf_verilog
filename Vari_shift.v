module Vari_shift(
	input			[2:0]						cont,
	input			[9:0]						sh_num,
	input			[1:0]						esh,
	input			[73:0]					con_sh,
	input			[1:0]						revise,
	output		[23:0]					M_result
);
	reg			[73:0]					sh_reg_temp;
	assign		M_result				=			(cont == 3'b000 )? sh_reg_temp[73:50] : (cont == 3'b001)
																? {1'b0,sh_reg_temp[70:60],1'b0,sh_reg_temp[34:24]} 
																		: (cont == 3'b010) ? sh_reg_temp[73:50] : 24'b0;
	always @(*)begin
		if(cont == 3'b000)begin
			if(esh[0] == 'b0)begin
				if(revise[0] == 1'b1)begin
					sh_reg_temp = con_sh << 1'b1;
				end else begin
				   sh_reg_temp = con_sh;
				end
			end else begin
				if(revise[0] == 1'b1)begin
					sh_reg_temp = con_sh << (sh_num[5:0] + 1'b1);
				end else begin
					sh_reg_temp = con_sh << sh_num[5:0];
				end
			end
		end else if (cont == 3'b001)begin
			if(esh[1] == 1'b1)begin
				sh_reg_temp[73:71] = 3'b0;
				sh_reg_temp[35]    = 'b0;
				if(revise[1] == 1'b1)begin
					sh_reg_temp[70:36] = con_sh[70:36] << (sh_num[9:5] + 1'b1);
				end else begin
					sh_reg_temp[70:36] = con_sh[70:36] << sh_num[9:5];
				end

			end else begin
				sh_reg_temp[73:71] = 3'b0;
				sh_reg_temp[35]    = 'b0;
				if(revise[1] == 1'b1)begin
					sh_reg_temp[70:36] = con_sh[70:36] << 1'b1;
				end else begin
					sh_reg_temp[70:36] = con_sh[70:36];
				end
				
			end 
			if(esh[0] == 1'b0)begin
				if(revise[0] == 1'b1)begin
					sh_reg_temp[34:0] = con_sh[34:0] << 1'b1;
				end else begin
					sh_reg_temp[34:0] =con_sh[34:0];
				end
			end else begin
				if(revise[0] == 1'b1)begin
					sh_reg_temp[34:0] =con_sh[34:0] << (sh_num[4:0] + 1'b1);
				end else begin
					sh_reg_temp[34:0] =con_sh[34:0]<< sh_num[4:0];
				end
			end
		end else if(cont == 3'b010)begin
			if(esh[0] == 'b0)begin
				if(revise[0] == 1'b1)begin
					sh_reg_temp = con_sh << 1'b1;
				end else begin
					sh_reg_temp = con_sh;
				end
			end else begin
			   if(revise[0] == 1'b1)begin
					sh_reg_temp = con_sh << (sh_num + {1'b0,1'b1});
				end
				else begin
					sh_reg_temp = con_sh << sh_num;
				end
			end
		end else begin
			sh_reg_temp = 74'b0;
		end
	end
endmodule
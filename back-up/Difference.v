module difference(
	input										clk,
	input										rstn,
	input				[7:0]					E_A,
	input				[7:0]					E_B,
	input				[7:0]					E_C,
	input				[2:0]					cont,
	output	reg	[7:0]					ASC_0,//移位位数，模式1，2，3；模式2中表示靠后
	output	reg	[7:0]					ASC_1,//移位尾数，模式2；模式2中表示靠前
	output	reg	[7:0]					sDifference_0,//阶差，模式1，2，3；模式2中表示靠后
	output	reg	[7:0]					sDifference_1//阶差，模式2；模式2中表示靠前
); 
always @(posedge	clk	or	negedge	rstn)begin
		if(!rstn)begin
			ASC_0				<=		7'b0;
			ASC_1				<=		7'b0;
			sDifference_0	<=		7'b0;
			sDifference_1	<=		7'b0;
		end
		else	begin
			ASC_0				<=		7'b0;
			sDifference_0	<=		7'b0;
			ASC_1				<=		7'b0;
			sDifference_1	<=		7'b0;
			if(cont == 3'b000)begin//模式1
				ASC_0				<=		8'd27 - (E_C - E_B - E_A) - 8'd127;
				sDifference_0	<=		E_C - E_B - E_A + 8'd127;
			end
			else if(cont == 3'b001) begin//模式2待添加******
				
			end 
			else begin//模式3 待添加******
				ASC_0				<=		8'd27 - (E_C - E_B - E_A) + 8'd97;
				sDifference_0	<=		E_C - E_B - E_A + 8'd97;
			end
		
		end
end


endmodule
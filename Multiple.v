`include "conf.v"
module Multiple(
	input			[2:0]						cont,
	input			[23:0]					M_A,
	input			[23:0]					M_B,
//	input										ena,//使能根据输入计算，一般只屏蔽：模式1，模式3中全错，模式2中全错，其它的不会屏蔽还会计算，高有效
	output 		[575:0]					M_out_plain//将部分积展开，最低位存低
);
	reg	[47:0]							M_out_temp[23:0];
	wire	[47:0]							M_out[11:0];
	reg	[5:0]								i;
	parameter	PSIZE = 6;//第一级压缩的循环次数
	/*
		展平逻辑
	*/
	assign		M_out_plain[47:0]    = M_out[0];//存储第0个行
	assign		M_out_plain[95:48]   = M_out[1];//存储第1个行
	assign		M_out_plain[143:96]  = M_out[2];//存储第2个行
	assign		M_out_plain[191:144] = M_out[3];//存储第3个行
	assign		M_out_plain[239:192] = M_out[4];//存储第4个行
	assign		M_out_plain[287:240] = M_out[5];//存储第5个行
	assign		M_out_plain[335:288] = M_out[6];//存储第6个行
	assign		M_out_plain[383:336] = M_out[7];//存储第7个行
	assign		M_out_plain[431:384] = M_out[8];//存储第8个行
	assign		M_out_plain[479:432] = M_out[9];//存储第9个行
	assign		M_out_plain[527:480] = M_out[10];//存储第10个行
	assign		M_out_plain[575:528] = M_out[11];//存储第11个行
	always@(*)begin//计算第一级的输入
		/*进行循环操作*/ 
		for(i = 5'd0; i < `SIZE; i = i + 5'd1)begin
			if(cont == 3'b0)begin
				if(M_B[i] == 1'b0)begin
					M_out_temp[i] = 48'b0;
				end
				else begin
					M_out_temp[i] = M_A << i;
				end
			end
			else if(cont== 3'b001)begin
				M_out_temp[i]	=	48'b0;
				if(i < `HSIZE)begin
					if(M_B[i] == 1'b1)begin
						M_out_temp[i] <= M_A[10:0] << i;
					end
				end else begin
					if(M_B[i] == 1'b1)begin
						M_out_temp[i] <= M_A[22:12]<< (i + 5'd12);
					end
				end
			end
			else if(cont == 3'b010)begin
				if(i < `HSIZE)begin
					if(M_B[i] == 'b1)begin
						M_out_temp[i] <= M_A[10:0] << i;
					end
					else begin
						M_out_temp[i]	<=	48'b0;
					end
				end else begin
					M_out_temp[i]	<=	48'b0;
				end
			end else begin
				M_out_temp[i] <= 48'b0;
			end
		end
	end

		/*
			进行第一级4-2压缩树压缩
		*/
		genvar j;
		generate
			for(j = 0; j < PSIZE; j = j + 1)begin:first_level
				F_t_file f_t_file(
					.P_1										(M_out_temp[j * 4]),
					.P_2										(M_out_temp[j * 4 + 1]),
					.P_3										(M_out_temp[j * 4+ 2]),
					.P_4										(M_out_temp[j * 4 + 3]),
					.Carry									(M_out[j * 2]),
					.Sum										(M_out[j * 2 + 1])
				);
			end
		endgenerate
endmodule
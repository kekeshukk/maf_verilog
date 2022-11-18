module	Wallace_L3(
	input				[575:0]				M_out_plain_in,
//	input										ena,//高有效
//	output			[47:0]				Carry,//没修正
//	output			[47:0]				Sum
	output			[287:0]				L3_level
);
	wire				[575:0]				M_temp;//为了节省功耗
	wire				[47:0]				L2_level[11:0];//第二级输入
	assign			L2_level[0]			=			M_temp[47:0];//展开第0行值,进行输入数据
	assign			L2_level[1]			=			M_temp[95:48];//展开第1行值,进行输入数据
	assign			L2_level[2]			=			M_temp[143:96];//展开第2行值,进行输入数据
	assign			L2_level[3]			=			M_temp[191:144];//展开第3行值,进行输入数据
	assign			L2_level[4]			=			M_temp[239:192];//展开第4行值,进行输入数据
	assign			L2_level[5]			=			M_temp[287:240];//展开第5行值,进行输入数据
	assign			L2_level[6]			=			M_temp[335:288];//展开第6行值,进行输入数据
	assign			L2_level[7]			=			M_temp[383:336];//展开第7行值,进行输入数据
	assign			L2_level[8]			=			M_temp[431:384];//展开第8行值,进行输入数据
	assign			L2_level[9]			=			M_temp[479:432];//展开第9行值,进行输入数据
	assign			L2_level[10]		=			M_temp[527:480];//展开第10行值,进行输入数据
	assign			L2_level[11]		=			M_temp[575:528];//展开第11行值,进行输入数据
	/*当有效位为1时才传播否则就是高阻态*/
	assign			M_temp				=			/*ena ==  'b0 ? 48'bz : */M_out_plain_in;
	/*压缩器在每一集的个数*/
	parameter      num_L_2 = 3;
	/*第二级传播*/
	genvar i;
	generate
		for(i = 0; i < num_L_2;i = i + 1)begin:level_2
			F_t_file f_t_file_2t3(
				.P_1							(L2_level[i * 4 + 0]),
				.P_2							(L2_level[i * 4 + 1]),
				.P_3							(L2_level[i * 4 + 2]),
				.P_4							(L2_level[i * 4 + 3]),
				.Carry						(L3_level[(i * 2)*48 + 47 : i* 2 * 48]),
				.Sum							(L3_level[(i * 2 + 1) * 48 + 47 : (i * 2 + 1) * 48])
			);
		end
	endgenerate
	
endmodule
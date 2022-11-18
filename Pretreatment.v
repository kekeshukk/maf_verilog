//T1_stage
/*
	尾数在输出的时候没有加上隐藏位
*/
`include "conf.v"
module Pretreatment(
	input						clk,//全局时钟信号
	input						rstn,//全局复位
	input			[31:0]	A,
	input			[31:0]	B,
	input			[31:0]	C,
	/*
		输入的控制信号：
		000 代表单精度、单精度、单精度
		001 代表并行两个半精度										待添加*******
		010 代表半精度、半精度、单精度
	*/
	input			[2:0]		cont,
	//尾数
	output reg	[23:0]	M_A,
	output reg	[23:0]	M_B,
	output reg  [23:0]	M_C,
	/*
	异常：
	规定 
		000 ：无异常
		001 - 006 ： 论文中的异常 
	*/
//	output reg	[3:0]		trap_0,//模式1模式2或者模式3
//	output reg	[3:0]		trap_1,//模式2
	//阶码
	output reg	[13:0]	E_A,
	output reg	[13:0]	E_B,
	output reg	[13:0]	E_C,
	//符号,带H的在半精度靠前位置
	output reg	         S_A,
	output reg			S_B,
	output reg				S_C,
	output reg				S_A_H,
	output reg				S_B_H,
	output reg				S_C_H,
	output reg	[2:0]	   con_state//内部控制信号
	/*
	这表示异常的情况下的输出结果
	第一位：符号位
	第二位：是不是NaN
	第三位：是不是Infi
	其中
	trap_ans_0是当为模式1，2，3时的异常的最终的结果情况，模式2中的靠后的半精度异常
	trap_ans_1是当为模式2时的异常的最终的结果情况
*/
//	output reg	[2:0]		trap_ans_0,
//	output reg	[2:0]    trap_ans_1
);
/*
	判断是不是非数，一般除了并行两个半精度外都只用0位。
*/
//	wire		[1:0]  	NaN_A;
//	wire		[1:0]  	NaN_B;
//	wire		[1:0]  	NaN_C;
/*
	判断是不是无穷
*/
//	wire		[1:0]		Infi_A;
//	wire		[1:0]		Infi_B;
//	wire		[1:0]		Infi_C;
/*
	判断0
*/
//	wire		[1:0]		Zeros_A;


//	wire		[1:0]		Zeros_B;
//	wire		[1:0]		Zeros_C;
	/*
	乘积符号
	*/
//	wire					Msignal_0;
//	wire					Msignal_1;
//	wire					Msignal_2;
	wire 		[22:0]	M_A_0;
	wire		[22:0]	M_B_0;
	wire		[22:0]	M_C_0;
	wire					S_A_0; 
	wire					S_B_0;
	wire					S_C_0;
	wire		[7:0]		E_A_0;
	wire		[7:0]		E_B_0;
	wire		[7:0]		E_C_0;
	wire 		[9:0]		M_A_1;
	wire		[9:0]		M_B_1;
	wire		[9:0]		M_C_1;
	wire					S_A_1;
	wire					S_B_1;
	wire					S_C_1;
	wire		[4:0]		E_A_1;
	wire		[4:0]		E_B_1;
	wire		[4:0]		E_C_1;
	wire 		[9:0]		M_A_2;
	wire		[9:0]		M_B_2;
	wire		[9:0]		M_C_2;
	wire					S_A_2;
	wire					S_B_2;
	wire					S_C_2;
	wire		[4:0]		E_A_2;
	wire		[4:0]		E_B_2;
	wire		[4:0]		E_C_2;

	/*
		数字各位的分离工作
		X_X_0:代表单精度的时候各个位代表的数字；
		X_X_1:代表半精度的时第一个数字各个位代表的数字；(存储在前半部分)
		X_X_2:代表半精度的时第二个数字各位代表的数字；（存储在后半部分）
	*/
	/*
		单精度
	*/
	assign  	M_A_0		=		A[22:0];
	assign  	M_B_0		=		B[22:0];
	assign  	M_C_0		=		C[22:0];
	assign	S_A_0		=		A[31];
	assign	S_B_0		=		B[31];
	assign	S_C_0		=		C[31];
	assign	E_A_0		=		A[30:23];
	assign	E_B_0		=		B[30:23];
	assign	E_C_0		=		C[30:23];
	/*
		半精度靠前的
	*/
	assign  	M_A_1		=		A[25:16];
	assign  	M_B_1		=		B[25:16];
	assign  	M_C_1		=		C[25:16];
	assign	S_A_1		=		A[31];
	assign	S_B_1		=		B[31];
	assign	S_C_1		=		C[31];
	assign	E_A_1		=		A[30:26];
	assign	E_B_1		=		B[30:26];
	assign	E_C_1		=		C[30:26];
	/*
		半精度靠后的
	*/
	assign	M_A_2		=		A[9:0];
	assign	M_B_2		=		B[9:0];
	assign		M_C_2	=		C[9:0];
	assign	S_B_2		=		B[15];
	assign	S_A_2		=		A[15];
	assign	S_C_2		=		C[15];
	assign	E_A_2	=			A[14:10];
	assign	E_B_2		=		B[14:10];
	assign	E_C_2		=		C[14:10];
//	assign	Msignal_0	=		((!S_A_0 && S_B_0) || (!S_B_0 &&  S_A_0));//用异或并，计算乘积的符号位，单精度
//	assign	Msignal_1	=		((!S_A_1 && S_B_1) || (!S_B_1 &&  S_A_1));//用异或并，计算乘积的符号位，半精度靠前
//	assign	Msignal_2	=		((!S_A_2 && S_B_2) || (!S_B_2 &&  S_A_2));//用异或并，计算乘积的符号位，版精度靠后
/*
判断是不是非数
*/

//	assign   NaN_A[0] = 		cont == 3'b000 ? ((M_A_0 != 23'b0 && E_A_0 == 8'd255) ? 1'b1 : 1'b0) : ((M_A_2 != 10'b0 && E_A_2 == 5'b11111) ? 1'b1 : 1'b0);
//	assign 	NaN_A[1]	=		cont == 3'b001	? ((M_A_1 != 10'b0 && E_A_0 == 5'b11111) ? 1'b1 : 1'b0) : 1'b0;
//	assign   NaN_B[0] = 		cont == 3'b000 ? ((M_B_0 != 23'b0 && E_B_0 == 8'd255) ? 1'b1 : 1'b0) : ((M_B_2 != 10'b0 && E_B_2 == 5'b11111) ? 1'b1 : 1'b0);
//	assign 	NaN_B[1]	=		cont == 3'b001	? ((M_B_1 != 10'b0 && E_B_0 == 5'b11111) ? 1'b1 : 1'b0) : 1'b0;
//	assign   NaN_C[0] = 		cont != 3'b001 ? ((M_C_0 != 23'b0 && E_C_0 == 8'd255) ? 1'b1 : 1'b0) : ((M_C_2 != 10'b0 && E_A_2 == 5'b11111) ? 1'b1 : 1'b0);
//	assign 	NaN_C[1]	=		cont == 3'b001	? ((M_A_1 != 10'b0 && E_A_0 == 5'b11111) ? 1'b1 : 1'b0) : 1'b0;
///*
//判断
//*/
//	assign	Infi_A[0] 	= 	cont == 3'b000 ? ((M_A_0 == 23'b0 && E_A_0 == 8'd255) ? 1'b1 : 1'b0) : ((M_A_2 == 10'b0 && E_A_2 == 5'b11111) ? 1'b1 : 1'b0);
//	assign	Infi_A[1]	=	cont == 3'b001 ? ((M_A_1 == 10'b0 && E_A_1 == 5'b11111) ? 1'b1 : 1'b0) : 1'b0;
//	assign	Infi_B[0] 	= 	cont == 3'b000 ? ((M_B_0 == 23'b0 && E_B_0 == 8'd255) ? 1'b1 : 1'b0) : ((M_B_2 == 10'b0 && E_B_2 == 5'b11111) ? 1'b1 : 1'b0);
//	assign	Infi_B[1]	=	cont == 3'b001 ? ((M_B_1 == 10'b0 && E_B_1 == 5'b11111) ? 1'b1 : 1'b0) : 1'b0;
//	assign	Infi_C[0] 	= 	cont == 3'b000 ? ((M_C_0 == 23'b0 && E_C_0 == 8'd255) ? 1'b1 : 1'b0) : ((M_C_2 == 10'b0 && E_C_2 == 5'b11111) ? 1'b1 : 1'b0);
//	assign	Infi_C[1]	=	cont == 3'b001 ? ((M_C_1 == 10'b0 && E_C_1 == 5'b11111) ? 1'b1 : 1'b0) : 1'b0;
///*
//判0,Z这里我认为即使是下溢，即非规约数中的E = 0,M!=0,要认为是机器0
//*/
//	assign	Zeros_A[0]	=	cont == 3'b000 ? (E_A_0 == 8'b0 ? 1'b1 : 1'b0) : ((E_A_2 == 5'd0) ? 1'b1 : 1'b0);
//	assign	Zeros_A[1]	=	cont == 3'b001 ? ((E_A_1 == 5'd0) ? 1'b1 : 1'b0) : 1'b0;
//	assign	Zeros_B[0]	=	cont == 3'b000 ? (E_B_0 == 8'b0 ? 1'b1 : 1'b0) : ((E_B_2 == 5'd0) ? 1'b1 : 1'b0);
//	assign	Zeros_B[1]	=	cont == 3'b001 ? ((E_B_1 == 5'd0) ? 1'b1 : 1'b0) : 1'b0;
////	assign	Zeros_C[0]	=	cont == 3'b000 ? (E_C_0 == 8'b0 ? 1 : 0) : ((E_C_2 == 5'd0) ? 1 : 0);
////	assign	Zeros_C[1]	=	cont == 3'b001 ? ((E_C_1 == 5'd0) ? 1 : 0) : 0;
	/*
		控制异常
	*/
	always @(posedge clk or negedge rstn)begin
		if(!rstn) begin//异步复位
//			trap_0			<=	#`PERIOD	4'b0;
//			trap_1			<=	#`PERIOD	4'b0;
//			trap_ans_0		<=	#`PERIOD	3'b0;
//			trap_ans_1		<=	#`PERIOD	3'b0;
//			con_state		<=	#`PERIOD	3'b0;
		end
		else begin//异常
//			con_state <= #`PERIOD cont;
//			trap_0 		<=	#`PERIOD 4'b0;
//			trap_ans_0	<= #`PERIOD 3'b0;
//			trap_1		<= #`PERIOD 4'b0;
//			trap_ans_1	<= #`PERIOD 3'b0;
//			if(cont == 3'b000)begin//模式1
//				if((NaN_A[0] != 1'b0) || (NaN_B[0] != 1'b0) || (NaN_C[0] != 1'b0))begin
//					trap_ans_0[1] 	<= #`PERIOD 1'b1;
//					trap_0 			<= #`PERIOD 4'd1;
//				end
//				if(((Infi_A[0] == 'b1) && (Zeros_B[0] == 'b0) && (Infi_C[0] == 'b0)) || ((Infi_B[0] == 'b1) && (Zeros_A[0] == 1'b0) &&(Infi_C[0] == 'b0))) begin
//					trap_ans_0[0] 	<= #`PERIOD Msignal_0;
//					trap_0[3:0] 	<= #`PERIOD 4'd1;
//					trap_ans_0[2]	<= #`PERIOD 1'b1;
//				end
//			
//				if(((Infi_A[0] == 'b1) && (Zeros_B[0] == 'b0) && (Infi_C[0] == 'b1)) || ((Infi_B[0] == 'b1) && (Zeros_A[0] == 1'b0) &&(Infi_C[0] == 'b1))) begin
//					if(Msignal_0 == S_C_0)begin
//						trap_ans_0[0] 	<= #`PERIOD Msignal_0	;
//						trap_ans_0[2]	<= #`PERIOD 1'b1;
//						trap_0 			<= #`PERIOD 4'd3;
//					end else	begin
//						trap_ans_0[1] 	<= #`PERIOD 1'b1;
//						trap_0        	<= #`PERIOD 4'd4;
//					end
//				end
//				if(((Zeros_A[0] == 'b1) && (Infi_B[0] == 'b1)) || ((Zeros_B[0] == 1'b1) && (Infi_A[0] == 1'b1)))begin
//					trap_ans_0[1] 	<= #`PERIOD 'b1;
//					trap_0			<= #`PERIOD 4'd5;
//				end
//				if(((Infi_A[0] == 'b0) && (Infi_B[0] == 'b0) && (Infi_C[0]  == 'b1)))begin
//					trap_ans_0[0] 	<=  #`PERIOD S_C_0;
//					trap_ans_0[2] 	<= #`PERIOD 'b1;
//					trap_0			<= #`PERIOD 4'd6;
//				end
//			end 
//			else if(cont == 3'b001)begin//模式2
//				/*
//					对于半精度中靠后的数字判断
//				*/
//				if((NaN_A[0] != 1'b0) || (NaN_B[0] != 1'b0) || (NaN_C[0] != 1'b0))begin
//					trap_ans_0[1] 	<= #`PERIOD 1'b1;
//					trap_0 			<= #`PERIOD 4'd1;
//				end
//				if(((Infi_A[0] == 'b1) && (Zeros_B[0] == 'b0) && (Infi_C[0] == 'b0)) || ((Infi_B[0] == 'b1) && (Zeros_A[0] == 1'b0) &&(Infi_C[0] == 'b0))) begin
//					trap_ans_0[0] 	<= #`PERIOD Msignal_2;
//					trap_0[3:0] 	<= #`PERIOD 4'd1;
//					trap_ans_0[2]	<= #`PERIOD 1'b1;
//				end
//			
//				if(((Infi_A[0] == 'b1) && (Zeros_B[0] == 'b0) && (Infi_C[0] == 'b1)) || ((Infi_B[0] == 'b1) && (Zeros_A[0] == 1'b0) &&(Infi_C[0] == 'b1))) begin
//					if(Msignal_2 == S_C_2)begin
//						trap_ans_0[0] 	<= #`PERIOD Msignal_2	;
//						trap_ans_0[2]	<= #`PERIOD 1'b1;
//						trap_0 			<= #`PERIOD 4'd3;
//					end else	begin
//						trap_ans_0[1] <= #`PERIOD 1'b1;
//						trap_0        <= #`PERIOD 4'd4;
//					end
//				end
//				if(((Zeros_A[0] == 'b1) && (Infi_B[0] == 'b1)) || ((Zeros_B[0] == 1'b1) && (Infi_A[0] == 1'b1)))begin
//					trap_ans_0[1] 	<= #`PERIOD 'b1;
//					trap_0			<= #`PERIOD 4'd5;
//				end
//				if(((Infi_A[0] == 'b0) && (Infi_B[0] == 'b0) && (Infi_C[0]== 'b1)))begin
//					trap_ans_0[0] 	<= #`PERIOD S_C_2;
//					trap_ans_0[2] 	<= #`PERIOD 'b1;
//					trap_0			<= #`PERIOD 4'd6;
//				end
//				/*
//					对于半精度中靠前的数字进行判断
//				*/
//				if((NaN_A[1] != 'b0) || (NaN_B[1] != 'b0) || (NaN_C[1] != 1'b0))begin
//					trap_ans_1[1]	<= #`PERIOD 1'b1;
//					trap_1			<= #`PERIOD 4'd1;
//				end
//				if(((Infi_A[1] == 1'b1) && (Zeros_B[1] == 1'b0) && (Infi_C[1] == 1'b0)) || ((Infi_B[1] == 1'b1) && (Infi_A[1] == 1'b0) && (Infi_C[1] == 1'b0)))begin
//					trap_ans_1[0]	<=	#`PERIOD Msignal_1;
//					trap_1[3:0] 	<= #`PERIOD 4'd2;
//					trap_ans_1[2]	<=	#`PERIOD 1'b1;
//				end
//				if(((Infi_A[1] == 1'b1) && (Zeros_B[1] == 1'b0) && (Infi_C[1] == 1'b1)) || ((Infi_B[1] == 1'b1) && (Infi_C[1] == 1'b1) && (Zeros_A[1] == 1'b0)))begin
//					if(Msignal_1 == S_C_1)begin
//						trap_ans_1[0]	<=	#`PERIOD Msignal_1;
//						trap_ans_1[2]	<= #`PERIOD 1'b1;
//						trap_1			<=	#`PERIOD 4'd3;
//					end	else 	begin
//						trap_ans_1[1]	<= #`PERIOD 1'b1;
//						trap_1 		<= 	#`PERIOD 4'd4;
//					end
//				end
//				if(((Zeros_A[1] == 1'b1) && (Infi_B[1] == 1'b1)) || ((Zeros_B[1] == 1'b1) && (Infi_A[1] == 1'b1)))begin
//					trap_ans_1[1]	<= #`PERIOD 1'b1;
//					trap_1			<=	#`PERIOD 4'd5;
//				end
//				if(((Infi_A[1] == 1'b0) && (Infi_B[1] == 1'b0) && (Infi_C[1] == 1'b1)))begin
//					trap_ans_1[0]	<=	#`PERIOD S_C_1;
//					trap_ans_1[2]	<=	#`PERIOD 1'b1;
//					trap_1			<= #`PERIOD 4'd6;
//				end
//			end 
//			else begin//模式3
//				if((NaN_A[0] != 1'b0) || (NaN_B[0] != 1'b0) || (NaN_C[0] != 1'b0))begin
//					trap_ans_0[1] 	<= #`PERIOD 1'b1;
//					trap_0 			<= #`PERIOD 4'd1;
//				end
//				if(((Infi_A[0] == 'b1) && (Zeros_B[0] == 'b0) && (Infi_C[0] == 'b0)) || ((Infi_B[0] == 'b1) && (Zeros_A[0] == 1'b0) &&(Infi_C[0] == 'b0))) begin
//					trap_ans_0[0] 	<= #`PERIOD Msignal_2;
//					trap_0[3:0] 	<= #`PERIOD 4'd1;
//					trap_ans_0[2]	<= #`PERIOD 1'b1;
//				end
//			
//				if(((Infi_A[0] == 'b1) && (Zeros_B[0] == 'b0) && (Infi_C[0] == 'b1)) || ((Infi_B[0] == 'b1) && (Zeros_A[0] == 1'b0) &&(Infi_C[0] == 'b1))) begin
//					if(Msignal_2 == S_C_0)begin
//						trap_ans_0[0] 	<= #`PERIOD Msignal_2	;
//						trap_ans_0[2]	<= #`PERIOD 1'b1;
//						trap_0 			<= #`PERIOD 4'd3;
//					end else	begin
//						trap_ans_0[1] <= #`PERIOD 1'b1;
//						trap_0        <= #`PERIOD 4'd4;
//					end
//				end
//				if(((Zeros_A[0] == 'b1) && (Infi_B[0] == 'b1)) || ((Zeros_B[0] == 1'b1) && (Infi_A[0] == 1'b1)))begin
//					trap_ans_0[1] 	<= #`PERIOD 'b1;
//					trap_0			<= #`PERIOD 4'd5;
//				end
//				if(((Infi_A[0] == 'b0) && (Infi_B[0] == 'b0) && (Infi_C[0]  == 'b1)))begin
//					trap_ans_0[0] 	<= #`PERIOD S_C_0;
//					trap_ans_0[2] 	<= #`PERIOD 'b1;
//					trap_0			<= #`PERIOD 4'd6;
//				end
//			end
		end
	end
/*
	数字分离工作
*/
	always @(posedge clk or negedge rstn) begin
		if(!rstn) begin
			con_state <= #`PERIOD 3'b0;
			M_A 	<=	#`PERIOD	24'b0;
			M_B	<=	#`PERIOD	24'b0;
			M_C	<=	#`PERIOD	24'b0;
			E_A	<=	#`PERIOD	14'b0;
			E_B	<=	#`PERIOD	14'b0;
			E_C	<=	#`PERIOD	14'b0;
			S_A	<=	#`PERIOD	1'b0;
			S_B	<=	#`PERIOD	1'b0;
			S_C	<=	#`PERIOD	1'b0;
//			M_A_H	<=		10'b0;
//			M_B_H	<=		10'b0;
//			M_C_H	<=		10'b0;
//			E_A_H	<=		5'b0;
//			E_B_H	<=		5'b0;
//			E_C_H	<=		5'b0;
			S_A_H	<=	#`PERIOD	'b0;
			S_B_H	<=	#`PERIOD	'b0;
			S_C_H	<=	#`PERIOD 'b0;
		end else begin
			con_state <= #`PERIOD cont;
		/*
			防止锁存器
		*/
			M_A 	<=	#`PERIOD	24'b0;
			M_B	<=	#`PERIOD	24'b0;
			M_C	<=	#`PERIOD	24'b0;
			E_A	<=	#`PERIOD	14'b0;
			E_B	<=	#`PERIOD	14'b0;
			E_C	<=	#`PERIOD	14'b0;
			S_A	<=	#`PERIOD	1'b0;
			S_B	<=	#`PERIOD	1'b0;
			S_C	<=	#`PERIOD	1'b0;
			S_A_H	<=	#`PERIOD	'b0;
			S_B_H	<=	#`PERIOD	'b0;
			S_C_H	<=	#`PERIOD  'b0;
			if(cont[1] == 'b1)begin//模式3
				M_A	<=	#`PERIOD	{13'b0,1'b1,M_A_2};
				M_B	<=	#`PERIOD	{13'b0,1'b1,M_B_2};
				M_C	<=	#`PERIOD	{1'b1,M_C_0};
				E_A	<=	#`PERIOD	{9'b0,E_A_2};
				E_B	<=	#`PERIOD	{9'b0,E_B_2};
				E_C	<=	#`PERIOD	{6'b0,E_C_0};
				S_A	<=	#`PERIOD	S_A_2;
				S_B	<=	#`PERIOD	S_B_2;
				S_C	<=	#`PERIOD	S_C_0;
			
				
			end else	if (cont[0] == 'b1)begin//模式2
				M_A	<=	#`PERIOD	{1'b0,1'b1,M_A_1,1'b0,1'b1,M_A_2};
				M_B	<=	#`PERIOD	{1'b0,1'b0,1'b1,M_B_1,1'b1,M_B_2};
				M_C	<=	#`PERIOD	{1'b0,1'b0,1'b1,M_C_1,1'b1,M_C_2};
				E_A	<=	#`PERIOD	{1'b0,1'b0,E_A_1,1'b0,1'b0,E_A_2};
				E_B	<=	#`PERIOD	{1'b0,1'b0,E_B_1,1'b0,1'b0,E_B_2};
				E_C	<=	#`PERIOD	{1'b0,1'b0,E_C_1,1'b0,1'b0,E_C_2};
				/*
					符号位分开
				*/
				S_A	<=	#`PERIOD	S_A_2;
				S_B	<=	#`PERIOD	S_B_2;
				S_C	<=	#`PERIOD	S_C_2;
				S_A_H	<=	#`PERIOD	S_A_1;
				S_B_H	<=	#`PERIOD	S_B_1;
				S_C_H	<=	#`PERIOD	S_C_1;
			end else if(cont[0] == 'b0)begin//模式1
				M_A	<=	#`PERIOD	{1'b1,M_A_0};
				M_B	<=	#`PERIOD	{1'b1,M_B_0};
				M_C	<=	#`PERIOD	{1'b1,M_C_0};
				E_A	<=	#`PERIOD	{6'b0,E_A_0};
				E_B	<=	#`PERIOD	{6'b0,E_B_0};
				E_C	<=	#`PERIOD	{6'b0,E_C_0};
				S_A	<=	#`PERIOD	S_A_0;
				S_B	<=	#`PERIOD	S_B_0;
				S_C	<=	#`PERIOD	S_C_0;
			end
		end
	end
endmodule

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

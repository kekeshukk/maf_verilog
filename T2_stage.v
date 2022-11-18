//第二级流水线
`include "conf.v"
module T2_stage(
	input										clk,
	input										rstn,
	input 		wire		[23:0]		M_A,
	input 		wire		[23:0]		M_B,
	input 		wire  	[23:0]		M_C,
	input 		wire		[3:0]			trap_T1_0,//模式1模式2或者模式3
	input 		wire		[3:0]			trap_T1_1,//模式2
	input 		wire		[13:0]		E_A,
	input 		wire		[13:0]		E_B,
	input 		wire		[13:0]		E_C,
	input 		wire	         		S_A_T1,
	input 		wire						S_B_T1,
	input 		wire						S_C_T1,
	input			wire						S_A_H_T1,
	input			wire						S_B_H_T1,
	input			wire						S_C_H_T1,
	input 		wire		[2:0]		   cont,
	input 		wire		[2:0]			trap_ans_T1_0,
	input			wire		[2:0] 	   trap_ans_T1_1,
	/*
		输出
	*/
	output					[11:0]		sh_num,
	output					[575:0]		M_out_plain,
	output					[75:0]		sh_reg,		
	output 		reg		[2:0]			trap_ans_T2_0,
	output 		reg		[2:0]			trap_ans_T2_1,
	output		reg		[3:0]			trap_T2_0,
	output		reg		[3:0]			trap_T2_1,
	output		reg						S_A_T2,
	output		reg						S_B_T2,
	output		reg						S_C_T2,
	output		reg						S_A_H_T2,
	output		reg						S_B_H_T2,
	output		reg						S_C_H_T2,
	output		reg		[2:0]			cont_T2,
	output		reg	[11:0]			d_T2,
	output		reg		[11:0]		E_T2		
);
	wire						[11:0]		d_lin;
	wire										ena;//使能位
	wire						[575:0]		M_out_lin;
//	wire                  [5:0]		tempa,tempb;
//	assign  tempa = E_A[13:7] + E_B[13:7] - 7'd30;
//	assign  tempb = E_C[13:7] - 7'b001_1101;
	/*
		移位部分
	*/
	ASC	asc(
		.cont										(cont),
		.clk										(clk),
		.rstn										(rstn),
		.E_A										(E_A),
		.E_B										(E_B),
		.E_C										(E_C),
		.sh_num									(sh_num),
		.d											(d_lin)	
	);
	Shift_reg shift_reg( 
		.cont										(cont),
		.M_C										(M_C),
		.clk										(clk),
		.rstn										(rstn),
		.sh_reg									(sh_reg)
	);
	/*
		乘积计算与华莱士树第一级
	*/
	Multiple multiple(
		.cont										(cont),
		.ena										(ena),
		.M_A										(M_A),
		.M_B										(M_B),
		.M_out_plain							(M_out_lin)
	);
	T2_reg t2_reg		(
		.M_out_plain_in						(M_out_lin),
		.clk										(clk),
		.rstn										(rstn),
		.M_out_plain_out						(M_out_plain)
	);
	/*
		级间控制信号的传递
	*/
/*	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			S_A_H_T2			<=			#`PERIOD	'b0;
			S_B_H_T2			<=			#`PERIOD	'b0;
			S_C_H_T2			<=			#`PERIOD 'b0;
			S_A_T2			<=			#`PERIOD	'b0;
			S_B_T2			<=			#`PERIOD	'b0;
			S_C_T2			<=			#`PERIOD	'b0;
			cont_T2			<=			#`PERIOD	3'b0;
			d_T2				<=			#`PERIOD 12'b0;
			E_T2				<=			#`PERIOD	10'b0;
		end else begin
			S_A_H_T2			<=			#`PERIOD	S_A_H_T1;
			S_B_H_T2			<=			#`PERIOD S_B_H_T1;
			S_C_H_T2			<=			#`PERIOD	S_C_H_T1;
			S_A_T2			<=			#`PERIOD	S_A_T1;
			S_B_T2			<=			#`PERIOD	S_B_T1;
			S_C_T2			<=			#`PERIOD	S_C_T1;
			cont_T2			<=			#`PERIOD cont;
			d_T2				<=			#`PERIOD d_lin;
			if(cont == 3'b000)begin
				E_T2			<=			#`PERIOD (E_A + E_B + 14'b01_1111_0000_0010) > (E_C + 14'b01_1111_0110_0110) ? (E_A + E_B - 14'b00_0000_1111_1110) : (E_C - 14'b00_0000_1001_1010);
			end else if(cont == 3'b001)begin
				E_T2[11:6]	<=			#`PERIOD (E_A[13:7] + E_B[13:7] + 7'b010_0010) > (E_C[13:7] + 7'b010_0011) ? tempa : tempb;
				E_T2[5:0]	<=			#`PERIOD (E_A[6:0] + E_B[6:0] + 7'b0100_0010) > (E_C[6:0] + 7'b000_0011) ? (E_A[6:0] + E_B[6:0] - 7'b01_1110) : (E_C[6:0] - 7'd29);
			end else if(cont == 3'b010)begin
				E_T2			<=			#`PERIOD	(E_A + E_B + 14'b01_1111_1110_0010) > (E_C + 14'b01_1111_0110_0110) ? E_A + E_B - 14'b001_1110 :E_C - 14'd154;
			end else begin
				E_T2			<=			#`PERIOD 12'b0;
			end
		end
	end*/
endmodule
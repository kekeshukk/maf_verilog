`include	"conf.v"
module T4_2_stage(
	/*输入*/
	/*control*/
	input										clk,
	input										rstn,
	input			[2:0]						cont_T4_1,
	input										S_A_T4_1,
	input										S_B_T4_1,
	input										S_C_T4_1,
	input										S_A_H_T4_1,
	input										S_B_H_T4_1,
	input										S_C_H_T4_1,
	input			[11:0]					E_T4_1,
	input			[3:0]						trap_T4_1_0,
	input			[3:0]						trap_T4_1_1,
	input			[2:0]						trap_ans_T4_1_0,
	input			[2:0]						trap_ans_T4_1_1,
	input			[11 : 0]					d_T4_1,
	/*data*/
	input			[73:0]					sh_reg_T4_1,
	input			[55:0]					GP_n,
	input			[55:0]					GP_p,
	input			[55:0]					GP_z,
	input			[55:0]					GN_n,
	input			[55:0]					GN_p,
	input			[55:0]					GN_z,
	input			[55:0]					F,
	input			[48:0]					Carryp,
	input			[47:0]					Sump,
	/*输出*/
	/*absoluate value*/
	output		[74:0]					p_reg,
	/*leadingZeroAnticipate*/
	output		[9:0]						sh_num,
	output		[1:0]						esh,
	output		[11:0]						levelp_4_T4_2,
	output		[11:0]						leveln_4_T4_2,
//	output		[1:0]						revising_T4_2,
	/*control*/
	output	reg[11:0]					E_T4_2,
	output	reg							S_A_T4_2,
	output	reg							S_B_T4_2,
	output	reg							S_C_T4_2,
	output	reg							S_A_H_T4_2,
	output	reg							S_B_H_T4_2,
	output	reg							S_C_H_T4_2,
//	output	reg							s2_T4_2,//最终符号位低位
//	output	reg							s2h_T4_2,//高位
	output	reg[3:0]						trap_T4_2_0,
	output	reg[3:0]						trap_T4_2_1,
	output	reg[2:0]						trap_ans_T4_2_0,
	output	reg[2:0]						trap_ans_T4_2_1,
	output	reg[2:0]						cont_T4_2,

	output	reg[11:0]					d_T4_2
);
//	wire			[1:0]						d_s;
	wire			[25:0]					sh_left;
//	wire			[1:0]						revising;
	wire			[9:0]						P;
	wire			[1:0]						V;
	wire										cin;
	wire			[74:0]					p_reg_temp;
	wire			[47:0]					sum_cal;
/*	wire										s;
	wire										s_h;*/
//	wire			[73:0]					p_reg_lin;
	wire			[11:0]						levelp_4;
	wire			[11:0]						leveln_4;
	assign		sh_left			=			(cont_T4_1 == 3'b0 || cont_T4_1 == 3'b010) ? sh_reg_T4_1[73:48] : (cont_T4_1 == 3'b001) ? {sh_reg_T4_1[69:57],sh_reg_T4_1[34:22]} : 26'b0;
	LeadingZeroAnt_2 leadingzeroant_2(
		//输入
		.cont									(cont_T4_1), 
		.S_A									(S_A_T4_1),
		.S_B									(S_B_T4_1),
		.S_C									(S_C_T4_1),
		.GP_n									(GP_n),
		.GP_p									(GP_p),
		.GP_z									(GP_z),
		.GN_p									(GN_p),
		.GN_n									(GN_n),
		.GN_z									(GN_z),
		.F										(F),
		.S_A_H								(S_A_H_T4_1),
		.S_B_H								(S_B_H_T4_1),
		.S_C_H								(S_C_H_T4_1),
		//输出
//		.revising							(revising),
		.P										(P),
		.V										(V),
		.levelp_4							(levelp_4),
		.leveln_4							(leveln_4)
	);
	Adder		add(
		.x										(Carryp),
		.y										(Sump),
		.cout									(cin),
		.sum									(sum_cal)
	);
	CAL cal(
		.M_C									(sh_left),
		.sum									(sum_cal),
		.cont									(cont_T4_1),
		.S_A									(S_A_T4_1),
		.S_B									(S_B_T4_1),
		.S_C									(S_C_T4_1),
		.S_A_H								(S_A_H_T4_1),
		.S_B_H								(S_B_H_T4_1),
		.S_C_H								(S_C_H_T4_1),
		.cin									(cin),
		.p_reg_temp							(p_reg_temp)
	);
	T4_2_reg t4_2_reg(
		.clk									(clk),
		.rstn									(rstn),
		.cont									(cont_T4_1),
		.P										(P),
		.V										(V),
		.p_reg_temp							(p_reg_temp),
		.levelp_4_in							(levelp_4),
		.leveln_4_in						(leveln_4),
//		.revi									(revising_T4_2),
		
		.sh_num								(sh_num),
		.esh									(esh),
		.levelp_4_out						(levelp_4_T4_2),
		.leveln_4_out						(leveln_4_T4_2),
		.p_reg								(p_reg)					
	);
	/*传递控制信号*/
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			trap_T4_2_0 		<=			#`PERIOD 4'b0000;
			trap_T4_2_1 		<=			#`PERIOD	4'b0000;
			trap_ans_T4_2_0	<=		   #`PERIOD 3'b000;
			trap_ans_T4_2_1  	<=			#`PERIOD 3'b000;
			S_A_H_T4_2			<=			#`PERIOD	'b0;
			S_B_H_T4_2			<=			#`PERIOD	'b0;
			S_C_H_T4_2			<=			#`PERIOD 'b0;
			S_A_T4_2				<=			#`PERIOD	'b0;
			S_B_T4_2				<=			#`PERIOD	'b0;
			S_C_T4_2				<=			#`PERIOD	'b0;
			cont_T4_2			<=			#`PERIOD	3'b0;
			d_T4_2				<=			#`PERIOD 12'b0;
			E_T4_2				<=			#`PERIOD 12'b0;
		end else begin
			trap_T4_2_0			<=			#`PERIOD trap_T4_1_0;
			trap_T4_2_1			<=			#`PERIOD	trap_T4_1_1;
			trap_ans_T4_2_0	<=			#`PERIOD	trap_ans_T4_1_0;
			trap_ans_T4_2_1	<=			#`PERIOD	trap_ans_T4_1_1;
			S_A_H_T4_2			<=			#`PERIOD	S_A_H_T4_1;
			S_B_H_T4_2			<=			#`PERIOD S_B_H_T4_1;
			S_C_H_T4_2			<=			#`PERIOD	S_C_H_T4_1;
			S_A_T4_2				<=			#`PERIOD	S_A_T4_1;
			S_B_T4_2				<=			#`PERIOD	S_B_T4_1;
			S_C_T4_2				<=			#`PERIOD	S_C_T4_1;
			cont_T4_2			<=			#`PERIOD cont_T4_1;
			d_T4_2				<=			#`PERIOD d_T4_1;
			E_T4_2				<=			#`PERIOD E_T4_1;
		end
	end 
endmodule

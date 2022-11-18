`include	"conf.v"
module T4_1_stage(
	/*杈撳叆*/
	input										clk,
	input										rstn,
	input			[2:0]						cont_T3_2,
	input			[73:0]					sh_reg_T3_2,
	input			[47:0]					Sum,
	input			[47:0]					Carry,
	input										S_A_T3_2,
	input										S_B_T3_2,
	input										S_C_T3_2,
	input										S_A_H_T3_2,
	input										S_B_H_T3_2,
	input									S_C_H_T3_2,
	input			[11:0]					d_T3_2,
	input			[3:0]						trap_T3_2_0,
	input			[3:0]						trap_T3_2_1,
	input			[2:0]						trap_ans_T3_2_0,
	input			[2:0]						trap_ans_T3_2_1,
	input			[11 : 0]					E_T3_2,
	/*输出*/
	/*data*/
	output		[55:0]					GP_n,
	output		[55:0]					GP_p,
	output		[55:0]					GP_z,
	output		[55:0]					GN_n,
	output		[55:0]					GN_p,
	output		[55:0]					GN_z,
	output		[55:0]					F,
	output	reg[73:0]					sh_reg_T4_1,
	output		[48:0]					Carry_out,
	output		[47:0]					Sum_out,
	/*control*/
	output	reg[11:0]					E_T4_1,
	output	reg							S_A_T4_1,
	output	reg							S_B_T4_1,
	output	reg							S_C_T4_1,
	output	reg							S_A_H_T4_1,
	output	reg							S_B_H_T4_1,
	output	reg							S_C_H_T4_1,
	output	reg[3:0]						trap_T4_1_0,
	output	reg[3:0]						trap_T4_1_1,
	output	reg[2:0]						trap_ans_T4_1_0,
	output	reg[2:0]						trap_ans_T4_1_1,
	output	reg[2:0]						cont_T4_1,
	output	reg[11:0]					d_T4_1
);
	wire			[1:0]						d_s;
	wire			[25:0]					sh_left;
	wire			[47:0]					sh_right;
	wire										signal;
	wire										signal_h;
	wire			[48:0]					Carryp;
	wire			[47:0]					Sump;
	wire			[55:0]					GP_n_lin;
	wire			[55:0]					GP_p_lin;
	wire			[55:0]					GP_z_lin;
	wire			[55:0]					GN_n_lin;
	wire			[55:0]					GN_p_lin;
	wire			[55:0]					GN_z_lin;
	wire			[55:0]					F_lin;
	assign		sh_left			=			(cont_T3_2 == 3'b0 || cont_T3_2 == 3'b010) ? sh_reg_T3_2[73:48] : (cont_T3_2 == 3'b001) ? {sh_reg_T3_2[69:57],sh_reg_T3_2[34:22]} : 26'b0;
	assign		sh_right			=			(cont_T3_2 == 3'b0) ? sh_reg_T3_2[47:0] : (cont_T3_2 == 3'b001) ? {3'b0,sh_reg_T3_2[56:35],1'b0,sh_reg_T3_2[21:0]} 
														: (cont_T3_2 == 3'b010) ? {3'b0,22'b0,1'b0,sh_reg_T3_2[47:26]} : {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,40'b0};  
	assign		signal			=			(!S_A_T3_2 && !S_B_T3_2 && S_C_T3_2) || (!S_A_T3_2 && S_B_T3_2 && !S_C_T3_2) || (S_A_T3_2 && S_B_T3_2 && S_C_T3_2) || (S_A_T3_2 && !S_B_T3_2 && !S_C_T3_2);
	assign		signal_h			=			(!S_A_H_T3_2 && !S_B_H_T3_2 && S_C_H_T3_2) || (!S_A_H_T3_2 && S_B_H_T3_2 && !S_C_H_T3_2) || (S_A_H_T3_2 && S_B_H_T3_2 && S_C_H_T3_2) || (S_A_H_T3_2 && !S_B_H_T3_2 && !S_C_H_T3_2);
	assign		d_s[1:0]         =        d_T3_2[1:0];
	T4_CSA_file t4_csa(
		.in1										(Sum),
		.in2										(Carry),
		.in3										(sh_right),
		.signal									(signal),
		.signal_h								(signal_h),
		.cont										(cont_T3_2),
		.Carry									(Carryp),
		.Sum										(Sump)
	);
	LeadingZeroAnt_1 leadingzeroant_1(
		//输入
		.cont										(cont_T3_2),
		.Sum										(Sump),
		.Carry									(Carryp),
		.d											(d_s),
		.S_A										(S_A_T3_2),
		.S_B										(S_B_T3_2),
		.S_C										(S_C_T3_2),
		.S_A_H									(S_A_H_T3_2),
		.S_B_H									(S_B_H_T3_2),
		.S_C_H									(S_C_H_T3_2),
		.M_C_A									(sh_left),
		//输出
		.GP_n										(GP_n_lin),
		.GP_p										(GP_p_lin),
		.GP_z										(GP_z_lin),
		.GN_n										(GN_n_lin),
		.GN_p										(GN_p_lin),
		.GN_z										(GN_z_lin),
		.F											(F_lin)
	);
	T4_1_reg t4_1_reg(
		//输入
		.clk										(clk),
		.rstn										(rstn),
		.cont										(cont_T3_2),
		.GP_n_in									(GP_n_lin),
		.GP_p_in									(GP_p_lin),
		.GP_z_in									(GP_z_lin),
		.GN_n_in									(GN_n_lin),
		.GN_p_in									(GN_p_lin),
		.GN_z_in									(GN_z_lin),
		.F_in										(F_lin),
		.Carry_in								(Carryp),
		.Carry_out								(Carry_out),
		.Sum_in									(Sump),
		.Sum_out									(Sum_out),
		//输出
		.GP_n_out								(GP_n),
		.GP_p_out								(GP_p),
		.GP_z_out								(GP_z),
		.GN_z_out								(GN_z),
		.GN_p_out								(GN_p),
		.GN_n_out								 (GN_n),
		.F_out									(F)
	);
		/*传递控制信号*/
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			trap_T4_1_0 	<=			#`PERIOD 4'b0000;
			trap_T4_1_1 	<=			#`PERIOD	4'b0000;
			trap_ans_T4_1_0<=		   #`PERIOD 3'b000;
			trap_ans_T4_1_1<=			#`PERIOD 3'b000;
			S_A_H_T4_1		<=			#`PERIOD	'b0;
			S_B_H_T4_1		<=			#`PERIOD	'b0;
			S_C_H_T4_1		<=			#`PERIOD 'b0;
			S_A_T4_1			<=			#`PERIOD	'b0;
			S_B_T4_1			<=			#`PERIOD	'b0;
			S_C_T4_1			<=			#`PERIOD	'b0;
			cont_T4_1		<=			#`PERIOD	3'b0;
			d_T4_1			<=			#`PERIOD 12'b0;
			E_T4_1			<=			#`PERIOD 12'b0;
			sh_reg_T4_1		<=			#`PERIOD 74'b0;
		end else begin
			trap_T4_1_0		<=			#`PERIOD trap_T3_2_0;
			trap_T4_1_1		<=			#`PERIOD	trap_T3_2_1;
			trap_ans_T4_1_0<=			#`PERIOD	trap_ans_T3_2_0;
			trap_ans_T4_1_1<=			#`PERIOD	trap_ans_T3_2_1;
			S_A_H_T4_1		<=			#`PERIOD	S_A_H_T3_2;
			S_B_H_T4_1		<=			#`PERIOD S_B_H_T3_2;
			S_C_H_T4_1		<=			#`PERIOD	S_C_H_T3_2;
			S_A_T4_1			<=			#`PERIOD	S_A_T3_2;
			S_B_T4_1			<=			#`PERIOD	S_B_T3_2;
			S_C_T4_1			<=			#`PERIOD	S_C_T3_2;
			cont_T4_1		<=			#`PERIOD cont_T3_2;
			d_T4_1			<=			#`PERIOD d_T3_2;
			E_T4_1			<=			#`PERIOD E_T3_2;
			sh_reg_T4_1		<=			#`PERIOD sh_reg_T3_2;
		end
	end 
endmodule

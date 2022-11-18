`include	"conf.v"
module T2_reg(
	input				[575:0]				M_out_plain_in,
	input										clk,
	input										rstn,
	input										cont,
	input 		wire	         		S_A_T1,
	input 		wire						S_B_T1,
	input 		wire						S_C_T1,
	input			wire						S_A_H_T1,
	input			wire						S_B_H_T1,
	input			wire						S_C_H_T1,
	input			wire						d_lin,
	input 		wire		[13:0]		E_A,
	input 		wire		[13:0]		E_B,
	input 		wire		[13:0]		E_C,
	//输出
	output		reg						S_A_T2,
	output		reg						S_B_T2,
	output		reg						S_C_T2,
	output		reg						S_A_H_T2,
	output		reg						S_B_H_T2,
	output		reg						S_C_H_T2,

	output		reg		[2:0]			cont_T2,
	output		reg	[11:0]			d_T2,
	output		reg		[11:0]		E_T2,
	output	reg	[575:0]				M_out_plain_out
);
	wire                  [5:0]		tempa,tempb;
	assign  tempa = E_A[13:7] + E_B[13:7] - 7'd30;
	assign  tempb = E_C[13:7] - 7'b001_1101;
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
			M_out_plain_out <= #`PERIOD	576'b0;
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
			M_out_plain_out <= #`PERIOD   M_out_plain_in;
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
	end
endmodule
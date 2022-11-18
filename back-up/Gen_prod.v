module Gen_prod (
	input [31:0] A,
	input neg,
	input zero,
	input one,
	input two,
	output [63:0] prod
);

reg [63:0] prod_pre;

always @ (*) begin
	prod_pre = 64'd0;
	if (zero)      //如果编码器zero为1，则输出部分和为0
		prod_pre = 64'd0;
	else if (one) //如果编码器one为1，则输出部分和为被乘数；
		prod_pre = { { 32{A[31]} }, A};
	else if (two)  //如果编码器two为1，则输出部分和为被乘数左移1位；
		prod_pre = { { 31{A[31]} }, A, 1'b0};
end

assign prod = neg ? ( ~prod_pre+1'b1 ) : prod_pre; //如果是负数，则生成补码输出。
		
endmodule
module Full_adder(
    input a,
    input b,
	 input c,
	 input d,
    input cin,  //上一级进位
    
	 output cout,  //进位信号
	 output carry,
    output s
);

assign cout = a & b + a & c + b & c;
assign carry =(a ^ b ^ c)& d + (a ^ b ^ c)& cin + d & cin;
assign s = a ^ b ^ c ^ d ^ cin;


endmodule
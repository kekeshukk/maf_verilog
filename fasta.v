module fasta(
    input wire [7:0] a,
    input wire [7:0] b,
    input wire c_in,
    output wire [7:0] sum,
    output wire c_out
    );
    wire[8:0] g,p,c;//g和p的含义已经讲解了，c代表每一位计算的进位，c[0]表示原始的进位c_in
    assign c[0]=c_in;
    assign p=a ^ b;
    assign g=a & b;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & (g[0] | (p[0] & c[0])));
    assign c[3] = g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))));
    assign c[4] = g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))));
    assign c[5] = g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))));
    assign c[6] = g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))));
    assign c[7] = g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))));
    assign c[8] = g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))));
    assign sum=p^c[7:0];
    assign c_out=c[8];
endmodule

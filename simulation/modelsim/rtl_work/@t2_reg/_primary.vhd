library verilog;
use verilog.vl_types.all;
entity T2_reg is
    port(
        M_out_plain_in  : in     vl_logic_vector(575 downto 0);
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        cont            : in     vl_logic;
        S_A_T1          : in     vl_logic;
        S_B_T1          : in     vl_logic;
        S_C_T1          : in     vl_logic;
        S_A_H_T1        : in     vl_logic;
        S_B_H_T1        : in     vl_logic;
        S_C_H_T1        : in     vl_logic;
        d_lin           : in     vl_logic;
        E_A             : in     vl_logic_vector(13 downto 0);
        E_B             : in     vl_logic_vector(13 downto 0);
        E_C             : in     vl_logic_vector(13 downto 0);
        S_A_T2          : out    vl_logic;
        S_B_T2          : out    vl_logic;
        S_C_T2          : out    vl_logic;
        S_A_H_T2        : out    vl_logic;
        S_B_H_T2        : out    vl_logic;
        S_C_H_T2        : out    vl_logic;
        cont_T2         : out    vl_logic_vector(2 downto 0);
        d_T2            : out    vl_logic_vector(11 downto 0);
        E_T2            : out    vl_logic_vector(11 downto 0);
        M_out_plain_out : out    vl_logic_vector(575 downto 0)
    );
end T2_reg;

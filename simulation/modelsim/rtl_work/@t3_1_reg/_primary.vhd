library verilog;
use verilog.vl_types.all;
entity T3_1_reg is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        L3_level        : in     vl_logic_vector(287 downto 0);
        S_A_T2          : in     vl_logic;
        S_B_T2          : in     vl_logic;
        S_C_T2          : in     vl_logic;
        S_A_H_T2        : in     vl_logic;
        S_B_H_T2        : in     vl_logic;
        S_C_H_T2        : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        d_T2            : in     vl_logic_vector(11 downto 0);
        E_T2            : in     vl_logic_vector(11 downto 0);
        S_A_T3_1        : out    vl_logic;
        S_B_T3_1        : out    vl_logic;
        S_C_T3_1        : out    vl_logic;
        S_A_H_T3_1      : out    vl_logic;
        S_B_H_T3_1      : out    vl_logic;
        S_C_H_T3_1      : out    vl_logic;
        cont_T3_1       : out    vl_logic_vector(2 downto 0);
        d_T3_1          : out    vl_logic_vector(11 downto 0);
        E_T3_1          : out    vl_logic_vector(11 downto 0);
        Level_out       : out    vl_logic_vector(287 downto 0)
    );
end T3_1_reg;

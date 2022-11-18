library verilog;
use verilog.vl_types.all;
entity T3_2_reg is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        Carry_in        : in     vl_logic_vector(47 downto 0);
        Sum_in          : in     vl_logic_vector(47 downto 0);
        S_A_T3_1        : in     vl_logic;
        S_B_T3_1        : in     vl_logic;
        S_C_T3_1        : in     vl_logic;
        S_A_H_T3_1      : in     vl_logic;
        S_B_H_T3_1      : in     vl_logic;
        S_C_H_T3_1      : in     vl_logic;
        cont_T3_1       : in     vl_logic_vector(2 downto 0);
        d_T3_1          : in     vl_logic_vector(11 downto 0);
        E_T3_1          : in     vl_logic_vector(11 downto 0);
        sh_rev_reg_in   : in     vl_logic_vector(73 downto 0);
        sti             : in     vl_logic_vector(3 downto 0);
        sh_rev_reg_out  : out    vl_logic_vector(73 downto 0);
        Carry_out       : out    vl_logic_vector(47 downto 0);
        S_A_T3_2        : out    vl_logic;
        S_B_T3_2        : out    vl_logic;
        S_C_T3_2        : out    vl_logic;
        S_A_H_T3_2      : out    vl_logic;
        S_B_H_T3_2      : out    vl_logic;
        S_C_H_T3_2      : out    vl_logic;
        cont_T3_2       : out    vl_logic_vector(2 downto 0);
        d_T3_2          : out    vl_logic_vector(11 downto 0);
        E_T3_2          : out    vl_logic_vector(11 downto 0);
        sti_out         : out    vl_logic_vector(3 downto 0);
        Sum_out         : out    vl_logic_vector(47 downto 0)
    );
end T3_2_reg;

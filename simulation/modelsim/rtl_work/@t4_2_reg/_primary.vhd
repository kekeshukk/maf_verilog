library verilog;
use verilog.vl_types.all;
entity T4_2_reg is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        P               : in     vl_logic_vector(9 downto 0);
        V               : in     vl_logic_vector(1 downto 0);
        p_reg_temp      : in     vl_logic_vector(74 downto 0);
        levelp_4_in     : in     vl_logic_vector(11 downto 0);
        leveln_4_in     : in     vl_logic_vector(11 downto 0);
        S_A_T4_1        : in     vl_logic;
        S_B_T4_1        : in     vl_logic;
        S_C_T4_1        : in     vl_logic;
        S_A_H_T4_1      : in     vl_logic;
        S_B_H_T4_1      : in     vl_logic;
        S_C_H_T4_1      : in     vl_logic;
        E_T4_1          : in     vl_logic_vector(11 downto 0);
        d_T4_1          : in     vl_logic_vector(11 downto 0);
        E_T4_2          : out    vl_logic_vector(11 downto 0);
        S_A_T4_2        : out    vl_logic;
        S_B_T4_2        : out    vl_logic;
        S_C_T4_2        : out    vl_logic;
        S_A_H_T4_2      : out    vl_logic;
        S_B_H_T4_2      : out    vl_logic;
        S_C_H_T4_2      : out    vl_logic;
        cont_T4_2       : out    vl_logic_vector(2 downto 0);
        d_T4_2          : out    vl_logic_vector(11 downto 0);
        levelp_4_out    : out    vl_logic_vector(11 downto 0);
        leveln_4_out    : out    vl_logic_vector(11 downto 0);
        sh_num          : out    vl_logic_vector(9 downto 0);
        esh             : out    vl_logic_vector(1 downto 0);
        p_reg           : out    vl_logic_vector(74 downto 0)
    );
end T4_2_reg;

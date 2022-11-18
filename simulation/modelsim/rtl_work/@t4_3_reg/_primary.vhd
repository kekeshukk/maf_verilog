library verilog;
use verilog.vl_types.all;
entity T4_3_reg is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        cont_T4_2       : in     vl_logic_vector(2 downto 0);
        P               : in     vl_logic_vector(9 downto 0);
        V               : in     vl_logic_vector(1 downto 0);
        p_reg_temp      : in     vl_logic_vector(73 downto 0);
        revising        : in     vl_logic_vector(1 downto 0);
        S_A_T4_2        : in     vl_logic;
        S_B_T4_2        : in     vl_logic;
        S_C_T4_2        : in     vl_logic;
        S_A_H_T4_2      : in     vl_logic;
        S_B_H_T4_2      : in     vl_logic;
        S_C_H_T4_2      : in     vl_logic;
        E_PRE_C         : in     vl_logic_vector(11 downto 0);
        d_T4_2          : in     vl_logic_vector(11 downto 0);
        s               : in     vl_logic;
        s_h             : in     vl_logic;
        sh_num          : out    vl_logic_vector(9 downto 0);
        esh             : out    vl_logic_vector(1 downto 0);
        p_reg           : out    vl_logic_vector(73 downto 0);
        revi            : out    vl_logic_vector(1 downto 0);
        E_T4_3          : out    vl_logic_vector(11 downto 0);
        S_A_T4_3        : out    vl_logic;
        S_B_T4_3        : out    vl_logic;
        S_C_T4_3        : out    vl_logic;
        S_A_H_T4_3      : out    vl_logic;
        S_B_H_T4_3      : out    vl_logic;
        S_C_H_T4_3      : out    vl_logic;
        s2_T4_3         : out    vl_logic;
        s2h_T4_3        : out    vl_logic;
        cont_T4_3       : out    vl_logic_vector(2 downto 0);
        d_T4_3          : out    vl_logic_vector(11 downto 0)
    );
end T4_3_reg;

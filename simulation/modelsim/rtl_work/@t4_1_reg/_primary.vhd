library verilog;
use verilog.vl_types.all;
entity T4_1_reg is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        GP_n_in         : in     vl_logic_vector(55 downto 0);
        GP_p_in         : in     vl_logic_vector(55 downto 0);
        GP_z_in         : in     vl_logic_vector(55 downto 0);
        GN_n_in         : in     vl_logic_vector(55 downto 0);
        GN_p_in         : in     vl_logic_vector(55 downto 0);
        GN_z_in         : in     vl_logic_vector(55 downto 0);
        F_in            : in     vl_logic_vector(55 downto 0);
        Carry_in        : in     vl_logic_vector(48 downto 0);
        Sum_in          : in     vl_logic_vector(47 downto 0);
        S_A_T3_2        : in     vl_logic;
        S_B_T3_2        : in     vl_logic;
        S_C_T3_2        : in     vl_logic;
        S_A_H_T3_2      : in     vl_logic;
        S_B_H_T3_2      : in     vl_logic;
        S_C_H_T3_2      : in     vl_logic;
        sh_reg_T3_2     : in     vl_logic_vector(73 downto 0);
        d_T3_2          : in     vl_logic_vector(11 downto 0);
        E_T3_2          : in     vl_logic_vector(11 downto 0);
        Sum_out         : out    vl_logic_vector(47 downto 0);
        Carry_out       : out    vl_logic_vector(48 downto 0);
        GP_n_out        : out    vl_logic_vector(55 downto 0);
        GP_p_out        : out    vl_logic_vector(55 downto 0);
        GP_z_out        : out    vl_logic_vector(55 downto 0);
        GN_n_out        : out    vl_logic_vector(55 downto 0);
        GN_p_out        : out    vl_logic_vector(55 downto 0);
        GN_z_out        : out    vl_logic_vector(55 downto 0);
        sh_reg_T4_1     : out    vl_logic_vector(73 downto 0);
        F_out           : out    vl_logic_vector(55 downto 0);
        E_T4_1          : out    vl_logic_vector(11 downto 0);
        S_A_T4_1        : out    vl_logic;
        S_B_T4_1        : out    vl_logic;
        S_C_T4_1        : out    vl_logic;
        S_A_H_T4_1      : out    vl_logic;
        S_B_H_T4_1      : out    vl_logic;
        S_C_H_T4_1      : out    vl_logic;
        cont_T4_1       : out    vl_logic_vector(2 downto 0);
        d_T4_1          : out    vl_logic_vector(11 downto 0)
    );
end T4_1_reg;
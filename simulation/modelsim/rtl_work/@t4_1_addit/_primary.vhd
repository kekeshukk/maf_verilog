library verilog;
use verilog.vl_types.all;
entity T4_1_addit is
    port(
        cont_T3_2       : in     vl_logic_vector(2 downto 0);
        sh_reg_T3_2     : in     vl_logic_vector(73 downto 0);
        S_A_T3_2        : in     vl_logic;
        S_B_T3_2        : in     vl_logic;
        S_C_T3_2        : in     vl_logic;
        S_A_H_T3_2      : in     vl_logic;
        S_B_H_T3_2      : in     vl_logic;
        S_C_H_T3_2      : in     vl_logic;
        d_T3_2          : in     vl_logic_vector(11 downto 0);
        sh_left         : out    vl_logic_vector(25 downto 0);
        sh_right        : out    vl_logic_vector(47 downto 0);
        \signal\        : out    vl_logic;
        signal_h        : out    vl_logic;
        d_s             : out    vl_logic_vector(1 downto 0)
    );
end T4_1_addit;

library verilog;
use verilog.vl_types.all;
entity CAL is
    port(
        sh_reg_T4_1     : in     vl_logic_vector(73 downto 0);
        sum             : in     vl_logic_vector(47 downto 0);
        cin             : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C_H           : in     vl_logic;
        p_reg_temp      : out    vl_logic_vector(74 downto 0)
    );
end CAL;

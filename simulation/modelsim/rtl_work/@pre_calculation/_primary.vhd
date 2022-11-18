library verilog;
use verilog.vl_types.all;
entity Pre_calculation is
    port(
        cont_T_4_2      : in     vl_logic_vector(2 downto 0);
        E_T_4_2         : in     vl_logic_vector(11 downto 0);
        P               : in     vl_logic_vector(9 downto 0);
        V               : in     vl_logic_vector(1 downto 0);
        d_T_4_2         : in     vl_logic_vector(11 downto 0);
        E_PRE_C         : out    vl_logic_vector(11 downto 0)
    );
end Pre_calculation;

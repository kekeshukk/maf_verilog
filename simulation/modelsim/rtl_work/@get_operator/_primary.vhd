library verilog;
use verilog.vl_types.all;
entity Get_operator is
    port(
        M_C_A           : in     vl_logic_vector(25 downto 0);
        Sum             : in     vl_logic_vector(47 downto 0);
        Carry           : in     vl_logic_vector(48 downto 0);
        cont            : in     vl_logic_vector(2 downto 0);
        num_p_0         : out    vl_logic_vector(55 downto 0);
        num_p_1         : out    vl_logic_vector(55 downto 0);
        num_n_0         : out    vl_logic_vector(55 downto 0);
        num_n_1         : out    vl_logic_vector(55 downto 0)
    );
end Get_operator;

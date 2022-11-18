library verilog;
use verilog.vl_types.all;
entity Select_operator is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        num_p_0         : in     vl_logic_vector(55 downto 0);
        num_p_1         : in     vl_logic_vector(55 downto 0);
        num_n_0         : in     vl_logic_vector(55 downto 0);
        num_n_1         : in     vl_logic_vector(55 downto 0);
        d               : in     vl_logic_vector(1 downto 0);
        op_0            : out    vl_logic_vector(55 downto 0);
        op_1            : out    vl_logic_vector(55 downto 0)
    );
end Select_operator;

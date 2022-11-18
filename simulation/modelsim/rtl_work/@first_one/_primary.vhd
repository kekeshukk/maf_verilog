library verilog;
use verilog.vl_types.all;
entity First_one is
    port(
        F               : in     vl_logic_vector(31 downto 0);
        P               : out    vl_logic_vector(4 downto 0);
        V               : out    vl_logic
    );
end First_one;

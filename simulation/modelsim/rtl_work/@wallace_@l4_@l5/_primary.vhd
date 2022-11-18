library verilog;
use verilog.vl_types.all;
entity Wallace_L4_L5 is
    port(
        Level_in        : in     vl_logic_vector(287 downto 0);
        Carry           : out    vl_logic_vector(47 downto 0);
        Sum             : out    vl_logic_vector(47 downto 0)
    );
end Wallace_L4_L5;

library verilog;
use verilog.vl_types.all;
entity First_one_16 is
    port(
        V3_0            : in     vl_logic;
        V3_1            : in     vl_logic;
        P3_0            : in     vl_logic_vector(2 downto 0);
        P3_1            : in     vl_logic_vector(2 downto 0);
        P4_0            : out    vl_logic_vector(3 downto 0);
        V4_0            : out    vl_logic
    );
end First_one_16;

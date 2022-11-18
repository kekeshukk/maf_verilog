library verilog;
use verilog.vl_types.all;
entity First_one_8 is
    port(
        V2_0            : in     vl_logic;
        V2_1            : in     vl_logic;
        P2_0            : in     vl_logic_vector(1 downto 0);
        P2_1            : in     vl_logic_vector(1 downto 0);
        P3_0            : out    vl_logic_vector(2 downto 0);
        V3_0            : out    vl_logic
    );
end First_one_8;

library verilog;
use verilog.vl_types.all;
entity First_one_32 is
    port(
        V4_0            : in     vl_logic;
        V4_1            : in     vl_logic;
        P4_0            : in     vl_logic_vector(3 downto 0);
        P4_1            : in     vl_logic_vector(3 downto 0);
        P5_0            : out    vl_logic_vector(4 downto 0);
        V5_0            : out    vl_logic
    );
end First_one_32;

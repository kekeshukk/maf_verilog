library verilog;
use verilog.vl_types.all;
entity First_one_4 is
    port(
        p1              : in     vl_logic;
        p2              : in     vl_logic;
        v1              : in     vl_logic;
        v2              : in     vl_logic;
        P               : out    vl_logic_vector(1 downto 0);
        V               : out    vl_logic
    );
end First_one_4;

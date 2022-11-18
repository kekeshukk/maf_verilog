library verilog;
use verilog.vl_types.all;
entity Adder is
    port(
        x               : in     vl_logic_vector(48 downto 0);
        y               : in     vl_logic_vector(47 downto 0);
        sum             : out    vl_logic_vector(47 downto 0);
        cout            : out    vl_logic
    );
end Adder;

library verilog;
use verilog.vl_types.all;
entity F_t_chip is
    port(
        in1             : in     vl_logic;
        in2             : in     vl_logic;
        in3             : in     vl_logic;
        in4             : in     vl_logic;
        cin             : in     vl_logic;
        cout            : out    vl_logic;
        carry           : out    vl_logic;
        sum             : out    vl_logic
    );
end F_t_chip;

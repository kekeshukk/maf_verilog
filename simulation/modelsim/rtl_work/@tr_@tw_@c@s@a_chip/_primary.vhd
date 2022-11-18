library verilog;
use verilog.vl_types.all;
entity Tr_Tw_CSA_chip is
    port(
        x               : in     vl_logic;
        y               : in     vl_logic;
        z               : in     vl_logic;
        s               : out    vl_logic;
        c               : out    vl_logic
    );
end Tr_Tw_CSA_chip;

library verilog;
use verilog.vl_types.all;
entity LeadingZeroAnt_3 is
    port(
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C_H           : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        levelp_4        : in     vl_logic_vector(11 downto 0);
        leveln_4        : in     vl_logic_vector(11 downto 0);
        revising        : out    vl_logic_vector(1 downto 0)
    );
end LeadingZeroAnt_3;

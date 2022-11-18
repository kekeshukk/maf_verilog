library verilog;
use verilog.vl_types.all;
entity Reverse is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        sh_reg          : in     vl_logic_vector(75 downto 0);
        S_A             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B             : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C             : in     vl_logic;
        S_C_H           : in     vl_logic;
        sh_rev_reg      : out    vl_logic_vector(73 downto 0);
        sti             : out    vl_logic_vector(3 downto 0)
    );
end Reverse;

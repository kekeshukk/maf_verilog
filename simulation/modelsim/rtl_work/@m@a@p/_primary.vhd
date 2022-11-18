library verilog;
use verilog.vl_types.all;
entity \MAP\ is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        C               : in     vl_logic_vector(31 downto 0);
        cont            : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end \MAP\;

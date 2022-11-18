library verilog;
use verilog.vl_types.all;
entity ASC is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        E_A             : in     vl_logic_vector(13 downto 0);
        E_B             : in     vl_logic_vector(13 downto 0);
        E_C             : in     vl_logic_vector(13 downto 0);
        sh_num          : out    vl_logic_vector(11 downto 0);
        d               : out    vl_logic_vector(11 downto 0)
    );
end ASC;

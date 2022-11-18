library verilog;
use verilog.vl_types.all;
entity MaF is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        M_in            : in     vl_logic_vector(23 downto 0);
        s2_T4           : in     vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        E               : in     vl_logic_vector(11 downto 0);
        s2h_T4          : in     vl_logic
    );
end MaF;

library verilog;
use verilog.vl_types.all;
entity Shift_reg is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        M_C             : in     vl_logic_vector(23 downto 0);
        sh_reg          : out    vl_logic_vector(75 downto 0)
    );
end Shift_reg;

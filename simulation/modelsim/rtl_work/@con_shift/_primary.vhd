library verilog;
use verilog.vl_types.all;
entity Con_shift is
    port(
        d_temp          : in     vl_logic_vector(11 downto 0);
        p_reg           : in     vl_logic_vector(73 downto 0);
        cont            : in     vl_logic_vector(2 downto 0);
        con_sh          : out    vl_logic_vector(73 downto 0)
    );
end Con_shift;

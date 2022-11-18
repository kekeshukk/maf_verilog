library verilog;
use verilog.vl_types.all;
entity Shifting is
    port(
        sh_in_reg       : in     vl_logic_vector(75 downto 0);
        cont            : in     vl_logic_vector(2 downto 0);
        sh_num          : in     vl_logic_vector(11 downto 0);
        sh_out_reg      : out    vl_logic_vector(75 downto 0)
    );
end Shifting;

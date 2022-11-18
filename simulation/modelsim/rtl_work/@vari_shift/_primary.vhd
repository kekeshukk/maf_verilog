library verilog;
use verilog.vl_types.all;
entity Vari_shift is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        sh_num          : in     vl_logic_vector(9 downto 0);
        esh             : in     vl_logic_vector(1 downto 0);
        con_sh          : in     vl_logic_vector(73 downto 0);
        revise          : in     vl_logic_vector(1 downto 0);
        M_result        : out    vl_logic_vector(23 downto 0)
    );
end Vari_shift;

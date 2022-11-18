library verilog;
use verilog.vl_types.all;
entity Multiple is
    generic(
        PSIZE           : integer := 6
    );
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        M_A             : in     vl_logic_vector(23 downto 0);
        M_B             : in     vl_logic_vector(23 downto 0);
        M_out_plain     : out    vl_logic_vector(575 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PSIZE : constant is 1;
end Multiple;

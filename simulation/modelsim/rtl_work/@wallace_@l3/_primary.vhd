library verilog;
use verilog.vl_types.all;
entity Wallace_L3 is
    generic(
        num_L_2         : integer := 3
    );
    port(
        M_out_plain_in  : in     vl_logic_vector(575 downto 0);
        L3_level        : out    vl_logic_vector(287 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of num_L_2 : constant is 1;
end Wallace_L3;

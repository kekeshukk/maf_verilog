library verilog;
use verilog.vl_types.all;
entity Tr_Tw_CSA_file is
    generic(
        SIZE            : integer := 48
    );
    port(
        in1             : in     vl_logic_vector(47 downto 0);
        in2             : in     vl_logic_vector(47 downto 0);
        in3             : in     vl_logic_vector(47 downto 0);
        carry           : out    vl_logic_vector(47 downto 0);
        sum             : out    vl_logic_vector(47 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE : constant is 1;
end Tr_Tw_CSA_file;

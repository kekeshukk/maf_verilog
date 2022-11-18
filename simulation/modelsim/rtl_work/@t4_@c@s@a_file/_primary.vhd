library verilog;
use verilog.vl_types.all;
entity T4_CSA_file is
    generic(
        PSIZE           : integer := 48
    );
    port(
        in1             : in     vl_logic_vector(47 downto 0);
        in2             : in     vl_logic_vector(47 downto 0);
        in3             : in     vl_logic_vector(47 downto 0);
        \signal\        : in     vl_logic;
        signal_h        : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        Carry           : out    vl_logic_vector(48 downto 0);
        Sum             : out    vl_logic_vector(47 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PSIZE : constant is 1;
end T4_CSA_file;

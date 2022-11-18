library verilog;
use verilog.vl_types.all;
entity F_t_file is
    generic(
        SIZE            : integer := 47
    );
    port(
        P_1             : in     vl_logic_vector(47 downto 0);
        P_2             : in     vl_logic_vector(47 downto 0);
        P_3             : in     vl_logic_vector(47 downto 0);
        P_4             : in     vl_logic_vector(47 downto 0);
        Carry           : out    vl_logic_vector(47 downto 0);
        Sum             : out    vl_logic_vector(47 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE : constant is 1;
end F_t_file;

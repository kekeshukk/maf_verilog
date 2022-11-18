library verilog;
use verilog.vl_types.all;
entity LeadingZeroAnt_2 is
    port(
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C_H           : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        GP_n            : in     vl_logic_vector(55 downto 0);
        GP_p            : in     vl_logic_vector(55 downto 0);
        GP_z            : in     vl_logic_vector(55 downto 0);
        GN_n            : in     vl_logic_vector(55 downto 0);
        GN_p            : in     vl_logic_vector(55 downto 0);
        GN_z            : in     vl_logic_vector(55 downto 0);
        F               : in     vl_logic_vector(55 downto 0);
        levelp_4        : out    vl_logic_vector(11 downto 0);
        leveln_4        : out    vl_logic_vector(11 downto 0);
        V               : out    vl_logic_vector(1 downto 0);
        P               : out    vl_logic_vector(9 downto 0)
    );
end LeadingZeroAnt_2;

library verilog;
use verilog.vl_types.all;
entity LeadingZeroAnt_1 is
    port(
        M_C_A           : in     vl_logic_vector(25 downto 0);
        Sum             : in     vl_logic_vector(47 downto 0);
        Carry           : in     vl_logic_vector(48 downto 0);
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C_H           : in     vl_logic;
        d               : in     vl_logic_vector(1 downto 0);
        cont            : in     vl_logic_vector(2 downto 0);
        GP_n            : out    vl_logic_vector(55 downto 0);
        GP_p            : out    vl_logic_vector(55 downto 0);
        GP_z            : out    vl_logic_vector(55 downto 0);
        GN_n            : out    vl_logic_vector(55 downto 0);
        GN_p            : out    vl_logic_vector(55 downto 0);
        GN_z            : out    vl_logic_vector(55 downto 0);
        F               : out    vl_logic_vector(55 downto 0)
    );
end LeadingZeroAnt_1;

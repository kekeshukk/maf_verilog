library verilog;
use verilog.vl_types.all;
entity Revising_1 is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        GP_p            : in     vl_logic_vector(55 downto 0);
        GP_n            : in     vl_logic_vector(55 downto 0);
        GP_z            : in     vl_logic_vector(55 downto 0);
        GN_p            : in     vl_logic_vector(55 downto 0);
        GN_n            : in     vl_logic_vector(55 downto 0);
        GN_z            : in     vl_logic_vector(55 downto 0);
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C_H           : in     vl_logic;
        levelp_4_out    : out    vl_logic_vector(11 downto 0);
        leveln_4_out    : out    vl_logic_vector(11 downto 0)
    );
end Revising_1;

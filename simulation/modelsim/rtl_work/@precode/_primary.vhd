library verilog;
use verilog.vl_types.all;
entity Precode is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        op0             : in     vl_logic_vector(55 downto 0);
        op1             : in     vl_logic_vector(55 downto 0);
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        S_C_H           : in     vl_logic;
        F               : out    vl_logic_vector(55 downto 0);
        GP_p            : out    vl_logic_vector(55 downto 0);
        GP_n            : out    vl_logic_vector(55 downto 0);
        GP_z            : out    vl_logic_vector(55 downto 0);
        GN_p            : out    vl_logic_vector(55 downto 0);
        GN_n            : out    vl_logic_vector(55 downto 0);
        GN_z            : out    vl_logic_vector(55 downto 0)
    );
end Precode;

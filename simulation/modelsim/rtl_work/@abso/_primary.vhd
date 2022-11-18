library verilog;
use verilog.vl_types.all;
entity Abso is
    port(
        cont            : in     vl_logic_vector(2 downto 0);
        p_reg_temp      : in     vl_logic_vector(74 downto 0);
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_A_H           : in     vl_logic;
        S_B_H           : in     vl_logic;
        s2              : out    vl_logic;
        s2_h            : out    vl_logic;
        p_reg           : out    vl_logic_vector(73 downto 0)
    );
end Abso;

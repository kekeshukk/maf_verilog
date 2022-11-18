library verilog;
use verilog.vl_types.all;
entity Pretreatment is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        C               : in     vl_logic_vector(31 downto 0);
        cont            : in     vl_logic_vector(2 downto 0);
        M_A             : out    vl_logic_vector(23 downto 0);
        M_B             : out    vl_logic_vector(23 downto 0);
        M_C             : out    vl_logic_vector(23 downto 0);
        E_A             : out    vl_logic_vector(13 downto 0);
        E_B             : out    vl_logic_vector(13 downto 0);
        E_C             : out    vl_logic_vector(13 downto 0);
        S_A             : out    vl_logic;
        S_B             : out    vl_logic;
        S_C             : out    vl_logic;
        S_A_H           : out    vl_logic;
        S_B_H           : out    vl_logic;
        S_C_H           : out    vl_logic;
        con_state       : out    vl_logic_vector(2 downto 0)
    );
end Pretreatment;

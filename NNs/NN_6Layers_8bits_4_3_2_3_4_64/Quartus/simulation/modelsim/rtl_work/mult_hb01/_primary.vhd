library verilog;
use verilog.vl_types.all;
entity mult_hb01 is
    port(
        dataa           : in     vl_logic_vector(7 downto 0);
        datab           : in     vl_logic_vector(7 downto 0);
        result          : out    vl_logic_vector(15 downto 0)
    );
end mult_hb01;

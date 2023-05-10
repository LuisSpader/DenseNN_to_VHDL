
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE parameters IS
    CONSTANT BITS : INTEGER := 8; --You need to change this depending on each desired input/output BITS
    CONSTANT clk_hz     : INTEGER                              := 100e6;
    CONSTANT clk_period : TIME                                 := 1 sec / clk_hz;

    
    CONSTANT FIRST_LAYER_NEURONS : INTEGER := 3;
    CONSTANT BITS_FX_IN : INTEGER := 2 * BITS;
    CONSTANT BITS_FX_OUT : INTEGER := BITS;
    CONSTANT Leaky_attenuation : NATURAL := 2;
    CONSTANT Leaky_ReLU_ones : signed (Leaky_attenuation - 1 DOWNTO 0) := (OTHERS => '1');

    CONSTANT ones : STD_LOGIC_VECTOR (BITS - 1 DOWNTO 0) := (OTHERS => '1'); --"1111..."
    CONSTANT zeros : signed (BITS - 1 DOWNTO 0) := (OTHERS => '0'); --"0000..."
    CONSTANT bias_val : signed (BITS - 1 DOWNTO 0) := (BITS - 2 => '1', OTHERS => '0'); --"0000..."

    CONSTANT signed_max_2xbit : signed ((2 * BITS) - 1 DOWNTO 0) := ((2 * BITS) - 1 => '0', OTHERS => '1'); --"0000..."
    CONSTANT signed_max : signed (BITS - 1 DOWNTO 0) := (BITS - 1 => '0', OTHERS => '1'); --"0000..."
    CONSTANT MAC_IN_BITS_rescale: integer := 1;
    CONSTANT MAC_OUT_BITS_rescale: integer := 2;


END parameters;
PACKAGE BODY parameters IS
END parameters;
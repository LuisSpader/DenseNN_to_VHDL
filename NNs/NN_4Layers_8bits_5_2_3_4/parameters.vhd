
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE parameters IS
    CONSTANT BITS : INTEGER := 8; --You need to change this depending on each desired input/output BITS
    CONSTANT ones : STD_LOGIC_VECTOR (BITS - 1 DOWNTO 0) := (OTHERS => '1'); --"0000..."

END parameters;
PACKAGE BODY parameters IS
END parameters;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY Adder IS
    GENERIC (
        BITS : NATURAL := BITS
    );
    PORT (
        A : IN signed((2 * BITS) - 1 DOWNTO 0);
        B : IN signed((2 * BITS) - 1 DOWNTO 0);
        S : OUT signed((2 * BITS) -1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Adder IS
BEGIN
    S <= A + B;
END ARCHITECTURE;
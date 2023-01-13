LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Adder_reg IS
    GENERIC (
        BITS : NATURAL := 8
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        A : IN signed((2 * BITS) - 1 DOWNTO 0);
        B : IN signed((2 * BITS) - 1 DOWNTO 0);
        S : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Adder_reg IS
    SIGNAL signal_S : signed((2 * BITS) - 1 DOWNTO 0);

BEGIN
    signal_S <= A + B;

    PROCESS (rst, clk)
    BEGIN
        IF (rst = '1') THEN
            S <= (OTHERS => '0');
        ELSE
            IF (clk'event AND clk = '1') THEN --se tem evento de clock
                S <= signal_S;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;
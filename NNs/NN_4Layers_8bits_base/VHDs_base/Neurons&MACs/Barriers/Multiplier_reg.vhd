LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Multiplier_reg IS
    GENERIC (
        BITS : NATURAL := 8
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        X : IN signed((BITS) - 1 DOWNTO 0);
        W : IN signed((BITS) - 1 DOWNTO 0);
        Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Multiplier_reg IS
    SIGNAL signal_Y : signed((2 * BITS) - 1 DOWNTO 0);

BEGIN
    signal_Y <= X * W;

    PROCESS (rst, clk)
    BEGIN
        IF (rst = '1') THEN
            Y <= (OTHERS => '0');
        ELSE
            IF (clk'event AND clk = '1') THEN --se tem evento de clock
                Y <= signal_Y;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
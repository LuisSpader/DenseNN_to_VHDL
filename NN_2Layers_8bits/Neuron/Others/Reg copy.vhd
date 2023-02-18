
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY Reg IS
    GENERIC (
        BITS : NATURAL := BITS
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        D : IN signed (BITS - 1 DOWNTO 0);
        Q : OUT signed (BITS - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Reg IS
    SIGNAL data : signed (BITS - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
    Q <= data;

    CLK_PROC : PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            data <= (OTHERS => '0');
        ELSE
            IF clk'event AND (clk = '1') THEN
                data <= D;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
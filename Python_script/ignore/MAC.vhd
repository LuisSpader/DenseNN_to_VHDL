LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY MAC IS
    PORT (
        bias : IN signed(7 DOWNTO 0);
        x1, x2, x3 : IN signed(7 DOWNTO 0);
        w1, w2, w3 : IN signed(7 DOWNTO 0);
        ----------------------------------------------
        y : OUT signed(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch OF MAC IS

    ---------- SINAIS ----------
    SIGNAL sbias : signed(7 DOWNTO 0);
    SIGNAL sum_all : signed(15 DOWNTO 0);
    SIGNAL sx1, sx2, sx3 : signed(7 DOWNTO 0);
    SIGNAL sw1, sw2, sw3 : signed(7 DOWNTO 0);
BEGIN

    sbias <= bias;
    sx1 <= x1;
    sx2 <= x2;
    sx3 <= x3;
    sw1 <= w1;
    sw2 <= w2;
    sw3 <= w3;

    sum_all <= ((signed(sx1) * signed(sw1)) +
        (signed(sx2) * signed(sw2)) +
        (signed(sx3) * signed(sw3)) + signed(sbias));
    ------------------
    y <= signed(sum_all(15 DOWNTO 8));

END arch;
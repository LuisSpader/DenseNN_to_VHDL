LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
ENTITY  MAC IS
  PORT (
    clk, rst: IN STD_LOGIC;
    bias: IN signed(7 DOWNTO 0);
    x1, x2, x3: IN signed(7 DOWNTO 0);
    w1, w2, w3: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  MAC  IS
------------- SINAIS -------------

        SIGNAL sbias : signed(7 DOWNTO 0);        
        SIGNAL sum_all : signed( 15 DOWNTO 0);    
        SIGNAL sx1, sx2, sx3: signed(7 DOWNTO 0);
        SIGNAL sw1, sw2, sw3: signed(7 DOWNTO 0);
        SIGNAL soma_1, soma_2, soma_3: signed(15 DOWNTO 0);
        SIGNAL mult_1, mult_2, mult_3: signed(15 DOWNTO 0);


BEGIN

  sbias <= bias;
  sx1 <= x1;
  sx2 <= x2;
  sx3 <= x3;
  sw1 <= w1;
  sw2 <= w2;
  sw3 <= w3;
        ------------------
        PROCESS (rst, clk)
        BEGIN
                IF (rst = '1') THEN
                        soma_1 <= (OTHERS => '0');
                        soma_2 <= (OTHERS => '0');
                        soma_3 <= (OTHERS => '0');
                        mult_1 <= (OTHERS => '0');
                        mult_2 <= (OTHERS => '0');
                        mult_3 <= (OTHERS => '0');
                ELSE
                        IF (clk'event AND clk = '1') THEN --se tem evento de clock
                                y <= signed(soma_3(15 DOWNTO 8));
                                mult_1 <= (signed(sx1) * signed(sw1));
                                mult_2 <= (signed(sx2) * signed(sw2));
                                mult_3 <= (signed(sx3) * signed(sw3));
                                soma_1 <=  mult_1 + mult_2;
                                soma_2 <=  soma_1 + mult_3;
                                soma_3 <= soma_2 + sbias;


                        END IF;
                END IF;
        END PROCESS;

END arch;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  MAC_comb_10n_8bit_signed_mult0_v0_add0_v0 IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 10;
        TOTAL_BITS : NATURAL := 80
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(7 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE arch OF  MAC_comb_10n_8bit_signed_mult0_v0_add0_v0  IS

    ---------- SINAIS ----------
	SIGNAL sum_all : signed((2*BITS) - 1 DOWNTO 0);
  SIGNAL s_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);
    
  COMPONENT mult0_v0 IS
    GENERIC (
      BITS : NATURAL := BITS
    );
    PORT (
      X : IN signed((BITS) - 1 DOWNTO 0);
      W : IN signed((BITS) - 1 DOWNTO 0);
      Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;

BEGIN
  s_Xi <= IO_in;
  s_Win <= W_in;


  sum_all <= (s_mult(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))) + 
    s_mult(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))) + 
    s_mult(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (2))) + 
    s_mult(((2 * BITS) * (3 + 1)) - 1 DOWNTO ((2 * BITS) * (3))) + 
    s_mult(((2 * BITS) * (4 + 1)) - 1 DOWNTO ((2 * BITS) * (4))) + 
    s_mult(((2 * BITS) * (5 + 1)) - 1 DOWNTO ((2 * BITS) * (5))) + 
    s_mult(((2 * BITS) * (6 + 1)) - 1 DOWNTO ((2 * BITS) * (6))) + 
    s_mult(((2 * BITS) * (7 + 1)) - 1 DOWNTO ((2 * BITS) * (7))) + 
    s_mult(((2 * BITS) * (8 + 1)) - 1 DOWNTO ((2 * BITS) * (8))) + 
    s_mult(((2 * BITS) * (9 + 1)) - 1 DOWNTO ((2 * BITS) * (9))) + 
    s_Win((BITS * (10 + 1)) - 1 DOWNTO (BITS * (10)))); 

loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : mult0_v0
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
                        IO_out <= (OTHERS => '0');
		ELSE
			IF (clk'event AND clk = '1') THEN --se tem evento de clock
                                IO_out <= signed(sum_all(15 DOWNTO 8));
			END IF;
		END IF;
	END PROCESS;


END arch;

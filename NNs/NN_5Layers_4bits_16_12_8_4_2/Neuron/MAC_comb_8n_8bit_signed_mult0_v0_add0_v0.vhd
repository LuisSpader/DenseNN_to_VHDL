LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  MAC_comb_8n_8bit_signed_mult0_v0_add0_v0 IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 8;
        TOTAL_BITS : NATURAL := 64
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed((MAC_OUT_BITS_rescale*BITS) -1 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE arch OF  MAC_comb_8n_8bit_signed_mult0_v0_add0_v0  IS

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
    s_Win((BITS * (8 + 1)) - 1 DOWNTO (BITS * (8)))); 

loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : mult0_v0
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;
IO_out <= signed(sum_all);
END arch;

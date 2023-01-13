LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

ENTITY MAC_comb_5n_8bit_signed_mul0_v0_add0_v0 IS
  GENERIC (
    BITS : NATURAL := 8;
    NUM_INPUTS : NATURAL := 5
  );
  PORT (
    clk, rst : IN STD_LOGIC;
    -- x1, x2, x3, x4, x5 : IN signed(BITS - 1 DOWNTO 0);
    -- w1, w2, w3, w4, w5 : IN signed(BITS - 1 DOWNTO 0);
    -- bias : IN signed(BITS - 1 DOWNTO 0);
    Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
    Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    ----------------------------------------------
    y : OUT signed(BITS - 1 DOWNTO 0)
    -- out_w1, out_w2, out_w3, out_w4, out_w5 : OUT signed(7 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF MAC_comb_5n_8bit_signed_mul0_v0_add0_v0 IS

  ---------- SINAIS ----------
  SIGNAL sum_all : signed((2 * BITS) - 1 DOWNTO 0);
  -- SIGNAL sbias : signed(BITS - 1 DOWNTO 0);
  -- SIGNAL sx1, sx2, sx3, sx4, sx5 : signed(BITS - 1 DOWNTO 0);
  -- SIGNAL sw1, sw2, sw3, sw4, sw5 : signed(BITS - 1 DOWNTO 0);
  -- ----------------
  SIGNAL s_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);
  -- SIGNAL s_add_mid : signed((((2 * BITS) + 1) * NUM_INPUTS) - 1 DOWNTO 0);
  -- SIGNAL s_add_end : signed(((2 * BITS) + NUM_INPUTS) - 1 DOWNTO 0);

  -- -------------
  COMPONENT Multiplier IS
    GENERIC (
      BITS : NATURAL := 8
    );
    PORT (
      X : IN signed((BITS) - 1 DOWNTO 0);
      W : IN signed((BITS) - 1 DOWNTO 0);
      Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Adder IS
    GENERIC (
      BITS : NATURAL := 8
    );
    PORT (
      A : IN signed((2 * BITS) - 1 DOWNTO 0);
      B : IN signed((2 * BITS) - 1 DOWNTO 0);
      S : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;

BEGIN
  s_Xi <= Xi;
  s_Win <= Win;

  -- sbias <= bias;
  -- sx1 <= x1;
  -- sx2 <= x2;
  -- sx3 <= x3;
  -- sx4 <= x4;
  -- sx5 <= x5;
  -- sw1 <= w1;
  -- sw2 <= w2;
  -- sw3 <= w3;
  -- sw4 <= w4;
  -- sw5 <= w5;

  sum_all <= (s_mult(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))) +
    s_mult(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))) +
    s_mult(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (2))) +
    s_mult(((2 * BITS) * (3 + 1)) - 1 DOWNTO ((2 * BITS) * (3))) +
    s_mult(((2 * BITS) * (4 + 1)) - 1 DOWNTO ((2 * BITS) * (4))) + s_Win((BITS * (5 + 1)) - 1 DOWNTO (BITS * (5))));

  loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    Multiplier_inst_loop : Multiplier
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;

  -- Adder_inst_loop : Adder
  -- PORT MAP(
  --   A => s_mult(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))),
  --   B => s_mult(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))),
  --   S => s_add_mid((((2 * BITS)) * (0 + 1)) - 1 DOWNTO (2 * BITS) * (0))
  -- );

  -- loop_Adder_port_map : FOR i IN 1 TO (NUM_INPUTS/2) - 1 GENERATE
  --   Adder_inst_loop : Adder
  --   PORT MAP(
  --     A => s_mult(((2 * BITS) * 2 * (i + 1)) - (2 * BITS) - 1 DOWNTO (2 * BITS) * (2 * i)),
  --     B => s_mult(((2 * BITS) * 2 * (i + 1)) - 1 DOWNTO (2 * BITS) * ((2 * i) + 1)),
  --     S => s_add_mid((((2 * BITS)) * (i + 1)) - 1 DOWNTO (2 * BITS) * (i))
  --   );
  -- END GENERATE;

  -- sum_all <= s_mult + s_Win((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS)));

  -- Adder_final_inst : Adder
  -- PORT MAP(
  --   A = >,
  --   B = >,
  --   S =>
  -- );

  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      y <= (OTHERS => '0');
    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        y <= signed(sum_all(15 DOWNTO 8));
      END IF;
    END IF;
  END PROCESS;
END arch;
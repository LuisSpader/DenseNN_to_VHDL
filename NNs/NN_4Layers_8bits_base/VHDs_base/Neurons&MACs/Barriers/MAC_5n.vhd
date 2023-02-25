LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
ENTITY MAC_3n IS
  GENERIC (
    BITS : NATURAL := 8;
    NUM_INPUTS : NATURAL := 5;
    TOTAL_BITS : NATURAL := BITS * NUM_INPUTS
  );
  PORT (
    clk, rst : IN STD_LOGIC;
    Xi : IN signed((TOTAL_BITS) - 1 DOWNTO 0);
    Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    ----------------------------------------------
    y : OUT signed(BITS - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF MAC_3n IS

  ---------- SINAIS ----------
  SIGNAL sum_all : signed(((2 * BITS) * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);

  COMPONENT mult0_v0 IS
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
      BITS : NATURAL := BITS
    );
    PORT (
      A : IN signed((2 * BITS) - 1 DOWNTO 0);
      B : IN signed((2 * BITS) - 1 DOWNTO 0);
      S : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;
  ------------- SINAIS 2 ------------

  -- SIGNAL sum_all : signed(15 DOWNTO 0);
  -- SIGNAL sx1, sx2, sx3 : signed(7 DOWNTO 0);
  -- SIGNAL sw1, sw2, sw3 : signed(7 DOWNTO 0);
  SIGNAL sbias : signed(7 DOWNTO 0);
  SIGNAL soma_1, soma_2, soma_3 : signed((2 * BITS) - 1 DOWNTO 0);
  SIGNAL soma_1_reg, soma_2_reg, soma_3_reg : signed((2 * BITS) - 1 DOWNTO 0);
  SIGNAL mult_1, mult_2, mult_3 : signed((2 * BITS) - 1 DOWNTO 0);
BEGIN
  s_Xi <= Xi;
  s_Win <= Win;

  -- sx1 <= x1;
  -- sx2 <= x2;
  -- sx3 <= x3;
  -- sw1 <= w1;
  -- sw2 <= w2;
  -- sw3 <= w3;
  -- y <= signed(sum_all(15 DOWNTO 8));

  -- ----------------- MULTIPLIERS ------------------------------
  # multiplicadores
  loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : mult0_v0
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;

  # Registradores saída dos multiplicadores
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      s_mult_reg <= (OTHERS => '0');
    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        s_mult_reg <= s_mult;
      END IF;
    END IF;
  END PROCESS;
  -- --------------------- ADDERS --------------------------
  mult_1 <= s_mult_reg(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))); -- 15 DOWNTO 0;
  mult_2 <= s_mult_reg(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))); -- 31 DOWNTO 16;
  mult_3 <= s_mult_reg(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (2))); -- 31 DOWNTO 16;

  bias <= s_Win((BITS * (3 + 1)) - 1 DOWNTO (BITS * (3)));

  soma_1_inst : Adder PORT MAP(A => mult_1, B => mult_2, S => soma_1);
  soma_2_inst : Adder PORT MAP(A => soma_1_reg, B => mult_3, S => soma_2);
  soma_3_inst : Adder PORT MAP(A => soma_2_reg, B => bias, S => soma_3);

  # Registradores saída dos adders
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      soma_1_reg <= (OTHERS => '0');
      soma_2_reg <= (OTHERS => '0');
      soma_3_reg <= (OTHERS => '0');
    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        soma_1_reg <= soma_1;
        soma_2_reg <= soma_2;
        soma_3_reg <= soma_3;
      END IF;
    END IF;
  END PROCESS;
  -- -----------------------------------------------
  -- PROCESS (rst, clk)
  -- BEGIN
  --   IF (rst = '1') THEN
  --     soma_1 <= (OTHERS => '0');
  --     soma_2 <= (OTHERS => '0');
  --     soma_3 <= (OTHERS => '0');
  --     mult_1 <= (OTHERS => '0');
  --     mult_2 <= (OTHERS => '0');
  --     mult_3 <= (OTHERS => '0');
  --   ELSE
  --     IF (clk'event AND clk = '1') THEN --se tem evento de clock
  --       y <= signed(soma_3(15 DOWNTO 8));
  --       mult_1 <= (signed(sx1) * signed(sw1));
  --       mult_2 <= (signed(sx2) * signed(sw2));
  --       mult_3 <= (signed(sx3) * signed(sw3));
  --       soma_1 <= mult_1 + mult_2;
  --       soma_2 <= soma_1 + mult_3;
  --       soma_3 <= soma_2 + sbias;
  --     END IF;
  --   END IF;
  -- END PROCESS;
  y <= soma_3_reg(7 DOWNTO 0); --!! OVERFLOW está sem tratamento!!

END arch;
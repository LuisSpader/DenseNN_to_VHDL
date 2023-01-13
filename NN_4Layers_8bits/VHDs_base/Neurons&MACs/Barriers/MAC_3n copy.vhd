LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

ENTITY MAC_3n IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := NUM_INPUTS;
    TOTAL_BITS : NATURAL := TOTAL_BITS
  );
  PORT (
    clk, rst : IN STD_LOGIC;
    Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    ----------------------------------------------
    y : OUT signed(BITS - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF MAC_3n IS

  ---------- SINAIS ----------
  -- SIGNAL sum_all : signed(((2 * BITS) * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);

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
      BITS : NATURAL := BITS
    );
    PORT (
      A : IN signed((2 * BITS) - 1 DOWNTO 0);
      B : IN signed((2 * BITS) - 1 DOWNTO 0);
      S : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;
  ------------- SINAIS 2 ------------

  SIGNAL bias : signed(BITS - 1 DOWNTO 0);
  SIGNAL last_sum, sbias : signed(15 DOWNTO 0);
  -- SIGNAL sx1, sx2, sx3 : signed(7 DOWNTO 0);
  -- SIGNAL sw1, sw2, sw3 : signed(7 DOWNTO 0);
  -- SIGNAL soma_1, soma_2, soma_3 : signed((2 * BITS) - 1 DOWNTO 0);
  -- SIGNAL soma_1_reg, soma_2_reg, soma_3_reg : signed((2 * BITS) - 1 DOWNTO 0);
  -- SIGNAL mult_1, mult_2, mult_3 : signed((2 * BITS) - 1 DOWNTO 0);
  -- SIGNAL soma_todos : signed((2 * BITS) * NUM_INPUTS - 1 DOWNTO 0);
  TYPE mult_array_type IS ARRAY (1 TO NUM_INPUTS) OF signed((2 * BITS) - 1 DOWNTO 0);
  SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
  -- TYPE mult_and_sum_array_type IS ARRAY (1 TO (NUM_INPUTS * 2)) OF signed((2 * BITS) - 1 DOWNTO 0);
  -- SIGNAL mult_and_sumreg_array : mult_and_sum_array_type;

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
  -- # multiplicadores
  loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : Multiplier
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;

  -- # Registradores saída dos multiplicadores
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
  loop_Mult_signal : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult_array(i + 1) <= s_mult_reg(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)));
  END GENERATE;
  bias <= s_Win((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS)));
  sbias <= resize(bias, sbias'length);

  -- mult_1 <= s_mult_reg(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))); -- 15 DOWNTO 0;
  -- mult_2 <= s_mult_reg(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))); -- 31 DOWNTO 16;
  -- mult_3 <= s_mult_reg(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (2))); -- 47 DOWNTO 32;
  -- loop_adders_inst : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
  --   soma_0_to_NUM_INPUTS_half_inst : IF i < NUM_INPUTS/2 GENERATE
  --     soma_i_inst : Adder PORT MAP(A => mult_array(2 * i), B => mult_array((2 * i) + 1), S => sum_array(i));
  --   END GENERATE;
  -- END GENERATE loop_adders_inst;
  -- mult_and_sumreg_array <= mult_array & sum_array_reg;

  loop_adders_inst : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    even_inst : IF (NUM_INPUTS MOD 2) = 0 GENERATE -- it's even

      sum_0_to_NUM_INPUTS_half_inst : IF i < (NUM_INPUTS/2) GENERATE -- i 0 to 1
        soma_i_inst : Adder PORT MAP(
          A => mult_array((2 * i) + 1), -- mult 1,3,5, ...
          B => mult_array((2 * i) + 2), -- mult 2,4,6, ...
          S => sum_array(i + 1) -- sum 1,2,3, ...
        );
      END GENERATE;

      sum_half_to_NUM_INPUTS_inst : IF (i > (NUM_INPUTS/2)) AND (i < NUM_INPUTS - 1) GENERATE -- i 2
        soma_i_inst : Adder PORT MAP(
          A => sum_array_reg(i - 1), -- sum 1,3,5, ...
          B => sum_array_reg(i), -- sum 2,4,6, ...
          S => sum_array(i + 1)
        );
      END GENERATE;

      sum_final_inst : IF i = NUM_INPUTS GENERATE -- i 3
        soma_i_inst : Adder PORT MAP(
          A => sum_array_reg(i - 1),
          B => sbias,
          S => sum_array(i + 1)
        );
      END GENERATE;

    END GENERATE even_inst;

    -- ----------------- ODD (ÍMPAR) --------------------
    odd_inst : IF (NUM_INPUTS MOD 2) /= 0 GENERATE -- it's odd

      -- i: 0 to 2 (NUM_INPUTS = 7)
      sum_0_to_NUM_INPUTS_half_inst : IF i < ((NUM_INPUTS/2) - 1) GENERATE
        soma_i_inst : Adder PORT MAP(
          A => mult_array((2 * i) + 1), -- mult 1,3,5 ...
          B => mult_array((2 * i) + 2), -- mult 2,4,6 ...
          S => sum_array(i + 1) -- sum 1,2,3 ...
        );
      END GENERATE;

      -- i: 3 (NUM_INPUTS = 7)
      sum_half_inst : IF (i = ((NUM_INPUTS - 1)/2)) GENERATE
        soma_i_inst : Adder PORT MAP(
          A => mult_array((2 * i) + 1), -- mult 7
          B => sum_array_reg(i - 1), -- sum_reg 1
          S => sum_array(i + 1) -- sum 4
        );
      END GENERATE;

      -- i: 4 to 5 (NUM_INPUTS = 7)
      sum_halfplus1_to_NUM_INPUTS_inst : IF (i > ((NUM_INPUTS - 1)/2)) AND (i < NUM_INPUTS - 1) GENERATE
        soma_i_inst : Adder PORT MAP(
          A => sum_array_reg((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 2), -- sum_reg 2,4, ...
          B => sum_array_reg((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 3), -- sum 3,5, ...
          S => sum_array(i + 1)
        );
      END GENERATE;

      sum_final_inst : IF i = (NUM_INPUTS - 1) GENERATE -- i 3
        soma_i_inst : Adder PORT MAP(
          A => sum_array_reg(i - 1),
          B => sbias,
          S => sum_array(i + 1)
        );
      END GENERATE;

    END GENERATE odd_inst;

  END GENERATE loop_adders_inst;

  -- soma_1_inst : Adder PORT MAP(A => mult_array(1), B => mult_array(2), S => sum_array(1));
  -- soma_2_inst : Adder PORT MAP(A => mult_array(3), B => soma_1_reg, S => sum_array(2));
  -- soma_3_inst : Adder PORT MAP(A => soma_2_reg, B => bias, S => sum_array(3));

  -- soma_1_inst : Adder PORT MAP(A => mult_1, B => mult_2, S => soma_1);
  -- soma_2_inst : Adder PORT MAP(A => soma_1_reg, B => mult_3, S => soma_2);
  -- soma_3_inst : Adder PORT MAP(A => soma_2_reg, B => bias, S => soma_3);

  -- # Registradores saída dos adders
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      -- soma_1_reg <= (OTHERS => '0');
      -- soma_2_reg <= (OTHERS => '0');
      -- soma_3_reg <= (OTHERS => '0');
      sum_array_reg <= (OTHERS => (OTHERS => '0'));
    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        sum_array_reg <= sum_array;
        -- soma_1_reg <= soma_1;
        -- soma_2_reg <= soma_2;
        -- soma_3_reg <= soma_3;
      END IF;
    END IF;
  END PROCESS;

  last_sum <= sum_array_reg(NUM_INPUTS); --!! OVERFLOW está sem tratamento!!
  y <= last_sum((2 * BITS) - 1 DOWNTO BITS);
  -- soma_1_inst : Adder PORT MAP(
  --   A => s_mult_reg(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))),
  --   B => s_mult_reg(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))),
  --   S => soma_todos(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0)))
  --   );  
  -- soma_2_inst : Adder PORT MAP(
  --     A => soma_todos(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))),
  --     B => s_mult_reg(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (2))),
  --     S => soma_todos(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1)))
  --     );
  -- soma_3_inst : Adder PORT MAP(
  --       A => s_mult_reg(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (0))),
  --       B => s_mult_reg(((2 * BITS) * (3 + 1)) - 1 DOWNTO ((2 * BITS) * (1))),
  --       S => soma_todos(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1)))
  --       );
  -- soma_2_inst : Adder PORT MAP(A => soma_1_reg, B => mult_3, S => soma_2);
  -- soma_3_inst : Adder PORT MAP(A => soma_2_reg, B => bias, S => soma_3);
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

END arch;
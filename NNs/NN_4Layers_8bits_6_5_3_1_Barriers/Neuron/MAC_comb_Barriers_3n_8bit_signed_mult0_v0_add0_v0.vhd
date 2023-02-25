LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  MAC_comb_Barriers_3n_8bit_signed_mult0_v0_add0_v0 IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 3;
        TOTAL_BITS : NATURAL := 24
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(BITS -1 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE arch OF  MAC_comb_Barriers_3n_8bit_signed_mult0_v0_add0_v0  IS

    ---------- SINAIS ----------
  SIGNAL s_Xi : signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);
  SIGNAL bias : signed(BITS - 1 DOWNTO 0);
  SIGNAL sbias : signed((2 * BITS) - 1 DOWNTO 0); -- barriers
    SIGNAL sum_all : signed((2*BITS) - 1 DOWNTO 0);
  TYPE mult_array_type IS ARRAY (1 TO NUM_INPUTS) OF signed((2 * BITS) - 1 DOWNTO 0);
  SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
    
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

    COMPONENT add0_v0 IS
        GENERIC (
            BITS : NATURAL := 8
        );
        PORT (
            X : IN signed((2* BITS) - 1 DOWNTO 0);
            W : IN signed((2* BITS) - 1 DOWNTO 0);
            Y : OUT signed((2* BITS) - 1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
  s_Xi <= IO_in;
  s_Win <= W_in;

  -- ----------------- MULTIPLIERS ------------------------------
  -- # multiplicadores
  loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : mult0_v0
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;

  -- # Registradores sai�da dos multiplicadores
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
  ---------------------- EVEN (PAR) --------------------------
  even_inst : IF (NUM_INPUTS MOD 2) = 0 GENERATE -- it's even
    loop_adders_inst : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE

      sum_0_to_NUM_INPUTS_half_inst : IF i < (NUM_INPUTS/2) GENERATE -- i 0 to 1
        soma_i_inst : add0_v0 PORT MAP(
          X => mult_array((2 * i) + 1), -- mult 1,3,5, ...
          W => mult_array((2 * i) + 2), -- mult 2,4,6, ...
          Y => sum_array(i + 1) -- sum 1,2,3, ...
        );
      END GENERATE;

      sum_half_to_NUM_INPUTS_inst : IF (i >= (NUM_INPUTS/2)) AND (i < (NUM_INPUTS - 1)) GENERATE -- i 2
        soma_i_inst : add0_v0 PORT MAP(
          X => sum_array_reg((2 * i) - NUM_INPUTS + 1), -- sum 1,3,5, ...
          W => sum_array_reg((2 * i) - NUM_INPUTS + 2), -- sum 2,4,6, ...
          Y => sum_array(i + 1)
        );
      END GENERATE;

      sum_final_inst : IF i = (NUM_INPUTS - 1) GENERATE -- i 3
        soma_i_inst : add0_v0 PORT MAP(
          X => sum_array_reg(i),
          W => sbias,
          Y => sum_array(i + 1)
        );
      END GENERATE;

    END GENERATE loop_adders_inst;
  END GENERATE even_inst;

  -- ------------------- ODD (IMPAR) -------------------------
  odd_inst : IF (NUM_INPUTS MOD 2) /= 0 GENERATE -- it's odd
    loop_adders_inst : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE

      -- i: 0 to 2 (NUM_INPUTS = 7)
      sum_0_to_NUM_INPUTS_half_inst : IF i < (((NUM_INPUTS - 1)/2)) GENERATE
        soma_i_inst : add0_v0 PORT MAP(
          X => mult_array((2 * i) + 1), -- mult 1,3,5 ...
          W => mult_array((2 * i) + 2), -- mult 2,4,6 ...
          Y => sum_array(i + 1) -- sum 1,2,3 ...
        );
      END GENERATE;

      -- i: 3 (NUM_INPUTS = 7)
      sum_half_inst : IF (i = ((NUM_INPUTS - 1)/2)) GENERATE
        soma_i_inst : add0_v0 PORT MAP(
          X => mult_array((2 * i) + 1), -- mult 7
          W => sum_array_reg(1), -- sum_reg 1
          Y => sum_array(i + 1) -- sum 4
        );
      END GENERATE;

      -- i: 4 to 5 (NUM_INPUTS = 7)
      sum_halfplus1_to_NUM_INPUTS_inst : IF (i > ((NUM_INPUTS - 1)/2)) AND (i < NUM_INPUTS - 1) GENERATE
        soma_i_inst : add0_v0 PORT MAP(
          X => sum_array_reg((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 2), -- sum_reg 2,4, ...
          W => sum_array_reg((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 3), -- sum_reg 3,5, ...
          Y => sum_array(i + 1)
        );
      END GENERATE;

      sum_final_inst : IF i = (NUM_INPUTS - 1) GENERATE -- i: 6
        soma_i_inst : add0_v0 PORT MAP(
          X => sum_array_reg(i),
          W => sbias,
          Y => sum_array(i + 1)
        );
      END GENERATE;

    END GENERATE loop_adders_inst;
  END GENERATE odd_inst;
  -- # Registradores saída dos adders
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      sum_array_reg <= (OTHERS => (OTHERS => '0'));

    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        sum_array_reg <= sum_array;

      END IF;
    END IF;
  END PROCESS;
  -------------------------------------------------------------
  sum_all <= sum_array_reg(NUM_INPUTS);
  IO_out <= sum_all((2 * BITS) - 1 DOWNTO BITS); --!! OVERFLOW está sem tratamento!!

END arch;

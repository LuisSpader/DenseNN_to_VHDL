LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY top_shift IS
  GENERIC (
    BITS       : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 5;
    TOTAL_BITS : NATURAL := 40
  );
  PORT (
    clk, rst, update_weights        : IN STD_LOGIC;

    -- Entradas primeira camada
    Xi                              : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    -- ======== Pesos & Bias ========
    c0_n0_Win, c0_n1_Win, c0_n2_Win : IN signed(BITS - 1 DOWNTO 0);

    ----------------------------------------------
    -- Saidas ultima camada
    c1_n0_y, c1_n1_y                : OUT signed(7 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF top_shift IS

  -------------------- COMPONENTS --------------------
  -- TODO LAYER SIGNALS
  -------------------- SIGNALS --------------------
  -- -- conexões entre camadas (entrada e saídas)
  -- -- camada 0
  -- SIGNAL c0_n0_Wout, c0_n1_Wout, c0_n2_Wout : signed(BITS - 1 DOWNTO 0);
  SIGNAL c0_n0_Wout, c0_n1_Wout    : signed(BITS - 1 DOWNTO 0); -- TODO SIGNALS_LENGTH: ((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL c0_n0_y, c0_n1_y, c0_n2_y : signed(BITS - 1 DOWNTO 0);

  -- -- camada 1
  SIGNAL Xi_c1                     : signed((BITS * 3) - 1 DOWNTO 0); -- todo Xi_ci ... logic
  SIGNAL c1_n0_Wout, c1_n1_Wout    : signed(BITS - 1 DOWNTO 0);       -- TODO SIGNALS_LENGTH: ((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  -- SIGNAL c1_n0_y, c1_n1_y, c1_n2_y : signed(7 DOWNTO 0);

  -- -- camada 2
  -- SIGNAL Xi_c2 : signed((BITS * 3) - 1 DOWNTO 0);
  -- SIGNAL c2_n0_Wout, c2_n1_Wout : signed(BITS - 1 DOWNTO 0);
  -- SIGNAL c2_n0_y, c2_n1_y : signed(7 DOWNTO 0);

  -- -- camada 3
  -- SIGNAL Xi_c3 : signed((BITS * 2) - 1 DOWNTO 0);
  -- -- SIGNAL c3_n0_Wout, c3_n1_Wout : signed(BITS - 1 DOWNTO 0);
  -- -- SIGNAL c3_n0_y, c3_n1_y : signed(7 DOWNTO 0);

  ------------
  -- TODO SIGNALS
  SIGNAL reg_Xi                    : signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL en_registers              : STD_LOGIC; -- SHIFT_REGISTER

BEGIN
  -- TODO EN_REGISTERS
  en_registers <= update_weights AND clk;
  -- TODO PROCESS
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_Xi <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_Xi <= Xi;
    END IF;
  END PROCESS;

  -- TODO :ENTITIES
  camada0_relu_3neuron_8bits_5n_signed_inst : ENTITY work.camada0_ReLU_3neuron_8bits_5n_signed
    -- GENERIC MAP(
    --   BITS => BITS,
    --   NUM_INPUTS => NUM_INPUTS,
    --   TOTAL_BITS => TOTAL_BITS
    -- )
    PORT MAP(
      clk            => clk,
      rst            => rst,
      update_weights => en_registers, -- todo: colocar en_registers
      Xi             => reg_Xi,       -- TODO 
      c0_n0_Win      => c0_n0_Win,
      c0_n1_Win      => c0_n1_Win,
      c0_n2_Win      => c0_n2_Win,
      c0_n0_y        => c0_n0_y,
      c0_n1_y        => c0_n1_y,
      c0_n2_y        => c0_n2_y,
      c0_n0_Wout     => c0_n0_Wout,
      c0_n1_Wout     => c0_n1_Wout
    );

  Xi_c1 <= c0_n0_y & c0_n1_y & c0_n2_y; -- TODO Xi_c1 statement
  camada1_sigmoid_2neuron_8bits_3n_signed_inst : ENTITY work.camada1_Sigmoid_2neuron_8bits_3n_signed
    -- GENERIC MAP(
    --   BITS => BITS,
    --   NUM_INPUTS => NUM_INPUTS,
    --   TOTAL_BITS => TOTAL_BITS
    -- )
    PORT MAP(
      clk            => clk,
      rst            => rst,
      update_weights => en_registers,
      Xi             => Xi_c1,      -- TODO Xi_c1
      c1_n0_Win      => c0_n0_Wout, -- TODO c0_n0_Wout
      c1_n1_Win      => c0_n1_Wout, -- TODO c0_n1_Wout
      c1_n0_y        => c1_n0_y,
      c1_n1_y        => c1_n1_y
      -- c1_n0_Wout => c1_n0_Wout,
      -- c1_n1_Wout => c1_n1_Wout
    );

END ARCHITECTURE;
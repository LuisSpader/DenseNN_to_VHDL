LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY top_shift IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 5;
    TOTAL_BITS : NATURAL := 40
  );
  PORT (
    clk, rst, update_weights : IN STD_LOGIC;

    -- Entradas primeira camada
    Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    -- ======== Pesos & Bias ========
    c0_n0_Win, c0_n1_Win, c0_n2_Win : IN signed(BITS - 1 DOWNTO 0);

    ----------------------------------------------
    -- Saidas ultima camada
    c3_n0_y, c3_n1_y : OUT signed(7 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF top_shift IS

  -------------------- COMPONENTS --------------------
  COMPONENT camada0_ReLU_3neuron_8bits_5n_signed IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 5;
      TOTAL_BITS : NATURAL := 40
    );
    PORT (
      clk, rst, update_weights : IN STD_LOGIC;
      Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_Win, c0_n1_Win, c0_n2_Win : IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c0_n0_y, c0_n1_y, c0_n2_y : OUT signed(7 DOWNTO 0);
      c0_n0_Wout, c0_n1_Wout, c0_n2_Wout : OUT signed(BITS - 1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT camada1_ReLU_3neuron_8bits_3n_signed IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 3;
      TOTAL_BITS : NATURAL := 24
    );
    PORT (
      clk, rst, update_weights : IN STD_LOGIC;
      Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c1_n0_Win, c1_n1_Win, c1_n2_Win : IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c1_n0_y, c1_n1_y, c1_n2_y : OUT signed(7 DOWNTO 0);
      c1_n0_Wout, c1_n1_Wout, c1_n2_Wout : OUT signed(BITS - 1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT camada2_ReLU_2neuron_8bits_3n_signed IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 3;
      TOTAL_BITS : NATURAL := 24
    );
    PORT (
      clk, rst, update_weights : IN STD_LOGIC;
      Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c2_n0_Win, c2_n1_Win : IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c2_n0_y, c2_n1_y : OUT signed(7 DOWNTO 0);
      c2_n0_Wout, c2_n1_Wout : OUT signed(BITS - 1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT camada3_Sigmoid_2neuron_8bits_2n_signed IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 2;
      TOTAL_BITS : NATURAL := 16
    );
    PORT (
      clk, rst, update_weights : IN STD_LOGIC;
      Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c3_n0_Win, c3_n1_Win : IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c3_n0_y, c3_n1_y : OUT signed(7 DOWNTO 0);
      c3_n0_Wout, c3_n1_Wout : OUT signed(BITS - 1 DOWNTO 0)
    );
  END COMPONENT;

  -------------------- SIGNALS --------------------
  -- conex??es entre camadas (entrada e sa??das)
  -- camada 0
  SIGNAL c0_n0_Wout, c0_n1_Wout, c0_n2_Wout : signed(BITS - 1 DOWNTO 0);
  SIGNAL c0_n0_y, c0_n1_y, c0_n2_y : signed(7 DOWNTO 0);

  -- camada 1
  SIGNAL Xi_c1 : signed((BITS * 3) - 1 DOWNTO 0);
  SIGNAL c1_n0_Wout, c1_n1_Wout : signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_n0_y, c1_n1_y, c1_n2_y : signed(7 DOWNTO 0);

  -- camada 2
  SIGNAL Xi_c2 : signed((BITS * 3) - 1 DOWNTO 0);
  SIGNAL c2_n0_Wout, c2_n1_Wout : signed(BITS - 1 DOWNTO 0);
  SIGNAL c2_n0_y, c2_n1_y : signed(7 DOWNTO 0);

  -- camada 3
  SIGNAL Xi_c3 : signed((BITS * 2) - 1 DOWNTO 0);
  -- SIGNAL c3_n0_Wout, c3_n1_Wout : signed(BITS - 1 DOWNTO 0);
  -- SIGNAL c3_n0_y, c3_n1_y : signed(7 DOWNTO 0);

BEGIN
  camada0_relu_3neuron_8bits_5n_signed_inst : camada0_ReLU_3neuron_8bits_5n_signed
  GENERIC MAP(
    BITS => BITS,
    NUM_INPUTS => NUM_INPUTS,
    TOTAL_BITS => TOTAL_BITS
  )
  PORT MAP(
    clk => clk,
    rst => rst,
    update_weights => update_weights,
    Xi => Xi,
    c0_n0_Win => c0_n0_Win, -- seq de pesos para neuronio 0
    c0_n1_Win => c0_n1_Win, -- seq de pesos para neuronio 1
    c0_n2_Win => c0_n2_Win, -- seq de pesos para neuronio 2
    c0_n0_y => c0_n0_y, -- saida neuronio 0
    c0_n1_y => c0_n1_y, -- saida neuronio 1
    c0_n2_y => c0_n2_y, -- saida neuronio 2
    c0_n0_Wout => c0_n0_Wout, -- seq de pesos do neuronio 0
    c0_n1_Wout => c0_n1_Wout, -- seq de pesos do neuronio 1
    c0_n2_Wout => c0_n2_Wout -- seq de pesos do neuronio 2
  );

  Xi_c1 <= c0_n0_y & c0_n1_y & c0_n2_y; -- 
  camada1_relu_3neuron_8bits_3n_signed_inst : ENTITY work.camada1_ReLU_3neuron_8bits_3n_signed
    PORT MAP(
      clk => clk,
      rst => rst,
      update_weights => update_weights,
      Xi => Xi_c1, -- bits_Xi_c1 = Number_of_neurons_c0 * bits
      c1_n0_Win => c0_n0_Wout, -- seq de pesos para neuronio 1
      c1_n1_Win => c0_n1_Wout, -- seq de pesos para neuronio 1
      c1_n2_Win => c0_n2_Wout, -- seq de pesos para neuronio 2
      c1_n0_y => c1_n0_y, -- saida neuronio 0
      c1_n1_y => c1_n1_y, -- saida neuronio 1
      c1_n2_y => c1_n2_y, -- saida neuronio 2
      c1_n0_Wout => c1_n0_Wout, -- seq de pesos do neuronio 0
      c1_n1_Wout => c1_n1_Wout -- seq de pesos do neuronio 1
      -- c1_n2_Wout => c1_n2_Wout -- seq de pesos do neuronio 2
    );

  Xi_c2 <= c1_n0_y & c1_n1_y & c1_n2_y;
  camada2_ReLU_2neuron_8bits_3n_signed_inst : ENTITY work.camada2_ReLU_2neuron_8bits_3n_signed
    PORT MAP(
      clk => clk,
      rst => rst,
      update_weights => update_weights,
      Xi => Xi_c2,
      c2_n0_Win => c1_n0_Wout,
      c2_n1_Win => c1_n1_Wout,
      c2_n0_y => c2_n0_y,
      c2_n1_y => c2_n1_y,
      c2_n0_Wout => c2_n0_Wout,
      c2_n1_Wout => c2_n1_Wout
    );

  Xi_c3 <= c2_n0_y & c2_n1_y;
  camada3_Sigmoid_2neuron_8bits_2n_signed_inst : ENTITY work.camada3_Sigmoid_2neuron_8bits_2n_signed
    PORT MAP(
      clk => clk,
      rst => rst,
      update_weights => update_weights,
      Xi => Xi_c3,
      c3_n0_Win => c2_n0_Wout,
      c3_n1_Win => c2_n1_Wout,
      c3_n0_y => c3_n0_y,
      c3_n1_y => c3_n1_y
      -- c3_n0_Wout => c3_n0_Wout,
      -- c3_n1_Wout => c3_n1_Wout
    );

END ARCHITECTURE;
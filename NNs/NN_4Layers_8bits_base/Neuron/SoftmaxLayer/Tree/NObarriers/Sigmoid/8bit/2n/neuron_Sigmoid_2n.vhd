LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

ENTITY neuron_Sigmoid_2n IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 2;
    TOTAL_BITS : NATURAL := 16
  );
  PORT (
    clk, rst, update_weights : IN STD_LOGIC;
    Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    Win : IN signed(BITS - 1 DOWNTO 0);
    ----------------------------------------------
    y : OUT signed(7 DOWNTO 0)
    -- Wout : OUT signed(BITS - 1 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE behavior OF neuron_Sigmoid_2n IS
  COMPONENT MAC_2n IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 2;
      TOTAL_BITS : NATURAL := 16
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      y : OUT signed(7 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT shift_reg_2n IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := NUM_INPUTS
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      Win : IN signed(BITS - 1 DOWNTO 0);
      Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
    );
  END COMPONENT;

  -- -- ROM
  -- COMPONENT ROM_fx_8bitaddr_8width IS
  --   PORT (
  --     address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
  --     ------------------------------------------
  --     data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
  --   );
  --   -- input: address (8 bits)
  --   -- output: data_out (8 bits)
  -- END COMPONENT;

  COMPONENT activation_fx IS
    GENERIC (
      BITS_FX_IN : NATURAL := BITS_FX_IN;
      BITS_FX_OUT : NATURAL := BITS_FX_OUT;
      ACTIVATION_TYPE : NATURAL := 2; -- 0: ReLU, 1: Leaky ReLU, 2: Sigmoid
      Leaky_attenuation : NATURAL := Leaky_attenuation;
      Leaky_ReLU_ones : signed := Leaky_ReLU_ones
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      fx_in : IN signed(BITS_FX_IN - 1 DOWNTO 0);
      fx_out : OUT signed(BITS_FX_OUT - 1 DOWNTO 0)
    );
  END COMPONENT;
  -------------------- SIGNALS --------------------

  SIGNAL out_reg_MAC : signed ((7) DOWNTO 0); --reg da saida do MAC
  SIGNAL out_ROM_act : signed(7 DOWNTO 0); --saida da ROM
  -- SIGNAL reg_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  -- SIGNAL en_registers : STD_LOGIC; -- SHIFT_REGISTER
  SIGNAL s_Wout : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN

  -- MAC ja registra a saida 
  U_MAC : MAC_2n PORT MAP(
    clk, rst,
    Xi,
    s_Wout,
    out_reg_MAC);

  -- en_registers <= update_weights AND clk; -- tirar isso depois e colocar fora dos neur??????nios
  inst_shift_reg : shift_reg_2n PORT MAP(update_weights, rst, Win, s_Wout);
  -- Wout <= s_Wout((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS + 0)));

  -- U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
  --   STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
  -- );
  -- input: address (8)
  -- output: data_out (8)

  U_ROM : activation_fx PORT MAP(
    clk, rst,
    out_reg_MAC,
    out_ROM_act
  );

  y <= signed (out_ROM_act);

END behavior;
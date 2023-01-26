LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

ENTITY neuron_ReLU_5n IS
  GENERIC (
    BITS       : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 5;
    TOTAL_BITS : NATURAL := 40
  );
  PORT (
    clk, rst, update_weights : IN STD_LOGIC;
    Xi                       : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    Win                      : IN signed(BITS - 1 DOWNTO 0);
    ----------------------------------------------
    y                        : OUT signed(7 DOWNTO 0) -- todo: signed(BITS - 1 DOWNTO 0)
    -- Wout : OUT signed(BITS - 1 DOWNTO 0) -- todo: trocar para
  );
END ENTITY;

ARCHITECTURE behavior OF neuron_ReLU_5n IS
  ---------- COMPONENTS ----------
  COMPONENT MAC_5n IS
    GENERIC (
      BITS       : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 5;
      TOTAL_BITS : NATURAL := 40
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      Xi       : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      Win      : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      y        : OUT signed(7 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT shift_reg_5n IS
    GENERIC (
      BITS       : NATURAL := BITS;
      NUM_INPUTS : NATURAL := NUM_INPUTS
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      Win      : IN signed(BITS - 1 DOWNTO 0);
      Wout     : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
    );
  END COMPONENT;
  COMPONENT activation_fx IS
    GENERIC (
      BITS_FX_IN        : NATURAL := BITS_FX_IN;
      BITS_FX_OUT       : NATURAL := BITS_FX_OUT;
      ACTIVATION_TYPE   : NATURAL := 2; -- 0: ReLU, 1: Leaky ReLU, 2: Sigmoid
      Leaky_attenuation : NATURAL := Leaky_attenuation;
      Leaky_ReLU_ones   : signed  := Leaky_ReLU_ones
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      fx_in    : IN signed(BITS_FX_IN - 1 DOWNTO 0);
      fx_out   : OUT signed(BITS_FX_OUT - 1 DOWNTO 0)
    );
  END COMPONENT;

  ---------- SIGNALS ----------
  -- # ROM_component
  SIGNAL out_reg_MAC  : signed (BITS - 1 DOWNTO 0); --reg da saida do MAC

  -- SIGNAL reg_Xi       : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);-- todo: retirar sinal
  SIGNAL en_registers : STD_LOGIC;                  -- SHIFT_REGISTER
  SIGNAL s_Wout       : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN

  -- MAC ja registra a saida 
  U_MAC : MAC_5n PORT MAP(
    clk, rst,
    Xi, -- todo: trocar reg_Xi por Xi
    s_Wout,
    out_reg_MAC);

  en_registers <= update_weights AND clk; -- tirar isso depois e colocar fora dos neur�nios
  inst_shift_reg     : shift_reg_5n PORT MAP(en_registers, rst, Win, s_Wout);

  -- Wout <= s_Wout; -- todo: trocar para versão abaixo
  -- Wout <= s_Wout((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS + 0))); -- todo: retirar isso

  -- todo: retirar process
  -- PROCESS (clk, rst, update_weights)
  -- BEGIN
  --   IF rst = '1' THEN
  --     reg_Xi <= (OTHERS => '0');

  --   ELSIF clk'event AND clk = '1' THEN
  --     reg_Xi <= Xi;

  --     IF out_reg_MAC > 0 THEN
  --       y <= out_reg_MAC;
  --     ELSE
  --       y <= (OTHERS => '0');
  --     END IF;

  --   END IF;
  -- END PROCESS;
  fx_activation_inst : activation_fx PORT MAP(
    clk, rst,
    out_reg_MAC,
    y
  );
END behavior;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

ENTITY neuron_Sigmoid_3n IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 3;
    TOTAL_BITS : NATURAL := 24
  );
  PORT (
    clk, rst, update_weights : IN STD_LOGIC;
    Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    Win : IN signed(BITS - 1 DOWNTO 0);
    ----------------------------------------------
    y : OUT signed(BITS - 1 DOWNTO 0) -- todo: signed(BITS - 1 DOWNTO 0);
    -- Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0) -- TODO: retirar Wout dos Softmax
  );
END ENTITY;

ARCHITECTURE behavior OF neuron_Sigmoid_3n IS
  COMPONENT MAC_3n IS
    GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := 3;
      TOTAL_BITS : NATURAL := 24
    );
    PORT (
      clk, rst : IN STD_LOGIC;
      Xi : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      y : OUT signed(7 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT shift_reg_3n IS
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
  -- ROM
  COMPONENT ROM_fx_8bitaddr_8width IS
    PORT (
      address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      ------------------------------------------
      data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
    -- input: address (8 bits)
    -- output: data_out (8 bits)
  END COMPONENT;
  SIGNAL out_reg_MAC : signed ((7) DOWNTO 0); --reg da saida do MAC
  SIGNAL out_ROM_act : STD_LOGIC_VECTOR(7 DOWNTO 0); --saida da ROM
  -- SIGNAL reg_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0); -- todo: RETIRAR regs
  -- SIGNAL en_registers : STD_LOGIC; -- SHIFT_REGISTER -- todo: retirar en_registers

  SIGNAL s_Wout : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN

  -- MAC ja registra a saida 
  U_MAC : MAC_3n PORT MAP(
    clk, rst,
    Xi, --todo: trocar para reg_Xi para Xi
    s_Wout,
    out_reg_MAC);

  -- en_registers <= update_weights AND clk; -- todo: retirar isso 
  -- inst_shift_reg : shift_reg_3n PORT MAP(en_registers, rst, Win, s_Wout); 
  inst_shift_reg : shift_reg_3n PORT MAP(update_weights, rst, Win, s_Wout); -- todo: trocar en_registers por 'update_weights'

  -- Wout <= s_Wout; --TODO: retirar essa declaração

  U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
    STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
  );
  -- input: address (8)
  -- output: data_out (8)

  -- TODO: retirar proccess abaixo
  -- PROCESS (clk, rst, update_weights)
  -- BEGIN
  --   IF rst = '1' THEN
  --     reg_Xi <= (OTHERS => '0');

  --   ELSIF clk'event AND clk = '1' THEN
  --     reg_Xi <= Xi;

  --   END IF;
  -- END PROCESS;
  y <= signed (out_ROM_act);

END behavior;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

ENTITY neuron_ReLU_3n IS
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
    y : OUT signed(7 DOWNTO 0);
    Wout : OUT signed(BITS - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE behavior OF neuron_ReLU_3n IS
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

  -- # ROM_component
  SIGNAL out_reg_MAC : signed (BITS - 1 DOWNTO 0); --reg da saida do MAC

  SIGNAL reg_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL en_registers : STD_LOGIC; -- SHIFT_REGISTER
  SIGNAL s_Wout : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN

  -- MAC ja registra a saida 
  U_MAC : MAC_3n PORT MAP(
    clk, rst,
    reg_Xi,
    s_Wout,
    out_reg_MAC);

  en_registers <= update_weights AND clk; -- tirar isso depois e colocar fora dos neur�nios
  inst_shift_reg : shift_reg_3n PORT MAP(en_registers, rst, Win, s_Wout);
  Wout <= s_Wout((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS + 0)));

  PROCESS (clk, rst, update_weights)
  BEGIN
    IF rst = '1' THEN
      reg_Xi <= (OTHERS => '0');

    ELSIF clk'event AND clk = '1' THEN
      reg_Xi <= Xi;

      IF out_reg_MAC > 0 THEN
        y <= out_reg_MAC;
      ELSE
        y <= (OTHERS => '0');
      END IF;

    END IF;
  END PROCESS;

END behavior;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY top IS
  GENERIC (
    BITS       : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 3;
    TOTAL_BITS : NATURAL := 24
  );
  PORT (
    clk, rst, update_weights        : IN STD_LOGIC;
    Xi                              : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    c0_n0_Win, c0_n1_Win, c0_n2_Win : IN signed(BITS - 1 DOWNTO 0);
    ----------------------------------------------
    c1_n0_y, c1_n1_y                : OUT signed(7 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF top IS
BEGIN

  camada0_inst_0 : ENTITY work.camada0_ReLU_3neuron_8bits_5n_signed
    PORT MAP(
      ---------- Entradas ----------
      -- ['IN']['STD_LOGIC'] 
      clk            => clk,
      rst            => rst,
      update_weights => update_weights,
      -- ['IN']['manual'] 
      Xi             => Xi,
      c0_n0_Win      => c0_n0_Win,
      c0_n1_Win      => c0_n1_Win,
      c0_n2_Win      => c0_n2_Win,
      ---------- Saidas ----------
      -- ['OUT']['SIGNED'] 
      c0_n0_y        => c0_n0_y,
      c0_n1_y        => c0_n1_y,
      c0_n2_y        => c0_n2_y,
      -- ['OUT']['manual'] 
      c0_n0_Wout     => c0_n0_Wout,
      c0_n1_Wout     => c0_n1_Wout,
      c0_n2_Wout     => c0_n2_Wout
    );

  camada1_inst_1 : ENTITY work.camada1_Sigmoid_2neuron_8bits_3n_signed
    PORT MAP(
      ---------- Entradas ----------
      -- ['IN']['STD_LOGIC'] 
      clk            => clk,
      rst            => rst,
      update_weights => update_weights,
      -- ['IN']['manual'] 
      Xi             => Xi,
      c1_n0_Win      => c1_n0_Win,
      c1_n1_Win      => c1_n1_Win,
      ---------- Saidas ----------
      -- ['OUT']['SIGNED'] 
      c1_n0_y        => c1_n0_y,
      c1_n1_y        => c1_n1_y
    );

END ARCHITECTURE;
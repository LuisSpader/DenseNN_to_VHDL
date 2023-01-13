LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY camada1_ReLU_3neuron_8bits_3n_signed IS
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
      c1_n0_Wout, c1_n1_Wout, c1_n2_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
   );
END ENTITY;

ARCHITECTURE arch OF camada1_ReLU_3neuron_8bits_3n_signed IS
BEGIN

   neuron_inst_0 : ENTITY work.neuron_ReLU_3n
      PORT MAP(
         ---------- Entradas ----------
         -- ['IN']['STD_LOGIC'] 
         clk => clk,
         rst => rst,
         update_weights => update_weights,
         -- ['IN']['manual'] 
         Xi => Xi,
         Win => c1_n0_Win,
         ---------- Saidas ----------
         -- ['OUT']['SIGNED'] 
         y => c1_n0_y,
         -- ['OUT']['manual'] 
         Wout => c1_n0_Wout
      );

   neuron_inst_1 : ENTITY work.neuron_ReLU_3n
      PORT MAP(
         ---------- Entradas ----------
         -- ['IN']['STD_LOGIC'] 
         clk => clk,
         rst => rst,
         update_weights => update_weights,
         -- ['IN']['manual'] 
         Xi => Xi,
         Win => c1_n1_Win,
         ---------- Saidas ----------
         -- ['OUT']['SIGNED'] 
         y => c1_n1_y,
         -- ['OUT']['manual'] 
         Wout => c1_n1_Wout
      );

   neuron_inst_2 : ENTITY work.neuron_ReLU_3n
      PORT MAP(
         ---------- Entradas ----------
         -- ['IN']['STD_LOGIC'] 
         clk => clk,
         rst => rst,
         update_weights => update_weights,
         -- ['IN']['manual'] 
         Xi => Xi,
         Win => c1_n2_Win,
         ---------- Saidas ----------
         -- ['OUT']['SIGNED'] 
         y => c1_n2_y,
         -- ['OUT']['manual'] 
         Wout => c1_n2_Wout
      );

END ARCHITECTURE;
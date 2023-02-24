LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada2_ReLU_2neuron_8bits_1n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 1;
    TOTAL_BITS : NATURAL := 8
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c2_n0_W_in, c2_n1_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c2_n0_IO_out, c2_n1_IO_out: OUT signed(7 DOWNTO 0);
      c2_n0_W_out, c2_n1_W_out: OUT signed(BITS - 1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada2_ReLU_2neuron_8bits_1n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_ReLU_1n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n0_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n0_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n0_W_out
   );
            
neuron_inst_1: ENTITY work.neuron_ReLU_1n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n1_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n1_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n1_W_out
   );
             
END ARCHITECTURE;

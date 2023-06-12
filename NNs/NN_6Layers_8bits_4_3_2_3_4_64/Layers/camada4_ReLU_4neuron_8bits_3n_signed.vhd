LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada4_ReLU_4neuron_8bits_3n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 3;
    TOTAL_BITS : NATURAL := 24
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c4_n0_W_in, c4_n1_W_in, c4_n2_W_in, c4_n3_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c4_n0_IO_out, c4_n1_IO_out, c4_n2_IO_out, c4_n3_IO_out: OUT signed(BITS -1 DOWNTO 0);
      c4_n0_W_out, c4_n1_W_out, c4_n2_W_out, c4_n3_W_out: OUT signed(BITS - 1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada4_ReLU_4neuron_8bits_3n_signed  IS
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c4_n0_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c4_n0_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c4_n0_W_out
   );
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c4_n1_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c4_n1_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c4_n1_W_out
   );
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c4_n2_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c4_n2_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c4_n2_W_out
   );
            
neuron_inst_3: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c4_n3_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c4_n3_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c4_n3_W_out
   );
            
END ARCHITECTURE;

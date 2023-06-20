LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada0_ReLU_16neuron_8bits_20n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 20;
    TOTAL_BITS : NATURAL := 160
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in, c0_n15_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out, c0_n6_IO_out, c0_n7_IO_out, c0_n8_IO_out, c0_n9_IO_out, c0_n10_IO_out, c0_n11_IO_out, c0_n12_IO_out, c0_n13_IO_out, c0_n14_IO_out, c0_n15_IO_out: OUT signed(BITS -1 DOWNTO 0);
      c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c0_n5_W_out, c0_n6_W_out, c0_n7_W_out, c0_n8_W_out, c0_n9_W_out, c0_n10_W_out, c0_n11_W_out: OUT signed(BITS - 1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada0_ReLU_16neuron_8bits_20n_signed  IS
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n0_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n0_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n0_W_out
   );
            
neuron_inst_1: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n1_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n1_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n1_W_out
   );
            
neuron_inst_2: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n2_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n2_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n2_W_out
   );
            
neuron_inst_3: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n3_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n3_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n3_W_out
   );
            
neuron_inst_4: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n4_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n4_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n4_W_out
   );
            
neuron_inst_5: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n5_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n5_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n5_W_out
   );
            
neuron_inst_6: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n6_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n6_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n6_W_out
   );
            
neuron_inst_7: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n7_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n7_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n7_W_out
   );
            
neuron_inst_8: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n8_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n8_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n8_W_out
   );
            
neuron_inst_9: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n9_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n9_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n9_W_out
   );
            
neuron_inst_10: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n10_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n10_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n10_W_out
   );
            
neuron_inst_11: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n11_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n11_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n11_W_out
   );
            
neuron_inst_12: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n12_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n12_IO_out
   );
            
neuron_inst_13: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n13_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n13_IO_out
   );
            
neuron_inst_14: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n14_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n14_IO_out
   );
            
neuron_inst_15: ENTITY work.neuron_comb_layer0_20n_8bit_signed_mult0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n15_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n15_IO_out
   );
            
END ARCHITECTURE;

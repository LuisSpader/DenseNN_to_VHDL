LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada2_ReLU_100neuron_8bits_300n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 300;
    TOTAL_BITS : NATURAL := 2400
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c2_n0_W_in, c2_n1_W_in, c2_n2_W_in, c2_n3_W_in, c2_n4_W_in, c2_n5_W_in, c2_n6_W_in, c2_n7_W_in, c2_n8_W_in, c2_n9_W_in, c2_n10_W_in, c2_n11_W_in, c2_n12_W_in, c2_n13_W_in, c2_n14_W_in, c2_n15_W_in, c2_n16_W_in, c2_n17_W_in, c2_n18_W_in, c2_n19_W_in, c2_n20_W_in, c2_n21_W_in, c2_n22_W_in, c2_n23_W_in, c2_n24_W_in, c2_n25_W_in, c2_n26_W_in, c2_n27_W_in, c2_n28_W_in, c2_n29_W_in, c2_n30_W_in, c2_n31_W_in, c2_n32_W_in, c2_n33_W_in, c2_n34_W_in, c2_n35_W_in, c2_n36_W_in, c2_n37_W_in, c2_n38_W_in, c2_n39_W_in, c2_n40_W_in, c2_n41_W_in, c2_n42_W_in, c2_n43_W_in, c2_n44_W_in, c2_n45_W_in, c2_n46_W_in, c2_n47_W_in, c2_n48_W_in, c2_n49_W_in, c2_n50_W_in, c2_n51_W_in, c2_n52_W_in, c2_n53_W_in, c2_n54_W_in, c2_n55_W_in, c2_n56_W_in, c2_n57_W_in, c2_n58_W_in, c2_n59_W_in, c2_n60_W_in, c2_n61_W_in, c2_n62_W_in, c2_n63_W_in, c2_n64_W_in, c2_n65_W_in, c2_n66_W_in, c2_n67_W_in, c2_n68_W_in, c2_n69_W_in, c2_n70_W_in, c2_n71_W_in, c2_n72_W_in, c2_n73_W_in, c2_n74_W_in, c2_n75_W_in, c2_n76_W_in, c2_n77_W_in, c2_n78_W_in, c2_n79_W_in, c2_n80_W_in, c2_n81_W_in, c2_n82_W_in, c2_n83_W_in, c2_n84_W_in, c2_n85_W_in, c2_n86_W_in, c2_n87_W_in, c2_n88_W_in, c2_n89_W_in, c2_n90_W_in, c2_n91_W_in, c2_n92_W_in, c2_n93_W_in, c2_n94_W_in, c2_n95_W_in, c2_n96_W_in, c2_n97_W_in, c2_n98_W_in, c2_n99_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c2_n0_IO_out, c2_n1_IO_out, c2_n2_IO_out, c2_n3_IO_out, c2_n4_IO_out, c2_n5_IO_out, c2_n6_IO_out, c2_n7_IO_out, c2_n8_IO_out, c2_n9_IO_out, c2_n10_IO_out, c2_n11_IO_out, c2_n12_IO_out, c2_n13_IO_out, c2_n14_IO_out, c2_n15_IO_out, c2_n16_IO_out, c2_n17_IO_out, c2_n18_IO_out, c2_n19_IO_out, c2_n20_IO_out, c2_n21_IO_out, c2_n22_IO_out, c2_n23_IO_out, c2_n24_IO_out, c2_n25_IO_out, c2_n26_IO_out, c2_n27_IO_out, c2_n28_IO_out, c2_n29_IO_out, c2_n30_IO_out, c2_n31_IO_out, c2_n32_IO_out, c2_n33_IO_out, c2_n34_IO_out, c2_n35_IO_out, c2_n36_IO_out, c2_n37_IO_out, c2_n38_IO_out, c2_n39_IO_out, c2_n40_IO_out, c2_n41_IO_out, c2_n42_IO_out, c2_n43_IO_out, c2_n44_IO_out, c2_n45_IO_out, c2_n46_IO_out, c2_n47_IO_out, c2_n48_IO_out, c2_n49_IO_out, c2_n50_IO_out, c2_n51_IO_out, c2_n52_IO_out, c2_n53_IO_out, c2_n54_IO_out, c2_n55_IO_out, c2_n56_IO_out, c2_n57_IO_out, c2_n58_IO_out, c2_n59_IO_out, c2_n60_IO_out, c2_n61_IO_out, c2_n62_IO_out, c2_n63_IO_out, c2_n64_IO_out, c2_n65_IO_out, c2_n66_IO_out, c2_n67_IO_out, c2_n68_IO_out, c2_n69_IO_out, c2_n70_IO_out, c2_n71_IO_out, c2_n72_IO_out, c2_n73_IO_out, c2_n74_IO_out, c2_n75_IO_out, c2_n76_IO_out, c2_n77_IO_out, c2_n78_IO_out, c2_n79_IO_out, c2_n80_IO_out, c2_n81_IO_out, c2_n82_IO_out, c2_n83_IO_out, c2_n84_IO_out, c2_n85_IO_out, c2_n86_IO_out, c2_n87_IO_out, c2_n88_IO_out, c2_n89_IO_out, c2_n90_IO_out, c2_n91_IO_out, c2_n92_IO_out, c2_n93_IO_out, c2_n94_IO_out, c2_n95_IO_out, c2_n96_IO_out, c2_n97_IO_out, c2_n98_IO_out, c2_n99_IO_out: OUT signed(7 DOWNTO 0);
      c2_n0_W_out, c2_n1_W_out, c2_n2_W_out, c2_n3_W_out, c2_n4_W_out, c2_n5_W_out, c2_n6_W_out, c2_n7_W_out, c2_n8_W_out, c2_n9_W_out, c2_n10_W_out, c2_n11_W_out, c2_n12_W_out, c2_n13_W_out, c2_n14_W_out, c2_n15_W_out, c2_n16_W_out, c2_n17_W_out, c2_n18_W_out, c2_n19_W_out, c2_n20_W_out, c2_n21_W_out, c2_n22_W_out, c2_n23_W_out, c2_n24_W_out, c2_n25_W_out, c2_n26_W_out, c2_n27_W_out, c2_n28_W_out, c2_n29_W_out, c2_n30_W_out, c2_n31_W_out, c2_n32_W_out, c2_n33_W_out, c2_n34_W_out, c2_n35_W_out, c2_n36_W_out, c2_n37_W_out, c2_n38_W_out, c2_n39_W_out, c2_n40_W_out, c2_n41_W_out, c2_n42_W_out, c2_n43_W_out, c2_n44_W_out, c2_n45_W_out, c2_n46_W_out, c2_n47_W_out, c2_n48_W_out, c2_n49_W_out, c2_n50_W_out, c2_n51_W_out, c2_n52_W_out, c2_n53_W_out, c2_n54_W_out, c2_n55_W_out, c2_n56_W_out, c2_n57_W_out, c2_n58_W_out, c2_n59_W_out, c2_n60_W_out, c2_n61_W_out, c2_n62_W_out, c2_n63_W_out, c2_n64_W_out, c2_n65_W_out, c2_n66_W_out, c2_n67_W_out, c2_n68_W_out, c2_n69_W_out, c2_n70_W_out, c2_n71_W_out, c2_n72_W_out, c2_n73_W_out, c2_n74_W_out, c2_n75_W_out, c2_n76_W_out, c2_n77_W_out, c2_n78_W_out, c2_n79_W_out, c2_n80_W_out, c2_n81_W_out, c2_n82_W_out, c2_n83_W_out, c2_n84_W_out, c2_n85_W_out, c2_n86_W_out, c2_n87_W_out, c2_n88_W_out, c2_n89_W_out, c2_n90_W_out, c2_n91_W_out, c2_n92_W_out, c2_n93_W_out, c2_n94_W_out, c2_n95_W_out, c2_n96_W_out, c2_n97_W_out, c2_n98_W_out, c2_n99_W_out: OUT signed(BITS - 1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada2_ReLU_100neuron_8bits_300n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_ReLU_300n_out
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
            
neuron_inst_1: ENTITY work.neuron_ReLU_300n_out
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
            
neuron_inst_2: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n2_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n2_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n2_W_out
   );
            
neuron_inst_3: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n3_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n3_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n3_W_out
   );
            
neuron_inst_4: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n4_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n4_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n4_W_out
   );
            
neuron_inst_5: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n5_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n5_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n5_W_out
   );
            
neuron_inst_6: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n6_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n6_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n6_W_out
   );
            
neuron_inst_7: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n7_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n7_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n7_W_out
   );
            
neuron_inst_8: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n8_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n8_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n8_W_out
   );
            
neuron_inst_9: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n9_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n9_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n9_W_out
   );
            
neuron_inst_10: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n10_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n10_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n10_W_out
   );
            
neuron_inst_11: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n11_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n11_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n11_W_out
   );
            
neuron_inst_12: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n12_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n12_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n12_W_out
   );
            
neuron_inst_13: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n13_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n13_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n13_W_out
   );
            
neuron_inst_14: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n14_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n14_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n14_W_out
   );
            
neuron_inst_15: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n15_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n15_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n15_W_out
   );
            
neuron_inst_16: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n16_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n16_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n16_W_out
   );
            
neuron_inst_17: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n17_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n17_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n17_W_out
   );
            
neuron_inst_18: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n18_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n18_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n18_W_out
   );
            
neuron_inst_19: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n19_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n19_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n19_W_out
   );
            
neuron_inst_20: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n20_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n20_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n20_W_out
   );
            
neuron_inst_21: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n21_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n21_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n21_W_out
   );
            
neuron_inst_22: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n22_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n22_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n22_W_out
   );
            
neuron_inst_23: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n23_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n23_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n23_W_out
   );
            
neuron_inst_24: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n24_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n24_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n24_W_out
   );
            
neuron_inst_25: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n25_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n25_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n25_W_out
   );
            
neuron_inst_26: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n26_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n26_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n26_W_out
   );
            
neuron_inst_27: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n27_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n27_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n27_W_out
   );
            
neuron_inst_28: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n28_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n28_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n28_W_out
   );
            
neuron_inst_29: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n29_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n29_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n29_W_out
   );
            
neuron_inst_30: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n30_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n30_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n30_W_out
   );
            
neuron_inst_31: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n31_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n31_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n31_W_out
   );
            
neuron_inst_32: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n32_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n32_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n32_W_out
   );
            
neuron_inst_33: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n33_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n33_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n33_W_out
   );
            
neuron_inst_34: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n34_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n34_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n34_W_out
   );
            
neuron_inst_35: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n35_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n35_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n35_W_out
   );
            
neuron_inst_36: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n36_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n36_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n36_W_out
   );
            
neuron_inst_37: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n37_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n37_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n37_W_out
   );
            
neuron_inst_38: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n38_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n38_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n38_W_out
   );
            
neuron_inst_39: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n39_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n39_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n39_W_out
   );
            
neuron_inst_40: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n40_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n40_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n40_W_out
   );
            
neuron_inst_41: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n41_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n41_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n41_W_out
   );
            
neuron_inst_42: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n42_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n42_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n42_W_out
   );
            
neuron_inst_43: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n43_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n43_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n43_W_out
   );
            
neuron_inst_44: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n44_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n44_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n44_W_out
   );
            
neuron_inst_45: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n45_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n45_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n45_W_out
   );
            
neuron_inst_46: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n46_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n46_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n46_W_out
   );
            
neuron_inst_47: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n47_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n47_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n47_W_out
   );
            
neuron_inst_48: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n48_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n48_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n48_W_out
   );
            
neuron_inst_49: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n49_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n49_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n49_W_out
   );
            
neuron_inst_50: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n50_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n50_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n50_W_out
   );
            
neuron_inst_51: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n51_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n51_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n51_W_out
   );
            
neuron_inst_52: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n52_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n52_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n52_W_out
   );
            
neuron_inst_53: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n53_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n53_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n53_W_out
   );
            
neuron_inst_54: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n54_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n54_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n54_W_out
   );
            
neuron_inst_55: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n55_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n55_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n55_W_out
   );
            
neuron_inst_56: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n56_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n56_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n56_W_out
   );
            
neuron_inst_57: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n57_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n57_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n57_W_out
   );
            
neuron_inst_58: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n58_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n58_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n58_W_out
   );
            
neuron_inst_59: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n59_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n59_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n59_W_out
   );
            
neuron_inst_60: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n60_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n60_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n60_W_out
   );
            
neuron_inst_61: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n61_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n61_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n61_W_out
   );
            
neuron_inst_62: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n62_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n62_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n62_W_out
   );
            
neuron_inst_63: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n63_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n63_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n63_W_out
   );
            
neuron_inst_64: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n64_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n64_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n64_W_out
   );
            
neuron_inst_65: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n65_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n65_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n65_W_out
   );
            
neuron_inst_66: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n66_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n66_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n66_W_out
   );
            
neuron_inst_67: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n67_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n67_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n67_W_out
   );
            
neuron_inst_68: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n68_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n68_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n68_W_out
   );
            
neuron_inst_69: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n69_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n69_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n69_W_out
   );
            
neuron_inst_70: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n70_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n70_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n70_W_out
   );
            
neuron_inst_71: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n71_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n71_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n71_W_out
   );
            
neuron_inst_72: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n72_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n72_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n72_W_out
   );
            
neuron_inst_73: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n73_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n73_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n73_W_out
   );
            
neuron_inst_74: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n74_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n74_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n74_W_out
   );
            
neuron_inst_75: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n75_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n75_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n75_W_out
   );
            
neuron_inst_76: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n76_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n76_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n76_W_out
   );
            
neuron_inst_77: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n77_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n77_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n77_W_out
   );
            
neuron_inst_78: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n78_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n78_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n78_W_out
   );
            
neuron_inst_79: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n79_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n79_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n79_W_out
   );
            
neuron_inst_80: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n80_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n80_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n80_W_out
   );
            
neuron_inst_81: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n81_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n81_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n81_W_out
   );
            
neuron_inst_82: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n82_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n82_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n82_W_out
   );
            
neuron_inst_83: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n83_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n83_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n83_W_out
   );
            
neuron_inst_84: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n84_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n84_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n84_W_out
   );
            
neuron_inst_85: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n85_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n85_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n85_W_out
   );
            
neuron_inst_86: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n86_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n86_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n86_W_out
   );
            
neuron_inst_87: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n87_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n87_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n87_W_out
   );
            
neuron_inst_88: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n88_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n88_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n88_W_out
   );
            
neuron_inst_89: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n89_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n89_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n89_W_out
   );
            
neuron_inst_90: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n90_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n90_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n90_W_out
   );
            
neuron_inst_91: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n91_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n91_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n91_W_out
   );
            
neuron_inst_92: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n92_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n92_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n92_W_out
   );
            
neuron_inst_93: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n93_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n93_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n93_W_out
   );
            
neuron_inst_94: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n94_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n94_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n94_W_out
   );
            
neuron_inst_95: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n95_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n95_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n95_W_out
   );
            
neuron_inst_96: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n96_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n96_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n96_W_out
   );
            
neuron_inst_97: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n97_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n97_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n97_W_out
   );
            
neuron_inst_98: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n98_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n98_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n98_W_out
   );
            
neuron_inst_99: ENTITY work.neuron_ReLU_300n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c2_n99_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c2_n99_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c2_n99_W_out
   );
             
END ARCHITECTURE;

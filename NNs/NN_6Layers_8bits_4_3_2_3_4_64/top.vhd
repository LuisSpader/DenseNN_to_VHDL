LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
  ENTITY  top IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 64;
    TOTAL_BITS : NATURAL := 512
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c5_n4_W_in, c5_n5_W_in, c5_n6_W_in, c5_n7_W_in, c5_n8_W_in, c5_n9_W_in, c5_n10_W_in, c5_n11_W_in, c5_n12_W_in, c5_n13_W_in, c5_n14_W_in, c5_n15_W_in, c5_n16_W_in, c5_n17_W_in, c5_n18_W_in, c5_n19_W_in, c5_n20_W_in, c5_n21_W_in, c5_n22_W_in, c5_n23_W_in, c5_n24_W_in, c5_n25_W_in, c5_n26_W_in, c5_n27_W_in, c5_n28_W_in, c5_n29_W_in, c5_n30_W_in, c5_n31_W_in, c5_n32_W_in, c5_n33_W_in, c5_n34_W_in, c5_n35_W_in, c5_n36_W_in, c5_n37_W_in, c5_n38_W_in, c5_n39_W_in, c5_n40_W_in, c5_n41_W_in, c5_n42_W_in, c5_n43_W_in, c5_n44_W_in, c5_n45_W_in, c5_n46_W_in, c5_n47_W_in, c5_n48_W_in, c5_n49_W_in, c5_n50_W_in, c5_n51_W_in, c5_n52_W_in, c5_n53_W_in, c5_n54_W_in, c5_n55_W_in, c5_n56_W_in, c5_n57_W_in, c5_n58_W_in, c5_n59_W_in, c5_n60_W_in, c5_n61_W_in, c5_n62_W_in, c5_n63_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c5_n0_IO_out, c5_n1_IO_out, c5_n2_IO_out, c5_n3_IO_out, c5_n4_IO_out, c5_n5_IO_out, c5_n6_IO_out, c5_n7_IO_out, c5_n8_IO_out, c5_n9_IO_out, c5_n10_IO_out, c5_n11_IO_out, c5_n12_IO_out, c5_n13_IO_out, c5_n14_IO_out, c5_n15_IO_out, c5_n16_IO_out, c5_n17_IO_out, c5_n18_IO_out, c5_n19_IO_out, c5_n20_IO_out, c5_n21_IO_out, c5_n22_IO_out, c5_n23_IO_out, c5_n24_IO_out, c5_n25_IO_out, c5_n26_IO_out, c5_n27_IO_out, c5_n28_IO_out, c5_n29_IO_out, c5_n30_IO_out, c5_n31_IO_out, c5_n32_IO_out, c5_n33_IO_out, c5_n34_IO_out, c5_n35_IO_out, c5_n36_IO_out, c5_n37_IO_out, c5_n38_IO_out, c5_n39_IO_out, c5_n40_IO_out, c5_n41_IO_out, c5_n42_IO_out, c5_n43_IO_out, c5_n44_IO_out, c5_n45_IO_out, c5_n46_IO_out, c5_n47_IO_out, c5_n48_IO_out, c5_n49_IO_out, c5_n50_IO_out, c5_n51_IO_out, c5_n52_IO_out, c5_n53_IO_out, c5_n54_IO_out, c5_n55_IO_out, c5_n56_IO_out, c5_n57_IO_out, c5_n58_IO_out, c5_n59_IO_out, c5_n60_IO_out, c5_n61_IO_out, c5_n62_IO_out, c5_n63_IO_out: OUT signed(BITS -1 DOWNTO 0)
  );
  end ENTITY;
ARCHITECTURE arch OF  top  IS
-- SIGNALS
  SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c1_n0_W_out, c1_n1_W_out, c1_n2_W_out, c4_n3_W_out, c2_n0_W_out, c2_n1_W_out, c3_n2_W_out, c3_n0_W_out, c3_n1_W_out, c4_n2_W_out, c4_n0_W_out, c4_n1_W_out: signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_IO_in:  signed((BITS*4) - 1 DOWNTO 0);
  SIGNAL c2_IO_in:  signed((BITS*3) - 1 DOWNTO 0);
  SIGNAL c3_IO_in:  signed((BITS*2) - 1 DOWNTO 0);
  SIGNAL c4_IO_in:  signed((BITS*3) - 1 DOWNTO 0);
  SIGNAL c5_IO_in:  signed((BITS*4) - 1 DOWNTO 0);
  SIGNAL c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c2_n0_IO_out, c2_n1_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c4_n0_IO_out, c4_n1_IO_out, c4_n2_IO_out, c4_n3_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL reg_IO_in: signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL en_registers: STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  c1_IO_in <= c0_n0_IO_out & c0_n1_IO_out & c0_n2_IO_out & c0_n3_IO_out;
c2_IO_in <= c1_n0_IO_out & c1_n1_IO_out & c1_n2_IO_out;
c3_IO_in <= c2_n0_IO_out & c2_n1_IO_out;
c4_IO_in <= c3_n0_IO_out & c3_n1_IO_out & c3_n2_IO_out;
c5_IO_in <= c4_n0_IO_out & c4_n1_IO_out & c4_n2_IO_out & c4_n3_IO_out;
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

camada0_inst_0: ENTITY work.camada0_ReLU_4neuron_8bits_64n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> reg_IO_in, 
            c0_n0_W_in=> c0_n0_W_in, 
            c0_n1_W_in=> c0_n1_W_in, 
            c0_n2_W_in=> c0_n2_W_in, 
            c0_n3_W_in=> c0_n3_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c0_n0_IO_out=> c0_n0_IO_out, 
            c0_n1_IO_out=> c0_n1_IO_out, 
            c0_n2_IO_out=> c0_n2_IO_out, 
            c0_n3_IO_out=> c0_n3_IO_out, 
            -- ['OUT']['manual'] 
            c0_n0_W_out=> c0_n0_W_out, 
            c0_n1_W_out=> c0_n1_W_out, 
            c0_n2_W_out=> c0_n2_W_out, 
            c0_n3_W_out=> c0_n3_W_out
   );
            
camada1_inst_1: ENTITY work.camada1_ReLU_3neuron_8bits_4n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c1_IO_in, 
            c1_n0_W_in=> c0_n0_W_out,
            c1_n1_W_in=> c0_n1_W_out,
            c1_n2_W_in=> c0_n2_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c1_n0_IO_out=> c1_n0_IO_out, 
            c1_n1_IO_out=> c1_n1_IO_out, 
            c1_n2_IO_out=> c1_n2_IO_out, 
            -- ['OUT']['manual'] 
            c1_n0_W_out=> c1_n0_W_out, 
            c1_n1_W_out=> c1_n1_W_out, 
            c1_n2_W_out=> c1_n2_W_out
   );
            
camada2_inst_2: ENTITY work.camada2_ReLU_2neuron_8bits_3n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c2_IO_in, 
            c2_n0_W_in=> c1_n0_W_out,
            c2_n1_W_in=> c1_n1_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c2_n0_IO_out=> c2_n0_IO_out, 
            c2_n1_IO_out=> c2_n1_IO_out, 
            -- ['OUT']['manual'] 
            c2_n0_W_out=> c2_n0_W_out, 
            c2_n1_W_out=> c2_n1_W_out
   );
            
camada3_inst_3: ENTITY work.camada3_ReLU_3neuron_8bits_2n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c3_IO_in, 
            c3_n0_W_in=> c2_n0_W_out,
            c3_n1_W_in=> c2_n1_W_out,
            c3_n2_W_in=> c1_n2_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c3_n0_IO_out=> c3_n0_IO_out, 
            c3_n1_IO_out=> c3_n1_IO_out, 
            c3_n2_IO_out=> c3_n2_IO_out, 
            -- ['OUT']['manual'] 
            c3_n0_W_out=> c3_n0_W_out, 
            c3_n1_W_out=> c3_n1_W_out, 
            c3_n2_W_out=> c3_n2_W_out
   );
            
camada4_inst_4: ENTITY work.camada4_ReLU_4neuron_8bits_3n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c4_IO_in, 
            c4_n0_W_in=> c3_n0_W_out,
            c4_n1_W_in=> c3_n1_W_out,
            c4_n2_W_in=> c3_n2_W_out,
            c4_n3_W_in=> c0_n3_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c4_n0_IO_out=> c4_n0_IO_out, 
            c4_n1_IO_out=> c4_n1_IO_out, 
            c4_n2_IO_out=> c4_n2_IO_out, 
            c4_n3_IO_out=> c4_n3_IO_out, 
            -- ['OUT']['manual'] 
            c4_n0_W_out=> c4_n0_W_out, 
            c4_n1_W_out=> c4_n1_W_out, 
            c4_n2_W_out=> c4_n2_W_out, 
            c4_n3_W_out=> c4_n3_W_out
   );
            
camada5_inst_5: ENTITY work.camada5_Sigmoid_64neuron_8bits_4n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c5_IO_in, 
            c5_n0_W_in=> c4_n0_W_out,
            c5_n1_W_in=> c4_n1_W_out,
            c5_n2_W_in=> c4_n2_W_out,
            c5_n3_W_in=> c4_n3_W_out,
            c5_n4_W_in=> c5_n4_W_in,
            c5_n5_W_in=> c5_n5_W_in,
            c5_n6_W_in=> c5_n6_W_in,
            c5_n7_W_in=> c5_n7_W_in,
            c5_n8_W_in=> c5_n8_W_in,
            c5_n9_W_in=> c5_n9_W_in,
            c5_n10_W_in=> c5_n10_W_in,
            c5_n11_W_in=> c5_n11_W_in,
            c5_n12_W_in=> c5_n12_W_in,
            c5_n13_W_in=> c5_n13_W_in,
            c5_n14_W_in=> c5_n14_W_in,
            c5_n15_W_in=> c5_n15_W_in,
            c5_n16_W_in=> c5_n16_W_in,
            c5_n17_W_in=> c5_n17_W_in,
            c5_n18_W_in=> c5_n18_W_in,
            c5_n19_W_in=> c5_n19_W_in,
            c5_n20_W_in=> c5_n20_W_in,
            c5_n21_W_in=> c5_n21_W_in,
            c5_n22_W_in=> c5_n22_W_in,
            c5_n23_W_in=> c5_n23_W_in,
            c5_n24_W_in=> c5_n24_W_in,
            c5_n25_W_in=> c5_n25_W_in,
            c5_n26_W_in=> c5_n26_W_in,
            c5_n27_W_in=> c5_n27_W_in,
            c5_n28_W_in=> c5_n28_W_in,
            c5_n29_W_in=> c5_n29_W_in,
            c5_n30_W_in=> c5_n30_W_in,
            c5_n31_W_in=> c5_n31_W_in,
            c5_n32_W_in=> c5_n32_W_in,
            c5_n33_W_in=> c5_n33_W_in,
            c5_n34_W_in=> c5_n34_W_in,
            c5_n35_W_in=> c5_n35_W_in,
            c5_n36_W_in=> c5_n36_W_in,
            c5_n37_W_in=> c5_n37_W_in,
            c5_n38_W_in=> c5_n38_W_in,
            c5_n39_W_in=> c5_n39_W_in,
            c5_n40_W_in=> c5_n40_W_in,
            c5_n41_W_in=> c5_n41_W_in,
            c5_n42_W_in=> c5_n42_W_in,
            c5_n43_W_in=> c5_n43_W_in,
            c5_n44_W_in=> c5_n44_W_in,
            c5_n45_W_in=> c5_n45_W_in,
            c5_n46_W_in=> c5_n46_W_in,
            c5_n47_W_in=> c5_n47_W_in,
            c5_n48_W_in=> c5_n48_W_in,
            c5_n49_W_in=> c5_n49_W_in,
            c5_n50_W_in=> c5_n50_W_in,
            c5_n51_W_in=> c5_n51_W_in,
            c5_n52_W_in=> c5_n52_W_in,
            c5_n53_W_in=> c5_n53_W_in,
            c5_n54_W_in=> c5_n54_W_in,
            c5_n55_W_in=> c5_n55_W_in,
            c5_n56_W_in=> c5_n56_W_in,
            c5_n57_W_in=> c5_n57_W_in,
            c5_n58_W_in=> c5_n58_W_in,
            c5_n59_W_in=> c5_n59_W_in,
            c5_n60_W_in=> c5_n60_W_in,
            c5_n61_W_in=> c5_n61_W_in,
            c5_n62_W_in=> c5_n62_W_in,
            c5_n63_W_in=> c5_n63_W_in,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c5_n0_IO_out=> c5_n0_IO_out, 
            c5_n1_IO_out=> c5_n1_IO_out, 
            c5_n2_IO_out=> c5_n2_IO_out, 
            c5_n3_IO_out=> c5_n3_IO_out, 
            c5_n4_IO_out=> c5_n4_IO_out, 
            c5_n5_IO_out=> c5_n5_IO_out, 
            c5_n6_IO_out=> c5_n6_IO_out, 
            c5_n7_IO_out=> c5_n7_IO_out, 
            c5_n8_IO_out=> c5_n8_IO_out, 
            c5_n9_IO_out=> c5_n9_IO_out, 
            c5_n10_IO_out=> c5_n10_IO_out, 
            c5_n11_IO_out=> c5_n11_IO_out, 
            c5_n12_IO_out=> c5_n12_IO_out, 
            c5_n13_IO_out=> c5_n13_IO_out, 
            c5_n14_IO_out=> c5_n14_IO_out, 
            c5_n15_IO_out=> c5_n15_IO_out, 
            c5_n16_IO_out=> c5_n16_IO_out, 
            c5_n17_IO_out=> c5_n17_IO_out, 
            c5_n18_IO_out=> c5_n18_IO_out, 
            c5_n19_IO_out=> c5_n19_IO_out, 
            c5_n20_IO_out=> c5_n20_IO_out, 
            c5_n21_IO_out=> c5_n21_IO_out, 
            c5_n22_IO_out=> c5_n22_IO_out, 
            c5_n23_IO_out=> c5_n23_IO_out, 
            c5_n24_IO_out=> c5_n24_IO_out, 
            c5_n25_IO_out=> c5_n25_IO_out, 
            c5_n26_IO_out=> c5_n26_IO_out, 
            c5_n27_IO_out=> c5_n27_IO_out, 
            c5_n28_IO_out=> c5_n28_IO_out, 
            c5_n29_IO_out=> c5_n29_IO_out, 
            c5_n30_IO_out=> c5_n30_IO_out, 
            c5_n31_IO_out=> c5_n31_IO_out, 
            c5_n32_IO_out=> c5_n32_IO_out, 
            c5_n33_IO_out=> c5_n33_IO_out, 
            c5_n34_IO_out=> c5_n34_IO_out, 
            c5_n35_IO_out=> c5_n35_IO_out, 
            c5_n36_IO_out=> c5_n36_IO_out, 
            c5_n37_IO_out=> c5_n37_IO_out, 
            c5_n38_IO_out=> c5_n38_IO_out, 
            c5_n39_IO_out=> c5_n39_IO_out, 
            c5_n40_IO_out=> c5_n40_IO_out, 
            c5_n41_IO_out=> c5_n41_IO_out, 
            c5_n42_IO_out=> c5_n42_IO_out, 
            c5_n43_IO_out=> c5_n43_IO_out, 
            c5_n44_IO_out=> c5_n44_IO_out, 
            c5_n45_IO_out=> c5_n45_IO_out, 
            c5_n46_IO_out=> c5_n46_IO_out, 
            c5_n47_IO_out=> c5_n47_IO_out, 
            c5_n48_IO_out=> c5_n48_IO_out, 
            c5_n49_IO_out=> c5_n49_IO_out, 
            c5_n50_IO_out=> c5_n50_IO_out, 
            c5_n51_IO_out=> c5_n51_IO_out, 
            c5_n52_IO_out=> c5_n52_IO_out, 
            c5_n53_IO_out=> c5_n53_IO_out, 
            c5_n54_IO_out=> c5_n54_IO_out, 
            c5_n55_IO_out=> c5_n55_IO_out, 
            c5_n56_IO_out=> c5_n56_IO_out, 
            c5_n57_IO_out=> c5_n57_IO_out, 
            c5_n58_IO_out=> c5_n58_IO_out, 
            c5_n59_IO_out=> c5_n59_IO_out, 
            c5_n60_IO_out=> c5_n60_IO_out, 
            c5_n61_IO_out=> c5_n61_IO_out, 
            c5_n62_IO_out=> c5_n62_IO_out, 
            c5_n63_IO_out=> c5_n63_IO_out
   );
            
END ARCHITECTURE;

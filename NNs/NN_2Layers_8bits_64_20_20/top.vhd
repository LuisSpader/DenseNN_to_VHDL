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
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in, c0_n15_W_in, c0_n16_W_in, c0_n17_W_in, c0_n18_W_in, c0_n19_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out, c1_n3_IO_out, c1_n4_IO_out, c1_n5_IO_out, c1_n6_IO_out, c1_n7_IO_out, c1_n8_IO_out, c1_n9_IO_out, c1_n10_IO_out, c1_n11_IO_out, c1_n12_IO_out, c1_n13_IO_out, c1_n14_IO_out, c1_n15_IO_out, c1_n16_IO_out, c1_n17_IO_out, c1_n18_IO_out, c1_n19_IO_out: OUT signed(BITS -1 DOWNTO 0)
  );
  end ENTITY;
ARCHITECTURE arch OF  top  IS
-- SIGNALS
  SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c0_n5_W_out, c0_n6_W_out, c0_n7_W_out, c0_n8_W_out, c0_n9_W_out, c0_n10_W_out, c0_n11_W_out, c0_n12_W_out, c0_n13_W_out, c0_n14_W_out, c0_n15_W_out, c0_n16_W_out, c0_n17_W_out, c0_n18_W_out, c0_n19_W_out: signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_IO_in:  signed((BITS*20) - 1 DOWNTO 0);
  SIGNAL c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out, c0_n6_IO_out, c0_n7_IO_out, c0_n8_IO_out, c0_n9_IO_out, c0_n10_IO_out, c0_n11_IO_out, c0_n12_IO_out, c0_n13_IO_out, c0_n14_IO_out, c0_n15_IO_out, c0_n16_IO_out, c0_n17_IO_out, c0_n18_IO_out, c0_n19_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL reg_IO_in: signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL en_registers: STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  c1_IO_in <= c0_n0_IO_out & c0_n1_IO_out & c0_n2_IO_out & c0_n3_IO_out & c0_n4_IO_out & c0_n5_IO_out & c0_n6_IO_out & c0_n7_IO_out & c0_n8_IO_out & c0_n9_IO_out & c0_n10_IO_out & c0_n11_IO_out & c0_n12_IO_out & c0_n13_IO_out & c0_n14_IO_out & c0_n15_IO_out & c0_n16_IO_out & c0_n17_IO_out & c0_n18_IO_out & c0_n19_IO_out;
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

camada0_inst_0: ENTITY work.camada0_ReLU_20neuron_8bits_64n_signed
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
            c0_n4_W_in=> c0_n4_W_in, 
            c0_n5_W_in=> c0_n5_W_in, 
            c0_n6_W_in=> c0_n6_W_in, 
            c0_n7_W_in=> c0_n7_W_in, 
            c0_n8_W_in=> c0_n8_W_in, 
            c0_n9_W_in=> c0_n9_W_in, 
            c0_n10_W_in=> c0_n10_W_in, 
            c0_n11_W_in=> c0_n11_W_in, 
            c0_n12_W_in=> c0_n12_W_in, 
            c0_n13_W_in=> c0_n13_W_in, 
            c0_n14_W_in=> c0_n14_W_in, 
            c0_n15_W_in=> c0_n15_W_in, 
            c0_n16_W_in=> c0_n16_W_in, 
            c0_n17_W_in=> c0_n17_W_in, 
            c0_n18_W_in=> c0_n18_W_in, 
            c0_n19_W_in=> c0_n19_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c0_n0_IO_out=> c0_n0_IO_out, 
            c0_n1_IO_out=> c0_n1_IO_out, 
            c0_n2_IO_out=> c0_n2_IO_out, 
            c0_n3_IO_out=> c0_n3_IO_out, 
            c0_n4_IO_out=> c0_n4_IO_out, 
            c0_n5_IO_out=> c0_n5_IO_out, 
            c0_n6_IO_out=> c0_n6_IO_out, 
            c0_n7_IO_out=> c0_n7_IO_out, 
            c0_n8_IO_out=> c0_n8_IO_out, 
            c0_n9_IO_out=> c0_n9_IO_out, 
            c0_n10_IO_out=> c0_n10_IO_out, 
            c0_n11_IO_out=> c0_n11_IO_out, 
            c0_n12_IO_out=> c0_n12_IO_out, 
            c0_n13_IO_out=> c0_n13_IO_out, 
            c0_n14_IO_out=> c0_n14_IO_out, 
            c0_n15_IO_out=> c0_n15_IO_out, 
            c0_n16_IO_out=> c0_n16_IO_out, 
            c0_n17_IO_out=> c0_n17_IO_out, 
            c0_n18_IO_out=> c0_n18_IO_out, 
            c0_n19_IO_out=> c0_n19_IO_out, 
            -- ['OUT']['manual'] 
            c0_n0_W_out=> c0_n0_W_out, 
            c0_n1_W_out=> c0_n1_W_out, 
            c0_n2_W_out=> c0_n2_W_out, 
            c0_n3_W_out=> c0_n3_W_out, 
            c0_n4_W_out=> c0_n4_W_out, 
            c0_n5_W_out=> c0_n5_W_out, 
            c0_n6_W_out=> c0_n6_W_out, 
            c0_n7_W_out=> c0_n7_W_out, 
            c0_n8_W_out=> c0_n8_W_out, 
            c0_n9_W_out=> c0_n9_W_out, 
            c0_n10_W_out=> c0_n10_W_out, 
            c0_n11_W_out=> c0_n11_W_out, 
            c0_n12_W_out=> c0_n12_W_out, 
            c0_n13_W_out=> c0_n13_W_out, 
            c0_n14_W_out=> c0_n14_W_out, 
            c0_n15_W_out=> c0_n15_W_out, 
            c0_n16_W_out=> c0_n16_W_out, 
            c0_n17_W_out=> c0_n17_W_out, 
            c0_n18_W_out=> c0_n18_W_out, 
            c0_n19_W_out=> c0_n19_W_out
   );
            
camada1_inst_1: ENTITY work.camada1_Linear_20neuron_8bits_20n_signed
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
            c1_n3_W_in=> c0_n3_W_out,
            c1_n4_W_in=> c0_n4_W_out,
            c1_n5_W_in=> c0_n5_W_out,
            c1_n6_W_in=> c0_n6_W_out,
            c1_n7_W_in=> c0_n7_W_out,
            c1_n8_W_in=> c0_n8_W_out,
            c1_n9_W_in=> c0_n9_W_out,
            c1_n10_W_in=> c0_n10_W_out,
            c1_n11_W_in=> c0_n11_W_out,
            c1_n12_W_in=> c0_n12_W_out,
            c1_n13_W_in=> c0_n13_W_out,
            c1_n14_W_in=> c0_n14_W_out,
            c1_n15_W_in=> c0_n15_W_out,
            c1_n16_W_in=> c0_n16_W_out,
            c1_n17_W_in=> c0_n17_W_out,
            c1_n18_W_in=> c0_n18_W_out,
            c1_n19_W_in=> c0_n19_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c1_n0_IO_out=> c1_n0_IO_out, 
            c1_n1_IO_out=> c1_n1_IO_out, 
            c1_n2_IO_out=> c1_n2_IO_out, 
            c1_n3_IO_out=> c1_n3_IO_out, 
            c1_n4_IO_out=> c1_n4_IO_out, 
            c1_n5_IO_out=> c1_n5_IO_out, 
            c1_n6_IO_out=> c1_n6_IO_out, 
            c1_n7_IO_out=> c1_n7_IO_out, 
            c1_n8_IO_out=> c1_n8_IO_out, 
            c1_n9_IO_out=> c1_n9_IO_out, 
            c1_n10_IO_out=> c1_n10_IO_out, 
            c1_n11_IO_out=> c1_n11_IO_out, 
            c1_n12_IO_out=> c1_n12_IO_out, 
            c1_n13_IO_out=> c1_n13_IO_out, 
            c1_n14_IO_out=> c1_n14_IO_out, 
            c1_n15_IO_out=> c1_n15_IO_out, 
            c1_n16_IO_out=> c1_n16_IO_out, 
            c1_n17_IO_out=> c1_n17_IO_out, 
            c1_n18_IO_out=> c1_n18_IO_out, 
            c1_n19_IO_out=> c1_n19_IO_out
   );
            
END ARCHITECTURE;

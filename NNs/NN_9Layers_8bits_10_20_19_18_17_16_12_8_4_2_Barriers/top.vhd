LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
  ENTITY  top IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 10;
    TOTAL_BITS : NATURAL := 80
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in, c0_n15_W_in, c0_n16_W_in, c0_n17_W_in, c0_n18_W_in, c0_n19_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c8_n0_IO_out, c8_n1_IO_out: OUT signed(BITS -1 DOWNTO 0)
  );
  end ENTITY;
ARCHITECTURE arch OF  top  IS
-- SIGNALS
  SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c0_n5_W_out, c0_n6_W_out, c0_n7_W_out, c0_n8_W_out, c0_n9_W_out, c0_n10_W_out, c0_n11_W_out, c0_n12_W_out, c0_n13_W_out, c0_n14_W_out, c0_n15_W_out, c0_n16_W_out, c0_n17_W_out, c0_n18_W_out, c1_n0_W_out, c1_n1_W_out, c1_n2_W_out, c1_n3_W_out, c1_n4_W_out, c1_n5_W_out, c1_n6_W_out, c1_n7_W_out, c1_n8_W_out, c1_n9_W_out, c1_n10_W_out, c1_n11_W_out, c1_n12_W_out, c1_n13_W_out, c1_n14_W_out, c1_n15_W_out, c1_n16_W_out, c1_n17_W_out, c2_n0_W_out, c2_n1_W_out, c2_n2_W_out, c2_n3_W_out, c2_n4_W_out, c2_n5_W_out, c2_n6_W_out, c2_n7_W_out, c2_n8_W_out, c2_n9_W_out, c2_n10_W_out, c2_n11_W_out, c2_n12_W_out, c2_n13_W_out, c2_n14_W_out, c2_n15_W_out, c2_n16_W_out, c3_n0_W_out, c3_n1_W_out, c3_n2_W_out, c3_n3_W_out, c3_n4_W_out, c3_n5_W_out, c3_n6_W_out, c3_n7_W_out, c3_n8_W_out, c3_n9_W_out, c3_n10_W_out, c3_n11_W_out, c3_n12_W_out, c3_n13_W_out, c3_n14_W_out, c3_n15_W_out, c4_n0_W_out, c4_n1_W_out, c4_n2_W_out, c4_n3_W_out, c4_n4_W_out, c4_n5_W_out, c4_n6_W_out, c4_n7_W_out, c4_n8_W_out, c4_n9_W_out, c4_n10_W_out, c4_n11_W_out, c5_n0_W_out, c5_n1_W_out, c5_n2_W_out, c5_n3_W_out, c5_n4_W_out, c5_n5_W_out, c5_n6_W_out, c5_n7_W_out, c6_n0_W_out, c6_n1_W_out, c6_n2_W_out, c6_n3_W_out, c7_n0_W_out, c7_n1_W_out: signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_IO_in:  signed((BITS*20) - 1 DOWNTO 0);
  SIGNAL c2_IO_in:  signed((BITS*19) - 1 DOWNTO 0);
  SIGNAL c3_IO_in:  signed((BITS*18) - 1 DOWNTO 0);
  SIGNAL c4_IO_in:  signed((BITS*17) - 1 DOWNTO 0);
  SIGNAL c5_IO_in:  signed((BITS*16) - 1 DOWNTO 0);
  SIGNAL c6_IO_in:  signed((BITS*12) - 1 DOWNTO 0);
  SIGNAL c7_IO_in:  signed((BITS*8) - 1 DOWNTO 0);
  SIGNAL c8_IO_in:  signed((BITS*4) - 1 DOWNTO 0);
  SIGNAL c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out, c0_n6_IO_out, c0_n7_IO_out, c0_n8_IO_out, c0_n9_IO_out, c0_n10_IO_out, c0_n11_IO_out, c0_n12_IO_out, c0_n13_IO_out, c0_n14_IO_out, c0_n15_IO_out, c0_n16_IO_out, c0_n17_IO_out, c0_n18_IO_out, c0_n19_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out, c1_n3_IO_out, c1_n4_IO_out, c1_n5_IO_out, c1_n6_IO_out, c1_n7_IO_out, c1_n8_IO_out, c1_n9_IO_out, c1_n10_IO_out, c1_n11_IO_out, c1_n12_IO_out, c1_n13_IO_out, c1_n14_IO_out, c1_n15_IO_out, c1_n16_IO_out, c1_n17_IO_out, c1_n18_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c2_n0_IO_out, c2_n1_IO_out, c2_n2_IO_out, c2_n3_IO_out, c2_n4_IO_out, c2_n5_IO_out, c2_n6_IO_out, c2_n7_IO_out, c2_n8_IO_out, c2_n9_IO_out, c2_n10_IO_out, c2_n11_IO_out, c2_n12_IO_out, c2_n13_IO_out, c2_n14_IO_out, c2_n15_IO_out, c2_n16_IO_out, c2_n17_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out, c3_n4_IO_out, c3_n5_IO_out, c3_n6_IO_out, c3_n7_IO_out, c3_n8_IO_out, c3_n9_IO_out, c3_n10_IO_out, c3_n11_IO_out, c3_n12_IO_out, c3_n13_IO_out, c3_n14_IO_out, c3_n15_IO_out, c3_n16_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c4_n0_IO_out, c4_n1_IO_out, c4_n2_IO_out, c4_n3_IO_out, c4_n4_IO_out, c4_n5_IO_out, c4_n6_IO_out, c4_n7_IO_out, c4_n8_IO_out, c4_n9_IO_out, c4_n10_IO_out, c4_n11_IO_out, c4_n12_IO_out, c4_n13_IO_out, c4_n14_IO_out, c4_n15_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c5_n0_IO_out, c5_n1_IO_out, c5_n2_IO_out, c5_n3_IO_out, c5_n4_IO_out, c5_n5_IO_out, c5_n6_IO_out, c5_n7_IO_out, c5_n8_IO_out, c5_n9_IO_out, c5_n10_IO_out, c5_n11_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c6_n0_IO_out, c6_n1_IO_out, c6_n2_IO_out, c6_n3_IO_out, c6_n4_IO_out, c6_n5_IO_out, c6_n6_IO_out, c6_n7_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c7_n0_IO_out, c7_n1_IO_out, c7_n2_IO_out, c7_n3_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL reg_IO_in: signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL en_registers: STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  c1_IO_in <= c0_n0_IO_out & c0_n1_IO_out & c0_n2_IO_out & c0_n3_IO_out & c0_n4_IO_out & c0_n5_IO_out & c0_n6_IO_out & c0_n7_IO_out & c0_n8_IO_out & c0_n9_IO_out & c0_n10_IO_out & c0_n11_IO_out & c0_n12_IO_out & c0_n13_IO_out & c0_n14_IO_out & c0_n15_IO_out & c0_n16_IO_out & c0_n17_IO_out & c0_n18_IO_out & c0_n19_IO_out;
c2_IO_in <= c1_n0_IO_out & c1_n1_IO_out & c1_n2_IO_out & c1_n3_IO_out & c1_n4_IO_out & c1_n5_IO_out & c1_n6_IO_out & c1_n7_IO_out & c1_n8_IO_out & c1_n9_IO_out & c1_n10_IO_out & c1_n11_IO_out & c1_n12_IO_out & c1_n13_IO_out & c1_n14_IO_out & c1_n15_IO_out & c1_n16_IO_out & c1_n17_IO_out & c1_n18_IO_out;
c3_IO_in <= c2_n0_IO_out & c2_n1_IO_out & c2_n2_IO_out & c2_n3_IO_out & c2_n4_IO_out & c2_n5_IO_out & c2_n6_IO_out & c2_n7_IO_out & c2_n8_IO_out & c2_n9_IO_out & c2_n10_IO_out & c2_n11_IO_out & c2_n12_IO_out & c2_n13_IO_out & c2_n14_IO_out & c2_n15_IO_out & c2_n16_IO_out & c2_n17_IO_out;
c4_IO_in <= c3_n0_IO_out & c3_n1_IO_out & c3_n2_IO_out & c3_n3_IO_out & c3_n4_IO_out & c3_n5_IO_out & c3_n6_IO_out & c3_n7_IO_out & c3_n8_IO_out & c3_n9_IO_out & c3_n10_IO_out & c3_n11_IO_out & c3_n12_IO_out & c3_n13_IO_out & c3_n14_IO_out & c3_n15_IO_out & c3_n16_IO_out;
c5_IO_in <= c4_n0_IO_out & c4_n1_IO_out & c4_n2_IO_out & c4_n3_IO_out & c4_n4_IO_out & c4_n5_IO_out & c4_n6_IO_out & c4_n7_IO_out & c4_n8_IO_out & c4_n9_IO_out & c4_n10_IO_out & c4_n11_IO_out & c4_n12_IO_out & c4_n13_IO_out & c4_n14_IO_out & c4_n15_IO_out;
c6_IO_in <= c5_n0_IO_out & c5_n1_IO_out & c5_n2_IO_out & c5_n3_IO_out & c5_n4_IO_out & c5_n5_IO_out & c5_n6_IO_out & c5_n7_IO_out & c5_n8_IO_out & c5_n9_IO_out & c5_n10_IO_out & c5_n11_IO_out;
c7_IO_in <= c6_n0_IO_out & c6_n1_IO_out & c6_n2_IO_out & c6_n3_IO_out & c6_n4_IO_out & c6_n5_IO_out & c6_n6_IO_out & c6_n7_IO_out;
c8_IO_in <= c7_n0_IO_out & c7_n1_IO_out & c7_n2_IO_out & c7_n3_IO_out;
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

camada0_inst_0: ENTITY work.camada0_ReLU_20neuron_8bits_10n_signed
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
            c0_n18_W_out=> c0_n18_W_out
   );
            
camada1_inst_1: ENTITY work.camada1_ReLU_19neuron_8bits_20n_signed
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
            -- ['OUT']['manual'] 
            c1_n0_W_out=> c1_n0_W_out, 
            c1_n1_W_out=> c1_n1_W_out, 
            c1_n2_W_out=> c1_n2_W_out, 
            c1_n3_W_out=> c1_n3_W_out, 
            c1_n4_W_out=> c1_n4_W_out, 
            c1_n5_W_out=> c1_n5_W_out, 
            c1_n6_W_out=> c1_n6_W_out, 
            c1_n7_W_out=> c1_n7_W_out, 
            c1_n8_W_out=> c1_n8_W_out, 
            c1_n9_W_out=> c1_n9_W_out, 
            c1_n10_W_out=> c1_n10_W_out, 
            c1_n11_W_out=> c1_n11_W_out, 
            c1_n12_W_out=> c1_n12_W_out, 
            c1_n13_W_out=> c1_n13_W_out, 
            c1_n14_W_out=> c1_n14_W_out, 
            c1_n15_W_out=> c1_n15_W_out, 
            c1_n16_W_out=> c1_n16_W_out, 
            c1_n17_W_out=> c1_n17_W_out
   );
            
camada2_inst_2: ENTITY work.camada2_ReLU_18neuron_8bits_19n_signed
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
            c2_n2_W_in=> c1_n2_W_out,
            c2_n3_W_in=> c1_n3_W_out,
            c2_n4_W_in=> c1_n4_W_out,
            c2_n5_W_in=> c1_n5_W_out,
            c2_n6_W_in=> c1_n6_W_out,
            c2_n7_W_in=> c1_n7_W_out,
            c2_n8_W_in=> c1_n8_W_out,
            c2_n9_W_in=> c1_n9_W_out,
            c2_n10_W_in=> c1_n10_W_out,
            c2_n11_W_in=> c1_n11_W_out,
            c2_n12_W_in=> c1_n12_W_out,
            c2_n13_W_in=> c1_n13_W_out,
            c2_n14_W_in=> c1_n14_W_out,
            c2_n15_W_in=> c1_n15_W_out,
            c2_n16_W_in=> c1_n16_W_out,
            c2_n17_W_in=> c1_n17_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c2_n0_IO_out=> c2_n0_IO_out, 
            c2_n1_IO_out=> c2_n1_IO_out, 
            c2_n2_IO_out=> c2_n2_IO_out, 
            c2_n3_IO_out=> c2_n3_IO_out, 
            c2_n4_IO_out=> c2_n4_IO_out, 
            c2_n5_IO_out=> c2_n5_IO_out, 
            c2_n6_IO_out=> c2_n6_IO_out, 
            c2_n7_IO_out=> c2_n7_IO_out, 
            c2_n8_IO_out=> c2_n8_IO_out, 
            c2_n9_IO_out=> c2_n9_IO_out, 
            c2_n10_IO_out=> c2_n10_IO_out, 
            c2_n11_IO_out=> c2_n11_IO_out, 
            c2_n12_IO_out=> c2_n12_IO_out, 
            c2_n13_IO_out=> c2_n13_IO_out, 
            c2_n14_IO_out=> c2_n14_IO_out, 
            c2_n15_IO_out=> c2_n15_IO_out, 
            c2_n16_IO_out=> c2_n16_IO_out, 
            c2_n17_IO_out=> c2_n17_IO_out, 
            -- ['OUT']['manual'] 
            c2_n0_W_out=> c2_n0_W_out, 
            c2_n1_W_out=> c2_n1_W_out, 
            c2_n2_W_out=> c2_n2_W_out, 
            c2_n3_W_out=> c2_n3_W_out, 
            c2_n4_W_out=> c2_n4_W_out, 
            c2_n5_W_out=> c2_n5_W_out, 
            c2_n6_W_out=> c2_n6_W_out, 
            c2_n7_W_out=> c2_n7_W_out, 
            c2_n8_W_out=> c2_n8_W_out, 
            c2_n9_W_out=> c2_n9_W_out, 
            c2_n10_W_out=> c2_n10_W_out, 
            c2_n11_W_out=> c2_n11_W_out, 
            c2_n12_W_out=> c2_n12_W_out, 
            c2_n13_W_out=> c2_n13_W_out, 
            c2_n14_W_out=> c2_n14_W_out, 
            c2_n15_W_out=> c2_n15_W_out, 
            c2_n16_W_out=> c2_n16_W_out
   );
            
camada3_inst_3: ENTITY work.camada3_ReLU_17neuron_8bits_18n_signed
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
            c3_n2_W_in=> c2_n2_W_out,
            c3_n3_W_in=> c2_n3_W_out,
            c3_n4_W_in=> c2_n4_W_out,
            c3_n5_W_in=> c2_n5_W_out,
            c3_n6_W_in=> c2_n6_W_out,
            c3_n7_W_in=> c2_n7_W_out,
            c3_n8_W_in=> c2_n8_W_out,
            c3_n9_W_in=> c2_n9_W_out,
            c3_n10_W_in=> c2_n10_W_out,
            c3_n11_W_in=> c2_n11_W_out,
            c3_n12_W_in=> c2_n12_W_out,
            c3_n13_W_in=> c2_n13_W_out,
            c3_n14_W_in=> c2_n14_W_out,
            c3_n15_W_in=> c2_n15_W_out,
            c3_n16_W_in=> c2_n16_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c3_n0_IO_out=> c3_n0_IO_out, 
            c3_n1_IO_out=> c3_n1_IO_out, 
            c3_n2_IO_out=> c3_n2_IO_out, 
            c3_n3_IO_out=> c3_n3_IO_out, 
            c3_n4_IO_out=> c3_n4_IO_out, 
            c3_n5_IO_out=> c3_n5_IO_out, 
            c3_n6_IO_out=> c3_n6_IO_out, 
            c3_n7_IO_out=> c3_n7_IO_out, 
            c3_n8_IO_out=> c3_n8_IO_out, 
            c3_n9_IO_out=> c3_n9_IO_out, 
            c3_n10_IO_out=> c3_n10_IO_out, 
            c3_n11_IO_out=> c3_n11_IO_out, 
            c3_n12_IO_out=> c3_n12_IO_out, 
            c3_n13_IO_out=> c3_n13_IO_out, 
            c3_n14_IO_out=> c3_n14_IO_out, 
            c3_n15_IO_out=> c3_n15_IO_out, 
            c3_n16_IO_out=> c3_n16_IO_out, 
            -- ['OUT']['manual'] 
            c3_n0_W_out=> c3_n0_W_out, 
            c3_n1_W_out=> c3_n1_W_out, 
            c3_n2_W_out=> c3_n2_W_out, 
            c3_n3_W_out=> c3_n3_W_out, 
            c3_n4_W_out=> c3_n4_W_out, 
            c3_n5_W_out=> c3_n5_W_out, 
            c3_n6_W_out=> c3_n6_W_out, 
            c3_n7_W_out=> c3_n7_W_out, 
            c3_n8_W_out=> c3_n8_W_out, 
            c3_n9_W_out=> c3_n9_W_out, 
            c3_n10_W_out=> c3_n10_W_out, 
            c3_n11_W_out=> c3_n11_W_out, 
            c3_n12_W_out=> c3_n12_W_out, 
            c3_n13_W_out=> c3_n13_W_out, 
            c3_n14_W_out=> c3_n14_W_out, 
            c3_n15_W_out=> c3_n15_W_out
   );
            
camada4_inst_4: ENTITY work.camada4_ReLU_16neuron_8bits_17n_signed
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
            c4_n3_W_in=> c3_n3_W_out,
            c4_n4_W_in=> c3_n4_W_out,
            c4_n5_W_in=> c3_n5_W_out,
            c4_n6_W_in=> c3_n6_W_out,
            c4_n7_W_in=> c3_n7_W_out,
            c4_n8_W_in=> c3_n8_W_out,
            c4_n9_W_in=> c3_n9_W_out,
            c4_n10_W_in=> c3_n10_W_out,
            c4_n11_W_in=> c3_n11_W_out,
            c4_n12_W_in=> c3_n12_W_out,
            c4_n13_W_in=> c3_n13_W_out,
            c4_n14_W_in=> c3_n14_W_out,
            c4_n15_W_in=> c3_n15_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c4_n0_IO_out=> c4_n0_IO_out, 
            c4_n1_IO_out=> c4_n1_IO_out, 
            c4_n2_IO_out=> c4_n2_IO_out, 
            c4_n3_IO_out=> c4_n3_IO_out, 
            c4_n4_IO_out=> c4_n4_IO_out, 
            c4_n5_IO_out=> c4_n5_IO_out, 
            c4_n6_IO_out=> c4_n6_IO_out, 
            c4_n7_IO_out=> c4_n7_IO_out, 
            c4_n8_IO_out=> c4_n8_IO_out, 
            c4_n9_IO_out=> c4_n9_IO_out, 
            c4_n10_IO_out=> c4_n10_IO_out, 
            c4_n11_IO_out=> c4_n11_IO_out, 
            c4_n12_IO_out=> c4_n12_IO_out, 
            c4_n13_IO_out=> c4_n13_IO_out, 
            c4_n14_IO_out=> c4_n14_IO_out, 
            c4_n15_IO_out=> c4_n15_IO_out, 
            -- ['OUT']['manual'] 
            c4_n0_W_out=> c4_n0_W_out, 
            c4_n1_W_out=> c4_n1_W_out, 
            c4_n2_W_out=> c4_n2_W_out, 
            c4_n3_W_out=> c4_n3_W_out, 
            c4_n4_W_out=> c4_n4_W_out, 
            c4_n5_W_out=> c4_n5_W_out, 
            c4_n6_W_out=> c4_n6_W_out, 
            c4_n7_W_out=> c4_n7_W_out, 
            c4_n8_W_out=> c4_n8_W_out, 
            c4_n9_W_out=> c4_n9_W_out, 
            c4_n10_W_out=> c4_n10_W_out, 
            c4_n11_W_out=> c4_n11_W_out
   );
            
camada5_inst_5: ENTITY work.camada5_ReLU_12neuron_8bits_16n_signed
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
            c5_n4_W_in=> c4_n4_W_out,
            c5_n5_W_in=> c4_n5_W_out,
            c5_n6_W_in=> c4_n6_W_out,
            c5_n7_W_in=> c4_n7_W_out,
            c5_n8_W_in=> c4_n8_W_out,
            c5_n9_W_in=> c4_n9_W_out,
            c5_n10_W_in=> c4_n10_W_out,
            c5_n11_W_in=> c4_n11_W_out,
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
            -- ['OUT']['manual'] 
            c5_n0_W_out=> c5_n0_W_out, 
            c5_n1_W_out=> c5_n1_W_out, 
            c5_n2_W_out=> c5_n2_W_out, 
            c5_n3_W_out=> c5_n3_W_out, 
            c5_n4_W_out=> c5_n4_W_out, 
            c5_n5_W_out=> c5_n5_W_out, 
            c5_n6_W_out=> c5_n6_W_out, 
            c5_n7_W_out=> c5_n7_W_out
   );
            
camada6_inst_6: ENTITY work.camada6_ReLU_8neuron_8bits_12n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c6_IO_in, 
            c6_n0_W_in=> c5_n0_W_out,
            c6_n1_W_in=> c5_n1_W_out,
            c6_n2_W_in=> c5_n2_W_out,
            c6_n3_W_in=> c5_n3_W_out,
            c6_n4_W_in=> c5_n4_W_out,
            c6_n5_W_in=> c5_n5_W_out,
            c6_n6_W_in=> c5_n6_W_out,
            c6_n7_W_in=> c5_n7_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c6_n0_IO_out=> c6_n0_IO_out, 
            c6_n1_IO_out=> c6_n1_IO_out, 
            c6_n2_IO_out=> c6_n2_IO_out, 
            c6_n3_IO_out=> c6_n3_IO_out, 
            c6_n4_IO_out=> c6_n4_IO_out, 
            c6_n5_IO_out=> c6_n5_IO_out, 
            c6_n6_IO_out=> c6_n6_IO_out, 
            c6_n7_IO_out=> c6_n7_IO_out, 
            -- ['OUT']['manual'] 
            c6_n0_W_out=> c6_n0_W_out, 
            c6_n1_W_out=> c6_n1_W_out, 
            c6_n2_W_out=> c6_n2_W_out, 
            c6_n3_W_out=> c6_n3_W_out
   );
            
camada7_inst_7: ENTITY work.camada7_ReLU_4neuron_8bits_8n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c7_IO_in, 
            c7_n0_W_in=> c6_n0_W_out,
            c7_n1_W_in=> c6_n1_W_out,
            c7_n2_W_in=> c6_n2_W_out,
            c7_n3_W_in=> c6_n3_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c7_n0_IO_out=> c7_n0_IO_out, 
            c7_n1_IO_out=> c7_n1_IO_out, 
            c7_n2_IO_out=> c7_n2_IO_out, 
            c7_n3_IO_out=> c7_n3_IO_out, 
            -- ['OUT']['manual'] 
            c7_n0_W_out=> c7_n0_W_out, 
            c7_n1_W_out=> c7_n1_W_out
   );
            
camada8_inst_8: ENTITY work.camada8_Linear_2neuron_8bits_4n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c8_IO_in, 
            c8_n0_W_in=> c7_n0_W_out,
            c8_n1_W_in=> c7_n1_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c8_n0_IO_out=> c8_n0_IO_out, 
            c8_n1_IO_out=> c8_n1_IO_out
   );
            
END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
  ENTITY  top IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 19;
    TOTAL_BITS : NATURAL := 152
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c4_n0_IO_out, c4_n1_IO_out: OUT signed(BITS -1 DOWNTO 0)
  );
  end ENTITY;
ARCHITECTURE arch OF  top  IS
-- SIGNALS
  SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c0_n5_W_out, c0_n6_W_out, c0_n7_W_out, c0_n8_W_out, c0_n9_W_out, c0_n10_W_out, c1_n0_W_out, c1_n1_W_out, c1_n2_W_out, c1_n3_W_out, c1_n4_W_out, c1_n5_W_out, c1_n6_W_out, c2_n0_W_out, c2_n1_W_out, c2_n2_W_out, c3_n0_W_out, c3_n1_W_out: signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_IO_in:  signed((BITS*15) - 1 DOWNTO 0);
  SIGNAL c2_IO_in:  signed((BITS*11) - 1 DOWNTO 0);
  SIGNAL c3_IO_in:  signed((BITS*7) - 1 DOWNTO 0);
  SIGNAL c4_IO_in:  signed((BITS*3) - 1 DOWNTO 0);
  SIGNAL c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out, c0_n6_IO_out, c0_n7_IO_out, c0_n8_IO_out, c0_n9_IO_out, c0_n10_IO_out, c0_n11_IO_out, c0_n12_IO_out, c0_n13_IO_out, c0_n14_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out, c1_n3_IO_out, c1_n4_IO_out, c1_n5_IO_out, c1_n6_IO_out, c1_n7_IO_out, c1_n8_IO_out, c1_n9_IO_out, c1_n10_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c2_n0_IO_out, c2_n1_IO_out, c2_n2_IO_out, c2_n3_IO_out, c2_n4_IO_out, c2_n5_IO_out, c2_n6_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL reg_IO_in: signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL en_registers: STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  c1_IO_in <= c0_n0_IO_out & c0_n1_IO_out & c0_n2_IO_out & c0_n3_IO_out & c0_n4_IO_out & c0_n5_IO_out & c0_n6_IO_out & c0_n7_IO_out & c0_n8_IO_out & c0_n9_IO_out & c0_n10_IO_out & c0_n11_IO_out & c0_n12_IO_out & c0_n13_IO_out & c0_n14_IO_out;
c2_IO_in <= c1_n0_IO_out & c1_n1_IO_out & c1_n2_IO_out & c1_n3_IO_out & c1_n4_IO_out & c1_n5_IO_out & c1_n6_IO_out & c1_n7_IO_out & c1_n8_IO_out & c1_n9_IO_out & c1_n10_IO_out;
c3_IO_in <= c2_n0_IO_out & c2_n1_IO_out & c2_n2_IO_out & c2_n3_IO_out & c2_n4_IO_out & c2_n5_IO_out & c2_n6_IO_out;
c4_IO_in <= c3_n0_IO_out & c3_n1_IO_out & c3_n2_IO_out;
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

camada0_inst_0: ENTITY work.camada0_ReLU_15neuron_8bits_19n_signed
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
            c0_n10_W_out=> c0_n10_W_out
   );
            
camada1_inst_1: ENTITY work.camada1_ReLU_11neuron_8bits_15n_signed
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
            -- ['OUT']['manual'] 
            c1_n0_W_out=> c1_n0_W_out, 
            c1_n1_W_out=> c1_n1_W_out, 
            c1_n2_W_out=> c1_n2_W_out, 
            c1_n3_W_out=> c1_n3_W_out, 
            c1_n4_W_out=> c1_n4_W_out, 
            c1_n5_W_out=> c1_n5_W_out, 
            c1_n6_W_out=> c1_n6_W_out
   );
            
camada2_inst_2: ENTITY work.camada2_ReLU_7neuron_8bits_11n_signed
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
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c2_n0_IO_out=> c2_n0_IO_out, 
            c2_n1_IO_out=> c2_n1_IO_out, 
            c2_n2_IO_out=> c2_n2_IO_out, 
            c2_n3_IO_out=> c2_n3_IO_out, 
            c2_n4_IO_out=> c2_n4_IO_out, 
            c2_n5_IO_out=> c2_n5_IO_out, 
            c2_n6_IO_out=> c2_n6_IO_out, 
            -- ['OUT']['manual'] 
            c2_n0_W_out=> c2_n0_W_out, 
            c2_n1_W_out=> c2_n1_W_out, 
            c2_n2_W_out=> c2_n2_W_out
   );
            
camada3_inst_3: ENTITY work.camada3_ReLU_3neuron_8bits_7n_signed
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
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c3_n0_IO_out=> c3_n0_IO_out, 
            c3_n1_IO_out=> c3_n1_IO_out, 
            c3_n2_IO_out=> c3_n2_IO_out, 
            -- ['OUT']['manual'] 
            c3_n0_W_out=> c3_n0_W_out, 
            c3_n1_W_out=> c3_n1_W_out
   );
            
camada4_inst_4: ENTITY work.camada4_Linear_2neuron_8bits_3n_signed
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
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c4_n0_IO_out=> c4_n0_IO_out, 
            c4_n1_IO_out=> c4_n1_IO_out
   );
            
END ARCHITECTURE;

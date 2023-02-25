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
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c3_n0_IO_out: OUT signed(7 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  top  IS
-- SIGNALS
  SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c1_n0_W_out, c1_n1_W_out, c1_n2_W_out, c2_n0_W_out: signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_IO_in:  signed((BITS*6) - 1 DOWNTO 0);
  SIGNAL c2_IO_in:  signed((BITS*5) - 1 DOWNTO 0);
  SIGNAL c3_IO_in:  signed((BITS*3) - 1 DOWNTO 0);
  SIGNAL c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out, c1_n3_IO_out, c1_n4_IO_out: SIGNED(BITS -1 DOWNTO 0);
  SIGNAL c2_n0_IO_out, c2_n1_IO_out, c2_n2_IO_out: SIGNED(BITS -1 DOWNTO 0);
    SIGNAL reg_IO_in: signed(TOTAL_BITS - 1 DOWNTO 0);
    SIGNAL en_registers: STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  c1_IO_in <= c0_n0_IO_out & c0_n1_IO_out & c0_n2_IO_out & c0_n3_IO_out & c0_n4_IO_out & c0_n5_IO_out;
c2_IO_in <= c1_n0_IO_out & c1_n1_IO_out & c1_n2_IO_out & c1_n3_IO_out & c1_n4_IO_out;
c3_IO_in <= c2_n0_IO_out & c2_n1_IO_out & c2_n2_IO_out;

  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

camada0_inst_0: ENTITY work.camada0_ReLU_6neuron_8bits_10n_signed
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
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c0_n0_IO_out=> c0_n0_IO_out, 
            c0_n1_IO_out=> c0_n1_IO_out, 
            c0_n2_IO_out=> c0_n2_IO_out, 
            c0_n3_IO_out=> c0_n3_IO_out, 
            c0_n4_IO_out=> c0_n4_IO_out, 
            c0_n5_IO_out=> c0_n5_IO_out, 
            -- ['OUT']['manual'] 
            c0_n0_W_out=> c0_n0_W_out, 
            c0_n1_W_out=> c0_n1_W_out, 
            c0_n2_W_out=> c0_n2_W_out, 
            c0_n3_W_out=> c0_n3_W_out, 
            c0_n4_W_out=> c0_n4_W_out
   );
            
camada1_inst_1: ENTITY work.camada1_ReLU_5neuron_8bits_6n_signed
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
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c1_n0_IO_out=> c1_n0_IO_out, 
            c1_n1_IO_out=> c1_n1_IO_out, 
            c1_n2_IO_out=> c1_n2_IO_out, 
            c1_n3_IO_out=> c1_n3_IO_out, 
            c1_n4_IO_out=> c1_n4_IO_out, 
            -- ['OUT']['manual'] 
            c1_n0_W_out=> c1_n0_W_out, 
            c1_n1_W_out=> c1_n1_W_out, 
            c1_n2_W_out=> c1_n2_W_out
   );
            
camada2_inst_2: ENTITY work.camada2_ReLU_3neuron_8bits_5n_signed
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
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c2_n0_IO_out=> c2_n0_IO_out, 
            c2_n1_IO_out=> c2_n1_IO_out, 
            c2_n2_IO_out=> c2_n2_IO_out, 
            -- ['OUT']['manual'] 
            c2_n0_W_out=> c2_n0_W_out
   );
            
camada3_inst_3: ENTITY work.camada3_Sigmoid_1neuron_8bits_3n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> en_registers, 
            -- ['IN']['manual'] 
            IO_in=> c3_IO_in, 
            c3_n0_W_in=> c2_n0_W_out,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c3_n0_IO_out=> c3_n0_IO_out
   );
            
END ARCHITECTURE;

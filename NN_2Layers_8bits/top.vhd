LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  top IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 3;
    TOTAL_BITS : NATURAL := 24
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c1_n0_IO_out, c1_n1_IO_out: OUT signed(7 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  top  IS 
BEGIN
  en_registers <= update_weights AND clk; 
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

camada0_inst_0: ENTITY work.camada0_ReLU_3neuron_8bits_5n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> reg_IO_in, 
            c0_n0_W_in=> c0_n0_W_in, 
            c0_n1_W_in=> c0_n1_W_in, 
            c0_n2_W_in=> c0_n2_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c0_n0_IO_out=> c0_n0_IO_out, 
            c0_n1_IO_out=> c0_n1_IO_out, 
            c0_n2_IO_out=> c0_n2_IO_out, 
            -- ['OUT']['manual'] 
            c0_n0_W_out=> c0_n0_W_out, 
            c0_n1_W_out=> c0_n1_W_out, 
            c0_n2_W_out=> c0_n2_W_out
   );
            
camada1_inst_1: ENTITY work.camada1_Sigmoid_2neuron_8bits_3n_signed
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> c1_IO_in, 
            c1_n0_W_in=> c0_n0_W_out, 
            c1_n1_W_in=> c0_n1_W_out, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            c1_n0_IO_out=> c1_n0_IO_out, 
            c1_n1_IO_out=> c1_n1_IO_out
   );
             
END ARCHITECTURE;
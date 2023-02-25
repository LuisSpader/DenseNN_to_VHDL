LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada3_Sigmoid_1neuron_8bits_3n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 3;
    TOTAL_BITS : NATURAL := 24
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c3_n0_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c3_n0_IO_out: OUT signed(BITS -1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada3_Sigmoid_1neuron_8bits_3n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_Sigmoid_3n_8bit_signed_mult0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c3_n0_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c3_n0_IO_out
   );
             
END ARCHITECTURE;

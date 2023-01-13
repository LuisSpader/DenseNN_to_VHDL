LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada3_Sigmoid_3neuron_8bits_3n_signed_shift IS
  PORT (
      clk, rst: IN STD_LOGIC;
      x1, x2, x3: IN signed(7 DOWNTO 0);

      c3_n0_bias, c3_n1_bias, c3_n2_bias: IN signed(7 DOWNTO 0);
      c3_n0_w1, c3_n0_w2, c3_n0_w3: IN signed(7 DOWNTO 0);
      c3_n1_w1, c3_n1_w2, c3_n1_w3: IN signed(7 DOWNTO 0);
      c3_n2_w1, c3_n2_w2, c3_n2_w3: IN signed(7 DOWNTO 0);

      c3_n0_bias_out, c3_n1_bias_out, c3_n2_bias_out: IN signed(7 DOWNTO 0);
      c3_n0_w1_out, c3_n0_w2_out, c3_n0_w3_out: IN signed(7 DOWNTO 0);
      c3_n1_w1_out, c3_n1_w2_out, c3_n1_w3_out: IN signed(7 DOWNTO 0);
      c3_n2_w1_out, c3_n2_w2_out, c3_n2_w3_out: IN signed(7 DOWNTO 0);
      ----------------------------------------------
      c3_n0_y, c3_n1_y, c3_n2_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada3_Sigmoid_3neuron_8bits_3n_signed_shift  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_Sigmoid_3n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c3_n0_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            w1=> c3_n0_w1, 
            w2=> c3_n0_w2, 
            w3=> c3_n0_w3, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c3_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_Sigmoid_3n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c3_n1_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            w1=> c3_n1_w1, 
            w2=> c3_n1_w2, 
            w3=> c3_n1_w3, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c3_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_Sigmoid_3n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c3_n2_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            w1=> c3_n2_w1, 
            w2=> c3_n2_w2, 
            w3=> c3_n2_w3, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c3_n2_y
   );           
             
END ARCHITECTURE;

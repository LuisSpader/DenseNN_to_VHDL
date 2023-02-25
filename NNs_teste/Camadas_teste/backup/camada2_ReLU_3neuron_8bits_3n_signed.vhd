LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada2_ReLU_3neuron_8bits_3n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c2_n0_bias, c2_n1_bias, c2_n2_bias, x1, x2, x3, c2_n0_w1, c2_n0_w2, c2_n0_w3, c2_n1_w1, c2_n1_w2, c2_n1_w3, c2_n2_w1, c2_n2_w2, c2_n2_w3: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c2_n0_y, c2_n1_y, c2_n2_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada2_ReLU_3neuron_8bits_3n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c2_n0_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            w1=> c2_n0_w1, 
            w2=> c2_n0_w2, 
            w3=> c2_n0_w3, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c2_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c2_n1_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            w1=> c2_n1_w1, 
            w2=> c2_n1_w2, 
            w3=> c2_n1_w3, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c2_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c2_n2_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            w1=> c2_n2_w1, 
            w2=> c2_n2_w2, 
            w3=> c2_n2_w3, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c2_n2_y
   );           
             
END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada1_ReLU_5neuron_8bits_8n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c1_n0_bias, c1_n1_bias, c1_n2_bias, c1_n3_bias, c1_n4_bias, x1, x2, x3, x4, x5, x6, x7, x8, c1_n0_w1, c1_n0_w2, c1_n0_w3, c1_n0_w4, c1_n0_w5, c1_n0_w6, c1_n0_w7, c1_n0_w8, c1_n1_w1, c1_n1_w2, c1_n1_w3, c1_n1_w4, c1_n1_w5, c1_n1_w6, c1_n1_w7, c1_n1_w8, c1_n2_w1, c1_n2_w2, c1_n2_w3, c1_n2_w4, c1_n2_w5, c1_n2_w6, c1_n2_w7, c1_n2_w8, c1_n3_w1, c1_n3_w2, c1_n3_w3, c1_n3_w4, c1_n3_w5, c1_n3_w6, c1_n3_w7, c1_n3_w8, c1_n4_w1, c1_n4_w2, c1_n4_w3, c1_n4_w4, c1_n4_w5, c1_n4_w6, c1_n4_w7, c1_n4_w8: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c1_n0_y, c1_n1_y, c1_n2_y, c1_n3_y, c1_n4_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada1_ReLU_5neuron_8bits_8n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_8n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n0_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            w1=> c1_n0_w1, 
            w2=> c1_n0_w2, 
            w3=> c1_n0_w3, 
            w4=> c1_n0_w4, 
            w5=> c1_n0_w5, 
            w6=> c1_n0_w6, 
            w7=> c1_n0_w7, 
            w8=> c1_n0_w8, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_8n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n1_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            w1=> c1_n1_w1, 
            w2=> c1_n1_w2, 
            w3=> c1_n1_w3, 
            w4=> c1_n1_w4, 
            w5=> c1_n1_w5, 
            w6=> c1_n1_w6, 
            w7=> c1_n1_w7, 
            w8=> c1_n1_w8, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_8n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n2_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            w1=> c1_n2_w1, 
            w2=> c1_n2_w2, 
            w3=> c1_n2_w3, 
            w4=> c1_n2_w4, 
            w5=> c1_n2_w5, 
            w6=> c1_n2_w6, 
            w7=> c1_n2_w7, 
            w8=> c1_n2_w8, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n2_y
   );           
            
neuron_inst_3: ENTITY work.neuron_comb_ReLU_8n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n3_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            w1=> c1_n3_w1, 
            w2=> c1_n3_w2, 
            w3=> c1_n3_w3, 
            w4=> c1_n3_w4, 
            w5=> c1_n3_w5, 
            w6=> c1_n3_w6, 
            w7=> c1_n3_w7, 
            w8=> c1_n3_w8, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n3_y
   );           
            
neuron_inst_4: ENTITY work.neuron_comb_ReLU_8n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n4_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            w1=> c1_n4_w1, 
            w2=> c1_n4_w2, 
            w3=> c1_n4_w3, 
            w4=> c1_n4_w4, 
            w5=> c1_n4_w5, 
            w6=> c1_n4_w6, 
            w7=> c1_n4_w7, 
            w8=> c1_n4_w8, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n4_y
   );           
             
END ARCHITECTURE;

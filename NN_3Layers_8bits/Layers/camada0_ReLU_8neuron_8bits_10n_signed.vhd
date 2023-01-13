LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada0_ReLU_8neuron_8bits_10n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c0_n0_bias, c0_n1_bias, c0_n2_bias, c0_n3_bias, c0_n4_bias, c0_n5_bias, c0_n6_bias, c0_n7_bias, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, c0_n0_w1, c0_n0_w2, c0_n0_w3, c0_n0_w4, c0_n0_w5, c0_n0_w6, c0_n0_w7, c0_n0_w8, c0_n0_w9, c0_n0_w10, c0_n1_w1, c0_n1_w2, c0_n1_w3, c0_n1_w4, c0_n1_w5, c0_n1_w6, c0_n1_w7, c0_n1_w8, c0_n1_w9, c0_n1_w10, c0_n2_w1, c0_n2_w2, c0_n2_w3, c0_n2_w4, c0_n2_w5, c0_n2_w6, c0_n2_w7, c0_n2_w8, c0_n2_w9, c0_n2_w10, c0_n3_w1, c0_n3_w2, c0_n3_w3, c0_n3_w4, c0_n3_w5, c0_n3_w6, c0_n3_w7, c0_n3_w8, c0_n3_w9, c0_n3_w10, c0_n4_w1, c0_n4_w2, c0_n4_w3, c0_n4_w4, c0_n4_w5, c0_n4_w6, c0_n4_w7, c0_n4_w8, c0_n4_w9, c0_n4_w10, c0_n5_w1, c0_n5_w2, c0_n5_w3, c0_n5_w4, c0_n5_w5, c0_n5_w6, c0_n5_w7, c0_n5_w8, c0_n5_w9, c0_n5_w10, c0_n6_w1, c0_n6_w2, c0_n6_w3, c0_n6_w4, c0_n6_w5, c0_n6_w6, c0_n6_w7, c0_n6_w8, c0_n6_w9, c0_n6_w10, c0_n7_w1, c0_n7_w2, c0_n7_w3, c0_n7_w4, c0_n7_w5, c0_n7_w6, c0_n7_w7, c0_n7_w8, c0_n7_w9, c0_n7_w10: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c0_n0_y, c0_n1_y, c0_n2_y, c0_n3_y, c0_n4_y, c0_n5_y, c0_n6_y, c0_n7_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada0_ReLU_8neuron_8bits_10n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n0_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n0_w1, 
            w2=> c0_n0_w2, 
            w3=> c0_n0_w3, 
            w4=> c0_n0_w4, 
            w5=> c0_n0_w5, 
            w6=> c0_n0_w6, 
            w7=> c0_n0_w7, 
            w8=> c0_n0_w8, 
            w9=> c0_n0_w9, 
            w10=> c0_n0_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n1_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n1_w1, 
            w2=> c0_n1_w2, 
            w3=> c0_n1_w3, 
            w4=> c0_n1_w4, 
            w5=> c0_n1_w5, 
            w6=> c0_n1_w6, 
            w7=> c0_n1_w7, 
            w8=> c0_n1_w8, 
            w9=> c0_n1_w9, 
            w10=> c0_n1_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n2_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n2_w1, 
            w2=> c0_n2_w2, 
            w3=> c0_n2_w3, 
            w4=> c0_n2_w4, 
            w5=> c0_n2_w5, 
            w6=> c0_n2_w6, 
            w7=> c0_n2_w7, 
            w8=> c0_n2_w8, 
            w9=> c0_n2_w9, 
            w10=> c0_n2_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n2_y
   );           
            
neuron_inst_3: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n3_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n3_w1, 
            w2=> c0_n3_w2, 
            w3=> c0_n3_w3, 
            w4=> c0_n3_w4, 
            w5=> c0_n3_w5, 
            w6=> c0_n3_w6, 
            w7=> c0_n3_w7, 
            w8=> c0_n3_w8, 
            w9=> c0_n3_w9, 
            w10=> c0_n3_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n3_y
   );           
            
neuron_inst_4: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n4_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n4_w1, 
            w2=> c0_n4_w2, 
            w3=> c0_n4_w3, 
            w4=> c0_n4_w4, 
            w5=> c0_n4_w5, 
            w6=> c0_n4_w6, 
            w7=> c0_n4_w7, 
            w8=> c0_n4_w8, 
            w9=> c0_n4_w9, 
            w10=> c0_n4_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n4_y
   );           
            
neuron_inst_5: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n5_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n5_w1, 
            w2=> c0_n5_w2, 
            w3=> c0_n5_w3, 
            w4=> c0_n5_w4, 
            w5=> c0_n5_w5, 
            w6=> c0_n5_w6, 
            w7=> c0_n5_w7, 
            w8=> c0_n5_w8, 
            w9=> c0_n5_w9, 
            w10=> c0_n5_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n5_y
   );           
            
neuron_inst_6: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n6_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n6_w1, 
            w2=> c0_n6_w2, 
            w3=> c0_n6_w3, 
            w4=> c0_n6_w4, 
            w5=> c0_n6_w5, 
            w6=> c0_n6_w6, 
            w7=> c0_n6_w7, 
            w8=> c0_n6_w8, 
            w9=> c0_n6_w9, 
            w10=> c0_n6_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n6_y
   );           
            
neuron_inst_7: ENTITY work.neuron_comb_ReLU_10n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n7_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            w1=> c0_n7_w1, 
            w2=> c0_n7_w2, 
            w3=> c0_n7_w3, 
            w4=> c0_n7_w4, 
            w5=> c0_n7_w5, 
            w6=> c0_n7_w6, 
            w7=> c0_n7_w7, 
            w8=> c0_n7_w8, 
            w9=> c0_n7_w9, 
            w10=> c0_n7_w10, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n7_y
   );           
             
END ARCHITECTURE;

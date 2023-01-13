LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada1_Leaky_ReLU_12neuron_8bits_6n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c1_n0_bias, c1_n1_bias, c1_n2_bias, c1_n3_bias, c1_n4_bias, c1_n5_bias, c1_n6_bias, c1_n7_bias, c1_n8_bias, c1_n9_bias, c1_n10_bias, c1_n11_bias, x1, x2, x3, x4, x5, x6, c1_n0_w1, c1_n0_w2, c1_n0_w3, c1_n0_w4, c1_n0_w5, c1_n0_w6, c1_n1_w1, c1_n1_w2, c1_n1_w3, c1_n1_w4, c1_n1_w5, c1_n1_w6, c1_n2_w1, c1_n2_w2, c1_n2_w3, c1_n2_w4, c1_n2_w5, c1_n2_w6, c1_n3_w1, c1_n3_w2, c1_n3_w3, c1_n3_w4, c1_n3_w5, c1_n3_w6, c1_n4_w1, c1_n4_w2, c1_n4_w3, c1_n4_w4, c1_n4_w5, c1_n4_w6, c1_n5_w1, c1_n5_w2, c1_n5_w3, c1_n5_w4, c1_n5_w5, c1_n5_w6, c1_n6_w1, c1_n6_w2, c1_n6_w3, c1_n6_w4, c1_n6_w5, c1_n6_w6, c1_n7_w1, c1_n7_w2, c1_n7_w3, c1_n7_w4, c1_n7_w5, c1_n7_w6, c1_n8_w1, c1_n8_w2, c1_n8_w3, c1_n8_w4, c1_n8_w5, c1_n8_w6, c1_n9_w1, c1_n9_w2, c1_n9_w3, c1_n9_w4, c1_n9_w5, c1_n9_w6, c1_n10_w1, c1_n10_w2, c1_n10_w3, c1_n10_w4, c1_n10_w5, c1_n10_w6, c1_n11_w1, c1_n11_w2, c1_n11_w3, c1_n11_w4, c1_n11_w5, c1_n11_w6: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c1_n0_y, c1_n1_y, c1_n2_y, c1_n3_y, c1_n4_y, c1_n5_y, c1_n6_y, c1_n7_y, c1_n8_y, c1_n9_y, c1_n10_y, c1_n11_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada1_Leaky_ReLU_12neuron_8bits_6n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
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
            w1=> c1_n0_w1, 
            w2=> c1_n0_w2, 
            w3=> c1_n0_w3, 
            w4=> c1_n0_w4, 
            w5=> c1_n0_w5, 
            w6=> c1_n0_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
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
            w1=> c1_n1_w1, 
            w2=> c1_n1_w2, 
            w3=> c1_n1_w3, 
            w4=> c1_n1_w4, 
            w5=> c1_n1_w5, 
            w6=> c1_n1_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
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
            w1=> c1_n2_w1, 
            w2=> c1_n2_w2, 
            w3=> c1_n2_w3, 
            w4=> c1_n2_w4, 
            w5=> c1_n2_w5, 
            w6=> c1_n2_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n2_y
   );           
            
neuron_inst_3: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
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
            w1=> c1_n3_w1, 
            w2=> c1_n3_w2, 
            w3=> c1_n3_w3, 
            w4=> c1_n3_w4, 
            w5=> c1_n3_w5, 
            w6=> c1_n3_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n3_y
   );           
            
neuron_inst_4: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
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
            w1=> c1_n4_w1, 
            w2=> c1_n4_w2, 
            w3=> c1_n4_w3, 
            w4=> c1_n4_w4, 
            w5=> c1_n4_w5, 
            w6=> c1_n4_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n4_y
   );           
            
neuron_inst_5: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n5_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n5_w1, 
            w2=> c1_n5_w2, 
            w3=> c1_n5_w3, 
            w4=> c1_n5_w4, 
            w5=> c1_n5_w5, 
            w6=> c1_n5_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n5_y
   );           
            
neuron_inst_6: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n6_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n6_w1, 
            w2=> c1_n6_w2, 
            w3=> c1_n6_w3, 
            w4=> c1_n6_w4, 
            w5=> c1_n6_w5, 
            w6=> c1_n6_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n6_y
   );           
            
neuron_inst_7: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n7_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n7_w1, 
            w2=> c1_n7_w2, 
            w3=> c1_n7_w3, 
            w4=> c1_n7_w4, 
            w5=> c1_n7_w5, 
            w6=> c1_n7_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n7_y
   );           
            
neuron_inst_8: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n8_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n8_w1, 
            w2=> c1_n8_w2, 
            w3=> c1_n8_w3, 
            w4=> c1_n8_w4, 
            w5=> c1_n8_w5, 
            w6=> c1_n8_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n8_y
   );           
            
neuron_inst_9: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n9_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n9_w1, 
            w2=> c1_n9_w2, 
            w3=> c1_n9_w3, 
            w4=> c1_n9_w4, 
            w5=> c1_n9_w5, 
            w6=> c1_n9_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n9_y
   );           
            
neuron_inst_10: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n10_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n10_w1, 
            w2=> c1_n10_w2, 
            w3=> c1_n10_w3, 
            w4=> c1_n10_w4, 
            w5=> c1_n10_w5, 
            w6=> c1_n10_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n10_y
   );           
            
neuron_inst_11: ENTITY work.neuron_comb_Leaky_ReLU_6n_8bit_unsigned_mul0_add0_v0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c1_n11_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            x2=> x2, 
            x3=> x3, 
            x4=> x4, 
            x5=> x5, 
            x6=> x6, 
            w1=> c1_n11_w1, 
            w2=> c1_n11_w2, 
            w3=> c1_n11_w3, 
            w4=> c1_n11_w4, 
            w5=> c1_n11_w5, 
            w6=> c1_n11_w6, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n11_y
   );           
             
END ARCHITECTURE;

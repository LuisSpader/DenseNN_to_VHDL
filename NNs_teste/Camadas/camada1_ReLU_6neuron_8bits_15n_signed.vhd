LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada1_ReLU_6neuron_8bits_15n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c1_n0_bias, c1_n1_bias, c1_n2_bias, c1_n3_bias, c1_n4_bias, c1_n5_bias, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, c1_n0_w1, c1_n0_w2, c1_n0_w3, c1_n0_w4, c1_n0_w5, c1_n0_w6, c1_n0_w7, c1_n0_w8, c1_n0_w9, c1_n0_w10, c1_n0_w11, c1_n0_w12, c1_n0_w13, c1_n0_w14, c1_n0_w15, c1_n1_w1, c1_n1_w2, c1_n1_w3, c1_n1_w4, c1_n1_w5, c1_n1_w6, c1_n1_w7, c1_n1_w8, c1_n1_w9, c1_n1_w10, c1_n1_w11, c1_n1_w12, c1_n1_w13, c1_n1_w14, c1_n1_w15, c1_n2_w1, c1_n2_w2, c1_n2_w3, c1_n2_w4, c1_n2_w5, c1_n2_w6, c1_n2_w7, c1_n2_w8, c1_n2_w9, c1_n2_w10, c1_n2_w11, c1_n2_w12, c1_n2_w13, c1_n2_w14, c1_n2_w15, c1_n3_w1, c1_n3_w2, c1_n3_w3, c1_n3_w4, c1_n3_w5, c1_n3_w6, c1_n3_w7, c1_n3_w8, c1_n3_w9, c1_n3_w10, c1_n3_w11, c1_n3_w12, c1_n3_w13, c1_n3_w14, c1_n3_w15, c1_n4_w1, c1_n4_w2, c1_n4_w3, c1_n4_w4, c1_n4_w5, c1_n4_w6, c1_n4_w7, c1_n4_w8, c1_n4_w9, c1_n4_w10, c1_n4_w11, c1_n4_w12, c1_n4_w13, c1_n4_w14, c1_n4_w15, c1_n5_w1, c1_n5_w2, c1_n5_w3, c1_n5_w4, c1_n5_w5, c1_n5_w6, c1_n5_w7, c1_n5_w8, c1_n5_w9, c1_n5_w10, c1_n5_w11, c1_n5_w12, c1_n5_w13, c1_n5_w14, c1_n5_w15: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c1_n0_y, c1_n1_y, c1_n2_y, c1_n3_y, c1_n4_y, c1_n5_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada1_ReLU_6neuron_8bits_15n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_15n_8bit_unsigned_mul0_v0_add0_v0
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
            x9=> x9, 
            x10=> x10, 
            x11=> x11, 
            x12=> x12, 
            x13=> x13, 
            x14=> x14, 
            x15=> x15, 
            w1=> c1_n0_w1, 
            w2=> c1_n0_w2, 
            w3=> c1_n0_w3, 
            w4=> c1_n0_w4, 
            w5=> c1_n0_w5, 
            w6=> c1_n0_w6, 
            w7=> c1_n0_w7, 
            w8=> c1_n0_w8, 
            w9=> c1_n0_w9, 
            w10=> c1_n0_w10, 
            w11=> c1_n0_w11, 
            w12=> c1_n0_w12, 
            w13=> c1_n0_w13, 
            w14=> c1_n0_w14, 
            w15=> c1_n0_w15, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_15n_8bit_unsigned_mul0_v0_add0_v0
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
            x9=> x9, 
            x10=> x10, 
            x11=> x11, 
            x12=> x12, 
            x13=> x13, 
            x14=> x14, 
            x15=> x15, 
            w1=> c1_n1_w1, 
            w2=> c1_n1_w2, 
            w3=> c1_n1_w3, 
            w4=> c1_n1_w4, 
            w5=> c1_n1_w5, 
            w6=> c1_n1_w6, 
            w7=> c1_n1_w7, 
            w8=> c1_n1_w8, 
            w9=> c1_n1_w9, 
            w10=> c1_n1_w10, 
            w11=> c1_n1_w11, 
            w12=> c1_n1_w12, 
            w13=> c1_n1_w13, 
            w14=> c1_n1_w14, 
            w15=> c1_n1_w15, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_15n_8bit_unsigned_mul0_v0_add0_v0
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
            x9=> x9, 
            x10=> x10, 
            x11=> x11, 
            x12=> x12, 
            x13=> x13, 
            x14=> x14, 
            x15=> x15, 
            w1=> c1_n2_w1, 
            w2=> c1_n2_w2, 
            w3=> c1_n2_w3, 
            w4=> c1_n2_w4, 
            w5=> c1_n2_w5, 
            w6=> c1_n2_w6, 
            w7=> c1_n2_w7, 
            w8=> c1_n2_w8, 
            w9=> c1_n2_w9, 
            w10=> c1_n2_w10, 
            w11=> c1_n2_w11, 
            w12=> c1_n2_w12, 
            w13=> c1_n2_w13, 
            w14=> c1_n2_w14, 
            w15=> c1_n2_w15, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n2_y
   );           
            
neuron_inst_3: ENTITY work.neuron_comb_ReLU_15n_8bit_unsigned_mul0_v0_add0_v0
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
            x9=> x9, 
            x10=> x10, 
            x11=> x11, 
            x12=> x12, 
            x13=> x13, 
            x14=> x14, 
            x15=> x15, 
            w1=> c1_n3_w1, 
            w2=> c1_n3_w2, 
            w3=> c1_n3_w3, 
            w4=> c1_n3_w4, 
            w5=> c1_n3_w5, 
            w6=> c1_n3_w6, 
            w7=> c1_n3_w7, 
            w8=> c1_n3_w8, 
            w9=> c1_n3_w9, 
            w10=> c1_n3_w10, 
            w11=> c1_n3_w11, 
            w12=> c1_n3_w12, 
            w13=> c1_n3_w13, 
            w14=> c1_n3_w14, 
            w15=> c1_n3_w15, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n3_y
   );           
            
neuron_inst_4: ENTITY work.neuron_comb_ReLU_15n_8bit_unsigned_mul0_v0_add0_v0
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
            x9=> x9, 
            x10=> x10, 
            x11=> x11, 
            x12=> x12, 
            x13=> x13, 
            x14=> x14, 
            x15=> x15, 
            w1=> c1_n4_w1, 
            w2=> c1_n4_w2, 
            w3=> c1_n4_w3, 
            w4=> c1_n4_w4, 
            w5=> c1_n4_w5, 
            w6=> c1_n4_w6, 
            w7=> c1_n4_w7, 
            w8=> c1_n4_w8, 
            w9=> c1_n4_w9, 
            w10=> c1_n4_w10, 
            w11=> c1_n4_w11, 
            w12=> c1_n4_w12, 
            w13=> c1_n4_w13, 
            w14=> c1_n4_w14, 
            w15=> c1_n4_w15, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n4_y
   );           
            
neuron_inst_5: ENTITY work.neuron_comb_ReLU_15n_8bit_unsigned_mul0_v0_add0_v0
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
            x7=> x7, 
            x8=> x8, 
            x9=> x9, 
            x10=> x10, 
            x11=> x11, 
            x12=> x12, 
            x13=> x13, 
            x14=> x14, 
            x15=> x15, 
            w1=> c1_n5_w1, 
            w2=> c1_n5_w2, 
            w3=> c1_n5_w3, 
            w4=> c1_n5_w4, 
            w5=> c1_n5_w5, 
            w6=> c1_n5_w6, 
            w7=> c1_n5_w7, 
            w8=> c1_n5_w8, 
            w9=> c1_n5_w9, 
            w10=> c1_n5_w10, 
            w11=> c1_n5_w11, 
            w12=> c1_n5_w12, 
            w13=> c1_n5_w13, 
            w14=> c1_n5_w14, 
            w15=> c1_n5_w15, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n5_y
   );           
             
END ARCHITECTURE;

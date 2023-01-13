LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada2_Sigmoid_3neuron_8bits_30n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c2_n0_bias, c2_n1_bias, c2_n2_bias, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, c2_n0_w1, c2_n0_w2, c2_n0_w3, c2_n0_w4, c2_n0_w5, c2_n0_w6, c2_n0_w7, c2_n0_w8, c2_n0_w9, c2_n0_w10, c2_n0_w11, c2_n0_w12, c2_n0_w13, c2_n0_w14, c2_n0_w15, c2_n0_w16, c2_n0_w17, c2_n0_w18, c2_n0_w19, c2_n0_w20, c2_n0_w21, c2_n0_w22, c2_n0_w23, c2_n0_w24, c2_n0_w25, c2_n0_w26, c2_n0_w27, c2_n0_w28, c2_n0_w29, c2_n0_w30, c2_n1_w1, c2_n1_w2, c2_n1_w3, c2_n1_w4, c2_n1_w5, c2_n1_w6, c2_n1_w7, c2_n1_w8, c2_n1_w9, c2_n1_w10, c2_n1_w11, c2_n1_w12, c2_n1_w13, c2_n1_w14, c2_n1_w15, c2_n1_w16, c2_n1_w17, c2_n1_w18, c2_n1_w19, c2_n1_w20, c2_n1_w21, c2_n1_w22, c2_n1_w23, c2_n1_w24, c2_n1_w25, c2_n1_w26, c2_n1_w27, c2_n1_w28, c2_n1_w29, c2_n1_w30, c2_n2_w1, c2_n2_w2, c2_n2_w3, c2_n2_w4, c2_n2_w5, c2_n2_w6, c2_n2_w7, c2_n2_w8, c2_n2_w9, c2_n2_w10, c2_n2_w11, c2_n2_w12, c2_n2_w13, c2_n2_w14, c2_n2_w15, c2_n2_w16, c2_n2_w17, c2_n2_w18, c2_n2_w19, c2_n2_w20, c2_n2_w21, c2_n2_w22, c2_n2_w23, c2_n2_w24, c2_n2_w25, c2_n2_w26, c2_n2_w27, c2_n2_w28, c2_n2_w29, c2_n2_w30: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c2_n0_y, c2_n1_y, c2_n2_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada2_Sigmoid_3neuron_8bits_30n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_Barriers_Sigmoid_30n_8bit_unsigned_mul0_add0_v0_v0
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
            x16=> x16, 
            x17=> x17, 
            x18=> x18, 
            x19=> x19, 
            x20=> x20, 
            x21=> x21, 
            x22=> x22, 
            x23=> x23, 
            x24=> x24, 
            x25=> x25, 
            x26=> x26, 
            x27=> x27, 
            x28=> x28, 
            x29=> x29, 
            x30=> x30, 
            w1=> c2_n0_w1, 
            w2=> c2_n0_w2, 
            w3=> c2_n0_w3, 
            w4=> c2_n0_w4, 
            w5=> c2_n0_w5, 
            w6=> c2_n0_w6, 
            w7=> c2_n0_w7, 
            w8=> c2_n0_w8, 
            w9=> c2_n0_w9, 
            w10=> c2_n0_w10, 
            w11=> c2_n0_w11, 
            w12=> c2_n0_w12, 
            w13=> c2_n0_w13, 
            w14=> c2_n0_w14, 
            w15=> c2_n0_w15, 
            w16=> c2_n0_w16, 
            w17=> c2_n0_w17, 
            w18=> c2_n0_w18, 
            w19=> c2_n0_w19, 
            w20=> c2_n0_w20, 
            w21=> c2_n0_w21, 
            w22=> c2_n0_w22, 
            w23=> c2_n0_w23, 
            w24=> c2_n0_w24, 
            w25=> c2_n0_w25, 
            w26=> c2_n0_w26, 
            w27=> c2_n0_w27, 
            w28=> c2_n0_w28, 
            w29=> c2_n0_w29, 
            w30=> c2_n0_w30, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c2_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_Barriers_Sigmoid_30n_8bit_unsigned_mul0_add0_v0_v0
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
            x16=> x16, 
            x17=> x17, 
            x18=> x18, 
            x19=> x19, 
            x20=> x20, 
            x21=> x21, 
            x22=> x22, 
            x23=> x23, 
            x24=> x24, 
            x25=> x25, 
            x26=> x26, 
            x27=> x27, 
            x28=> x28, 
            x29=> x29, 
            x30=> x30, 
            w1=> c2_n1_w1, 
            w2=> c2_n1_w2, 
            w3=> c2_n1_w3, 
            w4=> c2_n1_w4, 
            w5=> c2_n1_w5, 
            w6=> c2_n1_w6, 
            w7=> c2_n1_w7, 
            w8=> c2_n1_w8, 
            w9=> c2_n1_w9, 
            w10=> c2_n1_w10, 
            w11=> c2_n1_w11, 
            w12=> c2_n1_w12, 
            w13=> c2_n1_w13, 
            w14=> c2_n1_w14, 
            w15=> c2_n1_w15, 
            w16=> c2_n1_w16, 
            w17=> c2_n1_w17, 
            w18=> c2_n1_w18, 
            w19=> c2_n1_w19, 
            w20=> c2_n1_w20, 
            w21=> c2_n1_w21, 
            w22=> c2_n1_w22, 
            w23=> c2_n1_w23, 
            w24=> c2_n1_w24, 
            w25=> c2_n1_w25, 
            w26=> c2_n1_w26, 
            w27=> c2_n1_w27, 
            w28=> c2_n1_w28, 
            w29=> c2_n1_w29, 
            w30=> c2_n1_w30, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c2_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_Barriers_Sigmoid_30n_8bit_unsigned_mul0_add0_v0_v0
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
            x16=> x16, 
            x17=> x17, 
            x18=> x18, 
            x19=> x19, 
            x20=> x20, 
            x21=> x21, 
            x22=> x22, 
            x23=> x23, 
            x24=> x24, 
            x25=> x25, 
            x26=> x26, 
            x27=> x27, 
            x28=> x28, 
            x29=> x29, 
            x30=> x30, 
            w1=> c2_n2_w1, 
            w2=> c2_n2_w2, 
            w3=> c2_n2_w3, 
            w4=> c2_n2_w4, 
            w5=> c2_n2_w5, 
            w6=> c2_n2_w6, 
            w7=> c2_n2_w7, 
            w8=> c2_n2_w8, 
            w9=> c2_n2_w9, 
            w10=> c2_n2_w10, 
            w11=> c2_n2_w11, 
            w12=> c2_n2_w12, 
            w13=> c2_n2_w13, 
            w14=> c2_n2_w14, 
            w15=> c2_n2_w15, 
            w16=> c2_n2_w16, 
            w17=> c2_n2_w17, 
            w18=> c2_n2_w18, 
            w19=> c2_n2_w19, 
            w20=> c2_n2_w20, 
            w21=> c2_n2_w21, 
            w22=> c2_n2_w22, 
            w23=> c2_n2_w23, 
            w24=> c2_n2_w24, 
            w25=> c2_n2_w25, 
            w26=> c2_n2_w26, 
            w27=> c2_n2_w27, 
            w28=> c2_n2_w28, 
            w29=> c2_n2_w29, 
            w30=> c2_n2_w30, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c2_n2_y
   );           
             
END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada0_ReLU_3neuron_8bits_57n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c0_n0_bias, c0_n1_bias, c0_n2_bias, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32, x33, x34, x35, x36, x37, x38, x39, x40, x41, x42, x43, x44, x45, x46, x47, x48, x49, x50, x51, x52, x53, x54, x55, x56, x57, c0_n0_w1, c0_n0_w2, c0_n0_w3, c0_n0_w4, c0_n0_w5, c0_n0_w6, c0_n0_w7, c0_n0_w8, c0_n0_w9, c0_n0_w10, c0_n0_w11, c0_n0_w12, c0_n0_w13, c0_n0_w14, c0_n0_w15, c0_n0_w16, c0_n0_w17, c0_n0_w18, c0_n0_w19, c0_n0_w20, c0_n0_w21, c0_n0_w22, c0_n0_w23, c0_n0_w24, c0_n0_w25, c0_n0_w26, c0_n0_w27, c0_n0_w28, c0_n0_w29, c0_n0_w30, c0_n0_w31, c0_n0_w32, c0_n0_w33, c0_n0_w34, c0_n0_w35, c0_n0_w36, c0_n0_w37, c0_n0_w38, c0_n0_w39, c0_n0_w40, c0_n0_w41, c0_n0_w42, c0_n0_w43, c0_n0_w44, c0_n0_w45, c0_n0_w46, c0_n0_w47, c0_n0_w48, c0_n0_w49, c0_n0_w50, c0_n0_w51, c0_n0_w52, c0_n0_w53, c0_n0_w54, c0_n0_w55, c0_n0_w56, c0_n0_w57, c0_n1_w1, c0_n1_w2, c0_n1_w3, c0_n1_w4, c0_n1_w5, c0_n1_w6, c0_n1_w7, c0_n1_w8, c0_n1_w9, c0_n1_w10, c0_n1_w11, c0_n1_w12, c0_n1_w13, c0_n1_w14, c0_n1_w15, c0_n1_w16, c0_n1_w17, c0_n1_w18, c0_n1_w19, c0_n1_w20, c0_n1_w21, c0_n1_w22, c0_n1_w23, c0_n1_w24, c0_n1_w25, c0_n1_w26, c0_n1_w27, c0_n1_w28, c0_n1_w29, c0_n1_w30, c0_n1_w31, c0_n1_w32, c0_n1_w33, c0_n1_w34, c0_n1_w35, c0_n1_w36, c0_n1_w37, c0_n1_w38, c0_n1_w39, c0_n1_w40, c0_n1_w41, c0_n1_w42, c0_n1_w43, c0_n1_w44, c0_n1_w45, c0_n1_w46, c0_n1_w47, c0_n1_w48, c0_n1_w49, c0_n1_w50, c0_n1_w51, c0_n1_w52, c0_n1_w53, c0_n1_w54, c0_n1_w55, c0_n1_w56, c0_n1_w57, c0_n2_w1, c0_n2_w2, c0_n2_w3, c0_n2_w4, c0_n2_w5, c0_n2_w6, c0_n2_w7, c0_n2_w8, c0_n2_w9, c0_n2_w10, c0_n2_w11, c0_n2_w12, c0_n2_w13, c0_n2_w14, c0_n2_w15, c0_n2_w16, c0_n2_w17, c0_n2_w18, c0_n2_w19, c0_n2_w20, c0_n2_w21, c0_n2_w22, c0_n2_w23, c0_n2_w24, c0_n2_w25, c0_n2_w26, c0_n2_w27, c0_n2_w28, c0_n2_w29, c0_n2_w30, c0_n2_w31, c0_n2_w32, c0_n2_w33, c0_n2_w34, c0_n2_w35, c0_n2_w36, c0_n2_w37, c0_n2_w38, c0_n2_w39, c0_n2_w40, c0_n2_w41, c0_n2_w42, c0_n2_w43, c0_n2_w44, c0_n2_w45, c0_n2_w46, c0_n2_w47, c0_n2_w48, c0_n2_w49, c0_n2_w50, c0_n2_w51, c0_n2_w52, c0_n2_w53, c0_n2_w54, c0_n2_w55, c0_n2_w56, c0_n2_w57: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c0_n0_y, c0_n1_y, c0_n2_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada0_ReLU_3neuron_8bits_57n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_57n_8bit_signed_mul0_v0_add0_v0
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
            x31=> x31, 
            x32=> x32, 
            x33=> x33, 
            x34=> x34, 
            x35=> x35, 
            x36=> x36, 
            x37=> x37, 
            x38=> x38, 
            x39=> x39, 
            x40=> x40, 
            x41=> x41, 
            x42=> x42, 
            x43=> x43, 
            x44=> x44, 
            x45=> x45, 
            x46=> x46, 
            x47=> x47, 
            x48=> x48, 
            x49=> x49, 
            x50=> x50, 
            x51=> x51, 
            x52=> x52, 
            x53=> x53, 
            x54=> x54, 
            x55=> x55, 
            x56=> x56, 
            x57=> x57, 
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
            w11=> c0_n0_w11, 
            w12=> c0_n0_w12, 
            w13=> c0_n0_w13, 
            w14=> c0_n0_w14, 
            w15=> c0_n0_w15, 
            w16=> c0_n0_w16, 
            w17=> c0_n0_w17, 
            w18=> c0_n0_w18, 
            w19=> c0_n0_w19, 
            w20=> c0_n0_w20, 
            w21=> c0_n0_w21, 
            w22=> c0_n0_w22, 
            w23=> c0_n0_w23, 
            w24=> c0_n0_w24, 
            w25=> c0_n0_w25, 
            w26=> c0_n0_w26, 
            w27=> c0_n0_w27, 
            w28=> c0_n0_w28, 
            w29=> c0_n0_w29, 
            w30=> c0_n0_w30, 
            w31=> c0_n0_w31, 
            w32=> c0_n0_w32, 
            w33=> c0_n0_w33, 
            w34=> c0_n0_w34, 
            w35=> c0_n0_w35, 
            w36=> c0_n0_w36, 
            w37=> c0_n0_w37, 
            w38=> c0_n0_w38, 
            w39=> c0_n0_w39, 
            w40=> c0_n0_w40, 
            w41=> c0_n0_w41, 
            w42=> c0_n0_w42, 
            w43=> c0_n0_w43, 
            w44=> c0_n0_w44, 
            w45=> c0_n0_w45, 
            w46=> c0_n0_w46, 
            w47=> c0_n0_w47, 
            w48=> c0_n0_w48, 
            w49=> c0_n0_w49, 
            w50=> c0_n0_w50, 
            w51=> c0_n0_w51, 
            w52=> c0_n0_w52, 
            w53=> c0_n0_w53, 
            w54=> c0_n0_w54, 
            w55=> c0_n0_w55, 
            w56=> c0_n0_w56, 
            w57=> c0_n0_w57, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_57n_8bit_signed_mul0_v0_add0_v0
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
            x31=> x31, 
            x32=> x32, 
            x33=> x33, 
            x34=> x34, 
            x35=> x35, 
            x36=> x36, 
            x37=> x37, 
            x38=> x38, 
            x39=> x39, 
            x40=> x40, 
            x41=> x41, 
            x42=> x42, 
            x43=> x43, 
            x44=> x44, 
            x45=> x45, 
            x46=> x46, 
            x47=> x47, 
            x48=> x48, 
            x49=> x49, 
            x50=> x50, 
            x51=> x51, 
            x52=> x52, 
            x53=> x53, 
            x54=> x54, 
            x55=> x55, 
            x56=> x56, 
            x57=> x57, 
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
            w11=> c0_n1_w11, 
            w12=> c0_n1_w12, 
            w13=> c0_n1_w13, 
            w14=> c0_n1_w14, 
            w15=> c0_n1_w15, 
            w16=> c0_n1_w16, 
            w17=> c0_n1_w17, 
            w18=> c0_n1_w18, 
            w19=> c0_n1_w19, 
            w20=> c0_n1_w20, 
            w21=> c0_n1_w21, 
            w22=> c0_n1_w22, 
            w23=> c0_n1_w23, 
            w24=> c0_n1_w24, 
            w25=> c0_n1_w25, 
            w26=> c0_n1_w26, 
            w27=> c0_n1_w27, 
            w28=> c0_n1_w28, 
            w29=> c0_n1_w29, 
            w30=> c0_n1_w30, 
            w31=> c0_n1_w31, 
            w32=> c0_n1_w32, 
            w33=> c0_n1_w33, 
            w34=> c0_n1_w34, 
            w35=> c0_n1_w35, 
            w36=> c0_n1_w36, 
            w37=> c0_n1_w37, 
            w38=> c0_n1_w38, 
            w39=> c0_n1_w39, 
            w40=> c0_n1_w40, 
            w41=> c0_n1_w41, 
            w42=> c0_n1_w42, 
            w43=> c0_n1_w43, 
            w44=> c0_n1_w44, 
            w45=> c0_n1_w45, 
            w46=> c0_n1_w46, 
            w47=> c0_n1_w47, 
            w48=> c0_n1_w48, 
            w49=> c0_n1_w49, 
            w50=> c0_n1_w50, 
            w51=> c0_n1_w51, 
            w52=> c0_n1_w52, 
            w53=> c0_n1_w53, 
            w54=> c0_n1_w54, 
            w55=> c0_n1_w55, 
            w56=> c0_n1_w56, 
            w57=> c0_n1_w57, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_57n_8bit_signed_mul0_v0_add0_v0
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
            x31=> x31, 
            x32=> x32, 
            x33=> x33, 
            x34=> x34, 
            x35=> x35, 
            x36=> x36, 
            x37=> x37, 
            x38=> x38, 
            x39=> x39, 
            x40=> x40, 
            x41=> x41, 
            x42=> x42, 
            x43=> x43, 
            x44=> x44, 
            x45=> x45, 
            x46=> x46, 
            x47=> x47, 
            x48=> x48, 
            x49=> x49, 
            x50=> x50, 
            x51=> x51, 
            x52=> x52, 
            x53=> x53, 
            x54=> x54, 
            x55=> x55, 
            x56=> x56, 
            x57=> x57, 
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
            w11=> c0_n2_w11, 
            w12=> c0_n2_w12, 
            w13=> c0_n2_w13, 
            w14=> c0_n2_w14, 
            w15=> c0_n2_w15, 
            w16=> c0_n2_w16, 
            w17=> c0_n2_w17, 
            w18=> c0_n2_w18, 
            w19=> c0_n2_w19, 
            w20=> c0_n2_w20, 
            w21=> c0_n2_w21, 
            w22=> c0_n2_w22, 
            w23=> c0_n2_w23, 
            w24=> c0_n2_w24, 
            w25=> c0_n2_w25, 
            w26=> c0_n2_w26, 
            w27=> c0_n2_w27, 
            w28=> c0_n2_w28, 
            w29=> c0_n2_w29, 
            w30=> c0_n2_w30, 
            w31=> c0_n2_w31, 
            w32=> c0_n2_w32, 
            w33=> c0_n2_w33, 
            w34=> c0_n2_w34, 
            w35=> c0_n2_w35, 
            w36=> c0_n2_w36, 
            w37=> c0_n2_w37, 
            w38=> c0_n2_w38, 
            w39=> c0_n2_w39, 
            w40=> c0_n2_w40, 
            w41=> c0_n2_w41, 
            w42=> c0_n2_w42, 
            w43=> c0_n2_w43, 
            w44=> c0_n2_w44, 
            w45=> c0_n2_w45, 
            w46=> c0_n2_w46, 
            w47=> c0_n2_w47, 
            w48=> c0_n2_w48, 
            w49=> c0_n2_w49, 
            w50=> c0_n2_w50, 
            w51=> c0_n2_w51, 
            w52=> c0_n2_w52, 
            w53=> c0_n2_w53, 
            w54=> c0_n2_w54, 
            w55=> c0_n2_w55, 
            w56=> c0_n2_w56, 
            w57=> c0_n2_w57, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n2_y
   );           
             
END ARCHITECTURE;

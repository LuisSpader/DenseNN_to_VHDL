LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada0_ReLU_3neuron_8bits_1n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c0_n0_bias, c0_n1_bias, c0_n2_bias, x1, c0_n0_w1, c0_n1_w1, c0_n2_w1: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c0_n0_y, c0_n1_y, c0_n2_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada0_ReLU_3neuron_8bits_1n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_1n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n0_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            w1=> c0_n0_w1, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_1n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n1_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            w1=> c0_n1_w1, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_1n_8bit_signed_mul0_v0_add0_v0
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            -- ['IN']['SIGNED'] 
            bias=> c0_n2_bias, 
            -- ['IN']['SIGNED_num_inputs'] 
            x1=> x1, 
            w1=> c0_n2_w1, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n2_y
   );           
             
END ARCHITECTURE;

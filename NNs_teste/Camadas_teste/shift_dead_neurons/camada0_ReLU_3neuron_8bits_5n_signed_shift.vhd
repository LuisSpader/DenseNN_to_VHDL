LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada0_ReLU_3neuron_8bits_5n_signed_shift IS
  PORT (
      clk, rst: IN STD_LOGIC;
      x1, x2, x3, x4, x5: IN signed(7 DOWNTO 0);
      c0_n0_bias, c0_n1_bias, c0_n2_bias: IN signed(7 DOWNTO 0);
      c0_n0_w1, c0_n0_w2, c0_n0_w3, c0_n0_w4, c0_n0_w5: IN signed(7 DOWNTO 0); c0_n1_w1, c0_n1_w2, c0_n1_w3, c0_n1_w4, c0_n1_w5: IN signed(7 DOWNTO 0); c0_n2_w1, c0_n2_w2, c0_n2_w3, c0_n2_w4, c0_n2_w5: IN signed(7 DOWNTO 0);

      c0_n0_bias_out, c0_n1_bias_out, c0_n2_bias_out: IN signed(7 DOWNTO 0);
      c0_n0_w1_out, c0_n0_w2_out, c0_n0_w3_out: IN signed(7 DOWNTO 0);
      c0_n1_w1_out, c0_n1_w2_out, c0_n1_w3_out: IN signed(7 DOWNTO 0);
      c0_n2_w1_out, c0_n2_w2_out, c0_n2_w3_out: IN signed(7 DOWNTO 0);
      ----------------------------------------------
      c0_n0_y, c0_n1_y, c0_n2_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada0_ReLU_3neuron_8bits_5n_signed_shift  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_comb_ReLU_5n_8bit_signed_mul0_v0_add0_v0
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

            w1=> c0_n0_w1, 
            w2=> c0_n0_w2, 
            w3=> c0_n0_w3, 
            w4=> c0_n0_w4, 
            w5=> c0_n0_w5, 

            w1_out   => c0_n0_w1_out,
            w2_out   => c0_n0_w2_out,
            w3_out   => c0_n0_w3_out,

            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_comb_ReLU_5n_8bit_signed_mul0_v0_add0_v0
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

            w1=> c0_n1_w1, 
            w2=> c0_n1_w2, 
            w3=> c0_n1_w3, 
            w4=> c0_n1_w4, 
            w5=> c0_n1_w5, 

            w1_out   => c0_n1_w1_out,
            w2_out   => c0_n1_w2_out,
            w3_out   => c0_n1_w3_out,

            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_comb_ReLU_5n_8bit_signed_mul0_v0_add0_v0
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

            w1=> c0_n2_w1, 
            w2=> c0_n2_w2, 
            w3=> c0_n2_w3, 
            w4=> c0_n2_w4, 
            w5=> c0_n2_w5, 

            w1_out   => c0_n2_w1_out,
            w2_out   => c0_n2_w2_out,
            w3_out   => c0_n2_w3_out,
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c0_n2_y
   );           
             
END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY  camada1_ReLU_10neuron_8bits_2n_signed IS
  PORT (
    clk, rst: IN STD_LOGIC;
    c1_n0_bias, c1_n1_bias, c1_n2_bias, c1_n3_bias, c1_n4_bias, c1_n5_bias, c1_n6_bias, c1_n7_bias, c1_n8_bias, c1_n9_bias, x1, x2, c1_n0_w1, c1_n0_w2, c1_n1_w1, c1_n1_w2, c1_n2_w1, c1_n2_w2, c1_n3_w1, c1_n3_w2, c1_n4_w1, c1_n4_w2, c1_n5_w1, c1_n5_w2, c1_n6_w1, c1_n6_w2, c1_n7_w1, c1_n7_w2, c1_n8_w1, c1_n8_w2, c1_n9_w1, c1_n9_w2: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    c1_n0_y, c1_n1_y, c1_n2_y, c1_n3_y, c1_n4_y, c1_n5_y, c1_n6_y, c1_n7_y, c1_n8_y, c1_n9_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  camada1_ReLU_10neuron_8bits_2n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n0_w1, 
            w2=> c1_n0_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n0_y
   );           
            
neuron_inst_1: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n1_w1, 
            w2=> c1_n1_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n1_y
   );           
            
neuron_inst_2: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n2_w1, 
            w2=> c1_n2_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n2_y
   );           
            
neuron_inst_3: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n3_w1, 
            w2=> c1_n3_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n3_y
   );           
            
neuron_inst_4: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n4_w1, 
            w2=> c1_n4_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n4_y
   );           
            
neuron_inst_5: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n5_w1, 
            w2=> c1_n5_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n5_y
   );           
            
neuron_inst_6: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n6_w1, 
            w2=> c1_n6_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n6_y
   );           
            
neuron_inst_7: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n7_w1, 
            w2=> c1_n7_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n7_y
   );           
            
neuron_inst_8: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n8_w1, 
            w2=> c1_n8_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n8_y
   );           
            
neuron_inst_9: ENTITY work.neuron_ReLU_2n_8bit_signed
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
            w1=> c1_n9_w1, 
            w2=> c1_n9_w2, 
            ---------- Saidas ---------- 
            -- ['OUT']['SIGNED'] 
            y=> c1_n9_y
   );           
             
END ARCHITECTURE;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top IS
  PORT (
    clk, rst: IN STD_LOGIC;
    
    -- Entradas primeira camada
    x1, x2, x3, x4, x5: IN signed(7 DOWNTO 0);
    
    -- Bias 
    c0_n0_bias, c0_n1_bias, c0_n2_bias: IN signed(7 DOWNTO 0);
    c1_n0_bias, c1_n1_bias, c1_n2_bias: IN signed(7 DOWNTO 0);
    c2_n0_bias, c2_n1_bias, c2_n2_bias: IN signed(7 DOWNTO 0); -- morto: c2_n2_bias
    c3_n0_bias, c3_n1_bias, c3_n2_bias: IN signed(7 DOWNTO 0); -- morto: c3_n2_bias
    

    -- ======== Pesos ========
    -- c0 5n = W & bias | 3 neuron = Output &
    -- camada0_relu_3neuron_8bits_5n_signed_inst
    c0_n0_w1, c0_n0_w2, c0_n0_w3, c0_n0_w4, c0_n0_w5: IN signed(7 DOWNTO 0);
    c0_n1_w1, c0_n1_w2, c0_n1_w3, c0_n1_w4, c0_n1_w5: IN signed(7 DOWNTO 0);
    c0_n2_w1, c0_n2_w2, c0_n2_w3, c0_n2_w4, c0_n2_w5: IN signed(7 DOWNTO 0);
    
    -- camada1_relu_3neuron_8bits_3n_signed_inst
    c1_n0_w1, c1_n0_w2, c1_n0_w3, c1_n0_w4, c1_n0_w5: IN signed(7 DOWNTO 0);
    c1_n1_w1, c1_n1_w2, c1_n1_w3, c1_n1_w4, c1_n1_w5: IN signed(7 DOWNTO 0);
    c1_n2_w1, c1_n2_w2, c1_n2_w3, c1_n2_w4, c1_n2_w5: IN signed(7 DOWNTO 0);

    -- c2 3n & 2 neurons
    -- camada2_relu_2neuron_8bits_3n_signed_inst
    c2_n0_w1, c2_n0_w2, c2_n0_w3, c2_n0_w4, c2_n0_w5: IN signed(7 DOWNTO 0);
    c2_n1_w1, c2_n1_w2, c2_n1_w3, c2_n1_w4, c2_n1_w5: IN signed(7 DOWNTO 0);
    c2_n2_w1, c2_n2_w2, c2_n2_w3, c2_n2_w4, c2_n2_w5: IN signed(7 DOWNTO 0); -- morto

    -- camada3_sigmoid_2neuron_8bits_2n_signed_inst
    c3_n0_w1, c3_n0_w2, c3_n0_w3, c3_n0_w4, c3_n0_w5: IN signed(7 DOWNTO 0);
    c3_n1_w1, c3_n1_w2, c3_n1_w3, c3_n1_w4, c3_n1_w5: IN signed(7 DOWNTO 0);
    c3_n2_w1, c3_n2_w2, c3_n2_w3, c3_n2_w4, c3_n2_w5: IN signed(7 DOWNTO 0); -- morto
    ----------------------------------------------

    -- Saídas última camada
    c3_n0_y, c3_n1_y, c3_n2_y, c3_n3_y, c3_n4_y, c3_n5_y, c3_n6_y, c3_n7_y, c3_n8_y, c3_n9_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  top  IS 
signal  c0_out_0, c0_out_1, c0_out_2: signed(7 downto 0);
signal  c1_out_0, c1_out_1, c1_out_2: signed(7 downto 0);
signal  c2_out_0, c2_out_1, c2_out_2: signed(7 downto 0); -- morto: c2_out_2

BEGIN

camada0_relu_3neuron_8bits_5n_signed_inst: entity work.camada0_ReLU_3neuron_8bits_5n_signed
  port map (
    clk        => clk,
    rst        => rst,
    c0_n0_bias => c0_n0_bias,
    c0_n1_bias => c0_n1_bias,
    c0_n2_bias => c0_n2_bias,
    x1         => x1,
    x2         => x2,
    x3         => x3,
    x4         => x4,
    x5         => x5,
    c0_n0_w1   => c0_n0_w1,
    c0_n0_w2   => c0_n0_w2,
    c0_n0_w3   => c0_n0_w3,
    c0_n0_w4   => c0_n0_w4,
    c0_n0_w5   => c0_n0_w5,
    c0_n1_w1   => c0_n1_w1,
    c0_n1_w2   => c0_n1_w2,
    c0_n1_w3   => c0_n1_w3,
    c0_n1_w4   => c0_n1_w4,
    c0_n1_w5   => c0_n1_w5,
    c0_n2_w1   => c0_n2_w1,
    c0_n2_w2   => c0_n2_w2,
    c0_n2_w3   => c0_n2_w3,
    c0_n2_w4   => c0_n2_w4,
    c0_n2_w5   => c0_n2_w5,
    c0_n0_y    => c0_out_0,
    c0_n1_y    => c0_out_1,
    c0_n2_y    => c0_out_2
  );

camada1_relu_3neuron_8bits_3n_signed_inst: entity work.camada1_ReLU_3neuron_8bits_3n_signed
  port map (
    clk        => clk,
    rst        => rst,
    c1_n0_bias => c1_n0_bias,
    c1_n1_bias => c1_n1_bias,
    c1_n2_bias => c1_n2_bias,
    x1         => c0_out_0,
    x2         => c0_out_1,
    x3         => c0_out_2,
    c1_n0_w1   => c1_n0_w1,
    c1_n0_w2   => c1_n0_w2,
    c1_n0_w3   => c1_n0_w3,
    c1_n1_w1   => c1_n1_w1,
    c1_n1_w2   => c1_n1_w2,
    c1_n1_w3   => c1_n1_w3,
    c1_n2_w1   => c1_n2_w1,
    c1_n2_w2   => c1_n2_w2,
    c1_n2_w3   => c1_n2_w3,
    c1_n0_y    => c1_out_0,
    c1_n1_y    => c1_out_1,
    c1_n2_y    => c1_out_2
  );

camada2_relu_2neuron_8bits_3n_signed_inst: entity work.camada2_ReLU_2neuron_8bits_3n_signed
  port map (
    clk        => clk,
    rst        => rst,
    c2_n0_bias => c2_n0_bias,
    c2_n1_bias => c2_n1_bias,
    c2_n2_bias => c2_n2_bias, -- morto
    x1         => x1,
    x2         => x2,
    x3         => x3,
    c2_n0_w1   => c2_n0_w1,
    c2_n0_w2   => c2_n0_w2,
    c2_n0_w3   => c2_n0_w3,
    c2_n1_w1   => c2_n1_w1,
    c2_n1_w2   => c2_n1_w2,
    c2_n1_w3   => c2_n1_w3,
    c2_n2_w1   => c2_n2_w1, -- morto
    c2_n2_w2   => c2_n2_w2, -- morto
    c2_n2_w3   => c2_n2_w3, -- morto
    c2_n0_y    => c2_out_0,
    c2_n1_y    => c2_out_1,
    c2_n2_y    => c2_out_2 -- morto
  );

camada3_sigmoid_2neuron_8bits_2n_signed_inst: entity work.camada3_Sigmoid_2neuron_8bits_2n_signed
  port map (
    clk        => clk,
    rst        => rst,
    c3_n0_bias => c3_n0_bias,
    c3_n1_bias => c3_n1_bias,
    c3_n2_bias => c3_n2_bias, -- morto
    x1         => x1,
    x2         => x2,
    c3_n0_w1   => c3_n0_w1,
    c3_n0_w2   => c3_n0_w2,
    c3_n1_w1   => c3_n1_w1,
    c3_n1_w2   => c3_n1_w2,
    c3_n2_w1   => c3_n2_w1, -- morto
    c3_n2_w2   => c3_n2_w2, -- morto
    c3_n0_y    => c3_n0_y,
    c3_n1_y    => c3_n1_y,
    c3_n2_y    => c3_n2_y -- morto
  );


END ARCHITECTURE;

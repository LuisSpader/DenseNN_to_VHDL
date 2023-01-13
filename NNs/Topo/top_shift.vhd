LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_shift IS
  PORT (
    clk, rst: IN STD_LOGIC;
    
    -- Entradas primeira camada
    x1, x2, x3, x4, x5: IN signed(7 DOWNTO 0);
    
    -- Bias 
    c0_n0_bias, c0_n1_bias, c0_n2_bias: IN signed(7 DOWNTO 0);

    

    -- ======== Pesos ========
    -- c0 5n = W & bias | 3 neuron = Output &
    -- camada0_relu_3neuron_8bits_5n_signed_inst
    c0_n0_w1, c0_n0_w2, c0_n0_w3, c0_n0_w4, c0_n0_w5: IN signed(7 DOWNTO 0);
    c0_n1_w1, c0_n1_w2, c0_n1_w3, c0_n1_w4, c0_n1_w5: IN signed(7 DOWNTO 0);
    c0_n2_w1, c0_n2_w2, c0_n2_w3, c0_n2_w4, c0_n2_w5: IN signed(7 DOWNTO 0);
    
    -- camada1_relu_3neuron_8bits_3n_signed_inst
   

    -- c2 3n & 2 neurons
    -- camada2_relu_2neuron_8bits_3n_signed_inst


    -- camada3_sigmoid_2neuron_8bits_2n_signed_inst

    ----------------------------------------------

    -- Saídas última camada
    c3_n0_y, c3_n1_y, c3_n2_y, c3_n3_y, c3_n4_y, c3_n5_y, c3_n6_y, c3_n7_y, c3_n8_y, c3_n9_y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;

ARCHITECTURE arch OF  top_shift  IS 
-- saidas
SIGNAL c0_out_0, c0_out_1, c0_out_2: signed(7 downto 0);
SIGNAL c1_out_0, c1_out_1, c1_out_2: signed(7 downto 0);
SIGNAL c2_out_0, c2_out_1, c2_out_2: signed(7 downto 0); -- morto: c2_out_2

-- bias
SIGNAL c1_n0_bias, c1_n1_bias, c1_n2_bias: signed(7 DOWNTO 0);
SIGNAL c2_n0_bias, c2_n1_bias, c2_n2_bias: signed(7 DOWNTO 0); -- morto: c2_n2_bias
SIGNAL c3_n0_bias, c3_n1_bias, c3_n2_bias: signed(7 DOWNTO 0); -- morto: c3_n2_bias

-- c0
SIGNAL c0_n0_w1_out, c0_n0_w2_out, c0_n0_w3_out, c0_n0_w4_out, c0_n0_w5_out: signed(7 DOWNTO 0);
SIGNAL c0_n1_w1_out, c0_n1_w2_out, c0_n1_w3_out, c0_n1_w4_out, c0_n1_w5_out: signed(7 DOWNTO 0);
SIGNAL c0_n2_w1_out, c0_n2_w2_out, c0_n2_w3_out, c0_n2_w4_out, c0_n2_w5_out: signed(7 DOWNTO 0);
signal c0_n0_bias_out, c0_n1_bias_out, c0_n2_bias_out:  signed(7 DOWNTO 0);

-- c1
SIGNAL c1_n0_w1_out, c1_n0_w2_out, c1_n0_w3_out, c1_n0_w4_out, c1_n0_w5_out: signed(7 DOWNTO 0);
SIGNAL c1_n1_w1_out, c1_n1_w2_out, c1_n1_w3_out, c1_n1_w4_out, c1_n1_w5_out: signed(7 DOWNTO 0);
SIGNAL c1_n2_w1_out, c1_n2_w2_out, c1_n2_w3_out, c1_n2_w4_out, c1_n2_w5_out: signed(7 DOWNTO 0);
signal c1_n0_bias_out, c1_n1_bias_out, c1_n2_bias_out:  signed(7 DOWNTO 0);

-- c2
SIGNAL c2_n0_w1_out, c2_n0_w2_out, c2_n0_w3_out, c2_n0_w4_out, c2_n0_w5_out: signed(7 DOWNTO 0);
SIGNAL c2_n1_w1_out, c2_n1_w2_out, c2_n1_w3_out, c2_n1_w4_out, c2_n1_w5_out: signed(7 DOWNTO 0);
SIGNAL c2_n2_w1_out, c2_n2_w2_out, c2_n2_w3_out, c2_n2_w4_out, c2_n2_w5_out: signed(7 DOWNTO 0); -- morto
signal c2_n0_bias_out, c2_n1_bias_out, c2_n2_bias_out:  signed(7 DOWNTO 0);

-- c3
SIGNAL c3_n0_w1_out, c3_n0_w2_out, c3_n0_w3_out, c3_n0_w4_out, c3_n0_w5_out: signed(7 DOWNTO 0);
SIGNAL c3_n1_w1_out, c3_n1_w2_out, c3_n1_w3_out, c3_n1_w4_out, c3_n1_w5_out: signed(7 DOWNTO 0);
SIGNAL c3_n2_w1_out, c3_n2_w2_out, c3_n2_w3_out, c3_n2_w4_out, c3_n2_w5_out: signed(7 DOWNTO 0); -- morto



BEGIN

camada0_relu_3neuron_8bits_5n_signed_inst: entity work.camada0_ReLU_3neuron_8bits_5n_signed_shift
  port map (
    clk        => clk,
    rst        => rst,
    
    x1         => x1,
    x2         => x2,
    x3         => x3,
    x4         => x4,
    x5         => x5,
    
    -- Entrada dos registradores de peso e bias --> pega saída da memória
    c0_n0_bias => c0_n0_bias,
    c0_n1_bias => c0_n1_bias,
    c0_n2_bias => c0_n2_bias,

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
    ----------------------------------------------------------------------------------------------    
    -- Saída dos registradores de peso --> vai para a entrada dos registradores da próxima camada
    c0_n0_bias_out => c0_n0_bias_out,
    c0_n1_bias_out => c0_n1_bias_out,
    c0_n2_bias_out => c0_n2_bias_out,

    -- neuron 1
    c0_n0_w1_out   => c0_n0_w1_out,
    c0_n0_w2_out   => c0_n0_w2_out,
    c0_n0_w3_out   => c0_n0_w3_out,
    c0_n0_w4_out   => c0_n0_w4_out,
    c0_n0_w5_out   => c0_n0_w5_out,
    
    -- neuron 2
    c0_n1_w1_out   => c0_n1_w1_out,
    c0_n1_w2_out   => c0_n1_w2_out,
    c0_n1_w3_out   => c0_n1_w3_out,
    c0_n1_w4_out   => c0_n1_w4_out,
    c0_n1_w5_out   => c0_n1_w5_out,
    
    -- neuron 3
    c0_n2_w1_out   => c0_n2_w1_out,
    c0_n2_w2_out   => c0_n2_w2_out,
    c0_n2_w3_out   => c0_n2_w3_out,
    c0_n2_w4_out   => c0_n2_w4_out,
    c0_n2_w5_out   => c0_n2_w5_out,

    c0_n0_y    => c0_out_0,
    c0_n1_y    => c0_out_1,
    c0_n2_y    => c0_out_2
  );

camada1_relu_3neuron_8bits_3n_signed_inst: entity work.camada1_ReLU_3neuron_8bits_3n_signed
  port map (
    clk        => clk,
    rst        => rst,
    x1         => c0_out_0,
    x2         => c0_out_1,
    x3         => c0_out_2,
    
    -- Entrada dos registradores de peso e bias --> pega saída dos registradores da camada anterior
    
    c1_n0_bias => c0_n0_bias_out,
    c1_n1_bias => c0_n1_bias_out,
    c1_n2_bias => c0_n2_bias_out,
    
    -- neuron 0
    c1_n0_w1   => c0_n0_w1_out,
    c1_n0_w2   => c0_n0_w2_out,
    c1_n0_w3   => c0_n0_w3_out,

    -- neuron 1  
    c1_n1_w1   => c0_n1_w1_out,
    c1_n1_w2   => c0_n1_w2_out,
    c1_n1_w3   => c0_n1_w3_out,
    
    -- neuron 2
    c1_n2_w1   => c0_n2_w1_out,
    c1_n2_w2   => c0_n2_w2_out,
    c1_n2_w3   => c0_n2_w3_out,

    ----------------------------------------------------------------------------------------------    
    -- Saída dos registradores de peso e bias --> vai para a entrada dos registradores da próxima camada
    c1_n0_bias_out => c1_n0_bias_out,
    c1_n1_bias_out => c1_n1_bias_out,
    c1_n2_bias_out => c1_n2_bias_out,

    -- neuron 0
    c1_n0_w1_out   => c1_n0_w1_out,
    c1_n0_w2_out   => c1_n0_w2_out,
    c1_n0_w3_out   => c1_n0_w3_out,

    -- neuron 1
    c1_n1_w1_out   => c1_n1_w1_out,
    c1_n1_w2_out   => c1_n1_w2_out,
    c1_n1_w3_out   => c1_n1_w3_out,
    
    -- neuron 2
    c1_n2_w1_out   => c1_n2_w1_out,
    c1_n2_w2_out   => c1_n2_w2_out,
    c1_n2_w3_out   => c1_n2_w3_out,

    
    c1_n0_y    => c1_out_0,
    c1_n1_y    => c1_out_1,
    c1_n2_y    => c1_out_2
  );

camada2_relu_3neuron_8bits_3n_signed_inst: entity work.camada2_ReLU_3neuron_8bits_3n_signed
  port map (
    clk        => clk,
    rst        => rst,
    
    x1         => c1_out_0,
    x2         => c1_out_1,
    x3         => c1_out_2,
    
    -- Entrada dos registradores de peso --> pega saída dos registradores da camada anterior
    c2_n0_bias => c2_n0_bias,
    c2_n1_bias => c2_n1_bias,
    c2_n2_bias => c2_n2_bias, -- morto

    -- neuron 0
    c2_n0_w1   => c1_n0_w1_out,
    c2_n0_w2   => c1_n0_w2_out,
    c2_n0_w3   => c1_n0_w3_out,

    -- neuron 1
    c2_n1_w1   => c1_n1_w1_out,
    c2_n1_w2   => c1_n1_w2_out,
    c2_n1_w3   => c1_n1_w3_out,

    -- neuron 2
    c2_n2_w1   => c1_n2_w1_out, -- morto
    c2_n2_w2   => c1_n2_w2_out, -- morto
    c2_n2_w3   => c1_n2_w3_out, -- morto
    ----------------------------------------------------------------------------------------------
    -- Saída dos registradores de peso --> vai para a entrada dos registradores da próxima camada    
    c2_n0_bias_out => c2_n0_bias_out,
    c2_n1_bias_out => c2_n1_bias_out,
    c2_n2_bias_out => c2_n2_bias_out,

    -- neuron 0
    c2_n0_w1_out   => c2_n0_w1_out,
    c2_n0_w2_out   => c2_n0_w2_out,
    c2_n0_w3_out   => c2_n0_w3_out,

    -- neuron 1
    c2_n1_w1_out   => c2_n1_w1_out,
    c2_n1_w2_out   => c2_n1_w2_out,
    c2_n1_w3_out   => c2_n1_w3_out,

    -- neuron 2
    c2_n2_w1_out   => c2_n2_w1_out,
    c2_n2_w2_out   => c2_n2_w2_out,
    c2_n2_w3_out   => c2_n2_w3_out,    
    
    c2_n0_y    => c2_out_0,
    c2_n1_y    => c2_out_1,
    c2_n2_y    => c2_out_2 -- morto
  );

camada3_sigmoid_3neuron_8bits_3n_signed_inst: entity work.camada3_Sigmoid_3neuron_8bits_3n_signed
  port map (
    clk        => clk,
    rst        => rst,
    x1         => c2_out_0,
    x2         => c2_out_1,
    x3         => c2_out_2,
    
    -- note nao utilizamos os 3º pesos de cada neuronio da camada anterior, pois nesta camada sõ temos neurônios com 2 entradas
    -- c3_n0_w1   => c2_n0_w1_out,
    -- c3_n0_w2   => c2_n0_w2_out,
    -- c3_n1_w1   => c2_n1_w1_out,
    -- c3_n1_w2   => c2_n1_w2_out,
    -- c3_n2_w1   => c2_n2_w1_out, -- morto
    -- c3_n2_w2   => c2_n2_w2_out, -- morto
    
    -- Entrada dos registradores de peso e bias --> pega saída dos registradores da camada anterior
    c3_n0_bias => c2_n0_bias_out,
    c3_n1_bias => c2_n1_bias_out,
    c3_n2_bias => c2_n2_bias_out, -- morto

    c3_n0_w1   => c2_n0_w1_out,
    c3_n0_w2   => c2_n0_w2_out,
    c3_n0_w3   => c2_n0_w3_out,
    
    c3_n1_w1   => c2_n1_w1_out,
    c3_n1_w2   => c2_n1_w2_out,
    c3_n1_w3   => c2_n1_w3_out,
    
    c3_n2_w1   => c2_n2_w1_out, -- morto
    c3_n2_w2   => c2_n2_w2_out, -- morto
    c3_n2_w3   => c2_n2_w3_out, -- morto 
    ----------------------------------------------------------------------------------------------  
    -- Saída dos registradores de peso --> NÃO deve ter saída dos registradores na última camada


    c3_n0_y    => c3_n0_y,
    c3_n1_y    => c3_n1_y,
    c3_n2_y    => c3_n2_y -- morto
  );


END ARCHITECTURE;

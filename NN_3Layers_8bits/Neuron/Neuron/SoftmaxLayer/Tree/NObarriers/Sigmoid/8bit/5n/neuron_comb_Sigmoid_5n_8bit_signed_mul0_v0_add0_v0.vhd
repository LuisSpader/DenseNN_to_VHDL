LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;

    ENTITY  neuron_comb_Sigmoid_5n_8bit_signed_mul0_v0_add0_v0 IS
  PORT (
    clk, rst, update_weights: IN STD_LOGIC;
    bias: IN signed(7 DOWNTO 0);
    x1, x2, x3, x4, x5: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;


    ARCHITECTURE behavior of neuron_comb_Sigmoid_5n_8bit_signed_mul0_v0_add0_v0 is
    
        COMPONENT MAC_comb_5n_8bit_signed_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3, x4, x5: IN signed(7 DOWNTO 0);
            w1, w2, w3, w4, w5: IN signed(7 DOWNTO 0);
            bias: IN signed(7 DOWNTO 0) ; -- offset 
            ------------------------------------------ 
            output: OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
        END COMPONENT;                            
    
    
  -- ROM 
  COMPONENT ROM_fx_8bitaddr_8width IS
    PORT ( 
      address : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      ------------------------------------------
      data_out : OUT STD_LOGIC_VECTOR (7  DOWNTO 0)
    );
  -- input: address (16 bits)	
  -- output: data_out (8 bits)
  END COMPONENT;                     
  

        SIGNAL out_reg_MAC : signed (( 7 ) DOWNTO 0);	--reg da saida do MAC
        SIGNAL out_ROM_act : STD_LOGIC_VECTOR( 7 DOWNTO 0); --saida da ROM
        SIGNAL reg_out_ROM_act : signed ( 7 DOWNTO 0); --reg saida da ROM

        SIGNAL reg_x1, reg_x2, reg_x3, reg_x4, reg_x5: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed ( 7 DOWNTO 0);


    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_comb_5n_8bit_signed_mul0_v0_add0_v0 PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3, reg_x4, reg_x5,
 	   	reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, 
		reg_bias, 
		out_reg_MAC);
        
	U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
		STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
		);
	-- input: address (16)
	-- output: data_out (8)  
	
        
        PROCESS (clk, rst, update_weights)
        BEGIN
            IF rst = '1' THEN
                                               reg_out_ROM_act <= (OTHERS => '0');

                   reg_x1 <= (OTHERS => '0');
                   reg_x2 <= (OTHERS => '0');
                   reg_x3 <= (OTHERS => '0');
                   reg_x4 <= (OTHERS => '0');
                   reg_x5 <= (OTHERS => '0');

                   reg_w1 <= (OTHERS => '0');
                   reg_w2 <= (OTHERS => '0');
                   reg_w3 <= (OTHERS => '0');
                   reg_w4 <= (OTHERS => '0');
                   reg_w5 <= (OTHERS => '0');
                   reg_bias <= (OTHERS => '0');
            ELSIF clk'event AND clk = '1' THEN
                                                 reg_out_ROM_act <=  signed(out_ROM_act); 
                       IF update_weights = '0' THEN 
                         reg_x1 <= x1;
                         reg_x2 <= x2;
                         reg_x3 <= x3;
                         reg_x4 <= x4;
                         reg_x5 <= x5;

                       ELSE
                         reg_w1 <= x1;
                         reg_w2 <= x2;
                         reg_w3 <= x3;
                         reg_w4 <= x4;
                         reg_w5 <= x5;

                       END IF;
                       reg_bias <= bias;
            END IF;
        END PROCESS;
    

        y <= signed (reg_out_ROM_act);

    END behavior;
LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;

    ENTITY  neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0 IS
  PORT (
    clk, rst, update_weights: IN STD_LOGIC;
    Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
    Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    ----------------------------------------------
    y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;
  

    ARCHITECTURE behavior of neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0 is
    
        COMPONENT MAC_comb_3n_8bit_signed_mult0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            bias: IN signed(7 DOWNTO 0) ; -- offset 
            x1, x2, x3: IN signed(7 DOWNTO 0);
            w1, w2, w3: IN signed(7 DOWNTO 0);
            ------------------------------------------ 
            y: OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
        END COMPONENT;                            
    
    -- # ROM_component
        SIGNAL out_reg_MAC : signed ((7) DOWNTO 0);	--reg da saida do MAC
    
        SIGNAL reg_x1, reg_x2, reg_x3: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed (7 DOWNTO 0);

    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_comb_3n_8bit_signed_mult0_v0_add0_v0 PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3,
 	   	reg_w1, reg_w2, reg_w3, 
		reg_bias, 
		out_reg_MAC);
        
        PROCESS (clk, rst, update_weights)
        BEGIN
            IF rst = '1' THEN
                reg_x1 <= (OTHERS => '0');
                reg_x2 <= (OTHERS => '0');
                reg_x3 <= (OTHERS => '0');

                reg_w1 <= (OTHERS => '0');
                reg_w2 <= (OTHERS => '0');
                reg_w3 <= (OTHERS => '0');
                reg_bias <= (OTHERS => '0');

            ELSIF clk'event AND clk = '1' THEN
        
                IF out_reg_MAC > 0 THEN
                    y <= out_reg_MAC;
                ELSE
                    y <= (OTHERS => '0');
                END IF;
    
                            
                 reg_x1 <= x1;
                 reg_x2 <= x2;
                 reg_x3 <= x3;

                IF update_weights = '1' THEN 
                   reg_w1 <= x1;
                   reg_w2 <= x2;
                   reg_w3 <= x3;
                   reg_bias <= bias;
               END IF;
            END IF;
        END PROCESS;
    
    END behavior;
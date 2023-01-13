LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;

    ENTITY  neuron_ReLU_10n_8bit_signed IS
        -- GENERIC (
    -- 	input_bit:integer:= 8; output_bit:integer:= 8 ;	 n_input:integer:= 10
        -- );
    PORT (
        clk, rst, update_weights : IN STD_LOGIC;
        x1, x2, x3, x4, x5, x6, x7, x8, x9, x10: IN signed(7 DOWNTO 0);
    -- 	w1, w2, w3, w4, w5, w6, w7, w8, w9, w10: IN signed(7 DOWNTO 0);
        bias: IN signed(7 DOWNTO 0) ; -- offset
        ------------------------------------------
        y: OUT signed (7 DOWNTO 0) --output  result
    );
    -- clk, rst,
    -- inputs,
    -- weigths,
    -- bias,
    -- output
    end ENTITY;

    ARCHITECTURE behavior of neuron_ReLU_10n_8bit_signed is
    
        COMPONENT MAC_10n_8bit_signed IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6, x7, x8, x9, x10: IN signed(7 DOWNTO 0);
            w1, w2, w3, w4, w5, w6, w7, w8, w9, w10: IN signed(7 DOWNTO 0);
            bias: IN signed(7 DOWNTO 0) ; -- offset 
            ------------------------------------------ 
            output: OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
        END COMPONENT;                            
    
    -- # ROM_component
        SIGNAL out_reg_MAC : signed ((7) DOWNTO 0);	--reg da saida do MAC
    
        SIGNAL reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed (7 DOWNTO 0);

    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_10n_8bit_signed PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10,
 	   	reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, 
		reg_bias, 
		out_reg_MAC);
        
        PROCESS (clk, rst, update_weights)
        BEGIN
            IF rst = '1' THEN
                                               reg_x1 <= (OTHERS => '0');
                   reg_x2 <= (OTHERS => '0');
                   reg_x3 <= (OTHERS => '0');
                   reg_x4 <= (OTHERS => '0');
                   reg_x5 <= (OTHERS => '0');
                   reg_x6 <= (OTHERS => '0');
                   reg_x7 <= (OTHERS => '0');
                   reg_x8 <= (OTHERS => '0');
                   reg_x9 <= (OTHERS => '0');
                   reg_x10 <= (OTHERS => '0');

                   reg_w1 <= (OTHERS => '0');
                   reg_w2 <= (OTHERS => '0');
                   reg_w3 <= (OTHERS => '0');
                   reg_w4 <= (OTHERS => '0');
                   reg_w5 <= (OTHERS => '0');
                   reg_w6 <= (OTHERS => '0');
                   reg_w7 <= (OTHERS => '0');
                   reg_w8 <= (OTHERS => '0');
                   reg_w9 <= (OTHERS => '0');
                   reg_w10 <= (OTHERS => '0');
                   reg_bias <= (OTHERS => '0');
            ELSIF clk'event AND clk = '1' THEN
        
                IF out_reg_MAC > 0 THEN
                    y <= out_reg_MAC;
                ELSE
                    y <= (OTHERS => '0');
                END IF;
    
                                                   IF update_weights = '0' THEN 
                         reg_x1 <= x1;
                         reg_x2 <= x2;
                         reg_x3 <= x3;
                         reg_x4 <= x4;
                         reg_x5 <= x5;
                         reg_x6 <= x6;
                         reg_x7 <= x7;
                         reg_x8 <= x8;
                         reg_x9 <= x9;
                         reg_x10 <= x10;

                       ELSE
                         reg_w1 <= x1;
                         reg_w2 <= x2;
                         reg_w3 <= x3;
                         reg_w4 <= x4;
                         reg_w5 <= x5;
                         reg_w6 <= x6;
                         reg_w7 <= x7;
                         reg_w8 <= x8;
                         reg_w9 <= x9;
                         reg_w10 <= x10;

                       END IF;
                       reg_bias <= bias;
            END IF;
        END PROCESS;
    
    END behavior;
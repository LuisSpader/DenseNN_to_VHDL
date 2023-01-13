LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;

    ENTITY  neuron_comb_ReLU_15n_8bit_signed_mul0_v0_add0_v0 IS
        -- GENERIC (
    -- 	input_bit:integer:= 8; output_bit:integer:= 8 ;	 n_input:integer:= 15
        -- );
    PORT (
        clk, rst, update_weights : IN STD_LOGIC;
        x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15: IN signed(7 DOWNTO 0);
    -- 	w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15: IN signed(7 DOWNTO 0);
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

    ARCHITECTURE behavior of neuron_comb_ReLU_15n_8bit_signed_mul0_v0_add0_v0 is
    
        COMPONENT MAC_comb_15n_8bit_signed_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15: IN signed(7 DOWNTO 0);
            w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15: IN signed(7 DOWNTO 0);
            bias: IN signed(7 DOWNTO 0) ; -- offset 
            ------------------------------------------ 
            output: OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
        END COMPONENT;                            
    
    -- # ROM_component
        SIGNAL out_reg_MAC : signed ((7) DOWNTO 0);	--reg da saida do MAC
    
        SIGNAL reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10, reg_x11, reg_x12, reg_x13, reg_x14, reg_x15: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, reg_w11, reg_w12, reg_w13, reg_w14, reg_w15: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed (7 DOWNTO 0);

    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_comb_15n_8bit_signed_mul0_v0_add0_v0 PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10, reg_x11, reg_x12, reg_x13, reg_x14, reg_x15,
 	   	reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, reg_w11, reg_w12, reg_w13, reg_w14, reg_w15, 
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
                   reg_x11 <= (OTHERS => '0');
                   reg_x12 <= (OTHERS => '0');
                   reg_x13 <= (OTHERS => '0');
                   reg_x14 <= (OTHERS => '0');
                   reg_x15 <= (OTHERS => '0');

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
                   reg_w11 <= (OTHERS => '0');
                   reg_w12 <= (OTHERS => '0');
                   reg_w13 <= (OTHERS => '0');
                   reg_w14 <= (OTHERS => '0');
                   reg_w15 <= (OTHERS => '0');
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
                         reg_x11 <= x11;
                         reg_x12 <= x12;
                         reg_x13 <= x13;
                         reg_x14 <= x14;
                         reg_x15 <= x15;

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
                         reg_w11 <= x11;
                         reg_w12 <= x12;
                         reg_w13 <= x13;
                         reg_w14 <= x14;
                         reg_w15 <= x15;

                       END IF;
                       reg_bias <= bias;
            END IF;
        END PROCESS;
    
    END behavior;
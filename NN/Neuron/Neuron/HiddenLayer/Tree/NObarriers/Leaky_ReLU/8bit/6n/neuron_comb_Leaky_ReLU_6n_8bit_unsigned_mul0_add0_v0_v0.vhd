LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;


    ENTITY  neuron_comb_LeakyReLU_6n_8bit_signed_mul0_v0_add0_v0 IS
        -- GENERIC (
    -- 	input_bit:integer:=8; output_bit:integer:=8;	 n_input:integer:=6
        -- );
    PORT (
        clk, rst, update_weights : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6: IN signed(7 DOWNTO 0);
    -- 	w1, w2, w3, w4, w5, w6: IN signed(7 DOWNTO 0);
        bias: IN signed(7 DOWNTO 0) ; -- offset
        ------------------------------------------
        y: OUT signed(7 DOWNTO 0) --output  result
    );
    -- clk, rst,
    -- inputs,
    -- weigths,
    -- bias,
    -- output
    end ENTITY;


    ARCHITECTURE behavior of neuron_comb_LeakyReLU_6n_8bit_signed_mul0_v0_add0_v0 is
    
        COMPONENT MAC_comb_6n_8bit_signed_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6: IN signed(7 DOWNTO 0);
            w1, w2, w3, w4, w5, w6: IN signed(7 DOWNTO 0);
            bias: IN signed(7 DOWNTO 0) ; -- offset 
            ------------------------------------------ 
            output: OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
        END COMPONENT;                            
    
    -- #ROM_component

        SIGNAL out_reg_MAC : signed((7) DOWNTO 0);	--reg da saida do MAC

        SIGNAL reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed(7 DOWNTO 0);


    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_comb_6n_8bit_signed_mul0_v0_add0_v0 PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6,
 	   	reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, 
		reg_bias, 
		out_reg_MAC);
    --#	 PORT_MAP_ROM
        
        PROCESS (clk, rst, update_weights)
        BEGIN
            IF rst = '1' THEN
                       reg_x1 <= (OTHERS => '0');
                   reg_x2 <= (OTHERS => '0');
                   reg_x3 <= (OTHERS => '0');
                   reg_x4 <= (OTHERS => '0');
                   reg_x5 <= (OTHERS => '0');
                   reg_x6 <= (OTHERS => '0');

                   reg_w1 <= (OTHERS => '0');
                   reg_w2 <= (OTHERS => '0');
                   reg_w3 <= (OTHERS => '0');
                   reg_w4 <= (OTHERS => '0');
                   reg_w5 <= (OTHERS => '0');
                   reg_w6 <= (OTHERS => '0');
                   reg_bias <= (OTHERS => '0');

            ELSIF clk'event AND clk = '1' THEN
    
                IF out_reg_MAC > 0 THEN
                    y <= out_reg_MAC;
                ELSE
                    y <=  111 & out_reg_MAC(
        7  DOWNTO 3);
                END IF;
    
                           IF update_weights = '0' THEN 
                         reg_x1 <= x1;
                         reg_x2 <= x2;
                         reg_x3 <= x3;
                         reg_x4 <= x4;
                         reg_x5 <= x5;
                         reg_x6 <= x6;

                       ELSE
                         reg_w1 <= x1;
                         reg_w2 <= x2;
                         reg_w3 <= x3;
                         reg_w4 <= x4;
                         reg_w5 <= x5;
                         reg_w6 <= x6;

                       END IF;
                       reg_bias <= bias;
            END IF;
        END PROCESS;
    

    END behavior;
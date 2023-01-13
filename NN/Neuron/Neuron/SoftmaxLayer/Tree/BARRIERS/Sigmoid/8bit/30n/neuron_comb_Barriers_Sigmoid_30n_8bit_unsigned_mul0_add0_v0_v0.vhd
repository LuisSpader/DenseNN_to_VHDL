LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;

    ENTITY  neuron_comb_Barriers_Sigmoid_30n_8bit_signed_mul0_add0_v0_v0 IS
  PORT (
    clk, rst, update_weights: IN STD_LOGIC;
    bias: IN signed(7 DOWNTO 0);
    x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30: IN signed(7 DOWNTO 0);
    ----------------------------------------------
    y: OUT signed(7 DOWNTO 0)
    );
end ENTITY;


    ARCHITECTURE behavior of neuron_comb_Barriers_Sigmoid_30n_8bit_signed_mul0_add0_v0_v0 is
    
        COMPONENT MAC_comb_Barriers_30n_8bit_signed_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30: IN signed(7 DOWNTO 0);
            w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30: IN signed(7 DOWNTO 0);
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

        SIGNAL reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10, reg_x11, reg_x12, reg_x13, reg_x14, reg_x15, reg_x16, reg_x17, reg_x18, reg_x19, reg_x20, reg_x21, reg_x22, reg_x23, reg_x24, reg_x25, reg_x26, reg_x27, reg_x28, reg_x29, reg_x30: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, reg_w11, reg_w12, reg_w13, reg_w14, reg_w15, reg_w16, reg_w17, reg_w18, reg_w19, reg_w20, reg_w21, reg_w22, reg_w23, reg_w24, reg_w25, reg_w26, reg_w27, reg_w28, reg_w29, reg_w30: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed ( 7 DOWNTO 0);


    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_comb_Barriers_30n_8bit_signed_mul0_v0_add0_v0 PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10, reg_x11, reg_x12, reg_x13, reg_x14, reg_x15, reg_x16, reg_x17, reg_x18, reg_x19, reg_x20, reg_x21, reg_x22, reg_x23, reg_x24, reg_x25, reg_x26, reg_x27, reg_x28, reg_x29, reg_x30,
 	   	reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, reg_w11, reg_w12, reg_w13, reg_w14, reg_w15, reg_w16, reg_w17, reg_w18, reg_w19, reg_w20, reg_w21, reg_w22, reg_w23, reg_w24, reg_w25, reg_w26, reg_w27, reg_w28, reg_w29, reg_w30, 
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
                   reg_x16 <= (OTHERS => '0');
                   reg_x17 <= (OTHERS => '0');
                   reg_x18 <= (OTHERS => '0');
                   reg_x19 <= (OTHERS => '0');
                   reg_x20 <= (OTHERS => '0');
                   reg_x21 <= (OTHERS => '0');
                   reg_x22 <= (OTHERS => '0');
                   reg_x23 <= (OTHERS => '0');
                   reg_x24 <= (OTHERS => '0');
                   reg_x25 <= (OTHERS => '0');
                   reg_x26 <= (OTHERS => '0');
                   reg_x27 <= (OTHERS => '0');
                   reg_x28 <= (OTHERS => '0');
                   reg_x29 <= (OTHERS => '0');
                   reg_x30 <= (OTHERS => '0');

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
                   reg_w16 <= (OTHERS => '0');
                   reg_w17 <= (OTHERS => '0');
                   reg_w18 <= (OTHERS => '0');
                   reg_w19 <= (OTHERS => '0');
                   reg_w20 <= (OTHERS => '0');
                   reg_w21 <= (OTHERS => '0');
                   reg_w22 <= (OTHERS => '0');
                   reg_w23 <= (OTHERS => '0');
                   reg_w24 <= (OTHERS => '0');
                   reg_w25 <= (OTHERS => '0');
                   reg_w26 <= (OTHERS => '0');
                   reg_w27 <= (OTHERS => '0');
                   reg_w28 <= (OTHERS => '0');
                   reg_w29 <= (OTHERS => '0');
                   reg_w30 <= (OTHERS => '0');
                   reg_bias <= (OTHERS => '0');
            ELSIF clk'event AND clk = '1' THEN
                                                 reg_out_ROM_act <=  signed(out_ROM_act); 
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
                         reg_x16 <= x16;
                         reg_x17 <= x17;
                         reg_x18 <= x18;
                         reg_x19 <= x19;
                         reg_x20 <= x20;
                         reg_x21 <= x21;
                         reg_x22 <= x22;
                         reg_x23 <= x23;
                         reg_x24 <= x24;
                         reg_x25 <= x25;
                         reg_x26 <= x26;
                         reg_x27 <= x27;
                         reg_x28 <= x28;
                         reg_x29 <= x29;
                         reg_x30 <= x30;

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
                         reg_w16 <= x16;
                         reg_w17 <= x17;
                         reg_w18 <= x18;
                         reg_w19 <= x19;
                         reg_w20 <= x20;
                         reg_w21 <= x21;
                         reg_w22 <= x22;
                         reg_w23 <= x23;
                         reg_w24 <= x24;
                         reg_w25 <= x25;
                         reg_w26 <= x26;
                         reg_w27 <= x27;
                         reg_w28 <= x28;
                         reg_w29 <= x29;
                         reg_w30 <= x30;

                       END IF;
                       reg_bias <= bias;
            END IF;
        END PROCESS;
    

        y <= signed (reg_out_ROM_act);

    END behavior;
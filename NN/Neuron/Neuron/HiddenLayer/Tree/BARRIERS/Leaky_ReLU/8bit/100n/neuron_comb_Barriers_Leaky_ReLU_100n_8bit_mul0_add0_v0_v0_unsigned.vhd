LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.std_logic_unsigned.ALL;
    USE ieee.numeric_std.ALL;
    USE ieee.math_real.ALL;


    ENTITY  neuron_comb_Barriers_LeakyReLU_100n_8bit_signed_mul0_add0_v0_v0 IS
        -- GENERIC (
    -- 	input_bit:integer:=8; output_bit:integer:=8;	 n_input:integer:=100
        -- );
    PORT (
        clk, rst, update_weights : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32, x33, x34, x35, x36, x37, x38, x39, x40, x41, x42, x43, x44, x45, x46, x47, x48, x49, x50, x51, x52, x53, x54, x55, x56, x57, x58, x59, x60, x61, x62, x63, x64, x65, x66, x67, x68, x69, x70, x71, x72, x73, x74, x75, x76, x77, x78, x79, x80, x81, x82, x83, x84, x85, x86, x87, x88, x89, x90, x91, x92, x93, x94, x95, x96, x97, x98, x99, x100: IN signed(7 DOWNTO 0);
    -- 	w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, w32, w33, w34, w35, w36, w37, w38, w39, w40, w41, w42, w43, w44, w45, w46, w47, w48, w49, w50, w51, w52, w53, w54, w55, w56, w57, w58, w59, w60, w61, w62, w63, w64, w65, w66, w67, w68, w69, w70, w71, w72, w73, w74, w75, w76, w77, w78, w79, w80, w81, w82, w83, w84, w85, w86, w87, w88, w89, w90, w91, w92, w93, w94, w95, w96, w97, w98, w99, w100: IN signed(7 DOWNTO 0);
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


    ARCHITECTURE behavior of neuron_comb_Barriers_LeakyReLU_100n_8bit_signed_mul0_add0_v0_v0 is
    
        COMPONENT MAC_comb_Barriers_100n_8bit_signed_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31, x32, x33, x34, x35, x36, x37, x38, x39, x40, x41, x42, x43, x44, x45, x46, x47, x48, x49, x50, x51, x52, x53, x54, x55, x56, x57, x58, x59, x60, x61, x62, x63, x64, x65, x66, x67, x68, x69, x70, x71, x72, x73, x74, x75, x76, x77, x78, x79, x80, x81, x82, x83, x84, x85, x86, x87, x88, x89, x90, x91, x92, x93, x94, x95, x96, x97, x98, x99, x100: IN signed(7 DOWNTO 0);
            w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, w32, w33, w34, w35, w36, w37, w38, w39, w40, w41, w42, w43, w44, w45, w46, w47, w48, w49, w50, w51, w52, w53, w54, w55, w56, w57, w58, w59, w60, w61, w62, w63, w64, w65, w66, w67, w68, w69, w70, w71, w72, w73, w74, w75, w76, w77, w78, w79, w80, w81, w82, w83, w84, w85, w86, w87, w88, w89, w90, w91, w92, w93, w94, w95, w96, w97, w98, w99, w100: IN signed(7 DOWNTO 0);
            bias: IN signed(7 DOWNTO 0) ; -- offset 
            ------------------------------------------ 
            output: OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
        END COMPONENT;                            
    
    -- #ROM_component

        SIGNAL out_reg_MAC : signed((7) DOWNTO 0);	--reg da saida do MAC

        SIGNAL reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10, reg_x11, reg_x12, reg_x13, reg_x14, reg_x15, reg_x16, reg_x17, reg_x18, reg_x19, reg_x20, reg_x21, reg_x22, reg_x23, reg_x24, reg_x25, reg_x26, reg_x27, reg_x28, reg_x29, reg_x30, reg_x31, reg_x32, reg_x33, reg_x34, reg_x35, reg_x36, reg_x37, reg_x38, reg_x39, reg_x40, reg_x41, reg_x42, reg_x43, reg_x44, reg_x45, reg_x46, reg_x47, reg_x48, reg_x49, reg_x50, reg_x51, reg_x52, reg_x53, reg_x54, reg_x55, reg_x56, reg_x57, reg_x58, reg_x59, reg_x60, reg_x61, reg_x62, reg_x63, reg_x64, reg_x65, reg_x66, reg_x67, reg_x68, reg_x69, reg_x70, reg_x71, reg_x72, reg_x73, reg_x74, reg_x75, reg_x76, reg_x77, reg_x78, reg_x79, reg_x80, reg_x81, reg_x82, reg_x83, reg_x84, reg_x85, reg_x86, reg_x87, reg_x88, reg_x89, reg_x90, reg_x91, reg_x92, reg_x93, reg_x94, reg_x95, reg_x96, reg_x97, reg_x98, reg_x99, reg_x100: signed(7 DOWNTO 0); 
        SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, reg_w11, reg_w12, reg_w13, reg_w14, reg_w15, reg_w16, reg_w17, reg_w18, reg_w19, reg_w20, reg_w21, reg_w22, reg_w23, reg_w24, reg_w25, reg_w26, reg_w27, reg_w28, reg_w29, reg_w30, reg_w31, reg_w32, reg_w33, reg_w34, reg_w35, reg_w36, reg_w37, reg_w38, reg_w39, reg_w40, reg_w41, reg_w42, reg_w43, reg_w44, reg_w45, reg_w46, reg_w47, reg_w48, reg_w49, reg_w50, reg_w51, reg_w52, reg_w53, reg_w54, reg_w55, reg_w56, reg_w57, reg_w58, reg_w59, reg_w60, reg_w61, reg_w62, reg_w63, reg_w64, reg_w65, reg_w66, reg_w67, reg_w68, reg_w69, reg_w70, reg_w71, reg_w72, reg_w73, reg_w74, reg_w75, reg_w76, reg_w77, reg_w78, reg_w79, reg_w80, reg_w81, reg_w82, reg_w83, reg_w84, reg_w85, reg_w86, reg_w87, reg_w88, reg_w89, reg_w90, reg_w91, reg_w92, reg_w93, reg_w94, reg_w95, reg_w96, reg_w97, reg_w98, reg_w99, reg_w100: signed(7 DOWNTO 0); 
        SIGNAL reg_bias : signed(7 DOWNTO 0);


    BEGIN
        
        -- MAC ja registra a saida 
	U_MAC : MAC_comb_Barriers_100n_8bit_signed_mul0_v0_add0_v0 PORT MAP(
            clk, rst, 
	    	reg_x1, reg_x2, reg_x3, reg_x4, reg_x5, reg_x6, reg_x7, reg_x8, reg_x9, reg_x10, reg_x11, reg_x12, reg_x13, reg_x14, reg_x15, reg_x16, reg_x17, reg_x18, reg_x19, reg_x20, reg_x21, reg_x22, reg_x23, reg_x24, reg_x25, reg_x26, reg_x27, reg_x28, reg_x29, reg_x30, reg_x31, reg_x32, reg_x33, reg_x34, reg_x35, reg_x36, reg_x37, reg_x38, reg_x39, reg_x40, reg_x41, reg_x42, reg_x43, reg_x44, reg_x45, reg_x46, reg_x47, reg_x48, reg_x49, reg_x50, reg_x51, reg_x52, reg_x53, reg_x54, reg_x55, reg_x56, reg_x57, reg_x58, reg_x59, reg_x60, reg_x61, reg_x62, reg_x63, reg_x64, reg_x65, reg_x66, reg_x67, reg_x68, reg_x69, reg_x70, reg_x71, reg_x72, reg_x73, reg_x74, reg_x75, reg_x76, reg_x77, reg_x78, reg_x79, reg_x80, reg_x81, reg_x82, reg_x83, reg_x84, reg_x85, reg_x86, reg_x87, reg_x88, reg_x89, reg_x90, reg_x91, reg_x92, reg_x93, reg_x94, reg_x95, reg_x96, reg_x97, reg_x98, reg_x99, reg_x100,
 	   	reg_w1, reg_w2, reg_w3, reg_w4, reg_w5, reg_w6, reg_w7, reg_w8, reg_w9, reg_w10, reg_w11, reg_w12, reg_w13, reg_w14, reg_w15, reg_w16, reg_w17, reg_w18, reg_w19, reg_w20, reg_w21, reg_w22, reg_w23, reg_w24, reg_w25, reg_w26, reg_w27, reg_w28, reg_w29, reg_w30, reg_w31, reg_w32, reg_w33, reg_w34, reg_w35, reg_w36, reg_w37, reg_w38, reg_w39, reg_w40, reg_w41, reg_w42, reg_w43, reg_w44, reg_w45, reg_w46, reg_w47, reg_w48, reg_w49, reg_w50, reg_w51, reg_w52, reg_w53, reg_w54, reg_w55, reg_w56, reg_w57, reg_w58, reg_w59, reg_w60, reg_w61, reg_w62, reg_w63, reg_w64, reg_w65, reg_w66, reg_w67, reg_w68, reg_w69, reg_w70, reg_w71, reg_w72, reg_w73, reg_w74, reg_w75, reg_w76, reg_w77, reg_w78, reg_w79, reg_w80, reg_w81, reg_w82, reg_w83, reg_w84, reg_w85, reg_w86, reg_w87, reg_w88, reg_w89, reg_w90, reg_w91, reg_w92, reg_w93, reg_w94, reg_w95, reg_w96, reg_w97, reg_w98, reg_w99, reg_w100, 
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
                   reg_x31 <= (OTHERS => '0');
                   reg_x32 <= (OTHERS => '0');
                   reg_x33 <= (OTHERS => '0');
                   reg_x34 <= (OTHERS => '0');
                   reg_x35 <= (OTHERS => '0');
                   reg_x36 <= (OTHERS => '0');
                   reg_x37 <= (OTHERS => '0');
                   reg_x38 <= (OTHERS => '0');
                   reg_x39 <= (OTHERS => '0');
                   reg_x40 <= (OTHERS => '0');
                   reg_x41 <= (OTHERS => '0');
                   reg_x42 <= (OTHERS => '0');
                   reg_x43 <= (OTHERS => '0');
                   reg_x44 <= (OTHERS => '0');
                   reg_x45 <= (OTHERS => '0');
                   reg_x46 <= (OTHERS => '0');
                   reg_x47 <= (OTHERS => '0');
                   reg_x48 <= (OTHERS => '0');
                   reg_x49 <= (OTHERS => '0');
                   reg_x50 <= (OTHERS => '0');
                   reg_x51 <= (OTHERS => '0');
                   reg_x52 <= (OTHERS => '0');
                   reg_x53 <= (OTHERS => '0');
                   reg_x54 <= (OTHERS => '0');
                   reg_x55 <= (OTHERS => '0');
                   reg_x56 <= (OTHERS => '0');
                   reg_x57 <= (OTHERS => '0');
                   reg_x58 <= (OTHERS => '0');
                   reg_x59 <= (OTHERS => '0');
                   reg_x60 <= (OTHERS => '0');
                   reg_x61 <= (OTHERS => '0');
                   reg_x62 <= (OTHERS => '0');
                   reg_x63 <= (OTHERS => '0');
                   reg_x64 <= (OTHERS => '0');
                   reg_x65 <= (OTHERS => '0');
                   reg_x66 <= (OTHERS => '0');
                   reg_x67 <= (OTHERS => '0');
                   reg_x68 <= (OTHERS => '0');
                   reg_x69 <= (OTHERS => '0');
                   reg_x70 <= (OTHERS => '0');
                   reg_x71 <= (OTHERS => '0');
                   reg_x72 <= (OTHERS => '0');
                   reg_x73 <= (OTHERS => '0');
                   reg_x74 <= (OTHERS => '0');
                   reg_x75 <= (OTHERS => '0');
                   reg_x76 <= (OTHERS => '0');
                   reg_x77 <= (OTHERS => '0');
                   reg_x78 <= (OTHERS => '0');
                   reg_x79 <= (OTHERS => '0');
                   reg_x80 <= (OTHERS => '0');
                   reg_x81 <= (OTHERS => '0');
                   reg_x82 <= (OTHERS => '0');
                   reg_x83 <= (OTHERS => '0');
                   reg_x84 <= (OTHERS => '0');
                   reg_x85 <= (OTHERS => '0');
                   reg_x86 <= (OTHERS => '0');
                   reg_x87 <= (OTHERS => '0');
                   reg_x88 <= (OTHERS => '0');
                   reg_x89 <= (OTHERS => '0');
                   reg_x90 <= (OTHERS => '0');
                   reg_x91 <= (OTHERS => '0');
                   reg_x92 <= (OTHERS => '0');
                   reg_x93 <= (OTHERS => '0');
                   reg_x94 <= (OTHERS => '0');
                   reg_x95 <= (OTHERS => '0');
                   reg_x96 <= (OTHERS => '0');
                   reg_x97 <= (OTHERS => '0');
                   reg_x98 <= (OTHERS => '0');
                   reg_x99 <= (OTHERS => '0');
                   reg_x100 <= (OTHERS => '0');

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
                   reg_w31 <= (OTHERS => '0');
                   reg_w32 <= (OTHERS => '0');
                   reg_w33 <= (OTHERS => '0');
                   reg_w34 <= (OTHERS => '0');
                   reg_w35 <= (OTHERS => '0');
                   reg_w36 <= (OTHERS => '0');
                   reg_w37 <= (OTHERS => '0');
                   reg_w38 <= (OTHERS => '0');
                   reg_w39 <= (OTHERS => '0');
                   reg_w40 <= (OTHERS => '0');
                   reg_w41 <= (OTHERS => '0');
                   reg_w42 <= (OTHERS => '0');
                   reg_w43 <= (OTHERS => '0');
                   reg_w44 <= (OTHERS => '0');
                   reg_w45 <= (OTHERS => '0');
                   reg_w46 <= (OTHERS => '0');
                   reg_w47 <= (OTHERS => '0');
                   reg_w48 <= (OTHERS => '0');
                   reg_w49 <= (OTHERS => '0');
                   reg_w50 <= (OTHERS => '0');
                   reg_w51 <= (OTHERS => '0');
                   reg_w52 <= (OTHERS => '0');
                   reg_w53 <= (OTHERS => '0');
                   reg_w54 <= (OTHERS => '0');
                   reg_w55 <= (OTHERS => '0');
                   reg_w56 <= (OTHERS => '0');
                   reg_w57 <= (OTHERS => '0');
                   reg_w58 <= (OTHERS => '0');
                   reg_w59 <= (OTHERS => '0');
                   reg_w60 <= (OTHERS => '0');
                   reg_w61 <= (OTHERS => '0');
                   reg_w62 <= (OTHERS => '0');
                   reg_w63 <= (OTHERS => '0');
                   reg_w64 <= (OTHERS => '0');
                   reg_w65 <= (OTHERS => '0');
                   reg_w66 <= (OTHERS => '0');
                   reg_w67 <= (OTHERS => '0');
                   reg_w68 <= (OTHERS => '0');
                   reg_w69 <= (OTHERS => '0');
                   reg_w70 <= (OTHERS => '0');
                   reg_w71 <= (OTHERS => '0');
                   reg_w72 <= (OTHERS => '0');
                   reg_w73 <= (OTHERS => '0');
                   reg_w74 <= (OTHERS => '0');
                   reg_w75 <= (OTHERS => '0');
                   reg_w76 <= (OTHERS => '0');
                   reg_w77 <= (OTHERS => '0');
                   reg_w78 <= (OTHERS => '0');
                   reg_w79 <= (OTHERS => '0');
                   reg_w80 <= (OTHERS => '0');
                   reg_w81 <= (OTHERS => '0');
                   reg_w82 <= (OTHERS => '0');
                   reg_w83 <= (OTHERS => '0');
                   reg_w84 <= (OTHERS => '0');
                   reg_w85 <= (OTHERS => '0');
                   reg_w86 <= (OTHERS => '0');
                   reg_w87 <= (OTHERS => '0');
                   reg_w88 <= (OTHERS => '0');
                   reg_w89 <= (OTHERS => '0');
                   reg_w90 <= (OTHERS => '0');
                   reg_w91 <= (OTHERS => '0');
                   reg_w92 <= (OTHERS => '0');
                   reg_w93 <= (OTHERS => '0');
                   reg_w94 <= (OTHERS => '0');
                   reg_w95 <= (OTHERS => '0');
                   reg_w96 <= (OTHERS => '0');
                   reg_w97 <= (OTHERS => '0');
                   reg_w98 <= (OTHERS => '0');
                   reg_w99 <= (OTHERS => '0');
                   reg_w100 <= (OTHERS => '0');
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
                         reg_x31 <= x31;
                         reg_x32 <= x32;
                         reg_x33 <= x33;
                         reg_x34 <= x34;
                         reg_x35 <= x35;
                         reg_x36 <= x36;
                         reg_x37 <= x37;
                         reg_x38 <= x38;
                         reg_x39 <= x39;
                         reg_x40 <= x40;
                         reg_x41 <= x41;
                         reg_x42 <= x42;
                         reg_x43 <= x43;
                         reg_x44 <= x44;
                         reg_x45 <= x45;
                         reg_x46 <= x46;
                         reg_x47 <= x47;
                         reg_x48 <= x48;
                         reg_x49 <= x49;
                         reg_x50 <= x50;
                         reg_x51 <= x51;
                         reg_x52 <= x52;
                         reg_x53 <= x53;
                         reg_x54 <= x54;
                         reg_x55 <= x55;
                         reg_x56 <= x56;
                         reg_x57 <= x57;
                         reg_x58 <= x58;
                         reg_x59 <= x59;
                         reg_x60 <= x60;
                         reg_x61 <= x61;
                         reg_x62 <= x62;
                         reg_x63 <= x63;
                         reg_x64 <= x64;
                         reg_x65 <= x65;
                         reg_x66 <= x66;
                         reg_x67 <= x67;
                         reg_x68 <= x68;
                         reg_x69 <= x69;
                         reg_x70 <= x70;
                         reg_x71 <= x71;
                         reg_x72 <= x72;
                         reg_x73 <= x73;
                         reg_x74 <= x74;
                         reg_x75 <= x75;
                         reg_x76 <= x76;
                         reg_x77 <= x77;
                         reg_x78 <= x78;
                         reg_x79 <= x79;
                         reg_x80 <= x80;
                         reg_x81 <= x81;
                         reg_x82 <= x82;
                         reg_x83 <= x83;
                         reg_x84 <= x84;
                         reg_x85 <= x85;
                         reg_x86 <= x86;
                         reg_x87 <= x87;
                         reg_x88 <= x88;
                         reg_x89 <= x89;
                         reg_x90 <= x90;
                         reg_x91 <= x91;
                         reg_x92 <= x92;
                         reg_x93 <= x93;
                         reg_x94 <= x94;
                         reg_x95 <= x95;
                         reg_x96 <= x96;
                         reg_x97 <= x97;
                         reg_x98 <= x98;
                         reg_x99 <= x99;
                         reg_x100 <= x100;

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
                         reg_w31 <= x31;
                         reg_w32 <= x32;
                         reg_w33 <= x33;
                         reg_w34 <= x34;
                         reg_w35 <= x35;
                         reg_w36 <= x36;
                         reg_w37 <= x37;
                         reg_w38 <= x38;
                         reg_w39 <= x39;
                         reg_w40 <= x40;
                         reg_w41 <= x41;
                         reg_w42 <= x42;
                         reg_w43 <= x43;
                         reg_w44 <= x44;
                         reg_w45 <= x45;
                         reg_w46 <= x46;
                         reg_w47 <= x47;
                         reg_w48 <= x48;
                         reg_w49 <= x49;
                         reg_w50 <= x50;
                         reg_w51 <= x51;
                         reg_w52 <= x52;
                         reg_w53 <= x53;
                         reg_w54 <= x54;
                         reg_w55 <= x55;
                         reg_w56 <= x56;
                         reg_w57 <= x57;
                         reg_w58 <= x58;
                         reg_w59 <= x59;
                         reg_w60 <= x60;
                         reg_w61 <= x61;
                         reg_w62 <= x62;
                         reg_w63 <= x63;
                         reg_w64 <= x64;
                         reg_w65 <= x65;
                         reg_w66 <= x66;
                         reg_w67 <= x67;
                         reg_w68 <= x68;
                         reg_w69 <= x69;
                         reg_w70 <= x70;
                         reg_w71 <= x71;
                         reg_w72 <= x72;
                         reg_w73 <= x73;
                         reg_w74 <= x74;
                         reg_w75 <= x75;
                         reg_w76 <= x76;
                         reg_w77 <= x77;
                         reg_w78 <= x78;
                         reg_w79 <= x79;
                         reg_w80 <= x80;
                         reg_w81 <= x81;
                         reg_w82 <= x82;
                         reg_w83 <= x83;
                         reg_w84 <= x84;
                         reg_w85 <= x85;
                         reg_w86 <= x86;
                         reg_w87 <= x87;
                         reg_w88 <= x88;
                         reg_w89 <= x89;
                         reg_w90 <= x90;
                         reg_w91 <= x91;
                         reg_w92 <= x92;
                         reg_w93 <= x93;
                         reg_w94 <= x94;
                         reg_w95 <= x95;
                         reg_w96 <= x96;
                         reg_w97 <= x97;
                         reg_w98 <= x98;
                         reg_w99 <= x99;
                         reg_w100 <= x100;

                       END IF;
                       reg_bias <= bias;
            END IF;
        END PROCESS;
    

    END behavior;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY neuron_comb_barriers_ReLU_3n_8bit_unsigned_mul0_add0_v0_v0 IS
    PORT (
        clk, rst : IN STD_LOGIC;
        x1, x2, x3 : IN signed(7 DOWNTO 0);
        w1, w2, w3 : IN signed(7 DOWNTO 0);
        bias : IN signed(7 DOWNTO 0); -- offset
        ------------------------------------------
        y : OUT signed (7 DOWNTO 0) --output  result
    );
    -- clk, rst, 
    -- inputs, 
    -- weigths, 
    -- bias, 
    -- output
END ENTITY;

ARCHITECTURE behavior OF neuron_comb_barriers_ReLU_3n_8bit_unsigned_mul0_add0_v0_v0 IS

    COMPONENT MAC_comb_barriers_3n_8bit_unsigned_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            x1, x2, x3 : IN signed(7 DOWNTO 0);
            w1, w2, w3 : IN signed(7 DOWNTO 0);
            bias : IN signed(7 DOWNTO 0); -- offset 
            ------------------------------------------ 
            output : OUT signed(7 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
    END COMPONENT;

    SIGNAL out_reg_MAC : signed ((7) DOWNTO 0); --reg da saida do MAC

    SIGNAL reg_x1, reg_x2, reg_x3 : unsigned(7 DOWNTO 0);
    SIGNAL reg_w1, reg_w2, reg_w3 : unsigned(7 DOWNTO 0);
    SIGNAL reg_bias : signed (7 DOWNTO 0);

BEGIN

    -- MAC ja registra a saida 
    U_MAC : MAC_comb_barriers_3n_8bit_unsigned_mul0_v0_add0_v0 PORT MAP(
        clk, rst,
        reg_x1, reg_x2, reg_x3,
        reg_w1, reg_w2, reg_w3,
        reg_bias,
        out_reg_MAC);

    reg_x1 <= x1;
    reg_x2 <= x2;
    reg_x3 <= x3;

    reg_w1 <= x1;
    reg_w2 <= x2;
    reg_w3 <= x3;
    reg_bias <= bias;

    PROCESS (clk)
    BEGIN
        IF clk'event AND clk = '1' THEN

            IF out_reg_MAC > 0 THEN -- ReLU = Mux
                y <= out_reg_MAC;
            ELSE
                y <= (OTHERS => '0');
            END IF;

        END IF;
    END PROCESS;

END behavior;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY neuron_comb_ReLU_5n_8bit_signed_mul0_v0_add0_v0 IS
    GENERIC (
        BITS : NATURAL := 8;
        NUM_INPUTS : NATURAL := 5
    );
    PORT (
        clk, rst, update_weights : IN STD_LOGIC;
        -- x1, x2, x3, x4, x5 : IN signed(7 DOWNTO 0);
        Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
        Win : IN signed(bits - 1 DOWNTO 0);
        -- bias : IN signed(7 DOWNTO 0);
        ----------------------------------------------
        Wout : OUT signed(BITS - 1 DOWNTO 0);
        y : OUT signed(7 DOWNTO 0)
        -- out_w1, out_w2, out_w3, out_w4, out_w5 : OUT signed(7 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE behavior OF neuron_comb_ReLU_5n_8bit_signed_mul0_v0_add0_v0 IS

    COMPONENT MAC_comb_5n_8bit_signed_mul0_v0_add0_v0 IS
        PORT (
            clk, rst : IN STD_LOGIC;
            -- x1, x2, x3, x4, x5 : IN signed(BITS - 1 DOWNTO 0);
            -- w1, w2, w3, w4, w5 : IN signed(BITS - 1 DOWNTO 0);
            -- bias : IN signed(BITS - 1 DOWNTO 0);
            Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
            Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
            ----------------------------------------------
            y : OUT signed(BITS - 1 DOWNTO 0)
        ); -- clk, rst, inputs, weigths, bias, output
    END COMPONENT;

    COMPONENT shift_reg IS
        GENERIC (
            BITS : NATURAL := BITS;
            NUM_INPUTS : NATURAL := NUM_INPUTS
        );
        PORT (
            clk, rst : IN STD_LOGIC;
            Win : IN signed(BITS - 1 DOWNTO 0);
            Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- # ROM_component
    SIGNAL out_reg_MAC : signed (BITS - 1 DOWNTO 0); --reg da saida do MAC

    SIGNAL reg_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
    -- SIGNAL reg_w1, reg_w2, reg_w3, reg_w4, reg_w5 : signed(7 DOWNTO 0);
    -- SIGNAL reg_bias : signed (7 DOWNTO 0);

    SIGNAL en_registers : STD_LOGIC; -- SHIFT_REGISTER
    SIGNAL s_Wout : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
BEGIN

    -- MAC ja registra a saida 
    U_MAC : MAC_comb_5n_8bit_signed_mul0_v0_add0_v0 PORT MAP(
        clk, rst,
        reg_Xi,
        s_Wout,
        -- s_Wout((BITS * (1)) - 1 DOWNTO (BITS * (0))), -- reg_w1
        -- s_Wout((BITS * (2)) - 1 DOWNTO (BITS * (1))), -- reg_w2
        -- s_Wout((BITS * (3)) - 1 DOWNTO (BITS * (2))), -- reg_w3
        -- s_Wout((BITS * (4)) - 1 DOWNTO (BITS * (3))), -- reg_w4
        -- s_Wout((BITS * (5)) - 1 DOWNTO (BITS * (4))), -- reg_w5
        -- s_Wout((BITS * (6)) - 1 DOWNTO (BITS * (5))), -- reg_bias
        out_reg_MAC);

    en_registers <= update_weights AND clk; -- SHIFT_REGISTER
    Wout <= s_Wout((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS + 0)));

    inst_shift_reg : shift_reg PORT MAP(-- SHIFT_REGISTER
        en_registers, rst,
        Win,
        s_Wout
    );

    PROCESS (clk, rst, update_weights)
    BEGIN
        IF rst = '1' THEN
            reg_Xi <= (OTHERS => '0');
            -- reg_x2 <= (OTHERS => '0');
            -- reg_x3 <= (OTHERS => '0');
            -- reg_x4 <= (OTHERS => '0');
            -- reg_x5 <= (OTHERS => '0');

            -- reg_w1 <= (OTHERS => '0');
            -- reg_w2 <= (OTHERS => '0');
            -- reg_w3 <= (OTHERS => '0');
            -- reg_w4 <= (OTHERS => '0');
            -- reg_w5 <= (OTHERS => '0');
            -- reg_bias <= (OTHERS => '0');

        ELSIF clk'event AND clk = '1' THEN
            reg_Xi <= Xi;

            IF out_reg_MAC > 0 THEN
                y <= out_reg_MAC;
            ELSE
                y <= (OTHERS => '0');
            END IF;

        END IF;
    END PROCESS;

END behavior;
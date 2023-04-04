
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;


ENTITY activation_fx IS
    GENERIC (
        BITS_FX_IN        : NATURAL := BITS_FX_IN;
        BITS_FX_OUT       : NATURAL := BITS_FX_OUT;
        ACTIVATION_TYPE   : NATURAL := 2; -- 0: ReLU, 1: Leaky ReLU, 2: Sigmoid
        Leaky_attenuation : NATURAL := Leaky_attenuation;
        Leaky_ReLU_ones   : signed  := Leaky_ReLU_ones
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        fx_in    : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out   : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch OF activation_fx IS

    -------------------- COMPONENTS --------------------

COMPONENT ReLU IS
    PORT (
        fx_in : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END COMPONENT;


COMPONENT Leaky_ReLU IS
    PORT (
        fx_in : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END COMPONENT;

    -- ROM
    COMPONENT ROM_fx_8bitaddr_8width IS
        PORT (
            address  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            ------------------------------------------
            data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
        -- input: address (8 bits)
        -- output: data_out (8 bits)
    END COMPONENT;
    -------------------- SIGNALS --------------------
    SIGNAL s_fx_out     : signed(BITS_FX_OUT - 1 DOWNTO 0);
    SIGNAL s_fx_out_std : STD_LOGIC_VECTOR(BITS_FX_OUT - 1 DOWNTO 0);
    SIGNAL fx_in_ROM    : signed(BITS - 1 DOWNTO 0);

BEGIN
    ReLU_inst : IF ACTIVATION_TYPE = 0 GENERATE
        ReLU_inst : ReLU PORT MAP(fx_in, s_fx_out);
    END GENERATE;

    Leaky_ReLU_inst : IF ACTIVATION_TYPE = 1 GENERATE
        Leaky_ReLU_inst : Leaky_ReLU PORT MAP(fx_in, s_fx_out);

    END GENERATE;

    Sigmoid_ROM_inst : IF ACTIVATION_TYPE = 2 GENERATE -- it's even
        -- BEGIN
        -- fx_in_ROM <= to_signed(to_integer(fx_in), fx_in_ROM'length); -- Numeric_std
        fx_in_ROM <= fx_in((2 * BITS) - 1 DOWNTO BITS);

        U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
            STD_LOGIC_VECTOR(fx_in_ROM),
            s_fx_out_std
        ); -- input: address (8), output: data_out (8)
        -- END PROCESS fx_activation_inst;
        s_fx_out <= signed(s_fx_out_std);
    END GENERATE;

    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            fx_out <= (OTHERS => '0');
        ELSE
            IF clk'event AND clk = '1' THEN
                fx_out <= s_fx_out;
            END IF;
        END IF;

    END PROCESS;

END ARCHITECTURE;
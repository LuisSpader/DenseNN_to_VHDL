LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY Leaky_ReLU IS
    PORT (
        fx_in : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END Leaky_ReLU;

ARCHITECTURE rtl OF Leaky_ReLU IS

BEGIN

    PROCESS (fx_in)
    BEGIN
        IF fx_in > 0 THEN -- X > 0
            -- fx_out <= fx_in;
            IF fx_in > signed_max_2xbit THEN
                fx_out <= to_signed(to_integer(signed_max), fx_out'length);
            ELSE
                fx_out <= to_signed(to_integer(fx_in), fx_out'length); -- Numeric_std

            END IF;

        ELSE -- X < 0
            -- fx_out <= (OTHERS => '0');
            fx_out <= signed((Leaky_ReLU_ones & fx_in(BITS_FX_IN - 1 DOWNTO Leaky_attenuation)));

        END IF;
    END PROCESS;

END ARCHITECTURE;
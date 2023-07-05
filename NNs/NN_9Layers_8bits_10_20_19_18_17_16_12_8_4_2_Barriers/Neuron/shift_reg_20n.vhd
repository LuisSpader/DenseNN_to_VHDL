
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY shift_reg_20n IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 20
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        W_in : IN signed(BITS - 1 DOWNTO 0);
        -- w1, w2, w3, w4, w5 : OUT signed(7 DOWNTO 0)
        W_out : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF shift_reg_20n IS
    ------------------------------- SIGNALS --------------------------------
    SIGNAL s_shift_reg : signed (BITS * (NUM_INPUTS + 1 + 1) -1 DOWNTO 0);

    ------------------------------ COMPONENTS ------------------------------
    COMPONENT Reg IS
        PORT (
            clk, rst : IN STD_LOGIC;
            D : IN signed (BITS - 1 DOWNTO 0);
            Q : OUT signed (BITS - 1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    s_shift_reg(BITS - 1 DOWNTO 0) <= W_in;

    loop_port_map : FOR i IN 1 TO ((NUM_INPUTS + 1)) GENERATE
        Reg_inst_loop : Reg
        PORT MAP(
            clk => clk,
            rst => rst,
            D => s_shift_reg((BITS * (i + 0)) - 1 DOWNTO (BITS * (i - 1))),
            Q => s_shift_reg((BITS * (i + 1)) - 1 DOWNTO (BITS * (i + 0)))
        );
    END GENERATE;

    W_out <= s_shift_reg( (BITS *(NUM_INPUTS + 1 + 1)) -1 DOWNTO (BITS * (1)) );

END ARCHITECTURE;
    
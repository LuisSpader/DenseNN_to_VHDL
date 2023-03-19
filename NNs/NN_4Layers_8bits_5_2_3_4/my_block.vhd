LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY my_block IS
    PORT (
        input_1, input_2 : IN STD_LOGIC_VECTOR (8 - 1 DOWNTO 0);
        output           : OUT STD_LOGIC_VECTOR(16 - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF my_block IS
BEGIN
    output <= input_1;
END ARCHITECTURE;

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE work.parameters.ALL;

  ENTITY add0_v0 IS
      GENERIC (
          BITS : NATURAL := 8
      );
      PORT (
          X : IN signed((BITS) - 1 DOWNTO 0);
          W : IN signed((BITS) - 1 DOWNTO 0);
          Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
      );
  END ENTITY;

  ARCHITECTURE rtl OF add0_v0 IS
  BEGIN
      Y <= X * W;
  END ARCHITECTURE;
  
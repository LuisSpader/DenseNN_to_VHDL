LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  neuron_comb_Barriers_ReLU_4n_8bit_signed_mult0_add0_v0_v0 IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 4;
        TOTAL_BITS : NATURAL := 32
    );
    PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(BITS -1 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE behavior of neuron_comb_Barriers_ReLU_4n_8bit_signed_mult0_add0_v0_v0 is
  COMPONENT  MAC_comb_Barriers_4n_8bit_signed_mult0_v0_add0_v0 IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 4;
        TOTAL_BITS : NATURAL := 32
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in  : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(BITS -1 DOWNTO 0)
    );
  end COMPONENT;

    COMPONENT shift_reg_4n IS
        GENERIC (
            BITS : NATURAL := BITS;
            NUM_INPUTS : NATURAL := NUM_INPUTS
        );
        PORT (
            clk, rst : IN STD_LOGIC;
            W_in : IN signed(BITS - 1 DOWNTO 0);
            -- Win : IN signed(BITS - 1 DOWNTO 0);
            W_out : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
        );
    END COMPONENT;
        
    -- # ROM_component
    SIGNAL out_reg_MAC : signed (BITS-1 DOWNTO 0);	--reg da saida do MAC
    SIGNAL s_Wout : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN

        -- MAC ja registra a saida 
    U_MAC : MAC_comb_Barriers_4n_8bit_signed_mult0_v0_add0_v0 PORT MAP(
        clk, rst,
        IO_in,
        s_Wout,
        out_reg_MAC );
        inst_shift_reg : shift_reg_4n PORT MAP(update_weights, rst, W_in , s_Wout );
IO_out <= out_reg_MAC;
END behavior;
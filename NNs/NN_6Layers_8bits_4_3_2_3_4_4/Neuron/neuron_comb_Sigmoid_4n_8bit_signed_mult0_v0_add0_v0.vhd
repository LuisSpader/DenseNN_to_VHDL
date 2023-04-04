LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  neuron_comb_Sigmoid_4n_8bit_signed_mult0_v0_add0_v0 IS
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


ARCHITECTURE behavior of neuron_comb_Sigmoid_4n_8bit_signed_mult0_v0_add0_v0 is
------------- COMPONENTS -------------
  COMPONENT  MAC_comb_4n_8bit_signed_mult0_v0_add0_v0 IS
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
      IO_out: OUT signed((MAC_OUT_BITS_rescale*BITS) -1 DOWNTO 0)
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
        

COMPONENT activation_fx IS
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
END COMPONENT;
--------------- SIGNALS --------------

    SIGNAL out_reg_MAC : signed ((2*BITS)-1 DOWNTO 0);	--reg da saida do MAC
    SIGNAL out_ROM_act : STD_LOGIC_VECTOR( 7 DOWNTO 0); --saida da ROM
    SIGNAL s_Wout : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN

        -- MAC ja registra a saida 
    U_MAC : MAC_comb_4n_8bit_signed_mult0_v0_add0_v0 PORT MAP(
        clk, rst,
        IO_in,
        s_Wout,
        out_reg_MAC );
        inst_shift_reg : shift_reg_4n PORT MAP(update_weights, rst, W_in , s_Wout );


    fx_activation_inst : activation_fx PORT MAP(
    clk, rst,
    out_reg_MAC,
    IO_out
    );

END behavior;
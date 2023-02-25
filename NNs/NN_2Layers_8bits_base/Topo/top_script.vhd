LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY IS
    GENERIC (
        BITS       : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 3;
        TOTAL_BITS : NATURAL := 24
    );
    PORT (
        clk, rst, update_weights                           : IN STD_LOGIC;
        Xi                                                 : IN signed(TOTAL_BITS - 1 DOWNTO 0);
        top_n0_Win, top_n1_Win, top_n2_Win, top_n3_Win     : IN signed(BITS - 1 DOWNTO 0);
        ----------------------------------------------
        top_n0_y, top_n1_y, top_n2_y, top_n3_y             : OUT signed(7 DOWNTO 0);
        top_n0_Wout, top_n1_Wout, top_n2_Wout, top_n3_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch OF IS
BEGIN

    neuron_inst_0 : ENTITY work.neuron_ReLU_3n
        PORT MAP(
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC']
            clk            => clk,
            rst            => rst,
            update_weights => update_weights,
            -- ['IN']['manual']
            Xi             => Xi,
            Win            => top_n0_Win,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED']
            y              => top_n0_y,
            -- ['OUT']['manual']
            Wout           => top_n0_Wout
        );

    neuron_inst_1 : ENTITY work.neuron_ReLU_3n
        PORT MAP(
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC']
            clk            => clk,
            rst            => rst,
            update_weights => update_weights,
            -- ['IN']['manual']
            Xi             => Xi,
            Win            => top_n1_Win,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED']
            y              => top_n1_y,
            -- ['OUT']['manual']
            Wout           => top_n1_Wout
        );

    neuron_inst_2 : ENTITY work.neuron_ReLU_3n
        PORT MAP(
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC']
            clk            => clk,
            rst            => rst,
            update_weights => update_weights,
            -- ['IN']['manual']
            Xi             => Xi,
            Win            => top_n2_Win,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED']
            y              => top_n2_y,
            -- ['OUT']['manual']
            Wout           => top_n2_Wout
        );

    neuron_inst_3 : ENTITY work.neuron_ReLU_3n
        PORT MAP(
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC']
            clk            => clk,
            rst            => rst,
            update_weights => update_weights,
            -- ['IN']['manual']
            Xi             => Xi,
            Win            => top_n3_Win,
            ---------- Saidas ----------
            -- ['OUT']['SIGNED']
            y              => top_n3_y,
            -- ['OUT']['manual']
            Wout           => top_n3_Wout
        );

END ARCHITECTURE;
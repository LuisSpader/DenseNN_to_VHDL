
# bits = 8
# num_inputs = 3
# ----------


import os


def shift_reg_gen(num_inputs: int, reg_name: str = 'Reg', shift_reg_name: str = 'shift_reg'):
    reg_txt = (f'''
    LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.parameters.ALL;

    ENTITY {reg_name} IS
        GENERIC (
            BITS : NATURAL := BITS
        );
        PORT (
            clk, rst : IN STD_LOGIC;
            D : IN signed (BITS - 1 DOWNTO 0);
            Q : OUT signed (BITS - 1 DOWNTO 0)
        );
    END ENTITY;

    ARCHITECTURE rtl OF {reg_name} IS
        SIGNAL data : signed (BITS - 1 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        Q <= data;

        CLK_PROC : PROCESS (clk, rst)
        BEGIN
            IF rst = '1' THEN
                data <= (OTHERS => '0');
            ELSE
                IF clk'event AND (clk = '1') THEN
                    data <= D;
                END IF;
            END IF;
        END PROCESS;
    END ARCHITECTURE;
    ''')
    shift_reg_name = f"{shift_reg_name}_{num_inputs}n"

    shift_reg_txt = (f'''
    LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.parameters.ALL;

    ENTITY {shift_reg_name} IS
        GENERIC (
            BITS : NATURAL := BITS;
            NUM_INPUTS : NATURAL := {num_inputs}
        );
        PORT (
            clk, rst : IN STD_LOGIC;
            W_in : IN signed(BITS - 1 DOWNTO 0);
            -- w1, w2, w3, w4, w5 : OUT signed(7 DOWNTO 0)
            W_out : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
        );
    END ENTITY;

    ARCHITECTURE rtl OF {shift_reg_name} IS
        SIGNAL s_shift_reg : signed (BITS * (NUM_INPUTS + 1) - 1 DOWNTO 0);

        COMPONENT {reg_name} IS
            PORT (
                clk, rst : IN STD_LOGIC;
                D : IN signed (BITS - 1 DOWNTO 0);
                Q : OUT signed (BITS - 1 DOWNTO 0)
            );
        END COMPONENT;

    BEGIN
        s_shift_reg(BITS - 1 DOWNTO 0) <= W_in;
        -- W_out <= s_shift_reg((BITS * (NUM_INPUTS)) - 1 DOWNTO (BITS * (NUM_INPUTS - 1)));

        loop_port_map : FOR i IN 1 TO ((NUM_INPUTS + 1) - 1) GENERATE
            Reg_inst_loop : {reg_name}
            PORT MAP(
                clk => clk,
                rst => rst,
                D => s_shift_reg((BITS * (i + 0)) - 1 DOWNTO (BITS * (i - 1))),
                Q => s_shift_reg((BITS * (i + 1)) - 1 DOWNTO (BITS * (i + 0)))
            );
        END GENERATE;

        W_out <= s_shift_reg;

    END ARCHITECTURE;
    ''')
    # print(reg_txt)
    return reg_txt, shift_reg_txt, reg_name, shift_reg_name


# def parameters_vhd_gen
# parameters_vhd_name = 'parameters'
# path: str = "./"
# bits = 8
# -----


def parameters_vhd_gen(
    bits: int,
    # layer_dict: dict = {},
    parameters_vhd_name: str = 'parameters',
    OUTPUT_BASE_DIR_PATH: str = "./",
    create_path_folder: bool = False
):
    # bits = layer_dict['BIT_WIDTH']

    parameters_vhd_txt = (f'''
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE {parameters_vhd_name} IS
    CONSTANT BITS : INTEGER := {bits}; --You need to change this depending on each desired input/output BITS
    CONSTANT ones : STD_LOGIC_VECTOR (BITS - 1 DOWNTO 0) := (OTHERS => '1'); --"0000..."

END {parameters_vhd_name};
PACKAGE BODY {parameters_vhd_name} IS
END {parameters_vhd_name};''')

    if create_path_folder:
        os.makedirs(f"{OUTPUT_BASE_DIR_PATH}", exist_ok=True)  # softmax layer
        print(f"create_folder_neuron() -> Created: {OUTPUT_BASE_DIR_PATH}")

    with open(f"{OUTPUT_BASE_DIR_PATH}/{parameters_vhd_name}.vhd", "w") as writer:
        writer.write(parameters_vhd_txt)  # download MAC

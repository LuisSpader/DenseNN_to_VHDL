LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL; -- para tratamento de arquivos e textoÂ ->Â file_open...  
USE work.parameters.ALL;

ENTITY tb_top IS
    GENERIC (
        BITS       : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 5;
        TOTAL_BITS : NATURAL := 40
    );
END tb_top;

ARCHITECTURE tb OF tb_top IS
    SIGNAL clk, rst, update_weights                                   : STD_LOGIC;
    -- SIGNAL IO_in                                                      : signed(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    -- SIGNAL buff_in                                                    : STD_LOGIC_VECTOR(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    SIGNAL IO_in                                                      : signed(TOTAL_BITS - 1 DOWNTO 0);
    SIGNAL buff_in                                                    : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0);
    -- ======== Pesos & Bias ========
    SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in : signed(BITS - 1 DOWNTO 0);
    -- Saidas ultima camada
    SIGNAL c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out     : signed(BITS - 1 DOWNTO 0);
    SIGNAL buff_out                                                   : STD_LOGIC_VECTOR(((2) * BITS) - 1 DOWNTO 0);
    -- SIGNAL buff_out_signed : STD_LOGIC_VECTOR(((2) * BITS) - 1 DOWNTO 0);

    CONSTANT sigmoid_read_time                                        : TIME := 16 * clk_period;
    FILE weights_file                                                 : text OPEN read_mode IS "C:\Users\luisa\OneDrive\Não importante\Documentos\GitHub\DenseNN_to_VHDL\NNs\NN_4Layers_8bits_5_2_3_4\tb_Files/weights_bin.txt";
    FILE inputs_file                                                  : text OPEN read_mode IS "C:\Users\luisa\OneDrive\Não importante\Documentos\GitHub\DenseNN_to_VHDL\NNs\NN_4Layers_8bits_5_2_3_4\tb_Files/inputs_string.txt";

BEGIN
    -- Read weights from file and assign them to input ports
    read(weights_file, c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in);

    -- port map do componente 'top.vhd'
    UUT : ENTITY work.top PORT MAP
        (clk           => clk,
        rst            => rst,
        update_weights => update_weights,
        IO_in          => IO_in,
        c0_n0_W_in     => c0_n0_W_in,
        c0_n1_W_in     => c0_n1_W_in,
        c0_n2_W_in     => c0_n2_W_in,
        c0_n3_W_in     => c0_n3_W_in,
        c0_n4_W_in     => c0_n4_W_in,
        c3_n0_IO_out   => c3_n0_IO_out,
        c3_n1_IO_out   => c3_n1_IO_out,
        c3_n2_IO_out   => c3_n2_IO_out,
        c3_n3_IO_out   => c3_n3_IO_out
        );

    -- processo gerador de clock
    clk_gen : PROCESS
        --constant period: time := 20 ns;
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
END tb;
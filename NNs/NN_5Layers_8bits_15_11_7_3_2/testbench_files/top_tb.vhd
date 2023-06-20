LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL; -- para tratamento de arquivos e texto-> file_open...  
USE work.parameters.ALL;
ENTITY top_tb IS

GENERIC (
    BITS: NATURAL := 8; 
    NUM_INPUTS: NATURAL := 19; 
    TOTAL_BITS: NATURAL := 152
);
  
END top_tb;
ARCHITECTURE tb OF top_tb IS
    CONSTANT clk_hz                                                   : INTEGER                                     := 100e6;
    CONSTANT clk_period                                               : TIME                                        := 1 sec / clk_hz;
    SIGNAL buff_out                                                   : STD_LOGIC_VECTOR(((4) * BITS) - 1 DOWNTO 0) := (OTHERS => '0');
    CONSTANT sigmoid_read_time                                        : TIME                                        := 16 * clk_period;
    -- SIGNAL clk, rst, update_weights                                   : STD_LOGIC                                   := '0';
    -- SIGNAL IO_in                                                      : signed(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    -- SIGNAL buff_in                                                    : STD_LOGIC_VECTOR(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
   SIGNAL clk, rst, update_weights:  STD_LOGIC;
   SIGNAL IO_in:  signed(TOTAL_BITS - 1 DOWNTO 0);
   SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in:  signed(BITS - 1 DOWNTO 0);
   SIGNAL c4_n0_IO_out, c4_n1_IO_out:  signed(BITS -1 DOWNTO 0);
BEGIN
    -- port map do componente 'top.vhd'
        UUT : ENTITY work.top PORT MAP(
            clk => clk,
            rst => rst,
            update_weights => update_weights,
            IO_in => IO_in,
            c0_n0_W_in => c0_n0_W_in,
            c0_n1_W_in => c0_n1_W_in,
            c0_n2_W_in => c0_n2_W_in,
            c0_n3_W_in => c0_n3_W_in,
            c0_n4_W_in => c0_n4_W_in,
            c0_n5_W_in => c0_n5_W_in,
            c0_n6_W_in => c0_n6_W_in,
            c0_n7_W_in => c0_n7_W_in,
            c0_n8_W_in => c0_n8_W_in,
            c0_n9_W_in => c0_n9_W_in,
            c0_n10_W_in => c0_n10_W_in,
            c0_n11_W_in => c0_n11_W_in,
            c0_n12_W_in => c0_n12_W_in,
            c0_n13_W_in => c0_n13_W_in,
            c0_n14_W_in => c0_n14_W_in,
            c4_n0_IO_out => c4_n0_IO_out,
            c4_n1_IO_out => c4_n1_IO_out
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
    -- processo para leitura das entradas e escrita das saidas
    file_io : PROCESS
        --SIGNALS AND VARIABLES
        VARIABLE read_col_from_input_buf                                         : line; -- buffers de entrada e saida
        FILE input_buf                                                           : text; --text is keyword ->??
        VARIABLE read_col_from_sigmoid_buf                                       : line;
        FILE NN_weights_buff                                                     : text; --text is keyword -->??
        VARIABLE write_col_to_output_buf                                         : line;
        FILE output_buf                                                          : text; --text is keyword -->??
        VARIABLE val_address                                                     : STD_LOGIC_VECTOR(bits - 1 DOWNTO 0)       := (OTHERS => '0');
        VARIABLE val_c0_n0_W_in, val_c0_n1_W_in, val_c0_n2_W_in, val_c0_n3_W_in, val_c0_n4_W_in, val_c0_n5_W_in, val_c0_n6_W_in, val_c0_n7_W_in, val_c0_n8_W_in, val_c0_n9_W_in, val_c0_n10_W_in, val_c0_n11_W_in, val_c0_n12_W_in, val_c0_n13_W_in, val_c0_n14_W_in: STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        -- VARIABLE val_n0_IO_in, val_n1_IO_in, val_n2_IO_in, val_n3_IO_in, val_n4_IO_in : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_IO_in: STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_SPACE                                                       : CHARACTER;                                                    -- espacos da leitura de cada linha de entrada
    BEGIN
        -------------------- ATUALIZACAO DOS PESOS DA NN --------------------
        file_open(NN_weights_buff, "./NNs/NN_5Layers_8bits_15_11_7_3_2/testbench_files/weights_bin.txt", read_mode);
        rst <= '1', '0' AFTER clk_period;
        WAIT UNTIL rst = '0';                   -- espera rst desligar
        WHILE NOT endfile(NN_weights_buff) LOOP --enquanto arquivo nao terminar de ler
            update_weights <= '1';
            readline(NN_weights_buff, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel

            read(read_col_from_input_buf, val_c0_n0_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n1_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n2_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n3_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n4_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n5_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n6_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n7_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n8_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n9_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n10_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n11_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n12_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n13_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c0_n14_W_in);
            read(read_col_from_input_buf, val_SPACE);

            -- Pass the read values to signals
            c0_n0_W_in <= signed(val_c0_n0_W_in);
            c0_n1_W_in <= signed(val_c0_n1_W_in);
            c0_n2_W_in <= signed(val_c0_n2_W_in);
            c0_n3_W_in <= signed(val_c0_n3_W_in);
            c0_n4_W_in <= signed(val_c0_n4_W_in);
            c0_n5_W_in <= signed(val_c0_n5_W_in);
            c0_n6_W_in <= signed(val_c0_n6_W_in);
            c0_n7_W_in <= signed(val_c0_n7_W_in);
            c0_n8_W_in <= signed(val_c0_n8_W_in);
            c0_n9_W_in <= signed(val_c0_n9_W_in);
            c0_n10_W_in <= signed(val_c0_n10_W_in);
            c0_n11_W_in <= signed(val_c0_n11_W_in);
            c0_n12_W_in <= signed(val_c0_n12_W_in);
            c0_n13_W_in <= signed(val_c0_n13_W_in);
            c0_n14_W_in <= signed(val_c0_n14_W_in);
            -- WAIT FOR (2 * clk_period);
            WAIT FOR (1 * clk_period);
        END LOOP;                    --END: ATUALIZACAO DOS PESOS DA NN
        file_close(NN_weights_buff); --fecha leitura arquivo dos pesos da NN
        update_weights <= '0';
        -------------------- LEITURA ENTRADA E ESCRITA NO ARQUIVO DE SAIDA -------------------- 
        WAIT FOR (sigmoid_read_time);
        -- arquivo de entrada do tb:
        file_open(input_buf, "./NNs/NN_5Layers_8bits_15_11_7_3_2/testbench_files/tb_inputs.txt", read_mode);
        -- arquivo de saida do tb:
        file_open(output_buf, "./NNs/NN_5Layers_8bits_15_11_7_3_2/testbench_files/tb_outputs.txt", write_mode);
        WHILE NOT endfile(input_buf) LOOP             --enquanto arquivo nao terminar de ler
            readline(input_buf, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
            read(read_col_from_input_buf, val_IO_in);
            read(read_col_from_input_buf, val_SPACE);
            IO_in    <= signed(val_IO_in);
            buff_out <= STD_LOGIC_VECTOR(c4_n0_IO_out & c4_n1_IO_out);
            WAIT FOR (5 * clk_period);
            write(write_col_to_output_buf, buff_out);         --Pega valor da saida e associa ao sinal
            writeline(output_buf, write_col_to_output_buf);   --Escreve valor da saida (do sinal) no arquivo de texto
        END LOOP;                                         --END: LEITURA ENTRADA E ESCRITA NO ARQUIVO DE SAIDA----
        write(write_col_to_output_buf, STRING'(" END!")); --para confirmar que saiu do loop e estah tudo ok
        writeline(output_buf, write_col_to_output_buf);
        file_close(input_buf);  --fecha leitura arquivo INPUTS
        file_close(output_buf); --fecha arquivo OUTPUTS
        WAIT;                   --sem ele nd funciona; -->Pq??
    END PROCESS;
END tb;

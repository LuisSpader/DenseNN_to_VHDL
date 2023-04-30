-- nome do topo
-- IOs do topo
-- 	gerar sinais das IO
-- 		VARIABLE val_W_in
-- 		VARIABLE val_IO_in

-- path: weights_bin.txt
-- path: tb_inputs.txt
-- path: tb_outputs.txt

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
    CONSTANT clk_hz                                                   : INTEGER                                     := 100e6;
    CONSTANT clk_period                                               : TIME                                        := 1 sec / clk_hz;
    SIGNAL clk, rst, update_weights                                   : STD_LOGIC                                   := '0';
    -- SIGNAL IO_in                                                      : signed(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    -- SIGNAL buff_in                                                    : STD_LOGIC_VECTOR(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    SIGNAL IO_in                                                      : signed(TOTAL_BITS - 1 DOWNTO 0)             := (OTHERS => '0');
    -- ======== Pesos & Bias ========
    SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in : signed(BITS - 1 DOWNTO 0)                   := (OTHERS => '0');
    -- Saidas ultima camada
    SIGNAL c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out     : signed(BITS - 1 DOWNTO 0)                   := (OTHERS => '0');
    SIGNAL buff_out                                                   : STD_LOGIC_VECTOR(((4) * BITS) - 1 DOWNTO 0) := (OTHERS => '0');
    -- SIGNAL buff_out_signed : STD_LOGIC_VECTOR(((2) * BITS) - 1 DOWNTO 0);

    CONSTANT sigmoid_read_time                                        : TIME                                        := 16 * clk_period;

BEGIN
    -- port map do componente 'top.vhd'
    UUT : ENTITY work.top PORT MAP(
        clk            => clk,
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
        VARIABLE val_n0_W_in, val_n1_W_in, val_n2_W_in, val_n3_W_in, val_n4_W_in : STD_LOGIC_VECTOR(8 - 1 DOWNTO 0)          := (OTHERS => '0'); --signal 
        -- VARIABLE val_n0_IO_in, val_n1_IO_in, val_n2_IO_in, val_n3_IO_in, val_n4_IO_in : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_IO_in                                                       : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 

        VARIABLE val_SPACE                                                       : CHARACTER;                                                    -- espacos da leitura de cada linha de entrada

    BEGIN
        -- report "path: " & path 
        -------------------- ATUALIZACAO DOS PESOS DA NN --------------------
        file_open(NN_weights_buff, "C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\NNs\NN_4Layers_8bits_5_2_3_4\tb_Files/weights_bin.txt", read_mode);
        -- file_open(NN_weights_buff, "./tb_Files/weights_bin.txt", read_mode);

        rst <= '1', '0' AFTER clk_period;

        WAIT UNTIL rst = '0';                   -- espera rst desligar

        WHILE NOT endfile(NN_weights_buff) LOOP --enquanto arquivo nao terminar de ler
            update_weights <= '1';

            readline(NN_weights_buff, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
            read(read_col_from_input_buf, val_n0_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_n1_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_n2_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_n3_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_n4_W_in);
            read(read_col_from_input_buf, val_SPACE);
            -- Pass the read values to signals
            c0_n0_W_in <= signed(val_n0_W_in);
            c0_n1_W_in <= signed(val_n1_W_in);
            c0_n2_W_in <= signed(val_n2_W_in);
            c0_n3_W_in <= signed(val_n3_W_in);
            c0_n4_W_in <= signed(val_n4_W_in);
            -- WAIT FOR (2 * clk_period);
            WAIT FOR (1 * clk_period);

        END LOOP;                    --END: ATUALIZACAO DOS PESOS DA NN
        file_close(NN_weights_buff); --fecha leitura arquivo dos pesos da NN
        update_weights <= '0';

        -------------------- LEITURA ENTRADA E ESCRITA NO ARQUIVO DE SAIDA -------------------- 
        WAIT FOR (sigmoid_read_time);
        -- arquivo de entrada do tb:
        file_open(input_buf, "C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\NNs\NN_4Layers_8bits_5_2_3_4\tb_Files/tb_inputs.txt", read_mode);
        -- file_open(input_buf, "./Files/tb_inputs.txt", read_mode);

        -- arquivo de saida do tb:
        file_open(output_buf, "C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\NNs\NN_4Layers_8bits_5_2_3_4\tb_Files/tb_outputs.txt", write_mode);
        -- file_open(output_buf, "./Files/tb_outputs.txt", write_mode);

        WHILE NOT endfile(input_buf) LOOP             --enquanto arquivo nao terminar de ler
            readline(input_buf, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
            -- read(read_col_from_input_buf, val_n0_IO_in);
            -- read(read_col_from_input_buf, val_SPACE);

            -- read(read_col_from_input_buf, val_n1_IO_in);
            -- read(read_col_from_input_buf, val_SPACE);

            -- read(read_col_from_input_buf, val_n2_IO_in);
            -- read(read_col_from_input_buf, val_SPACE);

            -- read(read_col_from_input_buf, val_n3_IO_in);
            -- read(read_col_from_input_buf, val_SPACE);

            -- read(read_col_from_input_buf, val_n4_IO_in);
            -- read(read_col_from_input_bu1f, val_SPACE);

            -- buff_in  <= val_n0_IO_in & val_n1_IO_in & val_n2_IO_in & val_n3_IO_in & val_n4_IO_in;
            -- -- Pass the read values to signals
            -- IO_in    <= signed(buff_in);

            read(read_col_from_input_buf, val_IO_in);
            read(read_col_from_input_buf, val_SPACE);
            IO_in    <= signed(val_IO_in);

            buff_out <= STD_LOGIC_VECTOR(c3_n0_IO_out & c3_n1_IO_out & c3_n2_IO_out & c3_n3_IO_out);

            WAIT FOR (5 * clk_period);

            -- buff_out <= STD_LOGIC_VECTOR(c3_n0_IO_out & c3_n0_IO_out);

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
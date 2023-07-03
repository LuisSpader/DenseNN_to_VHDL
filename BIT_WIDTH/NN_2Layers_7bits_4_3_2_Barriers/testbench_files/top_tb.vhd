LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL; -- para tratamento de arquivos e texto-> file_open...  
USE work.parameters.ALL;
ENTITY top_tb IS

GENERIC (
    BITS: NATURAL := 8; 
    NUM_INPUTS: NATURAL := 4; 
    TOTAL_BITS: NATURAL := 28
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
   SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in:  signed(BITS - 1 DOWNTO 0);
   SIGNAL c1_n0_IO_out, c1_n1_IO_out:  signed(BITS -1 DOWNTO 0);
   SIGNAL c
   SIGNAL l
   SIGNAL k
   SIGNAL ,
   SIGNAL  
   SIGNAL r
   SIGNAL s
   SIGNAL t
   SIGNAL ,
   SIGNAL  
   SIGNAL u
   SIGNAL p
   SIGNAL d
   SIGNAL a
   SIGNAL t
   SIGNAL e
   SIGNAL _
   SIGNAL w
   SIGNAL e
   SIGNAL i
   SIGNAL g
   SIGNAL h
   SIGNAL t
   SIGNAL s
   SIGNAL :
   SIGNAL  
   SIGNAL  
   SIGNAL S
   SIGNAL T
   SIGNAL D
   SIGNAL _
   SIGNAL L
   SIGNAL O
   SIGNAL G
   SIGNAL I
   SIGNAL C
   SIGNAL ;
   SIGNAL I
   SIGNAL O
   SIGNAL _
   SIGNAL i
   SIGNAL n
   SIGNAL :
   SIGNAL  
   SIGNAL  
   SIGNAL s
   SIGNAL i
   SIGNAL g
   SIGNAL n
   SIGNAL e
   SIGNAL d
   SIGNAL (
   SIGNAL T
   SIGNAL O
   SIGNAL T
   SIGNAL A
   SIGNAL L
   SIGNAL _
   SIGNAL B
   SIGNAL I
   SIGNAL T
   SIGNAL S
   SIGNAL  
   SIGNAL -
   SIGNAL  
   SIGNAL 1
   SIGNAL  
   SIGNAL D
   SIGNAL O
   SIGNAL W
   SIGNAL N
   SIGNAL T
   SIGNAL O
   SIGNAL  
   SIGNAL 0
   SIGNAL )
   SIGNAL ;
   SIGNAL c
   SIGNAL 0
   SIGNAL _
   SIGNAL n
   SIGNAL 0
   SIGNAL _
   SIGNAL W
   SIGNAL _
   SIGNAL i
   SIGNAL n
   SIGNAL ,
   SIGNAL  
   SIGNAL c
   SIGNAL 0
   SIGNAL _
   SIGNAL n
   SIGNAL 1
   SIGNAL _
   SIGNAL W
   SIGNAL _
   SIGNAL i
   SIGNAL n
   SIGNAL ,
   SIGNAL  
   SIGNAL c
   SIGNAL 0
   SIGNAL _
   SIGNAL n
   SIGNAL 2
   SIGNAL _
   SIGNAL W
   SIGNAL _
   SIGNAL i
   SIGNAL n
   SIGNAL :
   SIGNAL  
   SIGNAL  
   SIGNAL s
   SIGNAL i
   SIGNAL g
   SIGNAL n
   SIGNAL e
   SIGNAL d
   SIGNAL (
   SIGNAL B
   SIGNAL I
   SIGNAL T
   SIGNAL S
   SIGNAL  
   SIGNAL -
   SIGNAL  
   SIGNAL 1
   SIGNAL  
   SIGNAL D
   SIGNAL O
   SIGNAL W
   SIGNAL N
   SIGNAL T
   SIGNAL O
   SIGNAL  
   SIGNAL 0
   SIGNAL )
   SIGNAL ;
   SIGNAL c
   SIGNAL 1
   SIGNAL _
   SIGNAL n
   SIGNAL 0
   SIGNAL _
   SIGNAL I
   SIGNAL O
   SIGNAL _
   SIGNAL o
   SIGNAL u
   SIGNAL t
   SIGNAL ,
   SIGNAL  
   SIGNAL c
   SIGNAL 1
   SIGNAL _
   SIGNAL n
   SIGNAL 1
   SIGNAL _
   SIGNAL I
   SIGNAL O
   SIGNAL _
   SIGNAL o
   SIGNAL u
   SIGNAL t
   SIGNAL :
   SIGNAL  
   SIGNAL  
   SIGNAL s
   SIGNAL i
   SIGNAL g
   SIGNAL n
   SIGNAL e
   SIGNAL d
   SIGNAL (
   SIGNAL B
   SIGNAL I
   SIGNAL T
   SIGNAL S
   SIGNAL  
   SIGNAL -
   SIGNAL 1
   SIGNAL  
   SIGNAL D
   SIGNAL O
   SIGNAL W
   SIGNAL N
   SIGNAL T
   SIGNAL O
   SIGNAL  
   SIGNAL 0
   SIGNAL )
   SIGNAL ;
   SIGNAL clk, rst, update_weights:  STD_LOGIC;
   SIGNAL IO_in:  signed(TOTAL_BITS - 1 DOWNTO 0);
   SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in:  signed(BITS - 1 DOWNTO 0);
   SIGNAL c1_n0_IO_out, c1_n1_IO_out:  signed(BITS -1 DOWNTO 0);
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
            c1_n0_IO_out => c1_n0_IO_out,
            c1_n1_IO_out => c1_n1_IO_out,
            clk => clk,
            rst => rst,
            update_weights => update_weights,
            IO_in => IO_in,
            c0_n0_W_in => c0_n0_W_in,
            c0_n1_W_in => c0_n1_W_in,
            c0_n2_W_in => c0_n2_W_in,
            c1_n0_IO_out => c1_n0_IO_out,
            c1_n1_IO_out => c1_n1_IO_out,
            c => c,
            l => l,
            k => k,
             => ,
             => ,
              =>  ,
            r => r,
            s => s,
            t => t,
             => ,
             => ,
              =>  ,
            u => u,
            p => p,
            d => d,
            a => a,
            t => t,
            e => e,
            _ => _,
            w => w,
            e => e,
            i => i,
            g => g,
            h => h,
            t => t,
            s => s,
             => ,
              =>  ,
              =>  ,
            S => S,
            T => T,
            D => D,
            _ => _,
            L => L,
            O => O,
            G => G,
            I => I,
            C => C,
            ; => ;,
            I => I,
            O => O,
            _ => _,
            i => i,
            n => n,
             => ,
              =>  ,
              =>  ,
            s => s,
            i => i,
            g => g,
            n => n,
            e => e,
            d => d,
            ( => (,
            T => T,
            O => O,
            T => T,
            A => A,
            L => L,
            _ => _,
            B => B,
            I => I,
            T => T,
            S => S,
              =>  ,
            - => -,
              =>  ,
            1 => 1,
              =>  ,
            D => D,
            O => O,
            W => W,
            N => N,
            T => T,
            O => O,
              =>  ,
            0 => 0,
            ) => ),
            ; => ;,
            c => c,
            0 => 0,
            _ => _,
            n => n,
            0 => 0,
            _ => _,
            W => W,
            _ => _,
            i => i,
            n => n,
             => ,
             => ,
              =>  ,
            c => c,
            0 => 0,
            _ => _,
            n => n,
            1 => 1,
            _ => _,
            W => W,
            _ => _,
            i => i,
            n => n,
             => ,
             => ,
              =>  ,
            c => c,
            0 => 0,
            _ => _,
            n => n,
            2 => 2,
            _ => _,
            W => W,
            _ => _,
            i => i,
            n => n,
             => ,
              =>  ,
              =>  ,
            s => s,
            i => i,
            g => g,
            n => n,
            e => e,
            d => d,
            ( => (,
            B => B,
            I => I,
            T => T,
            S => S,
              =>  ,
            - => -,
              =>  ,
            1 => 1,
              =>  ,
            D => D,
            O => O,
            W => W,
            N => N,
            T => T,
            O => O,
              =>  ,
            0 => 0,
            ) => ),
            ; => ;,
            c => c,
            1 => 1,
            _ => _,
            n => n,
            0 => 0,
            _ => _,
            I => I,
            O => O,
            _ => _,
            o => o,
            u => u,
            t => t,
             => ,
             => ,
              =>  ,
            c => c,
            1 => 1,
            _ => _,
            n => n,
            1 => 1,
            _ => _,
            I => I,
            O => O,
            _ => _,
            o => o,
            u => u,
            t => t,
             => ,
              =>  ,
              =>  ,
            s => s,
            i => i,
            g => g,
            n => n,
            e => e,
            d => d,
            ( => (,
            B => B,
            I => I,
            T => T,
            S => S,
              =>  ,
            - => -,
            1 => 1,
              =>  ,
            D => D,
            O => O,
            W => W,
            N => N,
            T => T,
            O => O,
              =>  ,
            0 => 0,
            ) => ),
            ; => ;,
            clk => clk,
            rst => rst,
            update_weights => update_weights,
            IO_in => IO_in,
            c0_n0_W_in => c0_n0_W_in,
            c0_n1_W_in => c0_n1_W_in,
            c0_n2_W_in => c0_n2_W_in,
            c1_n0_IO_out => c1_n0_IO_out,
            c1_n1_IO_out => c1_n1_IO_out
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
        VARIABLE val_c0_n0_W_in, val_c0_n1_W_in, val_c0_n2_W_in: STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        -- VARIABLE val_n0_IO_in, val_n1_IO_in, val_n2_IO_in, val_n3_IO_in, val_n4_IO_in : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_IO_in: STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_SPACE                                                       : CHARACTER;                                                    -- espacos da leitura de cada linha de entrada
    BEGIN
        -------------------- ATUALIZACAO DOS PESOS DA NN --------------------
        file_open(NN_weights_buff, "BIT_WIDTH/NN_2Layers_7bits_4_3_2_Barriers/testbench_files/weights_bin.txt", read_mode);
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

            -- Pass the read values to signals
            c0_n0_W_in <= signed(val_c0_n0_W_in);
            c0_n1_W_in <= signed(val_c0_n1_W_in);
            c0_n2_W_in <= signed(val_c0_n2_W_in);
            -- WAIT FOR (2 * clk_period);
            WAIT FOR (1 * clk_period);
        END LOOP;                    --END: ATUALIZACAO DOS PESOS DA NN
        file_close(NN_weights_buff); --fecha leitura arquivo dos pesos da NN
        update_weights <= '0';
        -------------------- LEITURA ENTRADA E ESCRITA NO ARQUIVO DE SAIDA -------------------- 
        WAIT FOR (sigmoid_read_time);
        -- arquivo de entrada do tb:
        file_open(input_buf, "BIT_WIDTH/NN_2Layers_7bits_4_3_2_Barriers/testbench_files/tb_inputs.txt", read_mode);
        -- arquivo de saida do tb:
        file_open(output_buf, "BIT_WIDTH/NN_2Layers_7bits_4_3_2_Barriers/testbench_files/tb_outputs.txt", write_mode);
        WHILE NOT endfile(input_buf) LOOP             --enquanto arquivo nao terminar de ler
            readline(input_buf, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
            read(read_col_from_input_buf, val_IO_in);
            read(read_col_from_input_buf, val_SPACE);
            IO_in    <= signed(val_IO_in);
            buff_out <= STD_LOGIC_VECTOR(c1_n0_IO_out & c1_n1_IO_out);
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

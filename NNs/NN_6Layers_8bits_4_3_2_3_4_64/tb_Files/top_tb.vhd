LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL; -- para tratamento de arquivos e texto-> file_open...  
USE work.parameters.ALL;

ENTITY top_tb IS
    GENERIC (
        BITS       : NATURAL := 8;
        NUM_INPUTS : NATURAL := 64;
        TOTAL_BITS : NATURAL := 512
    );
END top_tb;

ARCHITECTURE tb OF top_tb IS
    CONSTANT clk_hz                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : INTEGER                                      := 100e6;
    CONSTANT clk_period                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         : TIME                                         := 1 sec / clk_hz;
    SIGNAL buff_out                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : STD_LOGIC_VECTOR(((64) * BITS) - 1 DOWNTO 0) := (OTHERS => '0');
    CONSTANT sigmoid_read_time                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  : TIME                                         := 16 * clk_period;
    -- SIGNAL clk, rst, update_weights                                   : STD_LOGIC                                   := '0';
    -- SIGNAL IO_in                                                      : signed(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    -- SIGNAL buff_in                                                    : STD_LOGIC_VECTOR(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    SIGNAL clk, rst, update_weights                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : STD_LOGIC;
    SIGNAL IO_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                : signed(TOTAL_BITS - 1 DOWNTO 0);
    SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c5_n4_W_in, c5_n5_W_in, c5_n6_W_in, c5_n7_W_in, c5_n8_W_in, c5_n9_W_in, c5_n10_W_in, c5_n11_W_in, c5_n12_W_in, c5_n13_W_in, c5_n14_W_in, c5_n15_W_in, c5_n16_W_in, c5_n17_W_in, c5_n18_W_in, c5_n19_W_in, c5_n20_W_in, c5_n21_W_in, c5_n22_W_in, c5_n23_W_in, c5_n24_W_in, c5_n25_W_in, c5_n26_W_in, c5_n27_W_in, c5_n28_W_in, c5_n29_W_in, c5_n30_W_in, c5_n31_W_in, c5_n32_W_in, c5_n33_W_in, c5_n34_W_in, c5_n35_W_in, c5_n36_W_in, c5_n37_W_in, c5_n38_W_in, c5_n39_W_in, c5_n40_W_in, c5_n41_W_in, c5_n42_W_in, c5_n43_W_in, c5_n44_W_in, c5_n45_W_in, c5_n46_W_in, c5_n47_W_in, c5_n48_W_in, c5_n49_W_in, c5_n50_W_in, c5_n51_W_in, c5_n52_W_in, c5_n53_W_in, c5_n54_W_in, c5_n55_W_in, c5_n56_W_in, c5_n57_W_in, c5_n58_W_in, c5_n59_W_in, c5_n60_W_in, c5_n61_W_in, c5_n62_W_in, c5_n63_W_in                                                                                                                                 : signed(BITS - 1 DOWNTO 0);
    SIGNAL c5_n0_IO_out, c5_n1_IO_out, c5_n2_IO_out, c5_n3_IO_out, c5_n4_IO_out, c5_n5_IO_out, c5_n6_IO_out, c5_n7_IO_out, c5_n8_IO_out, c5_n9_IO_out, c5_n10_IO_out, c5_n11_IO_out, c5_n12_IO_out, c5_n13_IO_out, c5_n14_IO_out, c5_n15_IO_out, c5_n16_IO_out, c5_n17_IO_out, c5_n18_IO_out, c5_n19_IO_out, c5_n20_IO_out, c5_n21_IO_out, c5_n22_IO_out, c5_n23_IO_out, c5_n24_IO_out, c5_n25_IO_out, c5_n26_IO_out, c5_n27_IO_out, c5_n28_IO_out, c5_n29_IO_out, c5_n30_IO_out, c5_n31_IO_out, c5_n32_IO_out, c5_n33_IO_out, c5_n34_IO_out, c5_n35_IO_out, c5_n36_IO_out, c5_n37_IO_out, c5_n38_IO_out, c5_n39_IO_out, c5_n40_IO_out, c5_n41_IO_out, c5_n42_IO_out, c5_n43_IO_out, c5_n44_IO_out, c5_n45_IO_out, c5_n46_IO_out, c5_n47_IO_out, c5_n48_IO_out, c5_n49_IO_out, c5_n50_IO_out, c5_n51_IO_out, c5_n52_IO_out, c5_n53_IO_out, c5_n54_IO_out, c5_n55_IO_out, c5_n56_IO_out, c5_n57_IO_out, c5_n58_IO_out, c5_n59_IO_out, c5_n60_IO_out, c5_n61_IO_out, c5_n62_IO_out, c5_n63_IO_out : signed(BITS - 1 DOWNTO 0);
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
        c5_n4_W_in     => c5_n4_W_in,
        c5_n5_W_in     => c5_n5_W_in,
        c5_n6_W_in     => c5_n6_W_in,
        c5_n7_W_in     => c5_n7_W_in,
        c5_n8_W_in     => c5_n8_W_in,
        c5_n9_W_in     => c5_n9_W_in,
        c5_n10_W_in    => c5_n10_W_in,
        c5_n11_W_in    => c5_n11_W_in,
        c5_n12_W_in    => c5_n12_W_in,
        c5_n13_W_in    => c5_n13_W_in,
        c5_n14_W_in    => c5_n14_W_in,
        c5_n15_W_in    => c5_n15_W_in,
        c5_n16_W_in    => c5_n16_W_in,
        c5_n17_W_in    => c5_n17_W_in,
        c5_n18_W_in    => c5_n18_W_in,
        c5_n19_W_in    => c5_n19_W_in,
        c5_n20_W_in    => c5_n20_W_in,
        c5_n21_W_in    => c5_n21_W_in,
        c5_n22_W_in    => c5_n22_W_in,
        c5_n23_W_in    => c5_n23_W_in,
        c5_n24_W_in    => c5_n24_W_in,
        c5_n25_W_in    => c5_n25_W_in,
        c5_n26_W_in    => c5_n26_W_in,
        c5_n27_W_in    => c5_n27_W_in,
        c5_n28_W_in    => c5_n28_W_in,
        c5_n29_W_in    => c5_n29_W_in,
        c5_n30_W_in    => c5_n30_W_in,
        c5_n31_W_in    => c5_n31_W_in,
        c5_n32_W_in    => c5_n32_W_in,
        c5_n33_W_in    => c5_n33_W_in,
        c5_n34_W_in    => c5_n34_W_in,
        c5_n35_W_in    => c5_n35_W_in,
        c5_n36_W_in    => c5_n36_W_in,
        c5_n37_W_in    => c5_n37_W_in,
        c5_n38_W_in    => c5_n38_W_in,
        c5_n39_W_in    => c5_n39_W_in,
        c5_n40_W_in    => c5_n40_W_in,
        c5_n41_W_in    => c5_n41_W_in,
        c5_n42_W_in    => c5_n42_W_in,
        c5_n43_W_in    => c5_n43_W_in,
        c5_n44_W_in    => c5_n44_W_in,
        c5_n45_W_in    => c5_n45_W_in,
        c5_n46_W_in    => c5_n46_W_in,
        c5_n47_W_in    => c5_n47_W_in,
        c5_n48_W_in    => c5_n48_W_in,
        c5_n49_W_in    => c5_n49_W_in,
        c5_n50_W_in    => c5_n50_W_in,
        c5_n51_W_in    => c5_n51_W_in,
        c5_n52_W_in    => c5_n52_W_in,
        c5_n53_W_in    => c5_n53_W_in,
        c5_n54_W_in    => c5_n54_W_in,
        c5_n55_W_in    => c5_n55_W_in,
        c5_n56_W_in    => c5_n56_W_in,
        c5_n57_W_in    => c5_n57_W_in,
        c5_n58_W_in    => c5_n58_W_in,
        c5_n59_W_in    => c5_n59_W_in,
        c5_n60_W_in    => c5_n60_W_in,
        c5_n61_W_in    => c5_n61_W_in,
        c5_n62_W_in    => c5_n62_W_in,
        c5_n63_W_in    => c5_n63_W_in,
        c5_n0_IO_out   => c5_n0_IO_out,
        c5_n1_IO_out   => c5_n1_IO_out,
        c5_n2_IO_out   => c5_n2_IO_out,
        c5_n3_IO_out   => c5_n3_IO_out,
        c5_n4_IO_out   => c5_n4_IO_out,
        c5_n5_IO_out   => c5_n5_IO_out,
        c5_n6_IO_out   => c5_n6_IO_out,
        c5_n7_IO_out   => c5_n7_IO_out,
        c5_n8_IO_out   => c5_n8_IO_out,
        c5_n9_IO_out   => c5_n9_IO_out,
        c5_n10_IO_out  => c5_n10_IO_out,
        c5_n11_IO_out  => c5_n11_IO_out,
        c5_n12_IO_out  => c5_n12_IO_out,
        c5_n13_IO_out  => c5_n13_IO_out,
        c5_n14_IO_out  => c5_n14_IO_out,
        c5_n15_IO_out  => c5_n15_IO_out,
        c5_n16_IO_out  => c5_n16_IO_out,
        c5_n17_IO_out  => c5_n17_IO_out,
        c5_n18_IO_out  => c5_n18_IO_out,
        c5_n19_IO_out  => c5_n19_IO_out,
        c5_n20_IO_out  => c5_n20_IO_out,
        c5_n21_IO_out  => c5_n21_IO_out,
        c5_n22_IO_out  => c5_n22_IO_out,
        c5_n23_IO_out  => c5_n23_IO_out,
        c5_n24_IO_out  => c5_n24_IO_out,
        c5_n25_IO_out  => c5_n25_IO_out,
        c5_n26_IO_out  => c5_n26_IO_out,
        c5_n27_IO_out  => c5_n27_IO_out,
        c5_n28_IO_out  => c5_n28_IO_out,
        c5_n29_IO_out  => c5_n29_IO_out,
        c5_n30_IO_out  => c5_n30_IO_out,
        c5_n31_IO_out  => c5_n31_IO_out,
        c5_n32_IO_out  => c5_n32_IO_out,
        c5_n33_IO_out  => c5_n33_IO_out,
        c5_n34_IO_out  => c5_n34_IO_out,
        c5_n35_IO_out  => c5_n35_IO_out,
        c5_n36_IO_out  => c5_n36_IO_out,
        c5_n37_IO_out  => c5_n37_IO_out,
        c5_n38_IO_out  => c5_n38_IO_out,
        c5_n39_IO_out  => c5_n39_IO_out,
        c5_n40_IO_out  => c5_n40_IO_out,
        c5_n41_IO_out  => c5_n41_IO_out,
        c5_n42_IO_out  => c5_n42_IO_out,
        c5_n43_IO_out  => c5_n43_IO_out,
        c5_n44_IO_out  => c5_n44_IO_out,
        c5_n45_IO_out  => c5_n45_IO_out,
        c5_n46_IO_out  => c5_n46_IO_out,
        c5_n47_IO_out  => c5_n47_IO_out,
        c5_n48_IO_out  => c5_n48_IO_out,
        c5_n49_IO_out  => c5_n49_IO_out,
        c5_n50_IO_out  => c5_n50_IO_out,
        c5_n51_IO_out  => c5_n51_IO_out,
        c5_n52_IO_out  => c5_n52_IO_out,
        c5_n53_IO_out  => c5_n53_IO_out,
        c5_n54_IO_out  => c5_n54_IO_out,
        c5_n55_IO_out  => c5_n55_IO_out,
        c5_n56_IO_out  => c5_n56_IO_out,
        c5_n57_IO_out  => c5_n57_IO_out,
        c5_n58_IO_out  => c5_n58_IO_out,
        c5_n59_IO_out  => c5_n59_IO_out,
        c5_n60_IO_out  => c5_n60_IO_out,
        c5_n61_IO_out  => c5_n61_IO_out,
        c5_n62_IO_out  => c5_n62_IO_out,
        c5_n63_IO_out  => c5_n63_IO_out
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
        VARIABLE read_col_from_input_buf                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              : line; -- buffers de entrada e saida
        FILE input_buf                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                : text; --text is keyword ->??
        VARIABLE read_col_from_sigmoid_buf                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            : line;
        FILE NN_weights_buff                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : text; --text is keyword -->??
        VARIABLE write_col_to_output_buf                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              : line;
        FILE output_buf                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               : text; --text is keyword -->??
        VARIABLE val_address                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          : STD_LOGIC_VECTOR(bits - 1 DOWNTO 0)       := (OTHERS => '0');
        VARIABLE val_c0_n0_W_in, val_c0_n1_W_in, val_c0_n2_W_in, val_c0_n3_W_in, val_c5_n4_W_in, val_c5_n5_W_in, val_c5_n6_W_in, val_c5_n7_W_in, val_c5_n8_W_in, val_c5_n9_W_in, val_c5_n10_W_in, val_c5_n11_W_in, val_c5_n12_W_in, val_c5_n13_W_in, val_c5_n14_W_in, val_c5_n15_W_in, val_c5_n16_W_in, val_c5_n17_W_in, val_c5_n18_W_in, val_c5_n19_W_in, val_c5_n20_W_in, val_c5_n21_W_in, val_c5_n22_W_in, val_c5_n23_W_in, val_c5_n24_W_in, val_c5_n25_W_in, val_c5_n26_W_in, val_c5_n27_W_in, val_c5_n28_W_in, val_c5_n29_W_in, val_c5_n30_W_in, val_c5_n31_W_in, val_c5_n32_W_in, val_c5_n33_W_in, val_c5_n34_W_in, val_c5_n35_W_in, val_c5_n36_W_in, val_c5_n37_W_in, val_c5_n38_W_in, val_c5_n39_W_in, val_c5_n40_W_in, val_c5_n41_W_in, val_c5_n42_W_in, val_c5_n43_W_in, val_c5_n44_W_in, val_c5_n45_W_in, val_c5_n46_W_in, val_c5_n47_W_in, val_c5_n48_W_in, val_c5_n49_W_in, val_c5_n50_W_in, val_c5_n51_W_in, val_c5_n52_W_in, val_c5_n53_W_in, val_c5_n54_W_in, val_c5_n55_W_in, val_c5_n56_W_in, val_c5_n57_W_in, val_c5_n58_W_in, val_c5_n59_W_in, val_c5_n60_W_in, val_c5_n61_W_in, val_c5_n62_W_in, val_c5_n63_W_in : STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0)       := (OTHERS => '0'); --signal 
        -- VARIABLE val_n0_IO_in, val_n1_IO_in, val_n2_IO_in, val_n3_IO_in, val_n4_IO_in : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_IO_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        VARIABLE val_SPACE                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            : CHARACTER;                                                    -- espacos da leitura de cada linha de entrada
    BEGIN
        -------------------- ATUALIZACAO DOS PESOS DA NN --------------------
        file_open(NN_weights_buff, "C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/tb_Files/weights_bin.txt", read_mode);
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

            read(read_col_from_input_buf, val_c5_n4_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n5_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n6_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n7_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n8_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n9_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n10_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n11_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n12_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n13_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n14_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n15_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n16_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n17_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n18_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n19_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n20_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n21_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n22_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n23_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n24_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n25_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n26_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n27_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n28_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n29_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n30_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n31_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n32_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n33_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n34_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n35_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n36_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n37_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n38_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n39_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n40_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n41_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n42_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n43_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n44_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n45_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n46_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n47_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n48_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n49_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n50_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n51_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n52_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n53_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n54_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n55_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n56_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n57_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n58_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n59_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n60_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n61_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n62_W_in);
            read(read_col_from_input_buf, val_SPACE);

            read(read_col_from_input_buf, val_c5_n63_W_in);
            read(read_col_from_input_buf, val_SPACE);

            -- Pass the read values to signals
            c0_n0_W_in  <= signed(val_c0_n0_W_in);
            c0_n1_W_in  <= signed(val_c0_n1_W_in);
            c0_n2_W_in  <= signed(val_c0_n2_W_in);
            c0_n3_W_in  <= signed(val_c0_n3_W_in);
            c5_n4_W_in  <= signed(val_c5_n4_W_in);
            c5_n5_W_in  <= signed(val_c5_n5_W_in);
            c5_n6_W_in  <= signed(val_c5_n6_W_in);
            c5_n7_W_in  <= signed(val_c5_n7_W_in);
            c5_n8_W_in  <= signed(val_c5_n8_W_in);
            c5_n9_W_in  <= signed(val_c5_n9_W_in);
            c5_n10_W_in <= signed(val_c5_n10_W_in);
            c5_n11_W_in <= signed(val_c5_n11_W_in);
            c5_n12_W_in <= signed(val_c5_n12_W_in);
            c5_n13_W_in <= signed(val_c5_n13_W_in);
            c5_n14_W_in <= signed(val_c5_n14_W_in);
            c5_n15_W_in <= signed(val_c5_n15_W_in);
            c5_n16_W_in <= signed(val_c5_n16_W_in);
            c5_n17_W_in <= signed(val_c5_n17_W_in);
            c5_n18_W_in <= signed(val_c5_n18_W_in);
            c5_n19_W_in <= signed(val_c5_n19_W_in);
            c5_n20_W_in <= signed(val_c5_n20_W_in);
            c5_n21_W_in <= signed(val_c5_n21_W_in);
            c5_n22_W_in <= signed(val_c5_n22_W_in);
            c5_n23_W_in <= signed(val_c5_n23_W_in);
            c5_n24_W_in <= signed(val_c5_n24_W_in);
            c5_n25_W_in <= signed(val_c5_n25_W_in);
            c5_n26_W_in <= signed(val_c5_n26_W_in);
            c5_n27_W_in <= signed(val_c5_n27_W_in);
            c5_n28_W_in <= signed(val_c5_n28_W_in);
            c5_n29_W_in <= signed(val_c5_n29_W_in);
            c5_n30_W_in <= signed(val_c5_n30_W_in);
            c5_n31_W_in <= signed(val_c5_n31_W_in);
            c5_n32_W_in <= signed(val_c5_n32_W_in);
            c5_n33_W_in <= signed(val_c5_n33_W_in);
            c5_n34_W_in <= signed(val_c5_n34_W_in);
            c5_n35_W_in <= signed(val_c5_n35_W_in);
            c5_n36_W_in <= signed(val_c5_n36_W_in);
            c5_n37_W_in <= signed(val_c5_n37_W_in);
            c5_n38_W_in <= signed(val_c5_n38_W_in);
            c5_n39_W_in <= signed(val_c5_n39_W_in);
            c5_n40_W_in <= signed(val_c5_n40_W_in);
            c5_n41_W_in <= signed(val_c5_n41_W_in);
            c5_n42_W_in <= signed(val_c5_n42_W_in);
            c5_n43_W_in <= signed(val_c5_n43_W_in);
            c5_n44_W_in <= signed(val_c5_n44_W_in);
            c5_n45_W_in <= signed(val_c5_n45_W_in);
            c5_n46_W_in <= signed(val_c5_n46_W_in);
            c5_n47_W_in <= signed(val_c5_n47_W_in);
            c5_n48_W_in <= signed(val_c5_n48_W_in);
            c5_n49_W_in <= signed(val_c5_n49_W_in);
            c5_n50_W_in <= signed(val_c5_n50_W_in);
            c5_n51_W_in <= signed(val_c5_n51_W_in);
            c5_n52_W_in <= signed(val_c5_n52_W_in);
            c5_n53_W_in <= signed(val_c5_n53_W_in);
            c5_n54_W_in <= signed(val_c5_n54_W_in);
            c5_n55_W_in <= signed(val_c5_n55_W_in);
            c5_n56_W_in <= signed(val_c5_n56_W_in);
            c5_n57_W_in <= signed(val_c5_n57_W_in);
            c5_n58_W_in <= signed(val_c5_n58_W_in);
            c5_n59_W_in <= signed(val_c5_n59_W_in);
            c5_n60_W_in <= signed(val_c5_n60_W_in);
            c5_n61_W_in <= signed(val_c5_n61_W_in);
            c5_n62_W_in <= signed(val_c5_n62_W_in);
            c5_n63_W_in <= signed(val_c5_n63_W_in);
            -- WAIT FOR (2 * clk_period);
            WAIT FOR (1 * clk_period);
        END LOOP;                    --END: ATUALIZACAO DOS PESOS DA NN
        file_close(NN_weights_buff); --fecha leitura arquivo dos pesos da NN
        update_weights <= '0';
        -------------------- LEITURA ENTRADA E ESCRITA NO ARQUIVO DE SAIDA -------------------- 
        WAIT FOR (sigmoid_read_time);
        -- arquivo de entrada do tb:
        file_open(input_buf, "C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/tb_Files/tb_inputs.txt", read_mode);
        -- arquivo de saida do tb:
        file_open(output_buf, "C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/tb_Files/tb_outputs.txt", write_mode);
        WHILE NOT endfile(input_buf) LOOP             --enquanto arquivo nao terminar de ler
            readline(input_buf, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
            read(read_col_from_input_buf, val_IO_in);
            read(read_col_from_input_buf, val_SPACE);
            IO_in    <= signed(val_IO_in);
            buff_out <= STD_LOGIC_VECTOR(c5_n0_IO_out & c5_n1_IO_out & c5_n2_IO_out & c5_n3_IO_out & c5_n4_IO_out & c5_n5_IO_out & c5_n6_IO_out & c5_n7_IO_out & c5_n8_IO_out & c5_n9_IO_out & c5_n10_IO_out & c5_n11_IO_out & c5_n12_IO_out & c5_n13_IO_out & c5_n14_IO_out & c5_n15_IO_out & c5_n16_IO_out & c5_n17_IO_out & c5_n18_IO_out & c5_n19_IO_out & c5_n20_IO_out & c5_n21_IO_out & c5_n22_IO_out & c5_n23_IO_out & c5_n24_IO_out & c5_n25_IO_out & c5_n26_IO_out & c5_n27_IO_out & c5_n28_IO_out & c5_n29_IO_out & c5_n30_IO_out & c5_n31_IO_out & c5_n32_IO_out & c5_n33_IO_out & c5_n34_IO_out & c5_n35_IO_out & c5_n36_IO_out & c5_n37_IO_out & c5_n38_IO_out & c5_n39_IO_out & c5_n40_IO_out & c5_n41_IO_out & c5_n42_IO_out & c5_n43_IO_out & c5_n44_IO_out & c5_n45_IO_out & c5_n46_IO_out & c5_n47_IO_out & c5_n48_IO_out & c5_n49_IO_out & c5_n50_IO_out & c5_n51_IO_out & c5_n52_IO_out & c5_n53_IO_out & c5_n54_IO_out & c5_n55_IO_out & c5_n56_IO_out & c5_n57_IO_out & c5_n58_IO_out & c5_n59_IO_out & c5_n60_IO_out & c5_n61_IO_out & c5_n62_IO_out & c5_n63_IO_out);
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
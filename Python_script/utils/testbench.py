from utils.GLOBALS import GLOBAL
from utils.general.dict_utils import dict_list_exceptNone, dict_list_exceptNone_Callable
from utils.general.vhd_txt_utils import generic_gen
import os


def testbench_gen(testbench_path: str,
                  top_dict: dict,
                  id_IO_in: str = 'IO_in',
                  id_W_in: str = 'W_in',
                  id_IO_out: str = 'IO_out'):
    """
    Generates a testbench for the given top-level module.

    In summary, the function testbench_gen generates a testbench for a given top_dict, saving it in the testbench_path directory. Before calling tb_txt_gen, it generates the generic text, name and component of the testbench, the signals, inputs, inputs values, weights, outputs concatenation and text values of inputs and weights. It also converts the weights buffer to real values.

    Args:
        testbench_path (str): The path to the output directory.
        top_dict (dict): A dictionary containing information about the top-level module.
        id_IO_in (str, optional): The ID of the input signal. Defaults to 'IO_in'.
        id_W_in (str, optional): The ID of the weight input signal. Defaults to 'W_in'.
        id_IO_out (str, optional): The ID of the output signal. Defaults to 'IO_out'.

    Returns:
        None
    """
    # Generating generic text for the testbench
    tb_generic_txt = generic_gen(top_dict)

    # Generating the name and component of the testbench
    top_name, top_component = testbench_component_gen(top_dict)
    # top_name = 'top'

    # Example of GLOBAL.TESTBENCH.signals:
    # GLOBAL.TESTBENCH.signals = [
    #     '   SIGNAL clk, rst, update_weights:  STD_LOGIC;',
    #     '   SIGNAL IO_in:  signed(TOTAL_BITS - 1 DOWNTO 0);',
    #     '   SIGNAL c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in:  signed(BITS - 1 DOWNTO 0);',
    #     '   SIGNAL c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out:  signed(BITS -1 DOWNTO 0);']

    # Generating the signals for the testbench
    signals_tb = '\n'.join(map(str, (GLOBAL.TESTBENCH.signals)))

    # Generating the inputs, inputs value, weights, outputs concatenation and text value of inputs and weights
    inputs, inputs_val, text_val_inputs, buff_weights, text_val_weights, outputs_concatenation = testbench_lists(
        id_IO_in=id_IO_in,
        id_W_in=id_W_in,
        id_IO_out=id_IO_out)
    # inputs = "IO_in"
    # inputs_val = "val_IO_in"
    # text_val_inputs = "VARIABLE val_IO_in: STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); "
    # text_val_weights = "VARIABLE val_n0_W_in, val_n1_W_in, val_n2_W_in, val_n3_W_in, val_n4_W_in : STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0):= (OTHERS => '0');"
    # outputs_concatenation = 'c3_n0_IO_out & c3_n1_IO_out & c3_n2_IO_out & c3_n3_IO_out'
    # buff_weights = ['val_c0_n0_W_in', 'val_c0_n1_W_in', 'val_c0_n2_W_in', 'val_c0_n3_W_in', 'val_c0_n4_W_in']

    # Converting weights buffer to read values
    read_val_weights_from_line = read_variables(buff_weights)  # lista -> texto

    # read_val_weights_from_line = '''
    #         read(read_col_from_input_buf, val_n0_W_in);
    #         read(read_col_from_input_buf, val_SPACE);

    #         read(read_col_from_input_buf, val_n1_W_in);
    #         read(read_col_from_input_buf, val_SPACE);

    #         read(read_col_from_input_buf, val_n2_W_in);
    #         read(read_col_from_input_buf, val_SPACE);

    #         read(read_col_from_input_buf, val_n3_W_in);
    #         read(read_col_from_input_buf, val_SPACE);

    #         read(read_col_from_input_buf, val_n4_W_in);
    #         read(read_col_from_input_buf, val_SPACE);
    #         -- Pass the read values to signals
    #         c0_n0_W_in <= signed(val_n0_W_in);
    #         c0_n1_W_in <= signed(val_n1_W_in);
    #         c0_n2_W_in <= signed(val_n2_W_in);
    #         c0_n3_W_in <= signed(val_n3_W_in);
    #         c0_n4_W_in <= signed(val_n4_W_in);
    #         '''

    # Generating the testbench text file
    tb_txt_gen(testbench_path, tb_generic_txt, top_name, top_component, signals_tb, inputs, inputs_val,
               text_val_inputs, text_val_weights, outputs_concatenation, read_val_weights_from_line)  # download Reg


def testbench_component_gen(top_dict: dict):
    """
    Generates a port map of a VHDL component based on a given dictionary of parameters.
    The function generates a port map of a VHDL component based on a given dictionary of parameters. 
    The top_dict argument should be a dictionary that contains the name of the top-level entity to be instantiated in the port map. 
    The function returns a tuple containing two elements: the name of the top-level entity and its port map as a string.

    Args:
    - top_dict (dict): A dictionary that contains the name of the top-level entity to be instantiated in the port map.

    Returns:
    - A tuple containing two elements: the name of the top-level entity and its port map.

    Example usage:
    - top_dict = {
        'Inputs_number': 5, 
        'BIT_WIDTH': 8, 
        'Top_name': 'top', 
        'IO': {
            'GENERIC': {
                'BITS': <function <lambda> at 0x00000131CF8B7A60>, 
                'NUM_INPUTS': <function <lambda> at 0x00000131CF8BB8B0>, 
                'TOTAL_BITS': 40
                }, 
            'IN': {
                'STD_LOGIC': ['clk', 'rst', 'update_weights'], 
                'STD_LOGIC_VECTOR': None, 
                'SIGNED': None, 
                'manual': ['IO_in', 'c0_n0_W_in', 'c0_n1_W_in', 'c0_n2_W_in', 'c0_n3_W_in', 'c0_n4_W_in']
                }, 
            'OUT': {
                'STD_LOGIC': None, 
                'STD_LOGIC_VECTOR': None, 
                'SIGNED': ['c3_n0_IO_out', 'c3_n1_IO_out', 'c3_n2_IO_out', 'c3_n3_IO_out'], 
                'manual': None
                }
            }
        }
      name, port_map = testbench_component_gen(top_dict)
    """

    # Generate a list of port maps based on a list of I/O assignments
    port_map_top_tb = [
        f"            {item} => {item},"
        for item in GLOBAL.TESTBENCH.IO_assign_list
    ]
    port_map_top_tb[-1] = port_map_top_tb[-1][:-1]
    # ------ exemplo de port_map_top_tb:
    # port_map_top_tb = ['            clk => clk,',
    #                    '            rst => rst,',
    #                    '            update_weights => update_weights,',
    #                    '            IO_in => IO_in,',
    #                    '            c0_n0_W_in => c0_n0_W_in,',
    #                    '            c0_n1_W_in => c0_n1_W_in,',
    #                    '            c0_n2_W_in => c0_n2_W_in,',
    #                    '            c0_n3_W_in => c0_n3_W_in,',
    #                    '            c0_n4_W_in => c0_n4_W_in,',
    #                    '            c3_n0_IO_out => c3_n0_IO_out,',
    #                    '            c3_n1_IO_out => c3_n1_IO_out,',
    #                    '            c3_n2_IO_out => c3_n2_IO_out,',
    #                    '            c3_n3_IO_out => c3_n3_IO_out,'
    #                    ]

    # Convert the list of port maps into a string
    port_map_top_tb = '\n'.join(map(str, (port_map_top_tb)))

    # Extract the name of the top-level entity from the dictionary
    top_name = top_dict['Top_name']

    # Generate the port map for the top-level entity as a string
    top_component = f'''    -- port map do componente '{top_name}.vhd'
        UUT : ENTITY work.{top_name} PORT MAP(
{port_map_top_tb}
            );'''

    return top_name, top_component


def testbench_lists(id_IO_in: str = 'IO_in',
                    id_W_in: str = 'W_in',
                    id_IO_out: str = 'IO_out'):
    """
    Generates testbench variables for inputs, weights, and outputs.
    The function generates testbench variables for inputs, weights, and outputs based on the identifiers provided as arguments. 
    It loops through the GLOBAL.TESTBENCH.IOs list and checks for strings that match the identifiers. It then assigns the corresponding values to the generated variables.

    The function returns a tuple containing the generated variables for inputs, weights, and outputs.

    Args:
    - id_IO_in (str): identifier for input variables (default: 'IO_in')
    - id_W_in (str): identifier for weight variables (default: 'W_in')
    - id_IO_out (str): identifier for output variables (default: 'IO_out')

    Returns:
    - tuple: a tuple containing the generated variables for inputs, weights, and outputs

    Example Usage:
    ```
    inputs, inputs_val, text_val_inputs, buff_weights, text_val_weights, outputs_concatenation = testbench_lists()
    ```
    """
    # inputs = "IO_in"
    # inputs_val = "val_IO_in"
    # text_val_inputs = "VARIABLE val_IO_in: STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); "
    # text_val_weights = "VARIABLE val_n0_W_in, val_n1_W_in, val_n2_W_in, val_n3_W_in, val_n4_W_in : STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0):= (OTHERS => '0');"
    # outputs_concatenation = 'c3_n0_IO_out & c3_n1_IO_out & c3_n2_IO_out & c3_n3_IO_out'
    # buff_weights = ['val_c0_n0_W_in', 'val_c0_n1_W_in', 'val_c0_n2_W_in', 'val_c0_n3_W_in', 'val_c0_n4_W_in']

    # loop through IOs in GLOBAL.TESTBENCH
    for item in GLOBAL.TESTBENCH.IOs:
        if isinstance(item[0], str):
            if id_IO_in in item[0]:  # inputs variables (IO_in)
                inputs = item[0]
                inputs_val = f"val_{item[0]}"
                text_val_inputs = f"VARIABLE {inputs_val}: STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); "
            elif id_IO_out in item[0]:   # outputs variables (IO_out)
                # buff_IO_out = []
                # for jitem in item[0]:
                #     buff_IO_out.append(f"val_{jitem}")
                outputs_concatenation = item[0]
        else:  # is not str --> is sublist
            if id_W_in in item[0][0]:  # weights variables
                buff_weights = [f"val_{jitem}" for jitem in item[0]]
                text_val_weights = f"VARIABLE {', '.join(map(str, (buff_weights)))}: STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0) := (OTHERS => '0');"

            if id_IO_out in item[0][0]:   # outputs variables (IO_out)
                # buff_IO_out = []
                # for jitem in item[0]:
                #     buff_IO_out.append(f"val_{jitem}")
                outputs_concatenation = f"{' & '.join(map(str, (item[0])))}"

    # return the generated variables as a tuple
    return inputs, inputs_val, text_val_inputs, buff_weights, text_val_weights, outputs_concatenation


def read_variables(buff_weights: list):
    """
    Reads values from a buffer and generates a string of VHDL code to assign those values to signals.

    Args:
    - buff_weights (list): A list of strings, where each string represents a signal name to which a value is assigned.

    Returns:
    - read_val_weights_from_line (str): A string of VHDL code that reads values from a buffer and assigns them to signals.

    Example:
    ```
    buff_weights = ['val_n0_W_in', 'val_n1_W_in', 'val_n2_W_in', 'val_n3_W_in', 'val_n4_W_in']
    read_val_weights_from_line = read_variables(buff_weights)
    print(read_val_weights_from_line)
    ```
    Output:
    ```
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
    ```
    """
    read_val_weights_from_line = []
    for item in buff_weights:
        read_val_weights_from_line.extend(
            [
                '',
                f'''            read(read_col_from_input_buf, {item});''',
                '''            read(read_col_from_input_buf, val_SPACE);''',
            ]
        )

    read_val_weights_from_line.extend(['',
                                       "            -- Pass the read values to signals"])

    read_val_weights_from_line.extend(
        f'''            {item[4:]} <= signed({item});'''
        for item in buff_weights
    )
    return '\n'.join(map(str, (read_val_weights_from_line)))


def tb_txt_gen(testbench_path: str,
               tb_generic_txt: str,
               top_name: str,
               top_component: str,
               signals_tb: str,
               inputs: str,
               inputs_val: str,
               text_val_inputs: str,
               text_val_weights: str,
               outputs_concatenation: str,
               read_val_weights_from_line: str) -> None:
    """
    Generate the text file for a VHDL testbench.

    Parameters:
    -----------
    testbench_path : str
        Path to the output base directory.
    tb_generic_txt : str
        Text for the generic of the testbench.
    top_name : str
        Name of the top level entity of the testbench.
    top_component : str
        Architecture of the top level entity.
    signals_tb : str
        Text for the signals of the testbench.
    inputs : str
        VHDL signals used as input in the testbench.
    inputs_val : str
        VHDL variables used as input values in the testbench.
    text_val_inputs : str
        Text for the input values.
    text_val_weights : str
        Text for the weight values.
    outputs_concatenation : str
        Concatenation of the output signals.
    read_val_weights_from_line : str
        Text for the real values of the weight from a line.

    Returns:
    --------
    None
    """
    # whole_dir = os.path.abspath(".")
    # testbench_path = f"{whole_dir}{testbench_path[1:]}"
    # create the directory if it does not exist
    if not os.path.exists(testbench_path):
        os.makedirs(testbench_path)

    weights_file_path = f"{testbench_path}/weights_bin.txt"
    inputs_file_path = f"{testbench_path}/tb_inputs.txt"
    outputs_file_path = f"{testbench_path}/tb_outputs.txt"
    # -----------------------------------------------------------------------------------------------------
    tb_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL; -- para tratamento de arquivos e texto-> file_open...  
USE work.parameters.ALL;
ENTITY {top_name}_tb IS
{tb_generic_txt}
END {top_name}_tb;
ARCHITECTURE tb OF {top_name}_tb IS
    CONSTANT clk_hz                                                   : INTEGER                                     := 100e6;
    CONSTANT clk_period                                               : TIME                                        := 1 sec / clk_hz;
    SIGNAL buff_out                                                   : STD_LOGIC_VECTOR(((4) * BITS) - 1 DOWNTO 0) := (OTHERS => '0');
    CONSTANT sigmoid_read_time                                        : TIME                                        := 16 * clk_period;
    -- SIGNAL clk, rst, update_weights                                   : STD_LOGIC                                   := '0';
    -- SIGNAL IO_in                                                      : signed(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
    -- SIGNAL buff_in                                                    : STD_LOGIC_VECTOR(TOTAL_BITS * NUM_INPUTS - 1 DOWNTO 0);
{signals_tb}
BEGIN
{top_component}
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
        {text_val_weights} --signal 
        -- VARIABLE val_n0_IO_in, val_n1_IO_in, val_n2_IO_in, val_n3_IO_in, val_n4_IO_in : STD_LOGIC_VECTOR(TOTAL_BITS - 1 DOWNTO 0) := (OTHERS => '0'); --signal 
        {text_val_inputs}--signal 
        VARIABLE val_SPACE                                                       : CHARACTER;                                                    -- espacos da leitura de cada linha de entrada
    BEGIN
        -------------------- ATUALIZACAO DOS PESOS DA NN --------------------
        file_open(NN_weights_buff, "{weights_file_path}", read_mode);
        rst <= '1', '0' AFTER clk_period;
        WAIT UNTIL rst = '0';                   -- espera rst desligar
        WHILE NOT endfile(NN_weights_buff) LOOP --enquanto arquivo nao terminar de ler
            update_weights <= '1';
            readline(NN_weights_buff, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
{read_val_weights_from_line}
            -- WAIT FOR (2 * clk_period);
            WAIT FOR (1 * clk_period);
        END LOOP;                    --END: ATUALIZACAO DOS PESOS DA NN
        file_close(NN_weights_buff); --fecha leitura arquivo dos pesos da NN
        update_weights <= '0';
        -------------------- LEITURA ENTRADA E ESCRITA NO ARQUIVO DE SAIDA -------------------- 
        WAIT FOR (sigmoid_read_time);
        -- arquivo de entrada do tb:
        file_open(input_buf, "{inputs_file_path}", read_mode);
        -- arquivo de saida do tb:
        file_open(output_buf, "{outputs_file_path}", write_mode);
        WHILE NOT endfile(input_buf) LOOP             --enquanto arquivo nao terminar de ler
            readline(input_buf, read_col_from_input_buf); --le_linha buffer primeira linha -> escreve na variavel
            read(read_col_from_input_buf, {inputs_val});
            read(read_col_from_input_buf, val_SPACE);
            {inputs}    <= signed({inputs_val});
            buff_out <= STD_LOGIC_VECTOR({outputs_concatenation});
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
''')

    # tb_txt = tb_text(
    #     tb_generic=tb_generic_txt,
    #     signal_inputs=signal_inputs,
    #     signal_input_weights=signal_input_weights,
    #     signal_outputs=signal_outputs,
    #     top_component=top_component,
    #     text_val_inputs=text_val_inputs,
    #     text_val_weights=text_val_weights,
    #     weights_file_path=weights_file_path,
    #     inputs_file_path=inputs_file_path,
    #     outputs_file_path=outputs_file_path,
    #     read_val_weights_from_line=read_val_weights_from_line,
    #     inputs_val=inputs_val,
    #     inputs=inputs,
    #     outputs_concatenation=outputs_concatenation
    # )
    print(
        f"testbench_gen() -> tb_txt_gen() -> criando arquivo: {testbench_path}/{top_name}_tb.vhd")
    with open(f"{testbench_path}/{top_name}_tb.vhd", "w") as writer:
        writer.write(tb_txt)

from shift_reg import shift_reg_gen
import os
from pickle import TRUE
from MAC import *
from Create_Folders import create_folder_neuron
from vhd_txt_utils import entity, rom_component, port_map_ROM
from MAC import multiplication_mantissa
from dict_utils import dict_list_exceptNone
from components import mac_component
import numpy as np
from components import mac_component
from utils import input_sequences, all_inputs_signals, seq_input_output
from name import vhd_name
from standard_dicts import layer_dict_hidden, layer_dict_softmax
from components import entity_to_component
from Adders import adder_txt_gen
from Multipliers import multiplier_txt_gen


def tab_space(tab_space_num: int) -> str:
    """Função para retornar uma string vazia, com espaço de 'tab' 'tab_space_num' vezes.

    Args:
        tab_space_num (int): número de vezes que terá 'tab' na string vazia

    Returns:
        str: string vazia com 'tabs. Exemplo: tab_space_num = 2 --> tab_space_str = "      "
    """
    tab_space_str = ['  ']*tab_space_num
    tab_space_str = ''.join(map(str, tab_space_str))
    return tab_space_str


def reg_XW_sequence(num_inputs: int) -> tuple:
    """Função para gerar uma lista das sequências dos registradores:
    reg_x_sequence = ['reg_xi <= xi',...]
    reg_w_sequence = ['reg_wi <= wi',...]

    Args:
        num_inputs (int): Número de entradas

    Returns:
        _type_: _description_
    """
    reg_x_sequence = []
    reg_w_sequence = []

    i = 0

    while True:
        if (i < num_inputs):
            # reg_xi e reg_wi
            reg_x_sequence.append("reg_x"+str(i+1))
            reg_w_sequence.append("reg_w"+str(i+1))
            i = i+1

        else:
            i = 0
            break

    return reg_x_sequence, reg_w_sequence


def rst_receive_gen(num_inputs: int,
                    rst_space: int = 8) -> str:
    """Função para gerar atribuição de sinais para quando 'rst' = '1':
        IF rst = '1' THEN
            reg_x1 <= (OTHERS => '0');
            reg_x2 <= (OTHERS => '0');
            reg_x3 <= (OTHERS => '0');
            reg_x4 <= (OTHERS => '0');
            reg_x5 <= (OTHERS => '0');

            reg_w1 <= (OTHERS => '0');
            reg_w2 <= (OTHERS => '0');
            reg_w3 <= (OTHERS => '0');
            reg_w4 <= (OTHERS => '0');
            reg_w5 <= (OTHERS => '0');
            reg_bias <= (OTHERS => '0');

    Args:
        num_inputs (int): _description_
        rst_space (int, optional): _description_. Defaults to 4.

    Returns:
        str: _description_
    """
    rst_space = tab_space(tab_space_num=rst_space)
    reg_x_sequence, reg_w_sequence = reg_XW_sequence(num_inputs)

    rst_receive = []
    rst_receive.append(rst_space + "reg_out_ROM_act <= (OTHERS => '0');")
    rst_receive.append("")

    for i in range(0, len(reg_x_sequence)):
        rst_receive.append(
            rst_space + reg_x_sequence[i]+" <= (OTHERS => '0');")

    rst_receive.append("")

    for i in range(0, len(reg_w_sequence)):
        rst_receive.append(
            rst_space + reg_w_sequence[i]+" <= (OTHERS => '0');")

    rst_receive_string = '\n'.join(map(str, (rst_receive)))
    rst_receive_string = (rst_receive_string + "\n" +
                          rst_space + "reg_bias <= (OTHERS => '0');")
    return rst_receive_string


def clk_receive_gen(num_inputs: int,
                    clk_space: int = 4*2,
                    mux_in_Wi: bool = False) -> str:

    clk_space = tab_space(tab_space_num=clk_space)

    clk_receive = []
    clk_receive.append(
        clk_space + "reg_out_ROM_act <=  signed(out_ROM_act); ")
    clk_receive.append("")

    reg_x_sequence, reg_w_sequence = reg_XW_sequence(num_inputs)

    x_sequence = input_sequences('x', num_inputs, 'list', 0, 0)
    # -------------------------- MUX if ---------------------------------
    if mux_in_Wi == True:  # COM MUX na entrada
        #  IF update_weights = '0' THEN
        clk_receive.append(clk_space + "IF update_weights = '0' THEN ")

        # reg_xi <= xi;
        for i in range(0, len(reg_x_sequence)):
            clk_receive.append(clk_space + "   " +
                               reg_x_sequence[i]+" <= " + x_sequence[i] + ";")

        clk_receive.append("")
        # ELSE
        clk_receive.append(clk_space + "ELSE")
        # reg_wi <= wi
        for i in range(0, len(reg_w_sequence)):
            clk_receive.append(clk_space + "   " +
                               reg_w_sequence[i]+" <= " + x_sequence[i] + ";")

    else:
        # reg_xi <= xi;
        for i in range(0, len(reg_x_sequence)):
            clk_receive.append(clk_space[:-2] + "   " +
                               reg_x_sequence[i]+" <= " + x_sequence[i] + ";")

        clk_receive.append("")
        #  IF update_weights = '1' THEN
        clk_receive.append(clk_space + "IF update_weights = '1' THEN ")

        # reg_wi <= wi
        for i in range(0, len(reg_w_sequence)):
            clk_receive.append(clk_space + "   " +
                               reg_w_sequence[i]+" <= " + x_sequence[i] + ";")

    # -----------------------------------------------------------
    clk_receive.append(clk_space + "   " + "reg_bias <= bias;")
    clk_receive.append(clk_space[:-1] + "END IF;")

    clk_receive_string = '\n'.join(map(str, (clk_receive)))

    return clk_receive_string


def Neuron_Gen_from_dict(
        download_vhd: bool = True,
        layer_dict: dict = layer_dict_hidden,
        OUTPUT_BASE_DIR_PATH: str = "./NN/Neuron",
        DEBUG: bool = False):
    """Função para criar o neurônio (está bem gambiarra pois só copiei do script 'Python_vhd_script' e não ajustei ou aprimorei nada)

    Args:
        neuron_type (str, optional): Tipo de neurônio. Nesta função só temos 3 tipos:  'relu', 'leaky' e 'softmax'. Defaults to 'relu'.
        bits (int, optional): Largura de bits de representação para entradas, pesos e saída do neurônio. Defaults to 8.
        num_inputs (int, optional): Número de entradas do neurônio. Defaults to 3.
        IO_type (bool, optional): Tipo dos sinais de entrada, pesos e saída. True = signed, False = unsigned. Defaults to True.
        Barriers (bool, optional): Se possui barreira de registradores entre cada camada da árvore combinacional MAC (soma e multiplica). Defaults to True.
        Include_MAC_type (bool, optional): Se é para incluir o tipo do MAC no nome ('seq' ou 'comb'). Como esta função possui só a implementação da versão combinacional, este parâmetro nem faz sentido por enquanto. Defaults to True.
        leaky_attenuation (int, optional): Parâmetro usado apenas na versão 'leaky'. É o número de vezes que a função será dividida através de um 'shift right'. A incremento de 1 neste valor, a função é dividida por 2 (para valores de x menores que zero, conforme função Leaky ReLU). Defaults to 2.
        bits_mem (int, optional): Número de bits de representação da memória ROM/RAM. Normalmente o mesmo número dos bits de entrada/saída (parâmetro 'bits'). Defaults to 8.
        download_vhd (bool, optional): Se deseja fazer o download do arquivo '.vhd' do neurônio. True = download. Defaults to True.
        DEBUG (bool, optional): Parâmetro para imprimir algumas etapas da função. True = imprime. Defaults to False.
    """
    if DEBUG == True:
        print(" ====================================  COMEÇO Neuron_Gen_from_dict() ==================================== ")
    # neuron_type: str = 'relu',
    #  bits: int = 8,
    #  num_inputs: int = 3,
    #  IO_type: bool = True,
    #  Barriers: bool = True,
    #  Include_MAC_type: bool = True,
    #  leaky_attenuation: int = 2,
    #  bits_mem: int = 8,

    #! problema: MAC está pegando nome_MAC do dicionário (por padrão está sendo do 'layer_dict_hidden'), mas esta função está gernado o 'MAC_name' de outra forma, não pega do dict

    # ---------------- PEGA PARÂMETROS DO DICIONÁRIO -----------------------
    num_inputs, bits, IO_type, Neuron_name, Include_MAC_type, MAC_type, Barriers, fx_activation, n_bin, input_mem_bits, output_mem_bits = get_neuron_data_from_LayerDict(
        layer_dict=layer_dict)

    reg_txt, shift_reg_txt, reg_name, shift_reg_name = shift_reg_gen(
        num_inputs=num_inputs)
    # reg_txt = texto do '.vhd' de um registrador
    # shift_reg_txt = texto do '.vhd' de um registrador shift
    # print(shift_reg_txt)
    # reg_name = 'Reg'
    # shift_reg_name = 'shift_reg_name'

    output_name = dict_list_exceptNone(
        dict_slice=layer_dict['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)
    # output_name = [['IO_out'], ['W_out : OUT signed(BITS - 1 DOWNTO 0);']]
    output_name = output_name[0][0]  # problema aqui que não está
    # output_name = 'IO_out'

    neuron_type = fx_activation  # ReLU, Leaky, Softmax
    leaky_attenuation = layer_dict['Neuron_arch']['Activation_fx']['Leaky_ReLU']['Leaky_attenuation']
    # leaky_attenuation = int
    # IO_type = IO_type
    input_mem_bits = layer_dict['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['bits_mem']

    # -------------------- PRE DEFINED PARAMETERS --------------------

    # -------------------------- NOMES --------------------------
    # aqui estamos gerando o nome para cada um dos 3 tipos de neurônio e salvando em variáveis globais
    prefix_neuron = 'neuron_'
    fx_activation_dict = {
        'ReLU': f'{prefix_neuron}ReLU',
        'Leaky ReLU': f'{prefix_neuron}LeakyReLU',
        'Sigmoid': f'{prefix_neuron}Sigmoid'
    }
    neuron_ReLU_name = vhd_name(
        fx_activation_dict['ReLU'], bits, IO_type, num_inputs, Barriers, MAC_type, Include_MAC_type)

    neuron_Leaky_name = vhd_name(
        fx_activation_dict['Leaky ReLU'], bits, IO_type, num_inputs, Barriers, MAC_type, Include_MAC_type)
    neuron_Sigmoid_name = vhd_name(
        fx_activation_dict['Sigmoid'], bits, IO_type, num_inputs, Barriers, MAC_type, Include_MAC_type)

    if DEBUG:
        print(neuron_ReLU_name)
        print(neuron_Leaky_name)
        print(neuron_Sigmoid_name)

    # -----------------------------
    # ! tirar
    reg_x_sequence, reg_w_sequence = reg_XW_sequence(num_inputs)
    # reg_x_sequence = ['reg_x1', 'reg_x2', 'reg_x3', 'reg_x4', 'reg_x5']
    # reg_w_sequence = ['reg_w1', 'reg_w2', 'reg_w3', 'reg_w4', 'reg_w5']

    reg_x_sequence_string = ', '.join(map(str, (reg_x_sequence)))
    reg_w_sequence_string = ', '.join(map(str, (reg_w_sequence)))
    # reg_x_sequence_string = 'reg_x1, reg_x2, reg_x3, reg_x4, reg_x5'

    reg_x_sequence_string = reg_x_sequence_string + ","
    reg_w_sequence_string = reg_w_sequence_string + ","

    # ---------------------------- SEQUENCIAS ----------------------------
    rst_receive_string = rst_receive_gen(num_inputs=num_inputs)
    print(rst_receive_string)
    clk_receive_string = clk_receive_gen(
        num_inputs=num_inputs)
    # mux_in_Wi=mux_in_Wi)

    # ---------------------------- RELU ----------------------------
    mux_ReLU = ('''
                IF out_reg_MAC > 0 THEN
                    y <= out_reg_MAC;
                ELSE
                    y <= (OTHERS => '0');
                END IF;
    ''')

    rst_receive_string_middle = '\n'.join(rst_receive_string.splitlines()[2:])
    clk_receive_string_middle = '\n'.join(clk_receive_string.splitlines()[1:])

    # ---------------------------- LEAKY RELU -----------------------------------
    ones_leaky = str(np.ones(leaky_attenuation))
    ones_leaky = ones_leaky.replace(".", "")
    ones_leaky = ones_leaky.replace("[", "")
    ones_leaky = ones_leaky.replace("]", "")
    ones_leaky = ones_leaky.replace(" ", "")
    ones_leaky

    mux_LeakyReLU = (f'''
                IF out_reg_MAC > 0 THEN
                    y <= out_reg_MAC;
                ELSE
                    y <=  {ones_leaky} & out_reg_MAC(
        {str(bits -1)}  DOWNTO {str(leaky_attenuation)});
                END IF;
    ''')

    NEURON_LeakyReLU_INPUT_NET = (f'''
        PROCESS (clk, rst, update_weights)
        BEGIN
            IF rst = '1' THEN
{rst_receive_string_middle}


            ELSIF clk'event AND clk = '1' THEN
    {mux_LeakyReLU}
{clk_receive_string_middle}
            END IF;
        END PROCESS;
    ''')

    # =======================================================================================
    MAC_name = vhd_name(vhd_name='MAC',
                        bits=bits,
                        IO_type=IO_type,
                        num_inputs=num_inputs,
                        Barriers=Barriers,
                        MAC_type=MAC_type,
                        Include_MAC_type=Include_MAC_type,
                        mult_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0),
                        # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
                        mult_version=0,
                        adder_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
                        adder_version=0)

    # layer_dict = layer_dict_hidden
    output_name = dict_list_exceptNone(
        dict_slice=layer_dict['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)
    # ! pode dar problema caso n tenha o argumento: is_list = False
    output_name = output_name[0][0]  # problema aqui que não está generalizado

    W_in = layer_dict['Neuron_arch']['IO']['unique_IO']['IN']['manual'][0]

    mac_entity_txt = entity(name=MAC_name,
                            bits=layer_dict['Neuron_arch']['Bit_WIDTH'],
                            num_inputs=layer_dict['Neuron_arch']['Inputs_number'],
                            IO_dict_list=[layer_dict['Neuron_arch']['IO']['shared_IO'],
                                          layer_dict['Neuron_arch']['IO']['unique_IO']],
                            remove_dict_items=[
                                'Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);', 'update_weights'],
                            generic=True,
                            tab_space=1
                            )

    MAC_component = entity_to_component(mac_entity_txt)
    MAC_component = entity_to_component(
        entity_text=MAC_component,
        word=layer_dict['Neuron_arch']['IO']['unique_IO']['IN']['manual'][0],
        word_subs=f"{W_in.split(':')[0]} : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);")

    PORT_MAP_MAC = (f'''
        -- MAC ja registra a saida 
    U_MAC : {MAC_name} PORT MAP(
        clk, rst,
        IO_in,
        s_Wout,
        out_reg_MAC );''')
    # ----------------------------------
    shift_reg = True
    shift_reg_name = 'shift_reg'
    shift_reg_name_abrv = f"{shift_reg_name}_{num_inputs}n"

    if shift_reg:
        component_shift_reg = (f'''
    COMPONENT {shift_reg_name_abrv} IS
        GENERIC (
            BITS : NATURAL := BITS;
            NUM_INPUTS : NATURAL := NUM_INPUTS
        );
        PORT (
            clk, rst : IN STD_LOGIC;
            {W_in}
            -- Win : IN signed(BITS - 1 DOWNTO 0);
            W_out : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0)
        );
    END COMPONENT;
        ''')

        # port_map_shift_reg = (f'''
        # en_registers <= update_weights AND clk; -- tirar isso depois e colocar fora dos neurônios
        # inst_shift_reg : {shift_reg_name_abrv} PORT MAP(en_registers, rst, Win, s_Wout );
        # Wout <= s_Wout;''')
        port_map_shift_reg = (f'''
        inst_shift_reg : {shift_reg_name_abrv} PORT MAP(update_weights, rst, {W_in.split(':')[0]}, s_Wout ); 
        W_out <= s_Wout((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS + 0)));
''')
    else:
        component_shift_reg = ''
        port_map_shift_reg = ''
# -------------------------------------------------
    top_neuron_Leaky_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

{entity(neuron_Leaky_name, bits, num_inputs,[layer_dict['Neuron_arch']['IO']['shared_IO'], layer_dict['Neuron_arch']['IO']['unique_IO'] ], generic = True)}


ARCHITECTURE behavior of {neuron_Leaky_name} is
{MAC_component}
{component_shift_reg}
    -- #ROM_component

    SIGNAL out_reg_MAC : {IO_type}(({str(bits - 1)}) DOWNTO 0);	--reg da saida do MAC''' +
                            # {s_reg_x}
                            # {s_reg_w}
                            f'''
    SIGNAL s_Wout : {IO_type}((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    


BEGIN
{PORT_MAP_MAC}
{port_map_shift_reg}
    --#	 PORT_MAP_ROM
        {NEURON_LeakyReLU_INPUT_NET}

END behavior;'''
                            )

    top_neuron_ReLU_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

{entity(neuron_ReLU_name, bits, num_inputs,[layer_dict['Neuron_arch']['IO']['shared_IO'], layer_dict['Neuron_arch']['IO']['unique_IO']], remove_dict_items = [], generic = True )}

ARCHITECTURE behavior of {neuron_ReLU_name} is
{MAC_component}
{component_shift_reg}
    -- # ROM_component
    SIGNAL out_reg_MAC : {IO_type} (BITS-1 DOWNTO 0);	--reg da saida do MAC
    SIGNAL s_Wout : {IO_type}((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN
{PORT_MAP_MAC}
{port_map_shift_reg}
{f"{layer_dict['Neuron_arch']['IO']['unique_IO']['OUT']['SIGNED'][0]} <= out_reg_MAC;"}
END behavior;'''
                           )
    ROM_name = f"ROM_fx_{bits}bitaddr_{bits}width"
    ROM_component = rom_component(ROM_name, input_mem_bits, output_mem_bits)
    PORT_MAP_ROM = port_map_ROM(ROM_name, input_mem_bits, output_mem_bits)
    # ------
    shift_reg_sigmoid_port_map = port_map_shift_reg.split(
        ';')[0].replace('\n', '') + ';'
    top_neuron_soft_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

{entity(neuron_Sigmoid_name, bits, num_inputs,[layer_dict['Neuron_arch']['IO']['shared_IO'], layer_dict['Neuron_arch']['IO']['unique_IO'] ],generic = True)}


ARCHITECTURE behavior of {neuron_Sigmoid_name} is
{MAC_component}
{component_shift_reg}
{ROM_component}

    SIGNAL out_reg_MAC : {IO_type} (( {str(bits - 1)} ) DOWNTO 0);	--reg da saida do MAC
    SIGNAL out_ROM_act : STD_LOGIC_VECTOR( {str(bits - 1)} DOWNTO 0); --saida da ROM
    SIGNAL s_Wout : {IO_type}((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);

BEGIN
{PORT_MAP_MAC}
{shift_reg_sigmoid_port_map}
{PORT_MAP_ROM}

    {f"{layer_dict['Neuron_arch']['IO']['unique_IO']['OUT']['SIGNED'][0]} <= signed(out_ROM_act);"}


END behavior;'''
                           )

    TXT_MAC = MAC_TxtGen(MAC_name='MAC',
                         Include_MAC_type=Include_MAC_type,
                         rst_space=3*4,
                         clk_space=4*4,
                         layer_dict=layer_dict,  # tem que mudar aqui pra layer_dict
                         Barriers=Barriers
                         )

    Neurons_softmax = ['Sigmoid']
    Neurons_hidden = ['']

    if neuron_type == 'ReLU':   # ReLU
        Neurons_hidden = ['ReLU']
        gen_hidden = True
        gen_softmax = False
        path_hidden, path_soft = create_folder_neuron(
            bits,
            num_inputs,
            Neurons_hidden,
            Neurons_softmax,
            gen_hidden=gen_hidden,
            gen_softmax=gen_softmax,
            MAC_type=MAC_type,
            Barriers=Barriers,
            path=OUTPUT_BASE_DIR_PATH,
            create=True)
    elif neuron_type == 'Leaky_ReLU':  # Leaky ReLU
        Neurons_hidden = ['Leaky_ReLU']
        gen_hidden = True
        gen_softmax = False
        path_hidden, path_soft = create_folder_neuron(
            bits,
            num_inputs,
            Neurons_hidden,
            Neurons_softmax,
            gen_hidden=gen_hidden,
            gen_softmax=gen_softmax,
            MAC_type=MAC_type,
            Barriers=Barriers,
            path=OUTPUT_BASE_DIR_PATH,
            create=True)
    else:  # Sigmoid
        gen_hidden = False
        gen_softmax = True
        path_hidden, path_soft = create_folder_neuron(
            bits,
            num_inputs,
            Neurons_hidden,
            Neurons_softmax,
            gen_hidden=gen_hidden,
            gen_softmax=gen_softmax,
            MAC_type=MAC_type,
            Barriers=Barriers,
            path=OUTPUT_BASE_DIR_PATH,
            create=True)
    # wait
    path_others = path_soft[0].split('/')[0:3]
    # text_list can be an splitted text or a list of texts
    path_others = '/'.join(map(str, (path_others)))
    path_others = f"{path_others}/Others/"
    print(f"----------->>>>>>>>>>> path_others {path_others}")
    adder_txt_gen(layer_dict, path_others, create_path_folder=False)
    multiplier_txt_gen(layer_dict, path_others, create_path_folder=False)

    if download_vhd == True:

        path_soft = path_soft[0]
        path_ReLU = path_hidden[0]
        path_LeakyReLU = path_hidden[0]

        with open(f"{path_others}/{reg_name}.vhd", "w") as writer:
            writer.write(reg_txt)  # download Reg

        if neuron_type == 'ReLU':   # ReLU
            if DEBUG:
                print(
                    f"neuron_primitivo() -> criando arquivo: {path_ReLU}/{Neuron_name}.vhd")
                print(
                    f"neuron_primitivo() -> criando arquivo: {path_ReLU}/{MAC_name}.vhd")

            with open(f"{path_ReLU}/{neuron_ReLU_name}.vhd", "w") as writer:
                writer.write(top_neuron_ReLU_txt)  # download neurônio
            with open(f"{path_ReLU}/{MAC_name}.vhd", "w") as writer:
                writer.write(TXT_MAC)  # download MAC

            with open(f"{path_ReLU}/{shift_reg_name_abrv}.vhd", "w") as writer:
                writer.write(shift_reg_txt)  # download neurônio
            print("tentando gerar adder e multiplicador")

        if neuron_type == 'Leaky_ReLU':  # Leaky ReLU
            if DEBUG:
                print(
                    f"neuron_primitivo() -> criando arquivo: {path_LeakyReLU}/{Neuron_name}.vhd")
                print(
                    f"neuron_primitivo() -> criando arquivo: {path_LeakyReLU}/{MAC_name}.vhd")
            with open(f"{path_LeakyReLU}/{Neuron_name}.vhd", "w") as writer:
                writer.write(top_neuron_Leaky_txt)  # download neurônio
            with open(f"{path_LeakyReLU}/{MAC_name}.vhd", "w") as writer:
                writer.write(TXT_MAC)  # download MAC

            with open(f"{path_LeakyReLU}/{shift_reg_name_abrv}.vhd", "w") as writer:
                writer.write(shift_reg_txt)  # download

        if neuron_type == 'Sigmoid':  # SOFTMAX
            if DEBUG:
                print(
                    f"neuron_primitivo() -> criando arquivo: {path_soft}/{Neuron_name}.vhd")
                print(
                    f"neuron_primitivo() -> criando arquivo: {path_soft}/{MAC_name}.vhd")
            with open(f"{path_soft}/{Neuron_name}.vhd", "w") as writer:
                writer.write(top_neuron_soft_txt)  # download neurônio
            with open(f"{path_soft}/{MAC_name}.vhd", "w") as writer:
                writer.write(TXT_MAC)  # download MAC

            with open(f"{path_soft}/{shift_reg_name_abrv}.vhd", "w") as writer:
                writer.write(shift_reg_txt)  # download

    if DEBUG:
        print("--------------------- neuron_primitivo end -----------------------")

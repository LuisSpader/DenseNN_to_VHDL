import copy
from utils.GLOBALS import GLOBAL
from utils.SETTINGS import PARAMS
from utils.components.top import topDict_to_entityTxt
from utils.components.neuron_primitivo import *
from utils.layer_utils import *
from utils.standard_dicts import top_dict
from utils.general.shift_reg import parameters_vhd_gen

from itertools import chain, zip_longest
import sys
sys.path.append('./utils')
# -----------

# ! todo: colocar hierarquia na documentação -> de que forma quer essa hierarquia documentada?
# Done: refatorar para GEN_TOP_LEVEL_HDL
# TODO: modularizar FX ACTIVATION units
# import settings

# settings.init()          # Call only once
global remove_signals_list


def GEN_TOP_LEVEL_HDL(INPUTS_NUMBER: int = 3,
                      BIT_WIDTH: int = 8,
                      IO_TYPE_STR: str = 'signed',
                      LAYER_NEURONS_NUMBER_LIST: list = [3, 3, 3, 2],
                      BASE_DICT_HIDDEN: dict = layer_dict_hidden,
                      BASE_DICT_SOFTMAX: dict = layer_dict_softmax,
                      OUTPUT_BASE_DIR_PATH: str = './NN',
                      INCLUDE_PARAMETERS_ON_FOLDERNAME: bool = False,
                      DOWNLOAD_VHD: bool = True,
                      DEAD_NEURONS: bool = True,
                      DEBUG: bool = False
                      ):

    NUMBER_OF_LAYERS = len(LAYER_NEURONS_NUMBER_LIST)
    neurons_PM_matrix_local = PortMap_matrix(LAYER_NEURONS_NUMBER_LIST)
    # neurons_PM_matrix_local = [
    # ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
    # ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
    # ['c0_n2_W_out', 'c3_n2_W_out'],
    # ['c0_n3_W_out']
    # ]

    OUTPUT_BASE_DIR_PATH = generate_output_path(BIT_WIDTH, LAYER_NEURONS_NUMBER_LIST, BASE_DICT_HIDDEN,
                                                OUTPUT_BASE_DIR_PATH, INCLUDE_PARAMETERS_ON_FOLDERNAME, NUMBER_OF_LAYERS)

    print(" ================================== FAZENDO CAMADAS ==================================")
    layers_dict_list = all_dense_layers_gen(
        Inputs_number=INPUTS_NUMBER,
        bits=BIT_WIDTH,
        IO_type_str=IO_TYPE_STR,  # 'signed' or 'unsigned'
        number_of_layers=NUMBER_OF_LAYERS,
        Layer_Neurons_number_list=LAYER_NEURONS_NUMBER_LIST,
        base_dict_hidden_layers=BASE_DICT_HIDDEN,
        base_dict_softmax_layer=BASE_DICT_SOFTMAX,
        OUTPUT_BASE_DIR_PATH=f"{OUTPUT_BASE_DIR_PATH}",
        download_vhd=DOWNLOAD_VHD,
        gen_dead_neurons=DEAD_NEURONS,  # gera neurônios mortos
        DEBUG=DEBUG
    )
    PARAMS.layers_dict_list = layers_dict_list

    print(" ================================== FAZENDO NEURONIOS ==================================")

    for i, item in enumerate(layers_dict_list):
        PARAMS.layer_iteration = i
        Neuron_Gen_from_dict2(download_vhd=DOWNLOAD_VHD,
                              i=i,
                              layers_dict_list=layers_dict_list,
                              OUTPUT_BASE_DIR_PATH=f"{OUTPUT_BASE_DIR_PATH}/Neuron",
                              DEBUG=DEBUG)

    parameters_vhd_gen(
        BIT_WIDTH,
        parameters_vhd_name='parameters',
        OUTPUT_BASE_DIR_PATH=OUTPUT_BASE_DIR_PATH,
        create_path_folder=False
    )

    # ==================================== TOPO ====================================
    # https://youtube.com/watch?v=5mUUCl_4rGw&feature=shares
    # ----- port map -----
    lista_camada_inputs, lista_camada_outputs, txt_top_port_map = top_layers_port_map_0(
        layers_dict_list)
    # if DEBUG:
    print(" ==================================== TOP ==================================== ")
    # print(txt_top_port_map)
    # print(" ---------------------- IN  ---------------------- ")
    # print(lista_camada_inputs)
    # print(" ---------------------- OUT ---------------------- ")
    # print(lista_camada_outputs)

    # ---------------- PORT MAP NEURONS MATRIX
    txt_top_port_map_split = txt_top_port_map.split("\n")
    assign_list = []

    # lista de sinais para declarar dps: SIGNAL .... (... -1 downto 0);
    optimize_signal_declaration(
        neurons_PM_matrix_local, layers_dict_list, assign_list)

    # assign_list = [
    #     'c0_n0_W_out => c0_n0_W_out,',
    #     'c0_n1_W_out => c0_n1_W_out,',
    #     'c0_n2_W_out => c0_n2_W_out',
    #     'c1_n0_W_in => c0_n0_W_out,',
    #     'c2_n1_W_in => c0_n1_W_out,',
    #     'c3_n2_W_in => c0_n2_W_out,',
    #     'c2_n0_W_in => c1_n0_W_out,',
    #     'c3_n1_W_in => c2_n1_W_out,',
    #     'c3_n0_W_in => c2_n0_W_out,'
    # ]
    # txt_top_port_map

    # substituindo atribuição antiga (errada) por atribuição certa entre camadas
    for j, itemj in enumerate(txt_top_port_map_split):
        for item in assign_list:
            buff_original = itemj.split('=>')[0].strip()
            buff_subs = item.split('=>')[0].strip()
            if buff_subs in buff_original:
                txt_top_port_map_split[j] = item

    txt_top_port_map = '\n'.join(map(str, txt_top_port_map_split))

    # ------- entity ---------
    camada_inputs = extrai_lista_IO(list_IO=lista_camada_inputs)
    camada_outputs = extrai_lista_IO(list_IO=lista_camada_outputs)

    if DEBUG:
        # if True:
        print(
            f"layer_neurons_port_map_ALL() -> camada_inputs: {camada_inputs}")
        print(" \n")
        print(
            f"layer_neurons_port_map_ALL() -> camada_outputs: {camada_outputs}")
        print("-/-/-///-//-------/-/-//-//-/-/")

    l_inputs = list_concat_half(camada_inputs)
    l_outputs = list_concat_half(camada_outputs)

    # ['manual']
    l_inputs.append(camada_inputs[6])
    l_outputs.append(camada_outputs[6])

    # if True:
    if DEBUG:
        print(f"layer_neurons_port_map_ALL() -> l_inputs: {l_inputs}")
        print(f"layer_neurons_port_map_ALL() -> l_outputs: {l_outputs}")
        print("-/-/-///-//-------/-/-//-//-/-/")

    # substituindo '[]' por 'None'
    l_inputs = swap_empty_for_None(l_inputs)
    l_outputs = swap_empty_for_None(l_outputs)
    top_dict['Inputs_number'] = layers_dict_list[0]['Inputs_number']
    top_dict['bits'] = layers_dict_list[0]['bits']
    top_dict['IO']['IN']['STD_LOGIC'] = l_inputs[0]
    top_dict['IO']['IN']['STD_LOGIC_VECTOR'] = l_inputs[1]

    # https://stackoverflow.com/questions/46367233/efficient-way-to-union-two-list-with-list-or-none-value
    top_dict['IO']['IN']['SIGNED'] = l_inputs[2]

    # OK TODO: adicionar função para transformar top_dict['IO']['IN']['manual']
    top_dict['IO']['IN']['manual'] = l_inputs[3]

    top_dict['IO']['OUT']['STD_LOGIC'] = l_outputs[0]
    top_dict['IO']['OUT']['STD_LOGIC_VECTOR'] = l_outputs[1]

    top_dict['IO']['OUT']['SIGNED'] = l_outputs[2]
    # TODO: adicionar função para transformar top_dict['IO']['OUT']['manual']
    top_dict['IO']['OUT']['manual'] = l_outputs[3]


# ----------------
# https://youtu.be/oHSrqVhee_8
    nomes, nomes_all, remove_list = extract_IO_names(layers_dict_list)
# -----------------------------------------------------------------------------------------
    remove_items_from_nomes(nomes, nomes_all, remove_list)

    import itertools
    # list2d = [[1,2,3], [4,5,6], [7], [8,9]]
    signals_assign_txt = generate_signal_assignments(
        layers_dict_list, nomes, nomes_all, itertools)
    # --------------------------

    # https://youtu.be/aWCWZpIZYjY
    # https://www.youtube.com/watch?v=hdPC2G8NPHI&list=PL35tBJQqzeIuV6qlkvqiZy9ivc9IROLWh&index=29&t=1597s
    top_entity = topDict_to_entityTxt(top_dict=top_dict,
                                      IO_dict_compare=layers_dict_list[0],
                                      remove_dict_items=[],
                                      generic=True)
    txt_top_port_map = txt_top_port_map.replace(
        'update_weights=> update_weights,', 'update_weights=> en_registers,')

    top_text = Top_txt(DEBUG, txt_top_port_map, signals_assign_txt, top_entity)
    download_vhd = True
    # salvando VHDL
    if download_vhd:
        top_dir = f"{OUTPUT_BASE_DIR_PATH}/{top_dict['Top_name']}.vhd"
        with open(top_dir, "w") as writer:
            writer.write(top_text)
        # print(f"3 - layers_dict_list[{i}]: {layers_dict_list[i]['IO']['OUT']}")
        # if DEBUG:
        print(f"top_gen() -> Criando Top: {top_dir}")


def generate_signal_assignments(layers_dict_list, nomes, nomes_all, itertools):
    """
    Generates signal assignments for signals that are passed between layers.

    Args:
        layers_dict_list (list): A list of dictionaries containing layers.
        nomes (list): A list of signals passed as arguments to the layers.
        nomes_all (list): A list of all other signals.
        itertools (module): A module that provides a set of tools for working
            with iterables.

    Returns:
        str: A string containing the signal assignments.
    """
    nomes_all = list(itertools.chain.from_iterable(nomes_all))

    # Create signals manually
    for i, item in enumerate(nomes):
        for j, itemj in enumerate(item):
            if 'IN' in nomes[i][j][1]:
                nomes[i][j][1] = nomes[i][j][1].replace('IN', '')
            if 'OUT' in nomes[i][j][1]:
                nomes[i][j][1] = nomes[i][j][1].replace('OUT', '')

        if nomes[i] != []:
            names = f"{', '.join(map(str, (nomes[i][0][0])))}"
            if 'W_out' not in names:
                type_s = nomes[i][0][1]
                signals.signals_dec.append(f"SIGNAL {names}:{type_s}")

    # Create signals normally (for all other IOs)
    for i, item in enumerate(nomes_all):
        names = f"{', '.join(map(str, (nomes_all[i][0][0])))}"
        type_s = nomes_all[i][0][1]
        signals.signals_dec.append(
            f"SIGNAL {names}: {type_s}(BITS -1 DOWNTO 0);")

    signals.signals_to_text()

    # Create signal assignments for all signals that are passed between layers
    buff = [[] for _ in range(len(layers_dict_list))]

    for item in signals.signals_stack:
        if 'IO_out' in item[0]:
            buff[item[1]+1].append(item[0])

    for item in signals.signals_stack:
        if 'IO_in' in item[0]:
            buff[item[1]
                 ] = f"{item[0]} <= {' & '.join(map(str, (buff[item[1]])))};"

    signals_assign_stack = [x for x in buff if x != []]
    signals_assign_txt = '\n'.join(map(str, (signals_assign_stack)))
    return signals_assign_txt


def remove_items_from_nomes(nomes, nomes_all, remove_list):
    """
    Removes items from a list of names.

    Args:
    - nomes: a list of lists, where each list contains tuples with names.
    - nomes_all: a list of lists, where each list contains a list with tuples with names.
    - remove_list: a list of items to be removed.

    Returns:
    - Nothing, but the input lists are modified.
    """
    remove_list = copy.deepcopy(remove_list)
    for i, item in enumerate(remove_list):
        for j, item2 in enumerate(item):
            if ':' in item2:
                remove_list[i][j] = item2.split(':')[0].replace(' ', '')

    remove_list = [item for sublist in remove_list for item in sublist]

    global remove_signals_list
    remove_signals_list = list(dict.fromkeys(remove_list))

    for j in range(len(nomes)):
        remove_signals_list = [
            x for x in remove_signals_list if f"c{j}" not in x]

    # loop para remover itens que não são os sinais descritos (usa a lista remove_signals_list)
    remove_items_from_layer(nomes, nomes_all)
    # remove_items_from_layers(nomes, nomes_all)


def remove_items_from_layer(nomes, nomes_all):
    """
    Removes specific items from a layer.
    The following function takes in two lists, "nomes" and "nomes_all", and removes specific items from them based on a list called "remove_signals_list". The function loops through each layer of the input lists, then removes the items that match the items in the "remove_signals_list" from the layers.

    Args:
        layer (list): List of items to remove from.
        item_list (list): List of items to remove.

    Returns:
        list: The layer with the specified items removed.
    """
    for l, layer in enumerate(nomes):  # layer
        for item_s in remove_signals_list:  # lista de itens para excluir
            length = len(layer)
            f = 0
            while f < length:  # loop para lista que diminui seu tamanho
                if isinstance(layer[f][0], str):
                    nomes[l] = [x for x in nomes[l] if item_s not in x[0]]
                    f -= 1
                    length -= 1
                elif isinstance(layer[f][0], list):
                    if item_s in layer[f][0]:
                        layer[f][0].remove(item_s)
                        f -= 1
                        length -= 1
                f += 1

    for l, layer in enumerate(nomes_all):
        for item_s in remove_signals_list:  # lista de itens para excluir
            length = len(layer)
            f = 0
            while f < length:  # loop para lista que diminui seu tamanho
                if isinstance(layer[f][0], str):
                    nomes_all[l] = [x for x in nomes_all[l]
                                    if item_s not in x[0]]
                    f -= 1
                    length -= 1
                elif isinstance(layer[f][0], list):
                    for x, itemx in enumerate(layer[f][0][0]):
                        if item_s == itemx:
                            del layer[f][0][0][x]
                            if layer[f][0][0] == []:
                                del layer[f]
                                f -= 1
                                length -= 1
                f += 1


def remove_items(nomes, nomes_all, remove_list):
    """
    This function removes specific items from the input list of lists 'nomes' and 'nomes_all' based on a provided list
    'remove_list'. The function modifies the input lists directly and does not return anything.

    Args:
    - nomes (list of lists): A list of lists containing strings or other lists.
    - nomes_all (list of lists): A list of lists containing strings or other lists.
    - remove_list (list of str): A list of strings to be removed from the input lists.

    Example:
    >>> nomes = [['A', ['B', 'C']], ['D', 'E']]
    >>> nomes_all = [['F'], ['G', ['H', 'I']]]
    >>> remove_list = ['A', 'B', 'H']
    >>> remove_items(nomes, nomes_all, remove_list)
    >>> print(nomes)
    [['D', 'E']]
    >>> print(nomes_all)
    [['F'], ['G', ['I']]]
    """
    remove_list = [item.split(':')[0].strip(
    ) if ':' in item else item for sublist in remove_list for item in sublist]
    remove_signals_list = list(dict.fromkeys(remove_list))
    for layer in [nomes, nomes_all]:
        for l, sub_list in enumerate(layer):
            length = len(sub_list)
            f = 0
            while f < length:
                if isinstance(sub_list[f][0], str):
                    layer[l] = [x for x in layer[l] if sub_list[f]
                                [0] not in remove_signals_list]
                    f -= 1
                    length -= 1
                elif isinstance(sub_list[f][0], list):
                    if any(signal in sub_list[f][0] for signal in remove_signals_list):
                        sub_list[f][0] = [signal for signal in sub_list[f]
                                          [0] if signal not in remove_signals_list]
                        f -= 1
                        length -= 1
                    if sub_list[f][0] == []:
                        del sub_list[f]
                        f -= 1
                        length -= 1
                f += 1


def optimize_signal_declaration(neurons_PM_matrix_local, layers_dict_list, assign_list):
    """
    Optimize signal declaration by assigning 'out' signal of neuron[i] to 'in' signal of neuron[i-1].
    This function optimizes signal declaration by assigning the 'out' signal of neuron[i] to the 'in' signal of neuron[i-1]. It takes a list of lists containing the signal names of each neuron, a list of layer dictionaries, where each layer dictionary contains layer details, and a list of signal assignments. It returns nothing.

    Args:
    - neurons_PM_matrix_local: list of lists containing the signal names of each neuron
    - layers_dict_list: list of layer dictionaries, where each layer dictionary contains layer details
    - assign_list: list of signal assignments

    Returns:
    - None

    Example:
    - Input: optimize_signal_declaration([['c1_n0_W_out', 'c2_n0_W_out'], ['c1_n1_W_out', 'c2_n1_W_out'], ['c2_n2_W_out'], ['c2_n3_W_out']], [{'IO_type': 'signed', 'Neuron_number': 4, 'Activation_func': 'linear'}, {'IO_type': 'signed', 'Neuron_number': 2, 'Activation_func': 'linear'}], [])
    - Output: None
    """
    signals_Wout_list = []

    for l, layer in enumerate(layers_dict_list):
        for n, neuron in enumerate(neurons_PM_matrix_local):
            if l != 0:
                try:
                    # (c1_n0_W_out).replace('out','in') => c0_n0_W_out;
                    assign_list.append(
                        f"            {neurons_PM_matrix_local[n][1].replace('out','in')}=> {neurons_PM_matrix_local[n][0]},")
                    # lista para declaração dos sinals 'SIGNAL c0_n0_W_out, ... : signed(BITS -1 DOWNTO 0);
                    signals_Wout_list.append(neurons_PM_matrix_local[n][0])
                    del neurons_PM_matrix_local[n][0]

                except:
                    del neurons_PM_matrix_local[n]  # c0_n3_W_out retirar

    signals.signals_dec.append(
        f"SIGNAL {', '.join(map(str, (signals_Wout_list)))}: {layers_dict_list[0]['IO_type']}(BITS - 1 DOWNTO 0);")


def generate_output_path(BIT_WIDTH, LAYER_NEURONS_NUMBER_LIST, BASE_DICT_HIDDEN, OUTPUT_BASE_DIR_PATH, INCLUDE_PARAMETERS_ON_FOLDERNAME, NUMBER_OF_LAYERS):
    """Optimized function that returns the path for saving the output files.

    Args:
        BIT_WIDTH (int): Bit width for the output files.
        LAYER_NEURONS_NUMBER_LIST (list): List of integers with the number of neurons in each layer.
        BASE_DICT_HIDDEN (dict): Dictionary with the base architecture for the hidden layers.
        OUTPUT_BASE_DIR_PATH (str): Base directory path for the output files.
        INCLUDE_PARAMETERS_ON_FOLDERNAME (bool): True to include parameters on folder name, False otherwise.
        NUMBER_OF_LAYERS (int): Number of layers.

    Returns:
        - output_path (str): The output path for the neural network model.

    Example:
    >>> generate_output_path(8, [4, 3, 2, 1], {"Neuron_arch": {"Barriers": True}}, "/home/user/models", True, 4)
    "/home/user/models/NN_4Layers_8bits_4_3_2_1_Barriers"
    """
    barriers = ''
    if BASE_DICT_HIDDEN['Neuron_arch']['Barriers']:
        barriers = '_Barriers'

    arch = '_' + '_'.join(map(str, LAYER_NEURONS_NUMBER_LIST))

    if INCLUDE_PARAMETERS_ON_FOLDERNAME:
        path_parameters = f"{OUTPUT_BASE_DIR_PATH}/NN_{NUMBER_OF_LAYERS}Layers_{BIT_WIDTH}bits{arch}{barriers}"
        OUTPUT_BASE_DIR_PATH = path_parameters
    else:
        OUTPUT_BASE_DIR_PATH = OUTPUT_BASE_DIR_PATH

    PARAMS.path = OUTPUT_BASE_DIR_PATH

    return OUTPUT_BASE_DIR_PATH


def PortMap_matrix(LAYER_NEURONS_NUMBER_LIST):
    """
    This function generates a neuron port map matrix based on the input list.

    Args:
    - LAYER_NEURONS_NUMBER_LIST (list): a list containing the number of neurons for each layer.

    Returns:
    - neurons_PM_matrix_local (list): a list representing the neuron port map matrix.

    Example:
    >>> PortMap_matrix([4, 3, 2, 1])
    [['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
     ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
     ['c0_n2_W_out', 'c3_n2_W_out'],
     ['c0_n3_W_out']]
    """
    global layers_dict_list
    layers_dict_list = []

    # port_map between layers ()
    port_map_neurons_list = copy.deepcopy(LAYER_NEURONS_NUMBER_LIST)
    GLOBAL.PM_MATRIX.neurons_PM_matrix = [[]
                                          for _ in range(len(port_map_neurons_list))]

    # generating signal matrix
    for i, item in enumerate(port_map_neurons_list):
        for j in range(item):
            GLOBAL.PM_MATRIX.neurons_PM_matrix[i].append(f"c{i}_n{j}_W_out")

    GLOBAL.PM_MATRIX.neurons_PM_matrix = list(
        map(list, zip_longest(*GLOBAL.PM_MATRIX.neurons_PM_matrix, fillvalue=None)))
    neurons_PM_matrix_local = copy.deepcopy(GLOBAL.PM_MATRIX.neurons_PM_matrix)

    for i, item in enumerate(GLOBAL.PM_MATRIX.neurons_PM_matrix):
        neurons_PM_matrix_local[i] = [x for x in item if x is not None]

    return neurons_PM_matrix_local


def extract_IO_names(layers_dict_list):
    # https://youtube.com/watch?v=oHSrqVhee_8&feature=shares
    """
    Extracts the names and types of the inputs and outputs of a neural network model.

    Args:
    layers_dict_list (list): A list of dictionaries containing the architecture and settings of each layer of a neural network.

    Returns:
    list[list]: A list of lists, where each sub-list represents a layer in the model, and contains sub-lists representing the input and output names and types. Each sub-list has the following format:
        [
            [name_1, type_1],
            [name_2, type_2],
            ...,
            [name_n, type_n]
        ]
        where each name is a string representing the name of an input/output signal, and each type is a string representing the data type of the corresponding signal.

    Example:
    layers_dict_list = [
        {
            "Neuron_arch": {
                "IO": {
                    'unique_IO': {  # Entradas únicas ao neurônio
                        # 'IO':{ # INPUT & OUTPUT
                        'IN': {  # ENTRADAS
                            'STD_LOGIC': None,
                            'STD_LOGIC_VECTOR': None,
                            'SIGNED': None,
                            'STD_LOGIC_num_inputs': None,
                            'STD_LOGIC_VECTOR_num_inputs': None,
                            'SIGNED_num_inputs': None,
                            'manual': ['W_in : IN signed(BITS - 1 DOWNTO 0);']
                        },
                        'OUT': {  # SAÍDAS
                            'STD_LOGIC': None,
                            'STD_LOGIC_VECTOR': None,
                            'SIGNED': ['IO_out'],
                            'STD_LOGIC_VECTOR_num_inputs': None,
                            'STD_LOGIC_num_inputs': None,
                            'SIGNED_num_inputs': None,
                            'manual': ['W_out : OUT signed(BITS - 1 DOWNTO 0);']
                        },
                    'shared_IO': {  # Entradas & saídas compartilhadas
                        'IN': {  # ENTRADAS
                            'STD_LOGIC': ['clk', 'rst', 'update_weights'],
                            'STD_LOGIC_VECTOR': None,
                            'SIGNED': None,
                            'STD_LOGIC_num_inputs': None,
                            'STD_LOGIC_VECTOR_num_inputs': None,
                            'SIGNED_num_inputs': None,
                            'manual': ['IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);']
                        },
                        'OUT': {  # SAÍDAS
                            'STD_LOGIC': None,
                            'STD_LOGIC_VECTOR': None,
                            'SIGNED': None,
                            'STD_LOGIC_VECTOR_num_inputs': None,
                            'STD_LOGIC_num_inputs': None,
                            'SIGNED_num_inputs': None,
                            'manual': None
                        }
                    }
                }
            }
        },
            "Inputs_number": 2
        }
    ]
    extract_IO_names(layers_dict_list)
    # Output:
    # [
    #     [ # layer_0
    #         ['IO_in', ' IN signed((BITS*5) - 1 DOWNTO 0);'],
    #         ['W_in', ' IN signed(BITS - 1 DOWNTO 0);'],
    #         [['W_out', 'c0_n0_W_out', 'c0_n1_W_out', 'c0_n2_W_out', 'c0_n3_W_out', 'c0_n4_W_out'], 
                ' OUT signed(BITS - 1 DOWNTO 0);']

    #     ],
    #     [ # layer_1
    #         [['IO_in', 'c1_IO_in'], ' IN signed((BITS*6) - 1 DOWNTO 0);'],
    #         ['W_in', ' IN signed(BITS - 1 DOWNTO 0);'],
    #         [['W_out', 'c1_n0_W_out', 'c1_n1_W_out', 'c1_n2_W_out'], ' OUT signed(BITS - 1 DOWNTO 0);']
    #     ],
    #   ...,
    # ]
    """
    # https://youtube.com/watch?v=oHSrqVhee_8&feature=shares
    list_IN = [[] for _ in range(len(layers_dict_list))]
    list_OUT = [[] for _ in range(len(layers_dict_list))]
    list_IN_manual = [[] for _ in range(len(layers_dict_list))]
    list_OUT_manual = [[] for _ in range(len(layers_dict_list))]
    nomes = [None]*len(layers_dict_list)
    nomes_all = [[None]*2
                 for _ in range(len(layers_dict_list))]
    remove_list = []

    # criando lista das entradas e saídas (IO) e seus tipos
    for j in range(0, len(layers_dict_list)):
        # salvando nomes & tipos
        extract_io_info(layers_dict_list, list_IN, list_OUT, j)

        remove_list = get_remove_list(layers_dict_list, remove_list, j)
    # ---------------------------------------------------

        # removendo 'manual'
        for i in range(0, len(list_IN[j])):
            list_IN_manual[j].append(list_IN[j][i][-1])
            list_OUT_manual[j].append(list_OUT[j][i][-1])
            list_IN[j][i].pop()
            list_OUT[j][i].pop()

        # -------- ALL -------------
        nomes_all[j][0] = get_namesANDtypes_normal_IO(
            list_IN[j])  # nomes_all[layer[IN,OUT]]

        nomes_all[j][1] = get_namesANDtypes_normal_IO(
            list_OUT[j])  # nomes_all[layer[IN,OUT]]

        # ------------ MANUAL --------------
        nomes[j] = nomes_sinais(list_IN_manual, list_OUT_manual, nomes, j)

        # substituindo 'TOTAL_BITS' e 'NUM_INPUTS'
        replace_TOTALBITS_NUMINPUTS(layers_dict_list, nomes, j)

        # comparando pilha de sinais salvos em settings.signals_stack e concatenando na lista 'nomes'
        process_signals(nomes, nomes_all, j)
    return nomes, nomes_all, remove_list


def get_remove_list(layers_dict_list, remove_list, j):
    """
    Given a list of layers' dictionaries, remove_list, and an index j, return a new list of items to be removed 
    from the layers_dict_list.

    Parameters:
    - layers_dict_list (list of dict): a list of dictionaries containing the architecture of each layer
    - remove_list (list): a list of items to be removed from the layers_dict_list
    - j (int): the index of the current layer

    Returns:
    - remove_list (list): a new list of items to be removed from the layers_dict_list
    """
    shared_IO = layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']
    unique_IO = layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']

    remove_list += dict_list_exceptNone(unique_IO['IN'],
                                        return_value_or_key='value', is_list=False)
    remove_list += dict_list_exceptNone(shared_IO['IN'],
                                        return_value_or_key='value', is_list=False)
    remove_list += dict_list_exceptNone(unique_IO['OUT'],
                                        return_value_or_key='value', is_list=False)
    remove_list += dict_list_exceptNone(shared_IO['OUT'],
                                        return_value_or_key='value', is_list=False)
    return remove_list


def extract_io_info(layers_dict_list, list_IN, list_OUT, j):
    """
    Extracts input and output information from a layer dictionary and appends it to two lists.

    Args:
    layers_dict_list (list): A list of dictionaries containing layer information.
    list_IN (list): A list to store input information.
    list_OUT (list): A list to store output information.
    j (int): The index of the layer to extract information from.

    Returns:
    None
    """
    shared_IO = layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']
    unique_IO = layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']

    # Saving input information
    list_IN[j].extend([dict_to_list(shared_IO['IN'], True),
                       dict_to_list(shared_IO['IN'], False),
                       dict_to_list(unique_IO['IN'], True),
                       dict_to_list(unique_IO['IN'], False)])

    # Saving output information
    list_OUT[j].extend([dict_to_list(shared_IO['OUT'], True),
                        dict_to_list(shared_IO['OUT'], False),
                        dict_to_list(unique_IO['OUT'], True),
                        dict_to_list(unique_IO['OUT'], False)])

    return None


def dict_to_list(target_dict, key_or_value) -> list:
    """
    Extracts either keys or values from a dictionary and returns them as a list.

    Args:
    target_dict (dict): The dictionary to extract keys or values from.
    key_or_value (bool): If True, extracts the keys. If False, extracts the values.

    Returns:
    A list of either keys or values from the target dictionary.
    """
    if key_or_value:
        return list(target_dict.keys())
    else:
        return list(target_dict.values())


def process_signals(nomes, nomes_all, layer):
    """
    Process signals and update the given lists of signal names.

    Parameters:
    nomes (list): A list of signal names for the specified layer.
    nomes_all (list): A list of signal names for all layers.
    layer (int): The layer to process signals for.

    Returns:
    None
    """
    for signal in signals.signals_stack:
        txt_depois = signal[0].split("_")[-2:]
        txt_depois = f"{txt_depois[0]}_{txt_depois[1]}"
        # txt_depois = '_'.join(
        #     map(str, (signal[0].split(f"_")[-2:])))
        if signal[1] == layer:
            for k, item in enumerate(nomes[layer]):
                if txt_depois in item[0]:
                    s = signal[0]
                    if isinstance(nomes[layer][k][0], str):
                        nomes[layer][k][0] = [nomes[layer][k][0]]
                    nomes[layer][k][0].append(s)

            for k, item in enumerate(nomes_all[layer]):
                if isinstance(item[0], str):
                    if txt_depois in item[0]:
                        s = signal[0]
                        if isinstance(nomes_all[layer][k][0], str):
                            nomes_all[layer][k][0] = [nomes_all[layer][k][0]]
                        nomes_all[layer][k][0].append(s)
                elif isinstance(item[0], list):
                    for item_l in item[0]:
                        if txt_depois in item_l:
                            s = signal[0]
                            nomes_all[layer][k][0][0].append(s)


def replace_TOTALBITS_NUMINPUTS(layers_dict_list, nomes, j):
    # substituindo 'TOTAL_BITS' e 'NUM_INPUTS'
    for i, item in enumerate(nomes[j]):
        if 'TOTAL_BITS' in item[1]:
            nomes[j][i][1] = item[1].replace(
                'TOTAL_BITS', f"(BITS*{str(layers_dict_list[j]['Inputs_number'])})")
        if 'NUM_INPUTS' in item[1]:
            nomes[j][i][1] = item[1].replace('NUM_INPUTS', str(
                layers_dict_list[j]['Inputs_number']))


def nomes_sinais(list_IN_manual, list_OUT_manual, nomes, j):
    buff_nomes = []
    # lista de nomes dos sinais
    for item in list_IN_manual[j]:
        if item != []:
            if ':' in item[0]:
                buff_nomes.append(
                    [item[0].split(':')[0].replace(' ', ''), item[0].split(':')[1]])

        # lista dos tipos dos sinais
    for item in list_OUT_manual[j]:
        if item != [] and item != None:
            if ':' in item[0]:
                buff_nomes.append(
                    [item[0].split(':')[0].replace(' ', ''), item[0].split(':')[1]])
    return buff_nomes


def Top_txt(DEBUG, txt_top_port_map, signals_assign_txt, top_entity):
    """
    Generates the textual description of the top-level entity in VHDL.

    Args:
    - DEBUG: A boolean flag that indicates whether to print additional debug information.
    - txt_top_port_map: A string containing the textual description of the port map between layers.
    - signals_assign_txt: A string containing the textual description of the signal assignments.
    - top_entity: A string containing the name of the top-level entity.

    Returns:
    - top_text: A string containing the VHDL code for the top-level entity.

    This function takes as input the debug flag, a string with the port map between the layers,
    a string with the signal assignments, and the name of the top-level entity. It then generates
    the VHDL code for the top-level entity with the given inputs.
    """
    if DEBUG:
        print(top_dict)
        print(f''' - -------- TOP ENTITY - --------
{top_entity}''')

    top_text = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
{top_entity}
ARCHITECTURE arch OF  {top_dict['Top_name']}  IS
-- SIGNALS
{signals.signals_txt}
    SIGNAL reg_IO_in: signed(TOTAL_BITS - 1 DOWNTO 0);
    SIGNAL en_registers: STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  {signals_assign_txt}
  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;
{txt_top_port_map}
END ARCHITECTURE;
'''
                )

    return top_text


def top_layers_port_map_0(layers_dict_list: list, DEBUG: bool = False):
    """This function generates a textual description of the port map between the layers of a neural network. It takes as input a list of dictionaries representing the layers, and returns a tuple containing the input and output ports for each layer, as well as a string describing the port map. The results need to be tuned later to correctly map the layers

    Args:
        layers_dict_list (list): A list of dictionaries representing neural network layers.

    Returns:
        (lista_camada_inputs, lista_camada_outputs, txt_top_port_map) tuple: 
            lista_camada_inputs: A list of input ports for each layer.
            lista_camada_outputs: A list of output ports for each layer.
            txt_top_port_map: A string containing the port map between layers.

    """
    txt_list = []
    lista_camada_inputs = []
    lista_camada_outputs = []
    txt = ''

    # gerando texto inicial de port_map entre camadas
    for j, item_j in enumerate(layers_dict_list):
        txt, camada_inputs, camada_outputs = (entity_port_map_i_iplus1(
            i=j,
            dict_list=layers_dict_list,
            # num_inputs=INPUTS_NUMBER,
            ID_camada=f"c{str(j)}"))

        txt_list.append(txt)
        if j == 0:  # PRIMEIRA CAMADA
            lista_camada_inputs.append(camada_inputs)
            # print(camada_inputs)

        if j == (len(layers_dict_list) - 1):  # ÚLTIMA CAMADA
            lista_camada_outputs.append(camada_outputs)
            # print(camada_outputs)

    txt_top_port_map = ''.join(map(str, txt_list))
    if DEBUG:
        print(txt_top_port_map)
        print(" ---------------------- IN  ---------------------- ")
        print(lista_camada_inputs)
        print(" ---------------------- OUT ---------------------- ")
        print(lista_camada_outputs)
    return lista_camada_inputs, lista_camada_outputs, txt_top_port_map


def get_namesANDtypes_normal_IO(list_IO):
    buff_nomes = []
    buff_tipos = []
    # lista de nomes dos sinais
    for i in range(0, len(list_IO), 2):  # itera sobre 'shared_IO' ou 'unique_IO'
        item = list_IO[i]
        for k, tipo in enumerate(item):  # itera sobre tipos e nomes
            IO_name = list_IO[i+1][k]
            # for m, item3 enumerate(item2):
            if IO_name != None:
                # verificando se já existe o mesmo tipo, ex 'SIGNED' e coloca nos mesmos índices
                tipo_anterior = list_IO[i-2][k]
                try:
                    if tipo == tipo_anterior and (i-2 >= 0) and buff_nomes[k] != []:

                        if isinstance(IO_name, list):  # se for do tipo lista
                            for name in IO_name:  # itera sobre itens da lista
                                # se já n possui item igual
                                if not name in buff_nomes[k]:
                                    buff_nomes[k].append(name)
                        else:  # se não for lista
                            # se já n possui item igual
                            if not IO_name in buff_nomes[k]:
                                buff_nomes[k].append(IO_name)
                    else:
                        buff_nomes.append([IO_name, tipo])
                        # buff_nomes.append(IO_name)
                        # buff_tipos.append(tipo)
                except:
                    buff_nomes.append([IO_name, tipo])
                    # buff_nomes.append(IO_name)
                    # buff_tipos.append(tipo)

    return buff_nomes


def remove_Non_Signals(nomes, tipos):
    # for x, name_0 in enumerate(nomes):
    for y, name_1 in enumerate(nomes):
        # itens da lista: remove nome e tipo
        for j, name_2 in enumerate(name_1):
            i = 0
            # length = len(nomes[x][y])
            length = len(nomes[y])
            while i < length and j < length:
                # buff_nomes = f"nomes[{y}][{j}]: {nomes[y][j]}"
                # buff_tipos = f"tipos[{y}][{j}]:{tipos[y][j]}"
                buff = name_1[j]

                if buff == 'IO_in' or buff == 'W_in' or buff == 'W_out':
                    # del nomes[x][y][j]
                    # del tipos[x][y][j]
                    del nomes[y][j]
                    del tipos[y][j]
                    i -= 1

                else:
                    # sub_itens da lista: remove só o nome
                    for k, name3 in enumerate(name_1[j]):
                        length2 = len(name_1[j])
                        f = 0
                        while f < length2:
                            # buff_nomes = f"nomes[{y}][{j}][{k}]: {nomes[y][j][k]}"
                            # buff_tipos = f"tipos[{y}][{j}]: {tipos[y][j]}"
                            buff = name_1[j][k]

                            if buff == 'IO_in' or buff == 'W_in' or buff == 'W_out':
                                # del nomes[x][y][j][k]
                                del nomes[y][j][k]
                                f -= 1
                            length2 -= 1
                            f += 1
                length -= 1
                i += 1

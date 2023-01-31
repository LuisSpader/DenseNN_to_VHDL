# from standard_dicts import layer_dict_hidden, layer_dict_softmax
from neuron_primitivo import *
from layer_utils import *
from shift_reg import parameters_vhd_gen
from standard_dicts import top_dict
from top import topDict_to_entityTxt
from itertools import chain
# ! todo: colocar hierarquia na documentação -> de que forma quer essa hierarquia documentada?
# Done: refatorar para GEN_TOP_LEVEL_HDL
# TODO: modularizar FX ACTIVATION units


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
    layer_dict_list = []
    print(" ================================== FAZENDO CAMADAS ==================================")
    layer_dict_list = all_dense_layers_gen(
        Inputs_number=INPUTS_NUMBER,
        bits=BIT_WIDTH,
        IO_type_str=IO_TYPE_STR,  # 'signed' or 'unsigned'
        number_of_layers=NUMBER_OF_LAYERS,
        Layer_Neurons_number_list=LAYER_NEURONS_NUMBER_LIST,
        base_dict_hidden_layers=BASE_DICT_HIDDEN,
        base_dict_softmax_layer=BASE_DICT_SOFTMAX,
        OUTPUT_BASE_DIR_PATH=f"{OUTPUT_BASE_DIR_PATH}",
        Include_parameters_on_FolderName=INCLUDE_PARAMETERS_ON_FOLDERNAME,
        download_vhd=DOWNLOAD_VHD,
        gen_dead_neurons=DEAD_NEURONS,  # gera neurônios mortos
        DEBUG=DEBUG
    )
    # for i in range(0, len(layer_dict_list)):
    #     print(
    #         f"All_NN() _> dict[{i}] -> num_inputs: {layer_dict_list[i]['Neuron_arch']['Inputs_number']()}")
    OUTPUT_BASE_DIR_PATH = OUTPUT_BASE_DIR_PATH
    if INCLUDE_PARAMETERS_ON_FOLDERNAME:
        path_parameters = f"{OUTPUT_BASE_DIR_PATH}_{NUMBER_OF_LAYERS}Layers_{BIT_WIDTH}bits"
        OUTPUT_BASE_DIR_PATH = f"{path_parameters}"
    else:
        OUTPUT_BASE_DIR_PATH = f"{OUTPUT_BASE_DIR_PATH}"

    print(" ================================== FAZENDO NEURONIOS ==================================")
    for layer_dict_i in layer_dict_list:
        Neuron_Gen_from_dict(download_vhd=DOWNLOAD_VHD,
                             layer_dict=layer_dict_i,
                             OUTPUT_BASE_DIR_PATH=f"{OUTPUT_BASE_DIR_PATH}/Neuron",
                             DEBUG=True)
    parameters_vhd_gen(
        BIT_WIDTH,
        parameters_vhd_name='parameters',
        OUTPUT_BASE_DIR_PATH=OUTPUT_BASE_DIR_PATH,
        create_path_folder=False
    )

    # ============= TOPO ===============
    txt_list = []
    lista_camada_inputs = []
    lista_camada_outputs = []
    txt = ''

    # if (n_max = 0): # caso não queiramos gerar neurônios mortos
    for j in range(0, len(layer_dict_list)):

        txt, camada_inputs, camada_outputs = (entity_port_map(
            vhd_name=layer_dict_list[j]['Layer_name'],
            i=j,
            neuron_dict=layer_dict_list[j],
            num_inputs=INPUTS_NUMBER,
            ID_camada=str(j),
            port_map_layers_to_top=True))

        txt_list.append(txt)
        if j == 0:  # PRIMEIRA CAMADA
            lista_camada_inputs.append(camada_inputs)
            print(camada_inputs)

        if j == (len(layer_dict_list) - 1):  # ÚLTIMA CAMADA
            lista_camada_outputs.append(camada_outputs)
            print(camada_outputs)

    txt_top_port_map = ''.join(map(str, txt_list))
    # if DEBUG:
    print(" ================== TOP ================== ")
    print(txt_top_port_map)
    print(" ------------------ IN  ------------------ ")
    print(lista_camada_inputs)
    print(" ------------------ OUT ------------------ ")
    print(lista_camada_outputs)
# ----------------
    camada_inputs = extrai_lista_IO(list_IO=lista_camada_inputs)
    camada_outputs = extrai_lista_IO(list_IO=lista_camada_outputs)

    # if True:
    if DEBUG:
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

    top_dict['IO']['IN']['STD_LOGIC'] = l_inputs[0]
    top_dict['IO']['IN']['STD_LOGIC_VECTOR'] = l_inputs[1]

    # https://stackoverflow.com/questions/46367233/efficient-way-to-union-two-list-with-list-or-none-value
    lista_concat = set(chain.from_iterable(
        (l_inputs[2] or [], l_inputs[3] or [])))
    top_dict['IO']['IN']['SIGNED'] = lista_concat

    # TODO: adicionar função para transformar top_dict['IO']['IN']['manual']
    # top_dict['IO']['IN']['manual'] = l_inputs[3]

    top_dict['IO']['OUT']['STD_LOGIC'] = l_outputs[0]
    top_dict['IO']['OUT']['STD_LOGIC_VECTOR'] = l_outputs[1]
    lista_concat = set(chain.from_iterable(
        (l_outputs[2] or [], l_outputs[3] or [])))

    top_dict['IO']['OUT']['SIGNED'] = lista_concat

    # TODO: adicionar função para transformar top_dict['IO']['OUT']['manual']
    # top_dict['IO']['OUT']['manual'] = l_outputs[3]
# ----------------
    # if DEBUG:
    # print(top_dict)

    top_entity = topDict_to_entityTxt(top_dict=top_dict,
                                      remove_dict_items=[],
                                      generic=True
                                      )
#     print(f''' - -------- TOP ENTITY - --------
# {top_entity}''')

# topdict = {
#     'Inputs_number': 3,
#     'bits': 8,
#     'IO_type': 'signed',
#     'Neurons_number': 4,
#     'Top_name': '',
#     'IO': {
#         'GENERIC': {
#             'BITS': < function < lambda > at 0x000002223D701B80 > ,
#             'NUM_INPUTS': < function < lambda > at 0x000002223D701C10 > ,
#             'TOTAL_BITS': None},
#         'IN': {
#             'STD_LOGIC': ['clk', 'rst', 'update_weights'],
#             'STD_LOGIC_VECTOR': None, 'SIGNED': None,
#             'manual': ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']},
#         'OUT': {
#             'STD_LOGIC': None,
#             'STD_LOGIC_VECTOR': None,
#             'SIGNED': ['c1_n0_y', 'c1_n1_y'],
#             'manual': ['c1_n0_Wout', 'c1_n1_Wout']
#         }
#     }
# }

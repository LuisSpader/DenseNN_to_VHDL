import copy
from utils.top import topDict_to_entityTxt
from utils.GLOBALS import GLOBAL
from utils.SETTINGS import PARAMS
from utils.neuron_primitivo import *
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
    global layers_dict_list
    layers_dict_list = []
    # port_map between layers ()
    port_map_neurons_list = copy.deepcopy(LAYER_NEURONS_NUMBER_LIST)
    GLOBAL.PM_MATRIX.neurons_PM_matrix = [
        [] for _ in range(len(port_map_neurons_list))]

    # generating signal matrix
    for i, item in enumerate(port_map_neurons_list):
        for j in range(0, item):
            GLOBAL.PM_MATRIX.neurons_PM_matrix[i].append(
                f"c{i}_n{j}_W_out")

    # ! comentei aqui
    GLOBAL.PM_MATRIX.neurons_PM_matrix = list(
        map(list, zip_longest(*GLOBAL.PM_MATRIX.neurons_PM_matrix, fillvalue=None)))

    neurons_PM_matrix_local = copy.deepcopy(
        GLOBAL.PM_MATRIX.neurons_PM_matrix)

    for i, item in enumerate(GLOBAL.PM_MATRIX.neurons_PM_matrix):
        neurons_PM_matrix_local[i] = [x for x in item if x != None]
        # GLOBAL.PM_MATRIX.neurons_PM_matrix[i] = [x for x in item if x != None]

    barriers = ''
    if BASE_DICT_HIDDEN['Neuron_arch']['Barriers']:
        barriers = '_Barriers'
    # text_list can be an splitted text or a list of texts
    arch = '_' + '_'.join(map(str, (LAYER_NEURONS_NUMBER_LIST)))

    if INCLUDE_PARAMETERS_ON_FOLDERNAME:
        path_parameters = f"{OUTPUT_BASE_DIR_PATH}/NN_{NUMBER_OF_LAYERS}Layers_{BIT_WIDTH}bits{arch}{barriers}"
        OUTPUT_BASE_DIR_PATH = f"{path_parameters}"
    else:
        OUTPUT_BASE_DIR_PATH = f"{OUTPUT_BASE_DIR_PATH}"
    PARAMS.path = f"{OUTPUT_BASE_DIR_PATH}"

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
    # for i in range(0, len(layers_dict_list)):
    #     print(
    #         f"All_NN() _> dict[{i}] -> num_inputs: {layers_dict_list[i]['Neuron_arch']['Inputs_number']()}")

    # -------------------

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
    txt_list = []
    lista_camada_inputs = []
    lista_camada_outputs = []
    txt = ''

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
    # neurons_PM_matrix = [
    # ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
    # ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
    # ['c0_n2_W_out', 'c3_n2_W_out'],
    # ['c0_n3_W_out']
    # ]
    # lista de sinais para declarar dps: SIGNAL .... (... -1 downto 0);
    signals_Wout_list = []

    for l, layer in enumerate(layers_dict_list):
        for n, neuron in enumerate(neurons_PM_matrix_local):
            # todo: dá pra retirar o loop assign da primeira camada, pois fica igual o original
            if l == 0:  # primeira camada, só atribuímos normalmente
                pass

            else:  # segunda camada em diante
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
        for i, item in enumerate(assign_list):
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
    list_IN = [[] for _ in range(len(layers_dict_list))]
    list_OUT = [[] for _ in range(len(layers_dict_list))]
    list_IN_manual = [[] for _ in range(len(layers_dict_list))]
    list_OUT_manual = [[] for _ in range(len(layers_dict_list))]
    nomes = [None] * len(layers_dict_list)
    nomes_all = [[None] * 2 for _ in range(len(layers_dict_list))]
    remove_list = []

    # Criando lista das entradas e saídas (IO) e seus tipos
    for j in range(0, len(layers_dict_list)):
        # Inputs shared_IO: Salvando o nome
        list_IN[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']['IN'], key_or_value=True))
        # Inputs shared_IO: Salvando o tipo
        list_IN[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']['IN'], key_or_value=False))
        # Inputs unique_IO: Salvando o nome
        list_IN[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']['IN'], key_or_value=True))
        # Inputs unique_IO: Salvando o tipo
        list_IN[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']['IN'], key_or_value=False))

        # Outputs shared_IO: Salvando o nome
        list_OUT[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']['OUT'], key_or_value=True))
        # Outputs shared_IO: Salvando o tipo
        list_OUT[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']['OUT'], key_or_value=False))
        # Outputs unique_IO: Salvando o nome
        list_OUT[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']['OUT'], key_or_value=True))
        # Outputs unique_IO: Salvando o tipo
        list_OUT[j].append(dict_to_list(
            target_dict=layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']['OUT'], key_or_value=False))

        remove_list += dict_list_exceptNone(
            dict_slice=layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']['IN'], return_value_or_key='value', is_list=False)

        remove_list += dict_list_exceptNone(
            dict_slice=layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']['IN'], return_value_or_key='value', is_list=False)

        remove_list += dict_list_exceptNone(
            dict_slice=layers_dict_list[j]['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)

        remove_list += dict_list_exceptNone(
            dict_slice=layers_dict_list[j]['Neuron_arch']['IO']['shared_IO']['OUT'], return_value_or_key='value', is_list=False)

        # for j in lista_camadas_IO:
        #     for type in ['IN', 'OUT']:
        #         _ = IO_manual_Top(
        #             IO_dict=layers_dict_list[j],
        #             IO_list=top_dict['IO'],
        #             IO_type=type,
        #             SIGNALS=True,
        #             DEBUG=False)

        # removendo 'manual'
        for i in range(0, len(list_IN[j])):
            list_IN_manual[j].append(list_IN[j][i][-1])
            list_OUT_manual[j].append(list_OUT[j][i][-1])
            list_IN[j][i].pop()
            list_OUT[j][i].pop()

        # -------- ALL -------------
        buff_nomes = []

        buff_nomes = get_namesANDtypes_normal_IO(list_IN[j])
        nomes_all[j][0] = buff_nomes  # nomes_all[layer[IN,OUT]]

        buff_nomes = get_namesANDtypes_normal_IO(list_OUT[j])
        nomes_all[j][1] = buff_nomes  # nomes_all[layer[IN,OUT]]

        # ------------ MANUAL --------------
        buff_nomes = []
        buff_tipos = []
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

        nomes[j] = buff_nomes
        # tipos[j] = buff_tipos

        # substituindo 'TOTAL_BITS' e 'NUM_INPUTS'
        for i, item in enumerate(nomes[j]):
            if 'TOTAL_BITS' in item[1]:
                nomes[j][i][1] = item[1].replace(
                    'TOTAL_BITS', f"(BITS*{str(layers_dict_list[j]['Inputs_number'])})")
            if 'NUM_INPUTS' in item[1]:
                nomes[j][i][1] = item[1].replace('NUM_INPUTS', str(
                    layers_dict_list[j]['Inputs_number']))

        # comparando pilha de sinais salvos em settings.signals_stack e concatenando na lista 'nomes'
        for i, signal in enumerate(signals.signals_stack):
            txt_depois = '_'.join(
                map(str, (signal[0].split(f"_")[-2:])))

            if signal[1] == j:  # checa se é da mesma camada
                for k, item in enumerate(nomes[j]):
                    if txt_depois in item[0]:
                        # nomes[j][k] = [nomes[j][k]].append(signal)
                        s = signal[0]
                        if isinstance(nomes[j][k][0], str):
                            nomes[j][k][0] = [nomes[j][k][0]]
                        nomes[j][k][0].append(s)

     # comparando pilha de sinais salvos em settings.signals_stack e concatenando na lista 'nomes_all' = quando não é do tipo 'manual'
        for i, signal in enumerate(signals.signals_stack):
            txt_depois = '_'.join(
                map(str, (signal[0].split(f"_")[-2:])))

            if signal[1] == j:  # checa se é da mesma camada
                for k, item in enumerate(nomes_all[j]):
                    if isinstance(item[0], str):
                        if txt_depois in item[0]:
                            # nomes[j][k] = [nomes[j][k]].append(signal)
                            s = signal[0]
                            if isinstance(nomes_all[j][k][0], str):
                                nomes_all[j][k][0] = [nomes_all[j][k][0]]
                            nomes_all[j][k][0].append(s)
                    elif isinstance(item[0], list):
                        for item_l in item[0]:
                            if txt_depois in item_l:
                                # nomes[j][k] = [nomes[j][k]].append(signal)
                                s = signal[0]
                                # if isinstance(nomes_all[j][k][0], str):
                                #     nomes_all[j][k][0] = [nomes_all[j][k][0]]
                                nomes_all[j][k][0][0].append(s)

    remove_list = copy.deepcopy(remove_list)
    for i, item in enumerate(remove_list):
        for j, item2 in enumerate(item):
            if ':' in item2:
                remove_list[i][j] = item2.split(':')[0].replace(' ', '')

    remove_list = [item for sublist in remove_list for item in sublist]

    global remove_signals_list
    remove_signals_list = list(dict.fromkeys(remove_list))
    # for r, itemr in enumerate(remove_signals_list):
    for j in range(0, len(layers_dict_list)):
        remove_signals_list = [
            x for x in remove_signals_list if f"c{j}" not in x]

    # loop para remover itens que não são os sinais descritos (usa a lista remove_signals_list)
    for l, layer in enumerate(nomes):  # layer
        for item_s in remove_signals_list:  # lista de itens para excluir

            length = len(nomes[l])
            f = 0
            while f < length:  # loop para lista que diminui seu tamanho

                buff = f"nomes[{l}][{f}]: {nomes[l][f]}"
                buff = nomes[l][f]

                if isinstance(nomes[l][f][0], str):
                    nomes[l] = [x for x in nomes[l] if item_s not in x[0]]
                    f -= 1
                    length -= 1
                elif isinstance(nomes[l][f][0], list):
                    if item_s in nomes[l][f][0]:
                        nomes[l][f][0].remove(item_s)
                        f -= 1
                        length -= 1
                f += 1

    for l, layer in enumerate(nomes_all):  # layer
        for item_s in remove_signals_list:  # lista de itens para excluir

            length = len(nomes_all[l])
            f = 0
            while f < length:  # loop para lista que diminui seu tamanho

                buff = f"nomes_all[{l}][{f}]: {nomes_all[l][f]}"
                buff = nomes_all[l][f]

                if isinstance(nomes_all[l][f][0], str):
                    nomes_all[l] = [x for x in nomes_all[l]
                                    if item_s not in x[0]]
                    f -= 1
                    length -= 1
                elif isinstance(nomes_all[l][f][0], list):
                    for x, itemx in enumerate(nomes_all[l][f][0][0]):
                        if item_s == itemx:
                            del nomes_all[l][f][0][0][x]
                            # del itemx
                            # nomes_all[l][f][0][0].remove(item_s)
                            if nomes_all[l][f][0][0] == []:
                                del nomes_all[l][f]
                                f -= 1
                                length -= 1
                f += 1

    import itertools
    # list2d = [[1,2,3], [4,5,6], [7], [8,9]]
    nomes_all = list(itertools.chain.from_iterable(nomes_all))
    # --------------------------

    # SIGNALS manual
    for i, item in enumerate(nomes):
        for j, itemj in enumerate(item):
            # for i2, item2 in enumerate(item):
            if 'IN' in nomes[i][j][1]:
                nomes[i][j][1] = nomes[i][j][1].replace('IN', '')
            if 'OUT' in nomes[i][j][1]:
                nomes[i][j][1] = nomes[i][j][1].replace('OUT', '')

        if nomes[i] != []:
            names = f"{', '.join(map(str, (nomes[i][0][0])))}"
            if not 'W_out' in names:
                type_s = nomes[i][0][1]
                # print(f"nomes[c{i}]--> {names}:{type_s};")
                signals.signals_dec.append(f"SIGNAL {names}:{type_s}")

    # SIGNALS normal (all other IOs)
    for i, item in enumerate(nomes_all):

        names = f"{', '.join(map(str, (nomes_all[i][0][0])))}"
        type_s = nomes_all[i][0][1]
        # print(f"nomes_all[c{i}]--> {names}: {type_s}(BITS -1 DOWNTO 0);")
        signals.signals_dec.append(
            f"SIGNAL {names}: {type_s}(BITS -1 DOWNTO 0);")
    # --------------------------

    # print("  ")
    signals.signals_to_text()

    # ASSIGN: l1 <= l0; l2 <= l1; ...
    buff = [[] for _ in range(len(layers_dict_list))]

    for i, item in enumerate(signals.signals_stack):
        if 'IO_out' in item[0]:
            buff[item[1]+1].append(item[0])  # colocando na proxima camada

    for i, item in enumerate(signals.signals_stack):
        if 'IO_in' in item[0]:
            buff[item[1]
                 ] = f"{item[0]} <= {' & '.join(map(str, (buff[item[1]])))};"

    signals_assign_stack = [x for x in buff if x != []]
    signals_assign_txt = '\n'.join(map(str, (signals_assign_stack)))
    # --------------------------

    # ok todo: gerador de lista para entradas comuns ['nome_sinal', 'tipo_sinal'] --> FALTA FAZER PARA IO_out (signed)
    # OK todo: gerador para entradas 'manual'
    # OK todo: tratamento diferente para ci_IO_in devido ao 'TOTAL_BITS' ser diferente para cada camada
    # https://youtu.be/aWCWZpIZYjY
    # https://www.youtube.com/watch?v=hdPC2G8NPHI&list=PL35tBJQqzeIuV6qlkvqiZy9ivc9IROLWh&index=29&t=1597s
    top_entity = topDict_to_entityTxt(top_dict=top_dict,
                                      IO_dict_compare=layers_dict_list[0],
                                      remove_dict_items=[],
                                      generic=True)
    txt_top_port_map = txt_top_port_map.replace(
        'update_weights=> update_weights,', 'update_weights=> en_registers,')

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
    download_vhd = True
    # salvando VHDL
    if (download_vhd == True):
        top_dir = f"{OUTPUT_BASE_DIR_PATH}/{top_dict['Top_name']}.vhd"
        with open(top_dir, "w") as writer:
            writer.write(top_text)
        # print(f"3 - layers_dict_list[{i}]: {layers_dict_list[i]['IO']['OUT']}")
        # if DEBUG:
        print(f"top_gen() -> Criando Top: {top_dir}")


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

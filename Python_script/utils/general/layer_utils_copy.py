from ast import If
from utils.general.PORT_MAP_utils import *
from utils.general.utils import *
from utils.general.list_utils import list_concatenation, swap_empty_for_None
from utils.general.vhd_txt_utils import entity
from utils.general.Create_Folders import *
# from dict_utils import *
# from txt_utils import *


def extrai_lista_IO(list_IO: list) -> list:
    """Função para extrair uma lista bonitinha da lista anterior. Pegamos

    Args:
        list_IO (list): Lista de INPUTS ou OUTPUTS que ainda devem ser tratadas. Exemplo:
          camada_inputs = [[[['clk', 'rst'], ''],
                            ['', ''],
                            ['', [' c1_n0_bias']],
                            ['', ''],
                            ['', ''],
                            [['x1', 'x2', 'x3'], [' c1_n0_w1', ' c1_n0_w2', ' c1_n0_w3']]],
                          [[['clk', 'rst'], ''],
                            ['', ''],
                            ['', [' c1_n1_bias']],
                            ['', ''],
                            ['', ''],
                            [['x1', 'x2', 'x3'], [' c1_n1_w1', ' c1_n1_w2', ' c1_n1_w3']]]]

    Returns:
        other_list2 (list): Retorna lista bonitinha, já unindo elemento a elemento (de cada tipo de entrada) para todos os neurônios. Exemplo:
          other_list2 =  [['clk', 'rst'], --> STD_LOGIC
                          [], --> STD_LOGIC_VECTOR
                          [' c1_n0_bias', ' c1_n1_bias'], --> SIGNED
                          [], --> STD_LOGIC_num_inputs
                          [], --> STD_LOGIC_VECTOR_num_inputs
                          ['x1', 'x2', 'x3',' c1_n0_w1',' c1_n0_w2',' c1_n0_w3',' c1_n1_w1', ' c1_n1_w2',' c1_n1_w3']] --> SIGNED_num_inputs

    """

    # std_logic, std_logic_vector, signed | os mesmos porém '_num_inputs'
    mylist = [[]]*6
    mylist = [mylist] * len(list_IO)  # uma para cada neurônio
    other_list = []

    ultimo = int(len(list_IO[0]) - 1)  # ultimo por neurônio
    ultimo_v = []

    # iterando sobre as sublistas
    for i in range(0, len(list_IO)):
        # print(f"len(list_IO): {len(list_IO)}")
        # print("========")

        # salvando o último devido a um 'bug' ao alterar o último item da lista
        ultimo_v.append(list_concatenation(
            list_IO[i][ultimo]))

        # iterando sobre itens da sublista (cada sublista é um tipo de IO)
        for j in range(0, len(list_IO[i])-1):
            # print(f"len(list_IO[{i}]): {len(list_IO[i])}")
            # print(f"len(mylist[{i}]): {len(mylist[i]):}")
            # print("--------------")

            mylist[i][j] = list_concatenation(
                list_IO[i][j])

        other_list.append(mylist[i][:-1] + [ultimo_v[i]])

    other_list2 = [other_list[0]]

    for i in range(1, len(other_list)):  # itera sobre neurônios
        for j in range(0, len(other_list2[0])):  # itera sobre IO
            for k in other_list[i][j]:  # itera sobre itens da lista de cada tipo de IO

                other_list2[0][j] = other_list2[0][j] + [k]
                # print(f"k: {k}")
    other_list2 = list_concatenation(other_list2)

    for i in range(0, len(other_list2)):
        other_list2[i] = list(dict.fromkeys(other_list2[i]))

    return other_list2
# exemplo
# extrai_lista_IO(list_IO=camada_inputs)


def layer_neurons_port_map(number_of_neurons: int,
                           vhd_name: str,
                           neuron_dict: dict,
                           num_inputs: int,
                           ID_camada: str):
    """Função para gerar o mapeamento de TODOS OS NEURÔNIOS de uma camada. 
    Exemplo:
      layer_neurons_port_map(number_of_neurons = 3, 
                             IN_port_map = Neuron_IN_port_map, 
                             OUT_port_map = ''
                             )
      Output:
        test_0: ENTITY work.test
          PORT MAP (
                    ---------- Entradas ----------
                    -- ['IN']['STD_LOGIC'] 
                    clk=> clk, 
                    rst=> rst, 
                    -- ['IN']['STD_LOGIC_VECTOR'] 
                    A=>  c1_n0_A, 
                    B=>  c1_n0_B, 
                    -- ['IN']['SIGNED_num_inputs'] 
                    x1=> x1, 
                    x2=> x2, 
                    x3=> x3, 
                    -- ['IN']['SIGNED'] 
                    bias=>  c1_n0_bias, 
                    ---------- Saidas ---------- 

          );           

        test_1: ENTITY work.test
          PORT MAP (
                    ---------- Entradas ----------
                    -- ['IN']['STD_LOGIC'] 
                    clk=> clk, 
                    rst=> rst, 
                    -- ['IN']['STD_LOGIC_VECTOR'] 
                    A=>  c1_n1_A, 
                    B=>  c1_n1_B, 
                    -- ['IN']['SIGNED_num_inputs'] 
                    x1=> x1, 
                    x2=> x2, 
                    x3=> x3, 
                    -- ['IN']['SIGNED'] 
                    bias=>  c1_n1_bias, 
                    ---------- Saidas ---------- 

          );           

        test_2: ENTITY work.test
          PORT MAP (
                    ---------- Entradas ----------
                    -- ['IN']['STD_LOGIC'] 
                    clk=> clk, 
                    rst=> rst, 
                    -- ['IN']['STD_LOGIC_VECTOR'] 
                    A=>  c1_n2_A, 
                    B=>  c1_n2_B, 
                    -- ['IN']['SIGNED_num_inputs'] 
                    x1=> x1, 
                    x2=> x2, 
                    x3=> x3, 
                    -- ['IN']['SIGNED'] 
                    bias=>  c1_n2_bias, 
                    ---------- Saidas ---------- 

          );    

    ------------------------------------------------------------------------------------
    Args:
        number_of_neurons (int): número de neurônios da camada

        IN_port_map (str): texto com mapeamento das ENTRADAS, gerado pela função Neuron_port_map_IO()

        OUT_port_map (str): texto com mapeamento das SAÍDAS, gerado pela função Neuron_port_map_IO()

    Returns:
        txt(str): Retorna texto com todos os componentes mapeados, conforme exemplo acima.'
        lista_camada_inputs(list): lista com INPUTS. Cada sublista é um tipo de INPUT. Formato igual ao exemplo de 'lista_camada_outputs'. 
        lista_camada_outputs(list): lista com OUTPUTS. Cada sublista é um tipo de OUTPUT. Formato abaixo:
            lista_camada_outputs[0] -> 'STD_LOGIC'
            lista_camada_outputs[1] -> 'STD_LOGIC_VECTOR'
            lista_camada_outputs[2] -> 'SIGNED'
            lista_camada_outputs[3] -> 'STD_LOGIC_num_inputs'
            lista_camada_outputs[4] -> 'STD_LOGIC_VECTOR_num_inputs'
            lista_camada_outputs[5] -> 'SIGNED_num_inputs'
    """
    txt_list = []
    lista_camada_inputs = []
    lista_camada_outputs = []

    txt = ''
    # iterando sobre todos os neurônios (assim pegamos a lista de todas as IO de cada um e o texto de 'PORT MAP' de cada um também)
    for j in range(0, number_of_neurons):
        txt, camada_inputs, camada_outputs = (entity_port_map(
            vhd_name=vhd_name,
            i=j,
            num_inputs=num_inputs,
            neuron_dict=neuron_dict,
            ID_camada=ID_camada))

        txt_list.append(txt)
        lista_camada_inputs.append(camada_inputs)
        lista_camada_outputs.append(camada_outputs)

    txt = ''.join(map(str, txt_list))
    # concat_list_in = list_concatenation_all_sublists(
    #     lista_camada_inputs)  # transforma todas as sublists em 1 lista só
    # concat_list_in = list(dict.fromkeys(concat_list_in))  # remove duplicates
    # # inputs = ','.join(map(str, concat_list_in))

    # concat_list_out = list_concatenation_all_sublists(lista_camada_outputs)
    # concat_list_out = list(dict.fromkeys(concat_list_out))  # remove duplicates
    # # outputs = ','.join(map(str, concat_list_out))

    # return txt, inputs, outputs
    return txt, lista_camada_inputs, lista_camada_outputs
    # return txt, concat_list_in, concat_list_out


# Exemplo
# print(layer_neurons_port_map(number_of_neurons = 3,
#                            IN_port_map = Neuron_IN_port_map,
#                           #  OUT_port_map = Neuron_OUT_port_map
#                            OUT_port_map = ''
#                            ))


def layer_neurons_port_map_ALL(layer_dict_arg: dict,
                               ID_camada: str = 'c1'
                               ):
    """Função para gerar o mapeamento de TODOS OS NEURÔNIOS de uma camada, com base no dicionário do COMPONENTE desejado (neurônio).

    Args:
        layer_dict_arg (dict, optional): dicionário da camada. Contem toda as descriçeos da camada e do tipo de neuronio que a compoe. 
        ----------------------------------------------------------------
        ID_camada (str, optional): string identificador da camada e neurônio. 'c1_n1' = camada 1 e neurônio 1. Defaults to 'c1_n1'.
------------------------------------------------------------------------     

    Returns:
        camada_inputs(list), camada_outputs(list): listas de INPUTS e OUTPUTS que servirão para construção da camada.

        port_map_txt (txt): Texto com todo o mapeamento. 
            Exemplo:
                port_map_txt, camada_inputs, camada_outputs = layer_neurons_port_map_ALL(
                    neuron_dict = layer_dict_arg['Neuron_arch']['IO'],
                    ID_camada = 'c1',
                    number_of_neurons= 2,
                    num_inputs = 3,
                    vhd_name = layer_dict_arg['Neuron_arch']['neuron_name'])

                Output -> print(port_map_txt):
                    neuron_inst_0: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mul1a_v0_add0_v0
                        PORT MAP (
                                    ---------- Entradas ----------
                                    -- ['IN']['STD_LOGIC'] 
                                    clk=> clk, 
                                    rst=> rst, 
                                    -- ['IN']['SIGNED'] 
                                    bias=>  c1_n0_bias, 
                                    -- ['IN']['SIGNED_num_inputs'] 
                                    x1=> x1, 
                                    x2=> x2, 
                                    x3=> x3, 
                                    w1=>  c1_n0_w1, 
                                    w2=>  c1_n0_w2, 
                                    w3=>  c1_n0_w3, 
                                    ---------- Saidas ---------- 
                                    -- ['OUT']['SIGNED'] 
                                    y=>  c1_n0_y, 
                        );           

                        neuron_inst_1: ENTITY work.neuron_comb_ReLU_3n_8bit_signed_mul1a_v0_add0_v0
                        PORT MAP (
                                    ---------- Entradas ----------
                                    -- ['IN']['STD_LOGIC'] 
                                    clk=> clk, 
                                    rst=> rst, 
                                    -- ['IN']['SIGNED'] 
                                    bias=>  c1_n1_bias, 
                                    -- ['IN']['SIGNED_num_inputs'] 
                                    x1=> x1, 
                                    x2=> x2, 
                                    x3=> x3, 
                                    w1=>  c1_n1_w1, 
                                    w2=>  c1_n1_w2, 
                                    w3=>  c1_n1_w3, 
                                    ---------- Saidas ---------- 
                                    -- ['OUT']['SIGNED'] 
                                    y=>  c1_n1_y, 
                        );           
    """
    # GERA TEXTO DO DO MAPEAMENTO DAS ENTRADAS E SAÍDAS DO DICIONÁRIO
    """Exemplo:
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            ...
            """
    # for i in range(0,num_inputs):
    # Neuron_IN_port_map, Neuron_OUT_port_map = Neuron_port_map_IO(dict_test= neuron_dict,
    #                         num_inputs = num_inputs,
    #                         ID_camada = ID_camada)

    # dependencias
    # output_dict = copy.deepcopy(layer_dict_arg)
    output_dict = layer_dict_arg
    neuron_dict = output_dict['Neuron_arch']['IO']
    neuron_vhd_name = output_dict['Neuron_arch']['neuron_name']
    number_of_neurons = output_dict['Neurons_number']
    num_inputs = output_dict['Inputs_number']

    # mapeamento de TODOS OS NEURÔNIOS da camada
    port_map_txt, camada_inputs, camada_outputs = layer_neurons_port_map(
        number_of_neurons=number_of_neurons,
        vhd_name=neuron_vhd_name,
        neuron_dict=neuron_dict,
        num_inputs=num_inputs,
        ID_camada=ID_camada)

    camada_inputs = extrai_lista_IO(list_IO=camada_inputs)
    camada_outputs = extrai_lista_IO(list_IO=camada_outputs)

    l_inputs = list_concat_half(camada_inputs)
    l_outputs = list_concat_half(camada_outputs)

    # substituindo '[]' por 'None'
    l_inputs = swap_empty_for_None(l_inputs)
    l_outputs = swap_empty_for_None(l_outputs)

    output_dict['IO']['IN']['STD_LOGIC'] = l_inputs[0]
    output_dict['IO']['IN']['STD_LOGIC_VECTOR'] = l_inputs[1]
    output_dict['IO']['IN']['SIGNED'] = l_inputs[2]

    output_dict['IO']['OUT']['STD_LOGIC'] = l_outputs[0]
    output_dict['IO']['OUT']['STD_LOGIC_VECTOR'] = l_outputs[1]
    output_dict['IO']['OUT']['SIGNED'] = l_outputs[2]

    return port_map_txt, output_dict
# Neuron_IO_dict = {
#   'IN': { # ENTRADAS
#     'STD_LOGIC': ['clk', 'rst'],
#     'STD_LOGIC_VECTOR': None,
#     'STD_LOGIC_num_inputs': None,
#     'STD_LOGIC_VECTOR_num_inputs': None,
#     'SIGNED': ['bias'],
#     'SIGNED_num_inputs': ['x']
#     },
#  'OUT': { #SAÍDAS
#    'STD_LOGIC': None,
#     'STD_LOGIC_VECTOR': None,
#     'STD_LOGIC_num_inputs': None,
#     'STD_LOGIC_VECTOR_num_inputs': None,
#     'SIGNED': ['y'],
#     'SIGNED_num_inputs': None
#     }
#  }
# print(layer_neurons_port_map_ALL(neuron_dict = Neuron_IO_dict,
#                                ID_camada= 'c0',
#                                number_of_neurons = 2,
#                                num_inputs = 3,
#                                vhd_name = 'neuron_tree_ReLU_8bit_3n_signed'))

# Neuron_IO_dict = {
#   'IN': { # ENTRADAS
#     'STD_LOGIC': ['clk', 'rst'],
#     'STD_LOGIC_VECTOR': None,
#     'STD_LOGIC_num_inputs': None,
#     'STD_LOGIC_VECTOR_num_inputs': None,
#     'SIGNED': ['bias'],
#     'SIGNED_num_inputs': ['x']
#     },
#  'OUT': { #SAÍDAS
#    'STD_LOGIC': None,
#     'STD_LOGIC_VECTOR': None,
#     'STD_LOGIC_num_inputs': None,
#     'STD_LOGIC_VECTOR_num_inputs': None,
#     'SIGNED': ['y'],
#     'SIGNED_num_inputs': None
#     }
#  }
# print(layer_neurons_port_map_ALL(neuron_dict = Neuron_IO_dict,
#                                ID_camada= 'c0',
#                                number_of_neurons = 2,
#                                num_inputs = 3,
#                                vhd_name = 'neuron_tree_ReLU_8bit_3n_signed'))


# def layer_name(layer_num: int,
#                neuron_num: int,
#                bits: int,
#                num_inputs: int,
#                IO_type: bool  # 1= signed || 0= unsigned
#                ) -> str:
def layer_name(layer_dict_arg: dict,
               ) -> str:
    """Função para gerar nome da camada.

    Args:
        layer_num (int): número da camada
        neuron_num (int): número de neurônios na camada
        bits (int): bits de representação das entradas e pesos (WIDTH)
        num_inputs (int): número de entradas da camada

    Returns:
        str: nome da camada
    """
    if (layer_dict_arg['IO_type'] == True):
        IO_type = 'signed'
    else:
        IO_type = 'unsigned'

    # fx_activation = find_True_dict(dict_slice=layer_dict_arg['Neuron_arch']['Activation_function'])

    fx_activation = find_True_dict_Output_print(
        dict_slice=layer_dict_arg['Neuron_arch']['Activation_function'])
    if fx_activation == 'Using':  # caso seja uma fx com dicionário interno de parâmetros, devemos pegar o nome dela e não o 'using'
        """Exemplo: 
           'Activation_function':{
                'ReLU': False,
                'Leaky_ReLU': {
                    'Using': False,        # True = usar versão Leaky_ReLU
                    'Leaky_attenuation': 2 #número de vezes que divide por 2 a ReLU (shift right)
                },
                'Sigmoid': {
                    'Using': True,        # True = usar versão Sigmoid (Look Up Table)
                    'Memory': {
                    'bits_mem': 8,
                    'input_mem_bits': lambda:layer_dict_softmax['Neuron_arch']['Activation_function']['Sigmoid']['Memory']['bits_mem'],  # 'n' binary digits are the fractional part of `x`; = MANTISSA
                    }
                    }
                }
            O que confirma se é a Sigmoid é o {'Using': True }, porém queremos pegar o nome 'Sigmoid', que está um nível de hierarquia acima """
        fx_activation = find_True_dict_Output_print_above_level(
            dict_slice=layer_dict_arg['Neuron_arch']['Activation_function'])
    #### Nome do arquivo .vhd ####
    file_name = f"camada{str(layer_dict_arg['Layer_number'])}_{fx_activation}_{str(layer_dict_arg['Neurons_number'])}neuron_{str(layer_dict_arg['bits'])}bits_{str(layer_dict_arg['Inputs_number'])}n_{IO_type}"
    return file_name
# EXEMPLO
# file_name  = layer_name(layer_num =1,
#                neuron_num = layer_dict_arg['Neurons_number'],
#                bits = layer_dict_arg['bits'],
#                num_inputs = layer_dict_arg['Inputs_number'],
#                IO_type = layer_dict_arg['IO_type'])
# if (print_cells_result == 1):
#   print(file_name)


def layer_gen(layer_dict_arg: dict, Layer_number: int = 0) -> str:
    """Função para gerar texto de uma camada, de acordo com 'layer_dict_arg'.

    Args:
        layer_dict_arg (dict): Dicionário da camada.
        Layer_number (int, optional): Número da camada. Defaults to 0.

    Returns:
        str: _description_
    """
    # output_dict = copy.deepcopy(layer_dict_arg)
    output_dict = layer_dict_arg
    output_dict['Layer_number'] = Layer_number

    # gerando o nome da camada com base nos parâmetros passados no dicionário
    output_dict['Layer_name'] = layer_name(layer_dict_arg=output_dict)
    ID_camada = f"c{Layer_number}"

    # gerando texto port_map dos neurônios e atualizando as IO do 'layer'dict' (dicionário da camada)
    port_map_txt, output_dict = layer_neurons_port_map_ALL(
        layer_dict_arg=output_dict,
        ID_camada=ID_camada)

    layer_text = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

{entity(name = output_dict['Layer_name'], 
             bits = output_dict['bits'], 
             num_inputs = output_dict['Inputs_number'],
             IO_dict_list = [output_dict['IO']]
             )}

ARCHITECTURE arch OF  {output_dict['Layer_name']}  IS 
BEGIN
{port_map_txt} 
END ARCHITECTURE;
'''
                  )
    return layer_text


def layer_dict_gen_base(base_dict: dict,
                        Inputs_number: int,
                        bits: int,
                        IO_type: bool,  # 1= signed || 0= unsigned
                        Neurons_number: int,
                        Layer_number: int
                        ) -> dict:
    """Função para gerar um dicionário novo mais rapidamente através de um dicionário base já definido anteriormente. Desta forma definimos inicialmente um dicionário base, com a maioria dos parâmetros da arquitetura já definidos (tipo de multiplicador, adder, etc),  tendo assim uma arquitetura mais padrão e após isso geramos um novo dicionário, que será idêntico ao dicionário EXCETO pelos parâmetros que esta função possui, como: número de entradas, número de bits, tipo de IO (com ou sem sinal), número de neurônios da camada e por último, o número da camada (ordem crescente).

  Args:
      base_dict (dict): dicionário base
      Inputs_number (int): número de entradas da camada
      bits (int): número de bits para representação das entradas e saídas da camada
      IO_type (bool): tipo de represenação numérica (com ou sem sinal). 1 = signed | 0 = unsigned
      Layer_number (int): número da camada

    Returns:
        dict: Dicionário de saída, que será quase igual ao 'base_dict' exceto pelos parâmetros passados nesta função.
    """
    # output_dict = copy.deepcopy(base_dict)
    output_dict = base_dict
    output_dict['Inputs_number'] = Inputs_number
    output_dict['bits'] = bits
    output_dict['IO_type'] = IO_type
    output_dict['Neurons_number'] = Neurons_number
    output_dict['Layer_number'] = Layer_number
    output_dict['Layer_name'] = layer_name(layer_dict_arg=output_dict)

    fx_activation = find_True_dict_Output_print(
        dict_slice=output_dict['Neuron_arch']['Activation_function'])
    if fx_activation == 'Using':  # caso seja uma fx com dicionário interno de parâmetros, devemos pegar o nome dela e não o 'using'
        """Exemplo: 
           'Activation_function':{
                'ReLU': False,
                'Leaky_ReLU': {
                    'Using': False,        # True = usar versão Leaky_ReLU
                    'Leaky_attenuation': 2 #número de vezes que divide por 2 a ReLU (shift right)
                },
                'Sigmoid': {
                    'Using': True,        # True = usar versão Sigmoid (Look Up Table)
                    'Memory': {
                    'bits_mem': 8,
                    'input_mem_bits': lambda:layer_dict_softmax['Neuron_arch']['Activation_function']['Sigmoid']['Memory']['bits_mem'],  # 'n' binary digits are the fractional part of `x`; = MANTISSA
                    }
                    }
                }
            O que confirma se é a Sigmoid é o {'Using': True }, porém queremos pegar o nome 'Sigmoid', que está um nível de hierarquia acima """
        fx_activation = find_True_dict_Output_print_above_level(
            dict_slice=output_dict['Neuron_arch']['Activation_function'])

    # activation_fx = find_True_dict_above_level(dict_slice = output_dict['Neuron_arch']['Activation_function'])
    # if
    # base_dict['Layer_number'] = Layer_number
    # base_dict['Layer_number'] = Layer_number

    # Definindo nome do neurônio
    output_dict['Neuron_arch']['neuron_name'] = vhd_name(
        # modelo de função de ativação
        vhd_name=f"neuron_{fx_activation}",
        # Obs: dict_list 0: ReLU, 1: Leaky ReLU, 2: Sigmoid
        # Quantidade de bits para representação
        bits=output_dict['bits'],
        # 1= signed || 0= unsigned
        IO_type=output_dict['IO_type'],
        # Quantidade de entradas
        num_inputs=output_dict['Inputs_number'],
        # 0 = no Barriers | 1 = with register Barriers
        Barriers=output_dict['Neuron_arch']['Barriers'],
        # 0 = combinational(árvore) | 1 = Sequential
        MAC_type=output_dict['Neuron_arch']['MAC_type'],
        # 0 = don't inluce | 1 = include 'seq' or 'tree' on vhd_names
        Include_MAC_type=output_dict['Neuron_arch']['Include_MAC_type'],
        # Número do modelo de multiplicador. Exemplo: mult_number = 1 (multiplicador do tipo 1) --> mul1
        mult_number=find_True_dict_split(
            split_str='-', dict=output_dict['Neuron_arch']['Multiplier'], position=0),
        # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
        mult_version=0,
        adder_number=find_True_dict_split(
            split_str='-', dict=output_dict['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
        adder_version=0)

    return output_dict


def all_dense_layers_gen(
    Inputs_number: int,
    bits: int,
    IO_type_str: str,
    number_of_layers: int,
    Layer_Neurons_number_list: list,
    base_dict_hidden_layers: dict,
    base_dict_softmax_layer: dict,
    path: str,
    download_vhd: bool = True
) -> list:
    """Função para gerar todas as camadas da NN com base em dicionários base e outros parâmetros passados. Dicionários base, são dicionários que serão utilizados em toda 1 ou mais vezes, só alterando os outros parâmetros passados como 'Inputs_number', 'bits', 'IO_type' e 'Layer_Neurons_number_list'. 
        Ao final, irá gerar os arquivos VHDL de todas as camadas, salvando napasta 'NNs/Camadas', caso o parâmetro download_vhd == True

    Args:
        Inputs_number (int): Número de entradas da primeira camada

        bits (int): número de bits para representação (entradas e pesos)

        IO_type_str (str): 'signed' ou 'unsigned' (tipo das IO)

        number_of_layers (int): número de camadas

        Layer_Neurons_number_list (list): lista de número de neurônios para cada camada. Exemplo [10,7,5] -> primeira camada terá 10 neurônios, a segunda 7, ... etc

        base_dict_hidden_layers (dict): _description_

        base_dict_softmax_layer (dict): _description_

        path (str): _description_

        download_vhd (bool, optional): _description_. Defaults to True.

    Returns:
        layers_dict_list(list): Lista de dicionários. Será usada pela função que gera o topo. Pois o mesmo deverá coletar a lista de IO (Inputs & Outputs) de cada camada e fazer o 'PORT MAP' entre as mesmas.
    """

    # alterando parâmetro IO_type_str para True ou False

    if IO_type_str == 'signed':
        IO_type_str = True
    else:
        IO_type_str = False

    # gerando lista para armazenar dicionários de cada camada
    # layers_dict_list = [None]*number_of_layers
    layers_dict_list = [[None] for i in range(number_of_layers)]

    # --------------------------------------------------------
    """ atribuindo os dicionários base para cada item da lista. 
    Sendo:
    dicionário base das 'hidden_layers' = layer_dict_hidden
    dicionário base da camada softmax = layer_dict_softmax
        """
    for i in range(0, len(layers_dict_list)):
        layers_dict_list[i] = copy.deepcopy(base_dict_hidden_layers)

        if (i == (len(layers_dict_list)-1)):  # na última camada, atribui dicionário base softmax
            layers_dict_list[i] = copy.deepcopy(base_dict_softmax_layer)

    # --------------------------------------------------------
    # LAYERS_DICT_LIST = []
    # LOOP PARA ALTERAR ALGUNS PARÂMETROS DOS DICIONÁRIOS DE CADA CAMADA
    layers_dict_list[0] = layer_dict_gen_base(base_dict=layers_dict_list[0],
                                              Inputs_number=Inputs_number,
                                              bits=bits,
                                              IO_type=IO_type_str,  # 1= signed || 0= unsigned
                                              Neurons_number=Layer_Neurons_number_list[0],
                                              Layer_number=0
                                              )
    # LAYERS_DICT_LIST.append(layers_dict_list[0])

    for i in range(1, len(layers_dict_list)):

        layers_dict_list[i] = layer_dict_gen_base(base_dict=layers_dict_list[i],
                                                  Inputs_number=layers_dict_list[i -
                                                                                 1]['Neurons_number'],
                                                  bits=bits,
                                                  IO_type=IO_type_str,  # 1= signed || 0= unsigned
                                                  Neurons_number=Layer_Neurons_number_list[i],
                                                  Layer_number=i
                                                  )
        # LAYERS_DICT_LIST.append(layers_dict_list[i])

    # --------------------------------------------------------
    #  CRIANDO PASTA
    path = create_folder(
        path_list=[f'{path}'],
        path_level=True,
        create=download_vhd)  # (path_list, path_level, create)
    path = path[0]

    # LOOP PARA GERAR TEXTO DE CADA CAMADA CONFORME RESPECTIVO DICIONÁRIO E JÁ SALVAR COMO ARQUIVO '.vhd'

    for i in range(0, len(layers_dict_list)):

        # gerando texto para primeiro dicionário da 'lista de dicionários'
        layer_text = layer_gen(
            layer_dict_arg=layers_dict_list[i], Layer_number=layers_dict_list[i]['Layer_number'])

        # LAYERS_DICT_LIST.append(layers_dict_list[i])
        # salvando VHDL
        if (download_vhd == 1):
            with open(f"{path}{layers_dict_list[i]['Layer_name']}.vhd", "w") as writer:
                writer.write(layer_text)
            # print(f"3 - layers_dict_list[{i}]: {layers_dict_list[i]['IO']['OUT']}")

    print("All Dense Layers Created!!")

    return layers_dict_list
# # imprimindo texto VHDL para análise no Jupyter Notebook
# if (print_cells_result == 1):
#   print(layer_text)

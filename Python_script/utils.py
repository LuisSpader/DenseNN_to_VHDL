# from standard_dicts import layer_dict_hidden
from txt_utils import replace_chars
from dict_utils import dict_list_exceptNone
from txt_utils import erase_empty_lines, tab_lines
# from name import *
import copy
from list_utils import remove_all_lista_ocurrences

# Insert_string
#
# Detalhes


def insert_string_inside(original_txt: str,
                         split_character: str,
                         insert_txt: str,
                         position: int):

    text_split = original_txt.split(str(split_character))

    final_string = str(split_character).join(
        map(str, text_split[position:])
    )  # text_list can be an splitted text or a list of texts

    initial_string = str(split_character).join(
        map(str, text_split[:position])
    )  # text_list can be an splitted text or a list of texts

    final_txt = str(split_character).join(
        map(str, (initial_string, insert_txt)))

    final_txt = final_txt + str(split_character) + final_string

    # caso fique sobrando '_' no final, ele retira
    if final_txt[-1:] == '_':
        final_txt = final_txt[:-1]
    return final_txt


# def vhd_name_dict():


# Create folder neuron
#
# Cria uma pasta para os neuronios

def input_sequences(sequence_id,
                    num_inputs: int,
                    list_or_string: str,
                    port_map: bool,
                    new_line: bool):
    """Função para criar sequência de 'inputs'. Exemplo:
    input_sequences(
        sequence_id = 'x',
        num_inputs = 3,             #número de entradas
        list_or_string= 'string',   #indica que 'sequence_id' é string
        port_map = 1,               # e
        new_line= 1)

    Output:
        x1=>x1,
        x2=>x2,
        x3=>x3,
    ------------------
    print(input_sequences('x' ,
        num_inputs= 2,
        list_or_string = 'string',
        port_map = 0,
        new_line= False))

    Output:
        x1, x2


    Args:
        sequence_id (_type_): nome das entradas

        num_inputs (int): número de entradas

        port_map (bool): -> port_map= 1: x1=> x1, x2=> x2 | port_map= 0: x1, x2, ...'

        new_line (bool): se a string que será retornada a cada entrada, será em uma nova linha ou não -> new_line = 1: cada entrada será impressa em uma nova linha

        list_or_string (str): indicação se 'sequence_id' é uma string ou uma lista. -> passar como 'string' ou como 'list'

    Returns:
        str: Retorna lista de entradas conforme alguns exemplos acima
    """
    # sequence_id:      id for this sequence
    # num_inputs:       number of sequence elements
    # list_or_string:   'list' = list; 'string' = string
    # port_map:         1: x1 => x1 | 0: x1, x2, ...'
    # new_line:         1: 1 string elements per line | 0: all on the same line

    debug = 0
    sequence = []
    i = 0

    while True:
        for m in range(0, len(sequence_id)):

            for i in range(
                0, num_inputs
            ):  # Aqui formamos a sequência, exemplo para ID = 'x' | sequência = x1, x2, ...
                if list_or_string == "string":
                    if i < (num_inputs):
                        sequence.append(f"{sequence_id}{str(i+1)}")
                        # print(f"i={i}<{num_inputs-1}, m={m}")
                        if debug == 1:
                            print(sequence)

                if list_or_string == "list":
                    if i < (num_inputs):
                        sequence.append(f"{sequence_id[m]}{str(i+1)}")
                        # print(f"i={i}<{num_inputs-1}, m={m}")
                        if debug == 1:
                            print(sequence)

                if i == (num_inputs - 1):

                    # print(f"i={i}<{num_inputs-1}, m={m}")

                    #  ==================== APENAS STRING ==================== #
                    # se ID é apenas uma string, exemplo: 'x'
                    if list_or_string == "string":

                        if port_map == True:  # sequência port_map
                            for k in range(0, (num_inputs)):
                                sequence[k] = f"{sequence[k]}=>{sequence[k]}"

                        if new_line == 1:  # sequência com cada item em uma nova linha
                            for k in range(0, num_inputs):
                                sequence[k] = f"{sequence[k]}, \n"
                            return f"".join(map(str, (sequence)))

                        return f", ".join(map(str, (sequence)))

                    #  ==================== LISTA DE STRINGS ==================== #
                    # Se ID é uma lista de strings, exemplo: ['x','w']
                    if list_or_string == "list":
                        if m == len(sequence_id) - 1:

                            if port_map == True:  # sequência port_map
                                for k in range(0, (num_inputs * (len(sequence_id)))):
                                    if debug == 1:
                                        print(
                                            f"max = {(num_inputs*(len(sequence_id))  )}"
                                        )
                                        print(f"k = {k}")
                                    sequence[k] = f"{sequence[k]}=>{sequence[k]}"

                            if (
                                new_line == 1
                            ):  # sequência com cada item em uma nova linha
                                for k in range(0, (num_inputs * (len(sequence_id)))):
                                    sequence[k] = f"{sequence[k]}, \n"
                                return f"".join(map(str, (sequence)))

                            return sequence


# EXEMPLOS:
# print(input_sequences('x' ,num,num_inputs,'string',1,1)) # (sequence_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences(['x','w'] ,num_inputs,'list',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('x' ,num_inputs,'string',1,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('x' _id ,num_inputs, list_or_string, port_map, new_line)

# print(input_sequences('sx' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('sw' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('val_x' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('val_w' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences(['x','w'] ,num_inputs,'list',1,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line))
# print(input_sequences(['x','w'] ,num_inputs,'list',1,1)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line))


# def input_sequences_number_choice(sequence_id: list,      # sequence_id:      id for this sequence
#                                   port_map_list: list,    # funciona assim a escrita: sequence_id => port_map_list
#                                   port_map_is_str: bool,  # True or False
#                                   # port_map_is_str: se queremos igualar o tamanho de port_map_list ao sequence_id (necessario para casos em que sequence_id é uma lista e port_map_list é apenas uma string)
#                                   num_inputs: int,       # num_inputs:       number of sequence elements
#                                   list_or_string: str,   # list_or_string:   'list' = list; 'string' = string
#                                   port_map: bool,         # port_map:         1: x1 => x1 | 0: x1, x2, ...'
#                                   # new_line:         1: 1 string elements per line | 0: all on the same line
#                                   new_line: bool,
#                                   com_numero: bool) -> str:      # True: 'x' se torna 'x1, x2, ...'

#     debug = 0
#     i = 0
#     sequence = []
#     port_map_l = []

#     if port_map_is_str == True:  # se temos apena uma string, criaremos uma lista de strings iguais para podermos iterar nos loops
#         port_map_list = [port_map_list]*len(sequence_id)

#     # if com_numero == True:
#     #     number = str(i+1)
#     # else:
#     #     number = ''
#     if ((sequence_id == None) or (port_map_list == None)):
#         return ''
#     else:
#         while True:
#             for m in range(0, len(sequence_id)):
#                 for i in range(
#                     0, num_inputs
#                 ):  # Aqui formamos a sequência, exemplo para ID = 'x' | sequência = x1, x2, ...
#                     if com_numero == True:
#                         number = str(i+1)
#                     else:
#                         number = ''
#                     if list_or_string == "string":
#                         if i < (num_inputs):
#                             sequence.append(f"{sequence_id}{number}")
#                             port_map_l.append(f"{port_map_list}{number}")
#                             # print(f"i={i}<{num_inputs-1}, m={m}")
#                             if debug == 1:
#                                 print(sequence)

#                     if list_or_string == "list":
#                         if i < (num_inputs):
#                             sequence.append(f"{sequence_id[m]}{number}")
#                             port_map_l.append(f"{port_map_list[m]}{number}")
#                             # print(f"i={i}<{num_inputs-1}, m={m}")
#                             if debug == 1:
#                                 print(sequence)

#                     if i == (num_inputs - 1):

#                         # print(f"i={i}<{num_inputs-1}, m={m}")

#                         #  ==================== APENAS STRING ==================== #
#                         # se ID é apenas uma string, exemplo: 'x'
#                         if list_or_string == "string":

#                             if port_map == 1:  # sequência port_map
#                                 for k in range(0, (num_inputs)):
#                                     sequence[k] = f"{sequence[k]}=> {port_map_l[k]}"

#                             if new_line == 1:  # sequência com cada item em uma nova linha
#                                 for k in range(0, num_inputs):
#                                     sequence[k] = f"{sequence[k]}, \n"
#                                 return f"".join(map(str, (sequence)))

#                             return f", ".join(map(str, (sequence)))

#                         #  ==================== LISTA DE STRINGS ==================== #
#                         # Se ID é uma lista de strings, exemplo: ['x','w']
#                         if list_or_string == "list":
#                             if m == len(sequence_id) - 1:

#                                 if port_map == 1:  # sequência port_map
#                                     for k in range(0, (num_inputs * (len(sequence_id)))):
#                                         if debug == 1:
#                                             print(
#                                                 f"max = {(num_inputs*(len(sequence_id))  )}"
#                                             )
#                                             print(f"k = {k}")
#                                         sequence[k] = f"{sequence[k]}=> {port_map_l[k]}"

#                                 if (
#                                     new_line == 1
#                                 ):  # sequência com cada item em uma nova linha
#                                     for k in range(0, (num_inputs * (len(sequence_id)))):
#                                         sequence[k] = f"{sequence[k]}, \n"
#                                     return f"".join(map(str, (sequence)))

#                                 return sequence

def input_sequences_number_choice(sequence_id: list,      # sequence_id:      id for this sequence
                                  port_map_list: list,    # funciona assim a escrita: sequence_id => port_map_list
                                  port_map_is_str: bool,  # True or False
                                  # port_map_is_str: se queremos igualar o tamanho de port_map_list ao sequence_id (necessario para casos em que sequence_id é uma lista e port_map_list é apenas uma string)
                                  num_inputs: int,       # num_inputs:       number of sequence elements
                                  list_or_string: str,   # list_or_string:   'list' = list; 'string' = string
                                  port_map: bool,         # port_map:         1: x1 => x1 | 0: x1, x2, ...'
                                  new_line: bool,
                                  # new_line:         1: 1 string elements per line | 0: all on the same line
                                  com_numero: bool) -> str:      # True: 'x' se torna 'x1, x2, ...'

    # debug = True
    debug = False
    i = 0
    sequence = []
    port_map_l = []

    if port_map_is_str == True:  # se temos apena uma string, criaremos uma lista de strings iguais para podermos iterar nos loops
        port_map_list = [port_map_list]*len(sequence_id)

    # if com_numero == True:
    #     number = str(i+1)
    # else:
    #     number = ''
    if ((sequence_id == None) or (port_map_list == None)):
        return '', ''
    else:
        if not (sequence_id or port_map_list):
            return '', ''
        else:
            # while True:
            for m in range(0, len(sequence_id)):

                # Aqui formamos a sequência, exemplo para ID = 'x' | sequência = x1, x2, ...
                for i in range(0, num_inputs):
                    if com_numero == True:
                        number = str(i+1)
                    else:
                        number = ''
                    if list_or_string == "string":
                        if i < (num_inputs):
                            sequence.append(f"{sequence_id}{number}")
                            port_map_l.append(f"{port_map_list}{number}")
                            # print(f"i={i}<{num_inputs-1}, m={m}")
                            if debug == 1:
                                print(sequence)

                    if list_or_string == "list":
                        if i < (num_inputs):
                            sequence.append(f"{sequence_id[m]}{number}")
                            port_map_l.append(f"{port_map_list[m]}{number}")
                            # print(f"i={i}<{num_inputs-1}, m={m}")
                            if debug == 1:
                                print(sequence)

                    if i == (num_inputs - 1):

                        # print(f"i={i}<{num_inputs-1}, m={m}")

                        #  ==================== APENAS STRING ==================== #
                        # se ID é apenas uma string, exemplo: 'x'
                        if list_or_string == "string":

                            if port_map == 1:  # sequência port_map
                                for k in range(0, (num_inputs)):
                                    sequence[k] = f"{sequence[k]}=> {port_map_l[k]}"

                            if new_line == 1:  # sequência com cada item em uma nova linha
                                for k in range(0, num_inputs):
                                    sequence[k] = f"{sequence[k]}, \n"
                                return f"".join(map(str, (sequence))), port_map_l

                            return f", ".join(map(str, (sequence))), port_map_l

                        #  ==================== LISTA DE STRINGS ==================== #
                        # Se ID é uma lista de strings, exemplo: ['x','w']
                        if list_or_string == "list":
                            if m == len(sequence_id) - 1:

                                if port_map == 1:  # sequência port_map
                                    for k in range(0, (num_inputs * (len(sequence_id)))):
                                        if debug == 1:
                                            print(
                                                f"max = {(num_inputs*(len(sequence_id))  )}"
                                            )
                                            print(f"k = {k}")
                                        sequence[k] = f"{sequence[k]}=> {port_map_l[k]}"

                                if (
                                    new_line == 1
                                ):  # sequência com cada item em uma nova linha
                                    for k in range(0, (num_inputs * (len(sequence_id)))):
                                        sequence[k] = f"{sequence[k]}, \n"
                                    return f"".join(map(str, (sequence))), port_map_l

                                return sequence, port_map_l


def list_concat_half(IO_list: list) -> list:
    """Função para retornar uma lista pela metade, fazendo join dos elementos.
      Exemplo:
        IO_list =             [[1,2],[3,4],[5,6],[7,8]]
        Output (other_list) = [[1,2,5,6],[3,4,7,8]]
    Args:
        IO_list (list): lista para ser 'cortada pela metade'

    Returns:
        other_list (list): lista pela metade
    """
    other_list = []
    other_list = IO_list

    for i in range(0, int(len(other_list)/2)):
        other_list[i] = other_list[i] + other_list[i + int(len(other_list)/2)]
    other_list = other_list[:int(len(other_list)/2)]
    return other_list


def IO_list_to_layer_dict(IN_list: list,
                          OUT_list: list,
                          IO_dict: dict):

    IN_OUT = ['IN', 'OUT']

    # juntando 'std_logic' com 'std_logic_num_inputs' e assim por diante
    IN_list_half = list_concat_half(IO_list=IN_list)
    OUT_list_half = list_concat_half(IO_list=OUT_list)

    IO_list = IN_list_half + OUT_list_half

    i = 0
#   return_dict = copy.deepcopy(IO_dict)
    return_dict = IO_dict

    for j in range(0, len(IN_OUT)):  # ['IN','OUT']
        i = 0
        for item in IO_dict[IN_OUT[j]]:  # STD_LOGIC, STD_LOGIC_VECTOR, SIGNED
            if (IO_list[i] == []):  # quando é lista vazia, melhor preencher dict com: None
                return_dict[IN_OUT[j]][f"{item}"] = None
            else:  # caso contrário segue normal
                return_dict[IN_OUT[j]][f"{item}"] = IO_list[i]

                print(f"IO_list[{i}]{IO_list[i]}")
            i = i + 1

        return return_dict


#################################################################################
# IO_utils
#################################################################################

# from utils import input_sequences

# MAC_IO_dict = {
#   'IN': {
#   # INPUTS
#   'STD_LOGIC': ['clk', 'rst'] , #
#   'STD_LOGIC_VECTOR': None, #['A','B'],
#   # 'STD_LOGIC_VECTOR': ['A','B'],
#   'STD_LOGIC_num_inputs': None, #['C','D'],
#   'STD_LOGIC_VECTOR_num_inputs': None,
#   'SIGNED': ['bias'],
#   'SIGNED_num_inputs': ['x','w']
#   },
#   'OUT' : {
#   #  OUTPUTS
#   'STD_LOGIC': None , #
#   'STD_LOGIC_VECTOR': None, #['A','B'],
#   'STD_LOGIC_num_inputs': None, #['C','D'],
#   'STD_LOGIC_VECTOR_num_inputs': None,
#   'SIGNED': ['output'],
#   'SIGNED_num_inputs': None
#   }
#   }
# if (print_cells_result == 1):
#   MAC_IO_dict


def sequence_string_to_input(input_name: list, num_inputs: int):
    """
    Função que gera várias strings relacionadas às entradas do arquivo VHDL.
    Exemplo: sequence_string_to_input(['x'],3)
    Output:
      (['x1, x2, x3'],       a) nomes das entradas em uma string só
      ['sx1, sx2, sx3'],     b) nomes dos sinais para estas entradas (necessário dentro da lógica do VHDL)
      ['val_x1, val_x2, val_x3'], c) entradas para testbench (se não me engano)
      ['x1', 'x2', 'x3'],    d) nome das entradas, porém em uma lista
      ['x1=>x1', 'x2=>x2', 'x3=>x3']) e) isso aqui é usado para instanciar um módulo, exemplo: U1_inst = somador port map (x1=>x1, x2=>x2, ...)

    Args:
        input_name (list): lista de entradas que terá o VHDL, exemplo ['x','w']
        num_inputs (int): número de entradas do tipo 'input_name' passado

    Returns:
        list: retorna as listas de strings conforme já dado exemplo acima
    """
    x_sequence_string = []
    x_map_tb = []
    sx_sequence_string = []
    valx_sequence_string = []
    x_w_sequence_string = []

    if (input_name == None):  # quando o q é passado é 'None'
        return ''  # retornamos nada

    for i in (input_name):
        # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        x_sequence_string.append(
            input_sequences(i, num_inputs, 'string', 0, 0))
        # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        x_map_tb.append(input_sequences(i, num_inputs, 'string', 1, 0))
        # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        sx_sequence_string.append(input_sequences(
            f's{i}', num_inputs, 'string', 0, 0))
        # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        valx_sequence_string.append(input_sequences(
            f'val_{i}', num_inputs, 'string', 0, 0))

        # print(x_sequence_string)
        # print(sx_sequence_string)
        # print(valx_sequence_string)
        # print('-----------------')
        # return [x_sequence_string, sx_sequence_string,valx_sequence_string ]

    # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
    x_w_sequence_string = input_sequences(input_name, num_inputs, 'list', 0, 0)
    # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
    xw_map_tb_sequence_string = input_sequences(
        input_name, num_inputs, 'list', 1, 0)
    # print(x_w_sequence_string)
    # print(xw_map_tb_sequence_string)
    # print('-----------------')

    return x_sequence_string, sx_sequence_string, valx_sequence_string, x_w_sequence_string, xw_map_tb_sequence_string


def seq_input_output(x_seq: list,
                     type: str,
                     IO_type: str,
                     bits: int,
                     list_or_string: str,
                     port_position: str = 'init'
                     ):
    """Função para escrever as entradas completas, igual descrevemos num VHDL. Por exemplo:
    seq_input_output( x_seq = ['x1,x2,x3','w1,w2'],
                      type = "IN",
                      IO_type = 'signed',
                      bits = 8,
                      list_or_string = 'string',
                      port_position = 'begin')
      Output: #retornou tudo em uma string só
        x1,x2,x3: IN signed(7 DOWNTO 0);
        w1,w2: IN signed(7 DOWNTO 0);
    -----------------------------------

    seq_input_output( x_seq = ['x1,x2,x3','w1,w2'],
                      type = "IN",
                      IO_type = 'signed',
                      bits = 8,
                      list_or_string = 'list',
                      port_position = 'begin')
      Output: #retornou uma lista
        ['x1,x2,x3: IN signed(7 DOWNTO 0);', 'w1,w2: IN signed(7 DOWNTO 0);']

    Args:
        x_seq (list): lista de portas (entradas ou saídas)

        type (str): 'IN' = entrada, 'OUT' = saída

        IO_type (str): aqui colocamos o tipo da porta: 'signed' ou 'unsigned' ou 'STD_LOGIC_VECTOR'

        bits (int): número de bits da porta

        list_or_string (str): se queremos que a função retorne uma string só com todas as portas ou uma lista de declaração de portas

        port_position (str, optional): Aqui indicamos se as portas geradas estão no começo ou no final da descrição de portas da entidade. Pois se estiver no final, a última porta declarada não poderá ter o caractere ';' ao final da linha. Defaults to 'init'.

    Returns:
        str ou list: Retornará a declaração das portas desejadas em formato de lista ou string dependendo do parâmetro 'list_or_string' passado
    """
    x = []
    for i in x_seq:
        x.append(f"{i}: {type} {IO_type}({str(bits -1)} DOWNTO 0);")

    if (list_or_string == 'string'):  # caso queira o retorno em string

        if (port_position == 'end'):  # se está no final do 'port (...)' => tira último ';'
            x = '\n'.join(map(str, x))
            return x[:-1]
        else:
            return '\n'.join(map(str, x))

    else:  # caso queira o retorno em vetor
        return x
# seq_input_output(x_seq,"IN",IO_type,bits,'vector','begin')


def seq_signal(x_seq: list,
               type: str = 'SIGNAL',
               IO_type: str = 'signed',
               bits: int = '0'):
    """função para gerar string dos sinais. Exemplo:
    seq_signal(x_seq = ['x1,x2,x3','w1,w2'],
                    type = "SIGNAL",
                    IO_type = 'signed',
                    bits = 8)
      Output:
        ['SIGNAL x1,x2,x3: signed(7 DOWNTO 0);' ,
                                  'SIGNAL w1,w2: signed(7 DOWNTO 0);']

    Args:
        x_seq (list): lista de portas, exemplo: ['x1,x2,x3','w1,w2,w3']

        type (str): palavra do começo da declaração (SIGNAL ...)

        IO_type (str): aqui colocamos o tipo da porta: 'signed' ou 'unsigned' ou 'STD_LOGIC_VECTOR'

        bits (int): número de bits do sinal

    Returns:
        _type_: _description_
    """
    sx = []
    for i in x_seq:
        sx.append(f"{type} {i}: {IO_type}({str(bits -1)} DOWNTO 0); ")
    return sx
# seq_signal(x_seq,"SIGNAL",IO_type,bits)
# seq_signal(valx_seq,"SIGNAL","STD_LOGIC_VECTOR",bits)


def IO_STDL(IO_dict: dict,
            onerow: bool = True,
            IO: str = 'IN',
            remove_dict_items: list = ['']) -> str:
    """Função para gerar apenas as entradas (IO = 'IN') ou saídas (IO = 'OUT') do tipo STD_LOGIC.
    Exemplo:
      IO_STDL(MAC_IO_dict,1,'IN')
      Output:
        clk, rst: IN STD_LOGIC;

    Args:
        IO_dict (dict): dicionário que especifica as entradas e/ou saídas

        onerow (bool, optional): Se cada 'input' será declarada em uma linha diferente (onerow = True) ou não (onerow = False) . Defaults to True.

        IO (str, optional): tipo de porta (entrada ou saída)-> 'IN' ou 'OUT'. Defaults to 'IN'.

    Returns:
        str: retorna a declaração em texto
    """
    if (IO_dict[IO]['STD_LOGIC'] == None):
        return ''
    else:
        text = []

        if (onerow == 1):  # tudo em uma linha
            for i in IO_dict[IO]['STD_LOGIC']:
                text.append(f"{i}")
            text = remove_all_lista_ocurrences(
                lista=text, occurences_list=remove_dict_items)

            if text:  # se a lista não está vazia
                # text_list can be an splitted text or a list of
                text = ', '.join(map(str, (text)))
                text = f"{text}: {IO} STD_LOGIC;"
                # print(text)
            else:
                return ''

        else:
            for i in IO_dict[IO]['STD_LOGIC']:
                text.append(f"{i}")
            text = remove_all_lista_ocurrences(
                lista=text, occurences_list=remove_dict_items)

            if text:  # if is not empty
                for i in text:
                    text.append(f"{i}: {IO} STD_LOGIC;")
                    # print(f"{i}: IN STD_LOGIC;\n")
                    # print(i)
                # text_list can be an splitted text or a list of texts
                text = '\n'.join(map(str, (text)))
            else:
                return ''

        return text


def IO_STDL_V(IO_dict: dict = {},
              bits: int = 8,
              onerow: bool = True,
              IO: str = 'IN') -> str:
    """Função análoga à 'IO_STDL()' porém agora para entradas e saídas do tipo 'STD_LOGIC_VECTOR'

    Args:
        IO_dict (dict, optional): _description_. Defaults to {}.
        bits (int, optional): _description_. Defaults to 8.
        onerow (bool, optional): _description_. Defaults to True.
        IO (str, optional): _description_. Defaults to 'IN'.

    Returns:
        str: _description_
    """
    if (IO_dict[IO]['STD_LOGIC_VECTOR'] == None):
        # pass
        return ''

    else:
        text = []
        if (onerow == 1):  # tudo em uma linha
            for i in IO_dict[IO]['STD_LOGIC_VECTOR']:
                text.append(f"{i}")
            # text_list can be an splitted text or a list of
            text = ', '.join(map(str, (text)))
            text = f"{text}: {IO} STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);"

        else:
            for i in IO_dict[IO]['STD_LOGIC_VECTOR']:
                text.append(
                    f"{i}: {IO} STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);")
                # print(f"{i}: IN STD_LOGIC;\n")
                # print(i)
            # text_list can be an splitted text or a list of texts
            text = '\n'.join(map(str, (text)))

        return text
# EXEMPLO
# if (print_cells_result == 1):
#   print(IO_STDL_V(MAC_IO_dict,bits,1,'IN'))


def IO_signed(IO_dict: dict, bits: int, onerow: bool, IO: str) -> str:
    """Função análoga à 'IO_STDL()' porém agora para entradas e saídas do tipo 'SIGNED'

    Args:
        IO_dict (dict): _description_
        bits (int): _description_
        onerow (bool): _description_
        IO (str): _description_

    Returns:
        str: _description_
    """
    if (IO_dict[IO]['SIGNED'] == None):
        return ''

    else:
        text = []
        if (onerow == 1):  # tudo em uma linha
            for i in IO_dict[IO]['SIGNED']:
                text.append(f"{i}")
            # text_list can be an splitted text or a list of
            text = ', '.join(map(str, (text)))
            text = f"{text}: {IO} signed({str(bits -1)} DOWNTO 0);"

        else:
            for i in IO_dict[IO]['SIGNED']:
                text.append(f"{i}: {IO} signed({str(bits -1)} DOWNTO 0);")
            # text_list can be an splitted text or a list of texts
            text = '\n'.join(map(str, (text)))

        return text
# Exemplo
# if (print_cells_result == 1):
#   print(IO_signed(MAC_IO_dict,bits,1,'IN'))


def IO_STD_num_inputs(IO_dict: dict, num_inputs: int, onerow: bool = True, IO: str = 'IN') -> str:
    """Função análoga à 'IO_STDL()' porém agora irá gerar entradas ou saídas de acordo com o valor do parâmetro 'num_inputs'. Função para portas do tipo 'STD_LOGIC'.

    Exemplo:
        MAC_IO_dict['OUT']['STD_LOGIC_num_inputs'] = ['C','D']
        dict_slice = MAC_IO_dict['OUT']['STD_LOGIC_num_inputs']
        IO_STD_num_inputs(dict_slice,num_inputs,0,'OUT')

        Output:
            C1, C2, C3: OUT STD_LOGIC;
            D1, D2, D3: OUT STD_LOGIC;

    --------------------------------------------------------
    Args:
        IO_dict (dict): dicionário que especifica as entradas e/ou saídas

        num_inputs (int): número de entradas do neurônio

        onerow (bool): Se cada 'input' será declarada em uma linha diferente (onerow = True) ou não (onerow = False) . Defaults to True.

        IO (str, optional): tipo de porta (entrada ou saída)-> 'IN' ou 'OUT'. Defaults to 'IN'.. Defaults to 'IN'.

    Returns:
        str: string conforme 'Output' do exemplo acima
    """
    if (IO_dict[IO]['STD_LOGIC_num_inputs'] == None):  # quando o q é passado é 'None'
        return ''  # retornamos nada
    else:
        x_sequence_string, sx_sequence_string, valx_sequence_string, x_w_sequence_string, xw_map_tb_sequence_string = sequence_string_to_input(
            IO_dict[IO]['STD_LOGIC_num_inputs'], num_inputs)

    text = []
    if (onerow == 1):  # tudo em uma linha
        for i in x_sequence_string:
            text.append(f"{i}")
        # text_list can be an splitted text or a list of
        text = ', '.join(map(str, (text)))
        text = f"{text}: {IO} STD_LOGIC;"

    else:
        for i in x_sequence_string:
            text.append(f"{i}: {IO} STD_LOGIC;")
        # text_list can be an splitted text or a list of texts
        text = '\n'.join(map(str, (text)))

    return text
# Exemplo
# if (print_cells_result == 1):
#   print(IO_STD_num_inputs(MAC_IO_dict,num_inputs,0,'IN'))


def IO_STDL_V_num_inputs(IO_dict: dict,
                         bits: int,
                         num_inputs: int,
                         onerow: bool = True,
                         IO: str = 'IN'):
    """Função análoga à 'IO_STD_num_inputs()' porém agora para portas (input ou output) do tipo 'STD_LOGIC_VECTOR'

    Args:
        IO_dict (dict): _description_
        bits (int): _description_
        num_inputs (int): _description_
        onerow (bool, optional): _description_. Defaults to True.
        IO (str, optional): _description_. Defaults to 'IN'.

    Returns:
        _type_: _description_
    """

    if (IO_dict[IO]['STD_LOGIC_VECTOR_num_inputs'] == None):  # quando o q é passado é 'None'
        return ''  # retornamos nada

    else:
        x_sequence_string, sx_sequence_string, valx_sequence_string, x_w_sequence_string, xw_map_tb_sequence_string = sequence_string_to_input(
            IO_dict[IO]['STD_LOGIC_VECTOR_num_inputs'], num_inputs)  # gera todas as sequencias necessárias

    text = []
    if (onerow == 1):  # tudo em uma linha
        for i in x_sequence_string:
            text.append(f"{i}")
        # text_list can be an splitted text or a list of
        text = ', '.join(map(str, (text)))
        text = f"{text}: {IO} STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);"

    else:
        for i in x_sequence_string:
            text.append(
                f"{i}: {IO} STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);")
        # text_list can be an splitted text or a list of texts
        text = '\n'.join(map(str, (text)))

    return text
# EXEMPLO
# if (print_cells_result == 1):
#   print(IO_STDL_V_num_inputs(MAC_IO_dict,bits,num_inputs,0,'IN'))


def IO_signed_num_inputs(IO_dict: dict,
                         bits: int,
                         num_inputs: int,
                         onerow: bool = True,
                         IO: str = 'IN'):
    """Função análoga à 'IO_STD_num_inputs()' porém agora para portas (input ou output) do tipo 'signed'

    Args:
        IO_dict (dict): _description_
        bits (int): _description_
        num_inputs (int): _description_
        onerow (bool, optional): _description_. Defaults to True.
        IO (str, optional): _description_. Defaults to 'IN'.

    Returns:
        _type_: _description_
    """
    if (IO_dict[IO]['SIGNED_num_inputs'] == None):  # quando o q é passado é 'None'
        return ''  # retornamos nada

    else:
        x_sequence_string, sx_sequence_string, valx_sequence_string, x_w_sequence_string, xw_map_tb_sequence_string = sequence_string_to_input(
            IO_dict[IO]['SIGNED_num_inputs'], num_inputs)  # gera todas as sequencias necessárias

    text = []
    if (onerow == 1):  # tudo em uma linha
        for i in x_sequence_string:
            text.append(f"{i}")
        # text_list can be an splitted text or a list of
        text = ', '.join(map(str, (text)))
        text = f"{text}: {IO} signed({str(bits -1)} DOWNTO 0);"

    else:
        for i in x_sequence_string:
            text.append(f"{i}: {IO} signed({str(bits -1)} DOWNTO 0);")
        # text_list can be an splitted text or a list of texts
        text = '\n'.join(map(str, (text)))

    return text
# EXEMPLO
# if (print_cells_result == 1):
#   print(IO_signed_num_inputs(MAC_IO_dict,bits,num_inputs,0,'IN'))

# IO_manual


def concat_func(x, y): return x + "" + y


camada_inputs_teste = [['clk', 'rst', 'update_weights'], [], [],
                       [], [], [], ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']]


def IO_manual(IO_dict: dict, IO_list: list, IO_type: str = 'IN', DEBUG: bool = False) -> str:
    """Função para gerar entradas e saídas 'manual' com base no dicionário (IO_dict) e uma lista de IO do layers (IO_list), comparando assim a qual grupo cada item da IO_list pertence.

    Args:
        IO_dict (dict): dicionário padrão do arquivo 'standar_dicts'
        IO_list (list): lista de nome das entradas da camada. 
            Exemplo :
                IO_list = [
                    ['clk', 'rst', 'update_weights'], -- STD_LOGIC
                    [], -- STD_LOGIC_VECTOR
                    [], -- SIGNED
                    [], -- STD_LOGIC_num_inputs
                    [], -- STD_LOGIC_VECTOR_num_inputs
                    [], -- SIGNED_num_inputs
                    ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win'] -- manual
                    ]
        IO_type (str, optional): _description_. Defaults to 'IN'.

    Returns:
        final_string (str): Retorna texto com as IO. Exemplo para entradas compartilhadas entre os neurônios ('shared_IO'): 
            Xi : IN signed((TOTAL_BITS) - 1 DOWNTO 0);

            Ou por exemplo para entradas únicas a cada neurônio ('unique_IO'):
            c0_n0_Win, c0_n1_Win, c0_n2_Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    """
    nomes = []  # usado para comparação
    nomes2 = []  # usado para armazenar os items da lista que são similares a 'nomes'
    tipos = []
    tipos2 = []
    dict_list_value_manual = []

    for IO_class in ['shared_IO', 'unique_IO']:
        dict_list_value_manual.append(dict_list_exceptNone(
            dict_slice=IO_dict['Neuron_arch']['IO'][IO_class][IO_type]['manual'], return_value_or_key='value', is_list=True))
    # print(f"dict_list_value_manual: {dict_list_value_manual}")
    dict_list_value_manual = [j for i in dict_list_value_manual for j in i]

    find = ":"

    for item in dict_list_value_manual:
        #  Para o caso em que IO_type = 'IN'
        # dict_list_value_manual = [
        # ['Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);'],
        # ['Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);']
        #   ]

        position = item.find(f"{find}")
        txt_antes = item[:position].strip()  # nome variavel
        txt_depois = item[position:].strip()  # tipo de variavel
        if DEBUG:
            print(f"txt_antes: {txt_antes}")
            print(f"txt_depois: {txt_depois}")
            print(" ")

        if not txt_depois in tipos:
            tipos.append(txt_depois)
            nomes.append(txt_antes)
        else:
            for i in range(0, len(tipos)):
                if tipos[i] == txt_depois:  # quando temos itens do mesmo tipo
                    nomes[i] = f"{nomes[i]}, {txt_antes}"

    # print(f"nomes: {nomes}")
    # print(f"tipos: {tipos}")
    # print("---")
    find = "_"

    # nomes = ['Xi', 'Win']
    # tipos = ['IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);',
    # 'IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);']

    # criando listas com mesmo formato e tamanho
    nomes2 = ['']*len(nomes)
    tipos2 = ['']*len(tipos)

    # print("for item in IO_list:")
    # print(f"IO_list: {IO_list}")
    for item in IO_list[IO_type]['manual']:
        if DEBUG:
            print(f"item: {item}")  # clk, ... , Xi, c0_n0_Win, ...
        # para o caso em que IO_type = 'IN'
        #  dict_list_value_manual = [
        #     ['clk', 'rst', 'update_weights'],
        #     [],
        #     [],
        #     [],
        #     [],
        #     [],
        #     ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']
        #     ]

        if "_" in item:
            position = item.find(f"{find}")
            txt_depois = item.split(f"{find}")[-1]  # c0_n0_Win -> Win
        else:
            txt_depois = item  # clk -> clk
        # print(f"txt_antes: {txt_antes}")
        # print(f"txt_depois: {txt_depois}")  # -> Win
        # print(" ")

        # print("limpando listas: ")
        # print(f"nomes2: {nomes2}")
        # print(f"tipos2: {tipos2}")

        # if 'Win' vindo de 'c0_n0_Win'(item) in nomes:['Xi','Win']
        if txt_depois in nomes:
            # print(" ------------ igualdade !! ---------------- ")

            for i in range(0, len(nomes)):  # verificando os tipos que são iguais
                # se 'Win'(txt_depois) vindo de 'c0_n0_Win'(item)  == 'Win'(nomes[i])
                # em resumo: se 'Win'(txt_depois) == 'Win'(nomes[i])
                if txt_depois == nomes[i]:
                    if nomes2[i] == '':
                        # print(f"quando está vazio:  nomes2[{i}] = {item}")
                        nomes2[i] = f"{item}"  # 'c0_n0_Win'(item)
                        tipos2[i] = tipos[i]  # 'c0_n0_Win'(item)
                    else:
                        # print(f"quando já tem algo:  nomes2[{i}] = {nomes2[i]}, {item}")
                        nomes2[i] = f"{nomes2[i]}, {item}"  # 'c0_n0_Win'(item)
                        tipos2[i] = tipos[i]  # 'c0_n0_Win'(item)
        # nomes = ['Xi', 'Win']
        # tipos = ['IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);',
        # 'IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);']

        # print(f"nomes: {nomes}")
        # print(f"tipos: {tipos}")
        # print(' ')
        # print(f"nomes2: {nomes2}")
        # print(f"tipos2: {tipos2}")
        # print('---')

    text_list = list(map(concat_func, nomes2, tipos2))  # list the map function
    # text_list can be an splitted text or a list of texts
    final_string = '\n'.join(map(str, (text_list)))
    # print(f"utils.py :: IO_manual() -> final_string: {final_string}")
    return final_string


# def IO_manual_Top(IO_dict: dict, IO_list: list, IO_type: str = 'IN', DEBUG: bool = False) -> str:
    """Função para gerar entradas e saídas 'manual' com base no dicionário (IO_dict) e uma lista de IO do layers (IO_list), comparando assim a qual grupo cada item da IO_list pertence.

    Args:
        IO_dict (dict): dicionário padrão do arquivo 'standar_dicts'
        IO_list (list): lista de nome das entradas da camada. 
            Exemplo :
                IO_list = [
                    ['clk', 'rst', 'update_weights'], -- STD_LOGIC
                    [], -- STD_LOGIC_VECTOR
                    [], -- SIGNED
                    [], -- STD_LOGIC_num_inputs
                    [], -- STD_LOGIC_VECTOR_num_inputs
                    [], -- SIGNED_num_inputs
                    ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win'] -- manual
                    ]
        IO_type (str, optional): _description_. Defaults to 'IN'.

    Returns:
        final_string (str): Retorna texto com as IO. Exemplo para entradas compartilhadas entre os neurônios ('shared_IO'): 
            Xi : IN signed((TOTAL_BITS) - 1 DOWNTO 0);

            Ou por exemplo para entradas únicas a cada neurônio ('unique_IO'):
            c0_n0_Win, c0_n1_Win, c0_n2_Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
    """
    nomes = []  # usado para comparação
    nomes2 = []  # usado para armazenar os items da lista que são similares a 'nomes'
    tipos = []
    tipos2 = []
    dict_list_value_manual = []

    dict_list_value_manual.append(dict_list_exceptNone(
        dict_slice=IO_dict[IO_type]['manual'], return_value_or_key='value', is_list=True))
    dict_list_value_manual = [j for i in dict_list_value_manual for j in i]
    print(f"dict_list_value_manual: {dict_list_value_manual}")

    find = ":"

    for item in dict_list_value_manual:
        #  Para o caso em que IO_type = 'IN'
        # dict_list_value_manual = [
        # ['Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);'],
        # ['Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);']
        #   ]

        position = item.find(f"{find}")
        txt_antes = item[:position].strip()  # nome variavel
        txt_depois = item[position:].strip()  # tipo de variavel
        if True:
            # if DEBUG:
            print(f"txt_antes: {txt_antes}")
            print(f"txt_depois: {txt_depois}")
            print(" ")

        if not txt_depois in tipos:
            tipos.append(txt_depois)
            nomes.append(txt_antes)
        else:
            for i in range(0, len(tipos)):
                if tipos[i] == txt_depois:  # quando temos itens do mesmo tipo
                    nomes[i] = f"{nomes[i]}, {txt_antes}"

    # print(f"nomes: {nomes}")
    # print(f"tipos: {tipos}")
    # print("---")
    find = "_"

    # nomes = ['Xi', 'Win']
    # tipos = ['IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);',
    # 'IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);']

    # criando listas com mesmo formato e tamanho
    nomes2 = ['']*len(nomes)
    tipos2 = ['']*len(tipos)

    # print("for item in IO_list:")
    # print(f"IO_list: {IO_list}")
    for item in IO_list[IO_type]['manual']:
        # if DEBUG:
        if True:
            print(f"item: {item}")  # clk, ... , Xi, c0_n0_Win, ...
        # para o caso em que IO_type = 'IN'
        #  dict_list_value_manual = [
        #     ['clk', 'rst', 'update_weights'],
        #     [],
        #     [],
        #     [],
        #     [],
        #     [],
        #     ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']
        #     ]

        if "_" in item:
            position = item.find(f"{find}")
            txt_depois = item.split(f"{find}")[-1]  # c0_n0_Win -> Win
        else:
            txt_depois = item  # clk -> clk
        # print(f"txt_antes: {txt_antes}")
        # print(f"txt_depois: {txt_depois}")  # -> Win
        # print(" ")

        # print("limpando listas: ")
        # print(f"nomes2: {nomes2}")
        # print(f"tipos2: {tipos2}")

        # if 'Win' vindo de 'c0_n0_Win'(item) in nomes:['Xi','Win']
        if txt_depois in nomes:
            # print(" ------------ igualdade !! ---------------- ")

            for i in range(0, len(nomes)):  # verificando os tipos que são iguais
                # se 'Win'(txt_depois) vindo de 'c0_n0_Win'(item)  == 'Win'(nomes[i])
                # em resumo: se 'Win'(txt_depois) == 'Win'(nomes[i])
                if txt_depois == nomes[i]:
                    if nomes2[i] == '':
                        # print(f"quando está vazio:  nomes2[{i}] = {item}")
                        nomes2[i] = f"{item}"  # 'c0_n0_Win'(item)
                        tipos2[i] = tipos[i]  # 'c0_n0_Win'(item)
                    else:
                        # print(f"quando já tem algo:  nomes2[{i}] = {nomes2[i]}, {item}")
                        nomes2[i] = f"{nomes2[i]}, {item}"  # 'c0_n0_Win'(item)
                        tipos2[i] = tipos[i]  # 'c0_n0_Win'(item)
        # nomes = ['Xi', 'Win']
        # tipos = ['IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);',
        # 'IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);']

        # print(f"nomes: {nomes}")
        # print(f"tipos: {tipos}")
        # print(' ')
        # print(f"nomes2: {nomes2}")
        # print(f"tipos2: {tipos2}")
        # print('---')

    text_list = list(map(concat_func, nomes2, tipos2))  # list the map function
    # text_list can be an splitted text or a list of texts
    final_string = '\n'.join(map(str, (text_list)))
    # print(f"utils.py :: IO_manual() -> final_string: {final_string}")
    if DEBUG:
        print(f"utils.py --> IO_manual_Top: final_string: {final_string}")
    return final_string

# IO_dict_list = [layer_dict_hidden['IO']]
# for i in range(0, len(IO_dict_list)):
#     # print(IO_dict_list[i])


#     print(f"saida[{i}]: {IO_manual(IO_dict=IO_dict_list[i], IO='IN')}")
# print(IO_manual(IO_dict=layer_dict_hidden, IO_list=camada_inputs_teste, IO_type='IN')
#       )


def IO_manager(IO_dict_list: list = [{}, {}],
               bits: int = 0,
               num_inputs: int = 3,
               onerow: bool = True,
               tab_space: int = 2,
               remove_dict_items=[]) -> str:
    """Função para gerar toda a declaração das portas (inputs & outputs) da parte 'entity' do módulo.vhd com base em um dicionário em formato padrão pré-estabelecido. Retorna um texto disso tudo.
    -----------------------------------------------------
    Exemplo de dicionário:
      MAC_IO_dict = {
        'IN': {
          # INPUTS
          'STD_LOGIC': ['clk', 'rst'] , #
          'STD_LOGIC_VECTOR': None, #['A','B'],
          # 'STD_LOGIC_VECTOR': ['A','B'],
          'STD_LOGIC_num_inputs': None, #['C','D'],
          'STD_LOGIC_VECTOR_num_inputs': None,
          'SIGNED': ['bias'],
          'SIGNED_num_inputs': ['x','w']
          },
        'OUT' : {
          #  OUTPUTS
          'STD_LOGIC': None , #
          'STD_LOGIC_VECTOR': None, #['A','B'],
          # 'STD_LOGIC_num_inputs': None, #['C','D'],
          'STD_LOGIC_num_inputs': ['C','D'],
          'STD_LOGIC_VECTOR_num_inputs': None,
          'SIGNED': ['output'],
          'SIGNED_num_inputs': None
          }
        }
    -----------------------------------------------------
    Exemplo utilizando a função:
      IO, traço = IO_manager([MAC_IO_dict], bits = 8,
                             num_inputs = 3, onerow = 1,tab_space = 2)

      Output: (veja que está 2 'tabs' a direita --> tab_space = 2)
            clk, rst: IN STD_LOGIC;
            bias: IN signed(7 DOWNTO 0);
            x1, x2, x3: IN signed(7 DOWNTO 0);
            w1, w2, w3: IN signed(7 DOWNTO 0);
            ----------------------------------------------
            output: OUT signed(7 DOWNTO 0)

    -----------------------------------------------------
    Args:
        IO_dict_list (list, optional): lista de dicionários de INPUTS & OUTPUTS. Defaults to [{},{}].

        bits (int, optional): número de bits de representação (WIDTH). Defaults to 0.

        num_inputs (int, optional): número de entradas do neurônio (entradas que expandem por exemplo um 'x' para 'x1,x2,x3' caso num_inputs = 3). Defaults to 3.

        onerow (bool, optional): _description_. Defaults to True.

        tab_space (int, optional): número de 'tabs' a esquerda de cada linha (para melhor visualização e formatação de código). Defaults to 2.
    """

    from txt_utils import erase_empty_lines, tab_lines
    IN_stdl = []
    IN_stdl_v = []
    IN_stdl_num_inputs = []
    IN_stdl_v_num_inputs = []
    IN_signed = []
    IN_signed = []
    IN_signed_num_inputs = []
    IN_manual = []

    OUT_stdl = []
    OUT_stdl_v = []
    OUT_stdl_num_inputs = []
    OUT_stdl_v_num_inputs = []
    OUT_signed = []
    OUT_signed = []
    OUT_signed_num_inputs = []
    OUT_manual = []

    for i in range(0, len(IO_dict_list)):
        # INPUTS
        IN_stdl.append(
            IO_STDL(IO_dict_list[i], onerow, 'IN', remove_dict_items=remove_dict_items))
        IN_stdl_v.append(IO_STDL_V(
            IO_dict_list[i], bits, onerow, 'IN'))
        IN_stdl_num_inputs.append(IO_STD_num_inputs(
            IO_dict_list[i], num_inputs, onerow, 'IN'))
        IN_stdl_v_num_inputs.append(IO_STDL_V_num_inputs(
            IO_dict_list[i], bits, num_inputs, 0, 'IN'))
        IN_signed.append(IO_signed(IO_dict_list[i], bits, onerow, 'IN'))
        IN_signed_num_inputs.append(IO_signed_num_inputs(
            IO_dict_list[i], bits, num_inputs, 0, 'IN'))
        # print(f"IO_dict_list[i]['IN']: {IO_dict_list[i]['IN']}")
        IN_manual.append(dict_list_exceptNone(
            dict_slice=IO_dict_list[i]['IN']['manual']))

        # OUTPUTS
        OUT_stdl.append(IO_STDL(IO_dict_list[i], onerow, 'OUT'))
        OUT_stdl_v.append(IO_STDL_V(IO_dict_list[i], bits, onerow, 'OUT'))
        OUT_stdl_num_inputs.append(IO_STD_num_inputs(
            IO_dict_list[i], num_inputs, onerow, 'OUT'))
        OUT_stdl_v_num_inputs.append(IO_STDL_V_num_inputs(
            IO_dict_list[i], bits, num_inputs, 0, 'OUT'))
        OUT_signed.append(IO_signed(IO_dict_list[i], bits, onerow, 'OUT'))
        OUT_signed_num_inputs.append(IO_signed_num_inputs(
            IO_dict_list[i], bits, num_inputs, 0, 'OUT'))
        OUT_manual.append(dict_list_exceptNone(
            dict_slice=IO_dict_list[i]['OUT']['manual']))

    # para ficarmos com uma lista de apenas 1 nível
    IN_manual = [''.join(l) for l in IN_manual]
    OUT_manual = [''.join(l) for l in OUT_manual]
    # print(IN_manual)
    # print("------")
    # print(OUT_manual)

    # ---- Removendo I/O manuais que não queremos no MAC
    IN_manual = remove_all_lista_ocurrences(
        lista=IN_manual, occurences_list=remove_dict_items)
    OUT_manual = remove_all_lista_ocurrences(
        lista=OUT_manual, occurences_list=remove_dict_items)

    text = [IN_stdl, IN_stdl_v, IN_stdl_num_inputs, IN_signed, IN_signed_num_inputs, IN_stdl_v_num_inputs, IN_manual,
            ['----------------------------------------------'],
            OUT_stdl, OUT_stdl_v, OUT_stdl_num_inputs, OUT_signed, OUT_signed_num_inputs, OUT_stdl_v_num_inputs, OUT_manual]

    text = [j for i in text for j in i]
    text = '\n'.join(map(str, (text)))
    # text = ['\n'.join(l) for l in text]

    traço = ' --'+'\n --'.join(map(str, (IO_dict_list[i].items())))

    text = tab_lines(text, tab_space)
    text = erase_empty_lines(text)[:-1]
    # text = text[:-1] #tira ';' e uma linha em branco
    return (text, traço)
# EXEMPLO


def IO_manager_layer(IO_dict: dict = {},
                     bits: int = 0,
                     onerow: bool = True,
                     tab_space: int = 2) -> str:
    """Função para gerar toda a declaração das portas (inputs & outputs) da parte 'entity' do módulo.vhd com base em um dicionário em formato padrão pré-estabelecido. Retorna um texto disso tudo.
    -----------------------------------------------------
    Exemplo de dicionário:
      MAC_IO_dict = {
        'IN': {
          # INPUTS
          'STD_LOGIC': ['clk', 'rst'] , #
          'STD_LOGIC_VECTOR': None, #['A','B'],
          # 'STD_LOGIC_VECTOR': ['A','B'],
          'STD_LOGIC_num_inputs': None, #['C','D'],
          'STD_LOGIC_VECTOR_num_inputs': None,
          'SIGNED': ['bias'],
          'SIGNED_num_inputs': ['x','w']
          },
        'OUT' : {
          #  OUTPUTS
          'STD_LOGIC': None , #
          'STD_LOGIC_VECTOR': None, #['A','B'],
          # 'STD_LOGIC_num_inputs': None, #['C','D'],
          'STD_LOGIC_num_inputs': ['C','D'],
          'STD_LOGIC_VECTOR_num_inputs': None,
          'SIGNED': ['output'],
          'SIGNED_num_inputs': None
          }
        }
    -----------------------------------------------------
    Exemplo utilizando a função:
      IO, traço = IO_manager([MAC_IO_dict], bits = 8,
                             num_inputs = 3, onerow = 1,tab_space = 2)

      Output: (veja que está 2 'tabs' a direita --> tab_space = 2)
            clk, rst: IN STD_LOGIC;
            bias: IN signed(7 DOWNTO 0);
            x1, x2, x3: IN signed(7 DOWNTO 0);
            w1, w2, w3: IN signed(7 DOWNTO 0);
            ----------------------------------------------
            output: OUT signed(7 DOWNTO 0)

    -----------------------------------------------------
    Args:
        IO_dict_list (list, optional): lista de dicionários de INPUTS & OUTPUTS. Defaults to [{},{}].

        bits (int, optional): número de bits de representação (WIDTH). Defaults to 0.

        num_inputs (int, optional): número de entradas do neurônio (entradas que expandem por exemplo um 'x' para 'x1,x2,x3' caso num_inputs = 3). Defaults to 3.

        onerow (bool, optional): _description_. Defaults to True.

        tab_space (int, optional): número de 'tabs' a esquerda de cada linha (para melhor visualização e formatação de código). Defaults to 2.
    """

    from txt_utils import erase_empty_lines, tab_lines
    IN_stdl = []
    IN_stdl_v = []
    IN_signed = []
    IN_manual = []

    OUT_stdl = []
    OUT_stdl_v = []
    OUT_signed = []
    OUT_manual = []
    IO_dict_list = [IO_dict['IO']]

    for i in range(0, len(IO_dict_list)):
        print(
            f" ------------------> IO_dict_list[{i}]['IN']: {IO_dict_list[i]['IN']}")
        # INPUTS
        IN_stdl.append(IO_STDL(IO_dict_list[i], onerow, 'IN'))
        IN_stdl_v.append(IO_STDL_V(IO_dict_list[i], bits, onerow, 'IN'))
        IN_signed.append(IO_signed(IO_dict_list[i], bits, onerow, 'IN'))
        # IN_manual.append(dict_list_exceptNone(
        #     dict_slice=IO_dict_list[i]['IN']['manual']))
        IN_manual.append(
            IO_manual(IO_dict=IO_dict, IO_list=IO_dict_list[i], IO_type='IN'))

        # OUTPUTS
        # print(
        #     f" ------------------> IO_dict_list[{i}]['IN']: {IO_dict_list[i]['OUT']}")
        OUT_stdl.append(IO_STDL(IO_dict_list[i], onerow, 'OUT'))
        OUT_stdl_v.append(IO_STDL_V(IO_dict_list[i], bits, onerow, 'OUT'))
        OUT_signed.append(IO_signed(IO_dict_list[i], bits, onerow, 'OUT'))
        # OUT_manual.append(dict_list_exceptNone(
        #     dict_slice=IO_dict_list[i]['OUT']['manual']))
        OUT_manual.append(
            IO_manual(IO_dict=IO_dict, IO_list=IO_dict_list[i], IO_type='OUT'))
        print(f"IO_manager_layer() -> IN_manual: {IN_manual}")
        print(f"IO_manager_layer() -> OUT_manual: {OUT_manual}")

    # IN_stdl = '\n'.join(map(str, (IN_stdl)))

    # para ficarmos com uma lista de apenas 1 nível
    # IN_manual = [', '.join(l) for l in IN_manual]
    # OUT_manual = [', '.join(l) for l in OUT_manual]
    # # ---- Removendo I/O manuais que não queremos no MAC
    # IN_manual = remove_all_lista_ocurrences(
    #     lista=IN_manual, occurences_list=remove_dict_items)
    # OUT_manual = remove_all_lista_ocurrences(
    #     lista=OUT_manual, occurences_list=remove_dict_items)

    # print(f"IO_manager_layer() -> IN_manual: {IN_manual}")
    # print(f"IO_manager_layer() -> OUT_manual: {OUT_manual}")
    # print("---")

    # text = [IN_stdl, IN_stdl_v, IN_signed,
    #         ['----------------------------------------------'],
    #         OUT_stdl, OUT_stdl_v, OUT_signed]
    text = [IN_stdl, IN_stdl_v, IN_signed, IN_manual,
            ['----------------------------------------------'],
            OUT_stdl, OUT_stdl_v, OUT_signed, OUT_manual]

    text = [j for i in text for j in i]
    text = '\n'.join(map(str, (text)))
    # text = ['\n'.join(l) for l in text]

    traço = ' --'+'\n --'.join(map(str, (IO_dict_list[i].items())))

    text = tab_lines(text, tab_space)
    text = erase_empty_lines(text)[:-1]
    # text = text[:-1] #tira ';' e uma linha em branco
    return (text, traço)
# EXEMPLO
# print(entity(name = layer_dict['Neuron_arch']['Neuron_name'],
#              bits = 8,
#              num_inputs = 3,
#              IO_dict_list = [layer_dict['Neuron_arch']['shared_IO']['IO'], layer_dict['Neuron_arch']['unique_IO']['IO']]
#              ))


def IO_manager_Top(IO_dict_list: list = [{}, {}],
                   bits: int = 0,
                   num_inputs: int = 3,
                   onerow: bool = True,
                   tab_space: int = 2,
                   remove_dict_items=[]
                   ) -> str:
    """Função para gerar toda a declaração das portas (inputs & outputs) da parte 'entity' do módulo.vhd com base em um dicionário em formato padrão pré-estabelecido. Retorna um texto disso tudo.
    -----------------------------------------------------
    Exemplo de dicionário:
      'IO': {  # INPUT & OUTPUT
        'GENERIC': {
            'BITS': lambda: top_dict['bits'],
            'NUM_INPUTS': lambda: top_dict['Inputs_number'],
            'TOTAL_BITS': None
        },
        'IN': {  # ENTRADAS
            'STD_LOGIC': None,
            'STD_LOGIC_VECTOR': None,
            'SIGNED': None,
            'manual': None
        },
        'OUT': {  # SAÍDAS
            'STD_LOGIC': None,
            'STD_LOGIC_VECTOR': None,
            'SIGNED': None,
            'manual': None
        }
    }
    -----------------------------------------------------
    Exemplo utilizando a função:
      IO, traço = IO_manager([MAC_IO_dict], bits = 8,
                             num_inputs = 3, onerow = 1,tab_space = 2)

      Output: (veja que está 2 'tabs' a direita --> tab_space = 2)
            clk, rst: IN STD_LOGIC;
            bias: IN signed(7 DOWNTO 0);
            x1, x2, x3: IN signed(7 DOWNTO 0);
            w1, w2, w3: IN signed(7 DOWNTO 0);
            ----------------------------------------------
            output: OUT signed(7 DOWNTO 0)

    -----------------------------------------------------
    Args:
        IO_dict_list (list, optional): lista de dicionários de INPUTS & OUTPUTS. Defaults to [{},{}].

        bits (int, optional): número de bits de representação (WIDTH). Defaults to 0.

        num_inputs (int, optional): número de entradas do neurônio (entradas que expandem por exemplo um 'x' para 'x1,x2,x3' caso num_inputs = 3). Defaults to 3.

        onerow (bool, optional): _description_. Defaults to True.

        tab_space (int, optional): número de 'tabs' a esquerda de cada linha (para melhor visualização e formatação de código). Defaults to 2.
    """

    from txt_utils import erase_empty_lines, tab_lines
    IN_stdl = []
    IN_stdl_v = []
    IN_stdl_num_inputs = []
    IN_stdl_v_num_inputs = []
    IN_signed = []
    IN_signed = []
    IN_signed_num_inputs = []
    IN_manual = []

    OUT_stdl = []
    OUT_stdl_v = []
    OUT_stdl_num_inputs = []
    OUT_stdl_v_num_inputs = []
    OUT_signed = []
    OUT_signed = []
    OUT_signed_num_inputs = []
    OUT_manual = []

    for i in range(0, len(IO_dict_list)):
        # INPUTS
        IN_stdl.append(
            IO_STDL(IO_dict_list[i], onerow, 'IN', remove_dict_items=remove_dict_items))
        IN_stdl_v.append(IO_STDL_V(IO_dict_list[i], bits, onerow, 'IN'))
        IN_signed.append(IO_signed(IO_dict_list[i], bits, onerow, 'IN'))
        # IN_manual.append(dict_list_exceptNone(
        #     dict_slice=IO_dict_list[i]['IN']['manual'], return_value_or_key='value', is_list=True))
        # IN_manual.append(IO_manual_Top(
        #     IO_dict=IO_dict_list[i], IO_list=IO_dict_list[i], IO_type='IN'))

        # OUTPUTS
        OUT_stdl.append(IO_STDL(IO_dict_list[i], onerow, 'OUT'))
        OUT_stdl_v.append(IO_STDL_V(IO_dict_list[i], bits, onerow, 'OUT'))
        OUT_signed.append(IO_signed(IO_dict_list[i], bits, onerow, 'OUT'))
        # OUT_manual.append(dict_list_exceptNone(
        #     dict_slice=IO_dict_list[i]['OUT']['manual']))

    # print(IN_manual)
    # print("------")
    # print(OUT_manual)

    # # ---- Removendo I/O manuais que não queremos no MAC
    # IN_manual = remove_all_lista_ocurrences(
    #     lista=IN_manual, occurences_list=remove_dict_items)
    # OUT_manual = remove_all_lista_ocurrences(
    #     lista=OUT_manual, occurences_list=remove_dict_items)

    text = [IN_stdl, IN_stdl_v, IN_stdl_num_inputs, IN_signed, IN_signed_num_inputs, IN_stdl_v_num_inputs,
            # IN_manual,
            ['----------------------------------------------'],
            OUT_stdl, OUT_stdl_v, OUT_stdl_num_inputs, OUT_signed, OUT_signed_num_inputs, OUT_stdl_v_num_inputs
            # , OUT_manual
            ]

    text = [j for i in text for j in i]
    text = '\n'.join(map(str, (text)))
    # text = ['\n'.join(l) for l in text]

    traço = ' --'+'\n --'.join(map(str, (IO_dict_list[i].items())))

    text = tab_lines(text, tab_space)
    text = erase_empty_lines(text)[:-1]
    # text = text[:-1] #tira ';' e uma linha em branco
    return (text, traço)


def inputs_vector(bits: int,
                  IO_type: str,
                  x_seq: list,
                  sx_seq: list,
                  valx_seq: list,
                  is_list: bool):
    """Função para retornar as strings das entradas, sinais, sinais de testbench, tanto de 'x' quanto para 'w' (mas poderia ser usado pra muito mais tipos de entradas). Ela retorna tudo em múltiplas variáveis que irão ser salvas em variáveis globais, para serem usadas posteriormente na geração de texto dos arquivos '.vhd'. Exemplo:

    # EXEMPLO 1
    inputs_vector(bits = 8,
                IO_type = 'signed',
                x_seq= ['x1, x2, x3','w1, w2, w3'],
                sx_seq = ['sx1, sx2, sx3','sw1, sw2, sw3'],
                valx_seq= ['val_x1, val_x2, val_x3','val_w1, val_w2, val_w3'],
                is_list= True
                )
      Output: #retorna tudo em formato de lista
      ( ['x1, x2, x3: IN signed(7 DOWNTO 0);', 'w1, w2, w3: IN signed(7 DOWNTO 0);'],
        ['SIGNAL sx1, sx2, sx3: signed(7 DOWNTO 0); ',
          'SIGNAL sw1, sw2, sw3: signed(7 DOWNTO 0); '],
        ['SIGNAL x1, x2, x3: signed(7 DOWNTO 0); ',
          'SIGNAL w1, w2, w3: signed(7 DOWNTO 0); '],
        ['SIGNAL val_x1, val_x2, val_x3: STD_LOGIC_VECTOR(7 DOWNTO 0); ',
          'SIGNAL val_w1, val_w2, val_w3: STD_LOGIC_VECTOR(7 DOWNTO 0); '],
        ['VARIABLE val_x1, val_x2, val_x3: STD_LOGIC_VECTOR(7 DOWNTO 0); ',
          'VARIABLE val_w1, val_w2, val_w3: STD_LOGIC_VECTOR(7 DOWNTO 0); '])

    # EXEMPLO 2
    inputs_vector(bits = 8,
                IO_type = 'signed',
                x_seq= ['x1, x2, x3','w1, w2, w3'],
                sx_seq = ['sx1, sx2, sx3','sw1, sw2, sw3'],
                valx_seq= ['val_x1, val_x2, val_x3','val_w1, val_w2, val_w3'],
                is_list= False
                )
    Output: #retorna cada uma em 1 variável separada
      ( 'x1, x2, x3: IN signed(7 DOWNTO 0);',
        'w1, w2, w3: IN signed(7 DOWNTO 0);',
        'SIGNAL sx1, sx2, sx3: signed(7 DOWNTO 0); ',
        'SIGNAL sw1, sw2, sw3: signed(7 DOWNTO 0); ',
        'SIGNAL x1, x2, x3: signed(7 DOWNTO 0); ',
        'SIGNAL w1, w2, w3: signed(7 DOWNTO 0); ',
        'SIGNAL val_x1, val_x2, val_x3: STD_LOGIC_VECTOR(7 DOWNTO 0); ',
        'SIGNAL val_w1, val_w2, val_w3: STD_LOGIC_VECTOR(7 DOWNTO 0); ',
        'VARIABLE val_x1, val_x2, val_x3: STD_LOGIC_VECTOR(7 DOWNTO 0); ',
        'VARIABLE val_w1, val_w2, val_w3: STD_LOGIC_VECTOR(7 DOWNTO 0); ')
  -----------------------------------------------
    Args:
        bits (int): número de bits das portas

        IO_type (str): aqui colocamos o tipo da porta: 'signed' ou 'unsigned' ou 'STD_LOGIC_VECTOR'

        x_seq (list): lista de portas (entradas ou saídas)

        sx_seq (list): lista de sinais

        valx_seq (list): lista de sinais de testbench

        is_list (bool): True= tudo em uma variável só (não importando o número de elementos passados nos argumentos 'x_seq', 'sx_seq' e  'valx_seq' | False = caso queiramos converter as saídas em lista para diferentes variáveis (um para 'x' e outra para 'w' para cada tipo de sinal)
    """

    # INPUTS
    # https://stackoverflow.com/questions/15478127/remove-final-character-from-string

    x = []
    sx = []
    sx_tb = []
    val_x = []
    val_x_tb = []
    # input definitions
    x = seq_input_output(x_seq, "IN", IO_type, bits, 'vector', 'begin')
    sx_tb = seq_signal(x_seq, "SIGNAL", IO_type, bits)
    sx = seq_signal(sx_seq, "SIGNAL", IO_type, bits)
    val_x = seq_signal(valx_seq, "SIGNAL", "STD_LOGIC_VECTOR", bits)
    val_x_tb = seq_signal(valx_seq, "VARIABLE", "STD_LOGIC_VECTOR", bits)

    if (is_list == False):  # caso queiramos converter as saídas em lista para diferentes variáveis (um para 'x' e outra para 'w' para cada tipo de sinal)
        w = x[1]
        x = x[0]
        sw = sx[1]
        sx = sx[0]
        sw_tb = sx_tb[1]
        sx_tb = sx_tb[0]
        val_w = val_x[1]
        val_x = val_x[0]
        val_w_tb = val_x_tb[1]
        val_x_tb = val_x_tb[0]
        return (x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb)
    else:
        return (x, sx, sx_tb, val_x, val_x_tb)


def all_inputs_signals(inputs_list: list,
                       num_inputs: int,
                       bits: int,
                       IO_type: str,
                       is_list: bool):
    """Função final que irá gerar todas as portas necessárias aos arquivos '.vhd' assim como seus sinais necessários respectivos (retorna em múltiplas variáveis, para serem salvas em variáveis globais para posterior uso). Um exemplo:

    # Exemplo 1
    x,w,sx,sw,sx_tb,sw_tb,val_x,val_w,val_x_tb,val_w_tb =
    all_inputs_signals(
      inputs_list= ['x','w'],
      num_inputs = 3,
      bits = 8,
      IO_type = 'signed',
      is_list = 0
      )

      Output:
        x1, x2, x3: IN signed(7 DOWNTO 0); -- = x
        w1, w2, w3: IN signed(7 DOWNTO 0); -- = w
        SIGNAL sx1, sx2, sx3: signed(7 DOWNTO 0);  -- = sx
        SIGNAL sw1, sw2, sw3: signed(7 DOWNTO 0);  -- = sw
        SIGNAL x1, x2, x3: signed(7 DOWNTO 0);  -- = sx_tb
        SIGNAL w1, w2, w3: signed(7 DOWNTO 0);
        SIGNAL val_x1, val_x2, val_x3: STD_LOGIC_VECTOR(7 DOWNTO 0);
        SIGNAL val_w1, val_w2, val_w3: STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE val_x1, val_x2, val_x3: STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE val_w1, val_w2, val_w3: STD_LOGIC_VECTOR(7 DOWNTO 0);

    Args:
        inputs_list (list): lista de entradas, exemplo ['x','w']

        num_inputs (int): número de entradas. se num_inputs = 2, logo irá gerar entradas x1, x2, w1, w2 (assim como os sinais respectivos ....)

        bits (int): número de bits das portas

        IO_type (str): aqui colocamos o tipo da porta: 'signed' ou 'unsigned' ou 'STD_LOGIC_VECTOR'

        is_list (bool): True= retorna variáveis de forma aglutinada em uma lista (porém separando cada tipo de string, se é uma entrada, se é um sinal, etc)| False = caso queiramos converter as saídas em lista para diferentes variáveis (um para 'x' e outra para 'w' para cada tipo de sinal)
    """
    # ------- Parâmetros do início do script --------
    # num_inputs: número de entradas
    # bits: número de bits
    # IO_type: se é 'signed' ou 'unsigned'
    # -------------- Outros Parâmetros --------------
    # is_list: 1 = representar retornos em vetores x = [..] | 0 = representar em variáveis diferentes -> x, w, ....

    x_sequence_string, sx_sequence_string, valx_sequence_string, x_w_sequence_string, xw_map_tb_sequence_string = sequence_string_to_input(
        inputs_list, num_inputs)

    if (is_list == 0):
        x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb = (inputs_vector(
            bits,
            IO_type,
            x_sequence_string,
            sx_sequence_string,
            valx_sequence_string,
            is_list))
        return (x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb)

    else:  # quando é em vetor
        x, sx, sx_tb, val_x, val_x_tb = (inputs_vector(bits, IO_type,
                                                       x_sequence_string,
                                                       sx_sequence_string,
                                                       valx_sequence_string, is_list))
        return (x, sx, sx_tb, val_x, val_x_tb)

from utils import *
from dict_utils import *
from txt_utils import *


def port_map_dict(neuron_dict: dict,
                  ID_camada: str,
                  lista_camada_IO: list,
                  IO_type: str = 'IN',
                  port_type: str = 'STD_LOGIC_VECTOR',
                  num_inputs: int = 1,
                  com_numero: bool = True,
                  port_map_layers_to_top: bool = False) -> str:      # True: 'x' se torna 'x1, x2, ...'):
    """Função para gerar o mapeamento PORT MAP de entradas ou saídas com base numa lista de dicionários. Também retorna uma lista com as IO (Inputs & Outputs). Esta função é apenas um 'quebra galho' da função Neuron_port_map_IO(). O formato de dicionário deve ser conforme abaixo:
        dict = {
                'IN': { # ENTRADAS
                    'STD_LOGIC': None,
                    'STD_LOGIC_VECTOR': None,
                    'SIGNED': ['bias'],
                    'STD_LOGIC_num_inputs': None,
                    'STD_LOGIC_VECTOR_num_inputs': None,
                    'SIGNED_num_inputs': ['x','w']
                },
                'OUT': { #SAÍDAS
                    'STD_LOGIC': None,
                    'STD_LOGIC_VECTOR': None,
                    'SIGNED': ['y'],
                    'STD_LOGIC_VECTOR_num_inputs': None,
                    'STD_LOGIC_num_inputs': None,
                    'SIGNED_num_inputs': None
                }
            }

    Args:
        neuron_dict (dict): dicionário

        ID_camada (str): exemplo: ID_camada = 'c1'

        lista_camada_IO (list): lista de IO que será acumulada
        para ser utilizada no 'entity' do gerador de camadas

        IO_type (str, optional): 'IN' ou 'OUT'. Defaults to 'IN'.

        port_type (str, optional): tipo de porta com base no exemplo de dicionário acima. Defaults to 'STD_LOGIC_VECTOR'.

        num_inputs (int, optional): número de entradas que se repetem caso 'com_número' == True

        com_numero (bool, optional):  True: 'x' se torna 'x1, x2, ...'

    Returns:
        txt_port_map(str): retorna um texto com mapeamento entre as entradas e saídas
        lista_camada_IO (list): retorna lista de sublistas das Inputs & Outputs. Sendo cada sublista 1 tipo de entrada ou saída.

    """
    # lista = []
    # lista_var = []
    txt_port_map = []

    # for i in range(0, len(neuron_dict_list)):

    #  ------------ Para IO compartilhadas ['shared_IO'] ------------
    # ['shared_IO']: portas que são compartilhadas entre os neurônios: x1,x2,...
    # port_map_list = neuron_dict['shared_IO'][IO_type][port_type]
    if port_map_layers_to_top:
        port_map_list = dict_list_exceptNone(
            dict_slice=neuron_dict['IO'][IO_type][port_type],
            return_value_or_key='key', is_list=True)
    else:
        port_map_list = dict_list_exceptNone(
            dict_slice=neuron_dict['shared_IO'][IO_type][port_type], return_value_or_key='key', is_list=True)

    # print("------------ Para IO compartilhadas ['shared_IO'] ------------")
    for i in range(0, len(port_map_list)):
        # if port_map_list[i] != None:

        if ' ' in port_map_list[i]:
            # separa em blocos de strings divididos pelo caractere (vírgula) especificada
            port_map_list[i] = port_map_list[i].split(' ')[0]
            # estamos retirando o desnecessário e pegando apenas o nome da entrada
        # print(
        #     f"port_map_dict() -> port_map_list[{i}] shared_IO['{port_type}']['{IO_type}']: {port_map_list[i]}")
    txt, port_map_l = input_sequences_number_choice(

        # sequence_id=neuron_dict['shared_IO'][IO_type][port_type],
        # port_map_list=neuron_dict['shared_IO'][IO_type][port_type],
        sequence_id=port_map_list,
        port_map_list=port_map_list,
        port_map_is_str=False,
        num_inputs=num_inputs,
        list_or_string='list',
        port_map=1,
        new_line=1,
        com_numero=com_numero  # True: 'x' se torna 'x1, x2, ...'
    )
    # txt = 'baaaa'
    # port_map_l = 'caaaa'

    txt_port_map.append(txt)
    # print(port_map_l)
    lista_camada_IO = lista_camada_IO + [port_map_l]
    # if (len(lista_camada_IO)> 2):
    #     print("erro é aqui 1")

    # print(lista_camada_IO)
    # lista_camada_IO.append(port_map_l)

    if (not port_map_layers_to_top):
        #  ------------ Para IO únicas ['unique_IO'] ------------
        # ['unique_IO']: portas que NÃO são compartilhadas entre os neurônios
        # gerando entradas únicas:
        lista = neuron_dict['unique_IO'][IO_type][port_type]
        # conseguindo lidar com lista mesmo quando é 'None'
        s = dict_list_exceptNone(dict_slice=lista)
        # unindo ID_camada com cada elemento da lista

        for i in range(0, len(s)):
            if ' ' in s[i]:
                # separa em blocos de strings divididos pelo caractere (vírgula) especificada
                s[i] = s[i].split(' ')[0]
                # estamos retirando o desnecessário e pegando apenas o nome da entrada

        lista_var = [ID_camada + item for item in s]
        s = [item for item in s]
        # for item in s:
        #     print(f"item: {item}")
        #     print(f"ID_camada:{ID_camada}")

        # print("------------ Para IO únicas ['unique_IO'] ------------")
        # print(f"s['{port_type}']['{IO_type}']: {s}")
        # print(f"lista['{port_type}']['{IO_type}']: {lista}")
        # print(f"lista_var['{port_type}']['{IO_type}']: {lista_var}")

        txt, port_map_l = input_sequences_number_choice(
            # sequence_id=lista,
            sequence_id=s,
            port_map_list=lista_var,
            port_map_is_str=False,
            num_inputs=num_inputs,
            list_or_string='list',
            port_map=1,
            new_line=1,
            com_numero=com_numero  # True: 'x' se torna 'x1, x2, ...'
        )

        # print(f"txt['{port_type}']['{IO_type}']: {txt}")
        # print(" ")
        # print(f"port_map_l['{port_type}']['{IO_type}']: {port_map_l}")

        lista_camada_IO = lista_camada_IO + [port_map_l]
        # print(lista_camada_IO)
        # lista_camada_IO.append(port_map_l)
        # if (lista_camada_IO != None): # remove duplicates
        #     lista_camada_IO = list(dict.fromkeys(lista_camada_IO))

        txt_port_map.append(txt)

    txt_port_map = '\n'.join(map(str, txt_port_map))
    txt_port_map = erase_empty_lines_2(txt_port_map)
    # print("///////////////////////////////////////////////////////////////////")

    return txt_port_map, lista_camada_IO

# https://www.youtube.com/watch?v=D-MFQopyXPc


def Neuron_port_map_IO(neuron_dict_list: list,
                       num_inputs: int,
                       i: int,
                       ID_camada: str,
                       port_map_layers_to_top: bool = False):
    """Função para gerar o texto de todas as ATRIBUIÇÕES das entradas e saídas de um componente. Ou seja, serve para ser utilizado quando instanciamos um componente. Será utilizada quando queremos dentro de uma camada, instanciar múltiplos neurônios.

    Exemplo:
      Neuron_port_map_ports(neuron_dict_list= neuron_dict_list,   # dicionário de entradas e saídas (exemplo abaixo em 'Args')
                            num_inputs = 3,         # 3 entradas no neurônio
                            ID_camada = 'c1_n1')    # identificador do neurônio e camada

      Output:
      # esta função só entrega  umas linhas que possuírem '-- OK'
      inst1: PORT MAP neuronio_vhd (
        a => a, -- OK
        b => b  -- OK
      )
      (faça o teste utilizando a função utilizando as entradas acima, e o 'neuron_dict_list' exemplificado abaixo)

    Args:
        neuron_dict_list (dict): lista com 1 dicionário com descrições dos elementos. Exemplo:
          {'IN': {'STD_LOGIC': ['clk', 'rst'],
            'STD_LOGIC_VECTOR': ['A', 'B'],
            'STD_LOGIC_num_inputs': ['C', 'D'],
            'STD_LOGIC_VECTOR_num_inputs': ['E', 'X'],
            'SIGNED': ['bias'],
            'SIGNED_num_inputs': ['x', 'w']},
          'OUT': {'STD_LOGIC': ['F', 'G'],
            'STD_LOGIC_VECTOR': ['G', 'H'],
            'STD_LOGIC_num_inputs': ['I', 'J'],
            'STD_LOGIC_VECTOR_num_inputs': ['K', 'L'],
            'SIGNED': ['y'],
            'SIGNED_num_inputs': ['M', 'N']}}

        num_inputs (int): número de entradas de um neurônio.
        ID_camada (str): string (texto) que identifica o número do neurônio na camada e o número da camada. Exemplo: ID_camada = 'c1_n1' --> 1º neurônio (n1) da 1ª camada (c1).

    Returns:
        Neuron_IN_port_map(str), Neuron_OUT_port_map(str), lista_camada_inputs(list), lista_camada_outputs(list): retorna 2 variáveis armazenando strings (texto) das entradas e saídas e 2 variáveis armazenando lista das entradas e saídas referentes à camada respectiva (ID_camada)
    """
    Neuron_IN_port_map = ''
    Neuron_OUT_port_map = ''
    # string para adicionar no inicio de cada elemento da lista
    ID_camada = f"{ID_camada}_n{i}_"
    lista_camada_inputs = []
    lista_camada_outputs = []

    # for i in range(0,len(neuron_dict_list)):
    # ========================= IN =================================

    # ['IN']['STD_LOGIC'] - OK
    Neuron_IN_port_map = "-- ['IN']['STD_LOGIC'] \n"

    Neuron_IN_port_map = Neuron_IN_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs,
        IO_type='IN',
        port_type='STD_LOGIC',
        num_inputs=1,
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )

    # Neuron_IN_port_map = Neuron_IN_port_map + input_sequences_number_choice(neuron_dict_list[i]['IN']['STD_LOGIC'], neuron_dict_list[i]['IN']['STD_LOGIC'], False, 1, 'list', 1, 1, False)

    # --------------------------------------------------
    # ['IN']['STD_LOGIC_VECTOR'] - OK
    Neuron_IN_port_map = Neuron_IN_port_map + \
        "-- ['IN']['STD_LOGIC_VECTOR'] \n"
    Neuron_IN_port_map = Neuron_IN_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs,
        IO_type='IN',
        port_type='STD_LOGIC_VECTOR',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['IN']['SIGNED'] - OK
    Neuron_IN_port_map = Neuron_IN_port_map + \
        "-- ['IN']['SIGNED'] \n"
    Neuron_IN_port_map = Neuron_IN_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs,
        IO_type='IN',
        port_type='SIGNED',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )

    # --------------------------------------------------

    # ['IN']['STD_LOGIC_num_inputs'] - OK
    Neuron_IN_port_map = Neuron_IN_port_map + \
        "-- ['IN']['STD_LOGIC_num_inputs'] \n"
    Neuron_IN_port_map = Neuron_IN_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs,
        IO_type='IN',
        port_type='STD_LOGIC_num_inputs',
        num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
        com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )

    # --------------------------------------------------

    # ['IN']['STD_LOGIC_VECTOR_num_inputs'] - OK
    Neuron_IN_port_map = Neuron_IN_port_map + \
        "-- ['IN']['STD_LOGIC_VECTOR_num_inputs'] \n"
    Neuron_IN_port_map = Neuron_IN_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs,
        IO_type='IN',
        port_type='STD_LOGIC_VECTOR_num_inputs',
        num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
        com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['IN']['SIGNED_num_inputs'] -
    Neuron_IN_port_map = Neuron_IN_port_map + \
        "-- ['IN']['SIGNED_num_inputs'] \n"
    Neuron_IN_port_map = Neuron_IN_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs,
        IO_type='IN',
        port_type='SIGNED_num_inputs',
        num_inputs=num_inputs,
        com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )

    # ========================== OUT =============================

    # ['OUT']['STD_LOGIC']
    Neuron_OUT_port_map = Neuron_OUT_port_map + "-- ['OUT']['STD_LOGIC'] \n"
    Neuron_OUT_port_map = Neuron_OUT_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs,
        IO_type='OUT',
        port_type='STD_LOGIC',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['OUT']['STD_LOGIC_VECTOR']
    Neuron_OUT_port_map = Neuron_OUT_port_map + \
        "-- ['OUT']['STD_LOGIC_VECTOR'] \n"
    Neuron_OUT_port_map = Neuron_OUT_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs,
        IO_type='OUT',
        port_type='STD_LOGIC_VECTOR',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['OUT']['SIGNED']
    Neuron_OUT_port_map = Neuron_OUT_port_map + "-- ['OUT']['SIGNED'] \n"
    Neuron_OUT_port_map = Neuron_OUT_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs,
        IO_type='OUT',
        port_type='SIGNED',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['OUT']['STD_LOGIC_num_inputs']
    Neuron_OUT_port_map = Neuron_OUT_port_map + \
        "-- ['OUT']['STD_LOGIC_num_inputs'] \n"
    Neuron_OUT_port_map = Neuron_OUT_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs,
        IO_type='OUT',
        port_type='STD_LOGIC_num_inputs',
        num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
        com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['OUT']['STD_LOGIC_VECTOR_num_inputs']
    Neuron_OUT_port_map = Neuron_OUT_port_map + \
        "-- ['OUT']['STD_LOGIC_VECTOR_num_inputs'] \n"
    Neuron_OUT_port_map = Neuron_OUT_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs,
        IO_type='OUT',
        port_type='STD_LOGIC_VECTOR_num_inputs',
        num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
        com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    # --------------------------------------------------

    # ['OUT']['SIGNED_num_inputs']
    Neuron_OUT_port_map = Neuron_OUT_port_map + \
        "-- ['OUT']['SIGNED_num_inputs'] \n"
    Neuron_OUT_port_map = Neuron_OUT_port_map + port_map_dict(
        neuron_dict_list=neuron_dict_list,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs,
        IO_type='OUT',
        port_type='SIGNED_num_inputs',
        num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
        com_numero=True,  # True: 'x' se torna 'x1, x2, ...',

    )
    # --------------------------------------------------

    return Neuron_IN_port_map, Neuron_OUT_port_map, lista_camada_inputs, lista_camada_outputs
# Neuron_IN_port_map, Neuron_OUT_port_map = Neuron_port_map_IO(neuron_dict_list= neuron_dict_list, i = 2, num_inputs = 3, ID_camada = 'c1')


def Neuron_port_map_IO_unique(neuron_dict: dict,
                              num_inputs: int,
                              i: int,
                              ID_camada: str,
                              port_map_layers_to_top: bool = False,
                              DEBUG: bool = False):
    """Função para gerar o texto de todas as ATRIBUIÇÕES das entradas e saídas de um componente. Ou seja, serve para ser utilizado quando instanciamos um componente. Será utilizada quando queremos dentro de uma camada, instanciar múltiplos neurônios.

    Exemplo:
      Neuron_port_map_ports(neuron_dict_list= neuron_dict_list,   # dicionário de entradas e saídas (exemplo abaixo em 'Args')
                            num_inputs = 3,         # 3 entradas no neurônio
                            ID_camada = 'c1_n1')    # identificador do neurônio e camada

      Output:
      # esta função só entrega  umas linhas que possuírem '-- OK'
      inst1: PORT MAP neuronio_vhd (
        a => a, -- OK
        b => b  -- OK
      )
      (faça o teste utilizando a função utilizando as entradas acima, e o 'neuron_dict_list' exemplificado abaixo)

    Args:
        neuron_dict_list (dict): lista com 1 dicionário com descrições dos elementos. Exemplo:
          {'IN': {'STD_LOGIC': ['clk', 'rst'],
            'STD_LOGIC_VECTOR': ['A', 'B'],
            'STD_LOGIC_num_inputs': ['C', 'D'],
            'STD_LOGIC_VECTOR_num_inputs': ['E', 'X'],
            'SIGNED': ['bias'],
            'SIGNED_num_inputs': ['x', 'w']},
          'OUT': {'STD_LOGIC': ['F', 'G'],
            'STD_LOGIC_VECTOR': ['G', 'H'],
            'STD_LOGIC_num_inputs': ['I', 'J'],
            'STD_LOGIC_VECTOR_num_inputs': ['K', 'L'],
            'SIGNED': ['y'],
            'SIGNED_num_inputs': ['M', 'N']}}

        num_inputs (int): número de entradas de um neurônio.
        ID_camada (str): string (texto) que identifica o número do neurônio na camada e o número da camada. Exemplo: ID_camada = 'c1_n1' --> 1º neurônio (n1) da 1ª camada (c1).

    Returns:
        Neuron_IN_port_map(str), Neuron_OUT_port_map(str), lista_camada_inputs(list), lista_camada_outputs(list): retorna 2 variáveis armazenando strings (texto) das entradas e saídas e 2 variáveis armazenando lista das entradas e saídas referentes à camada respectiva (ID_camada)
    """
    Neuron_IN_port_map = ''
    Neuron_OUT_port_map = ''
    # string para adicionar no inicio de cada elemento da lista
    ID_camada = f"{ID_camada}_n{i}_"
    # lista_camada_inputs = []
    # lista_camada_outputs = []

    lista_camada_inputs = [[]]*7
    lista_camada_outputs = [[]]*7
    x = ''

    # for i in range(0,len(neuron_dict_list)):
    # ========================= IN =================================
    # ['IN']['STD_LOGIC'] - OK
    # Neuron_IN_port_map = "-- ['IN']['STD_LOGIC'] \n"

    # lista_camada_IN_STD_LOGIC = []
    x, lista_camada_inputs[0] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs[0],
        IO_type='IN',
        port_type='STD_LOGIC',
        num_inputs=1,
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...',
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):
        Neuron_IN_port_map = "-- ['IN']['STD_LOGIC'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x

    # Neuron_IN_port_map = Neuron_IN_port_map + input_sequences_number_choice(neuron_dict[i]['IN']['STD_LOGIC'], neuron_dict[i]['IN']['STD_LOGIC'], False, 1, 'list', 1, 1, False)

    # --------------------------------------------------
    # ['IN']['STD_LOGIC_VECTOR'] - OK
    # lista_camada_IN_STD_LOGIC_VECTOR = []
    x, lista_camada_inputs[1] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs[1],
        IO_type='IN',
        port_type='STD_LOGIC_VECTOR',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):
        Neuron_IN_port_map = Neuron_IN_port_map + \
            "-- ['IN']['STD_LOGIC_VECTOR'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x
    # --------------------------------------------------

    # ['IN']['SIGNED'] - OK
    # lista_camada_IN_STD_LOGIC_VECTOR = []
    x, lista_camada_inputs[2] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs[2],
        IO_type='IN',
        port_type='SIGNED',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):
        Neuron_IN_port_map = Neuron_IN_port_map + \
            "-- ['IN']['SIGNED'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x

    # --------------------------------------------------
    try:
        # ['IN']['STD_LOGIC_num_inputs'] - OK
        x, lista_camada_inputs[3] = port_map_dict(
            neuron_dict=neuron_dict,
            ID_camada=ID_camada,
            lista_camada_IO=lista_camada_inputs[3],
            IO_type='IN',
            port_type='STD_LOGIC_num_inputs',
            num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
            com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
            port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
        )
    except:
        x = ''
    if (x != ''):
        Neuron_IN_port_map = Neuron_IN_port_map + \
            "-- ['IN']['STD_LOGIC_num_inputs'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x
    # --------------------------------------------------
    try:
        # ['IN']['STD_LOGIC_VECTOR_num_inputs'] - OK
        x, lista_camada_inputs[4] = port_map_dict(
            neuron_dict=neuron_dict,
            ID_camada=ID_camada,
            lista_camada_IO=lista_camada_inputs[4],
            IO_type='IN',
            port_type='STD_LOGIC_VECTOR_num_inputs',
            num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
            com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
            port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
        )
    except:
        x = ''
    if (x != ''):
        Neuron_IN_port_map = Neuron_IN_port_map + \
            "-- ['IN']['STD_LOGIC_VECTOR_num_inputs'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x
    # --------------------------------------------------
    try:
        # ['IN']['SIGNED_num_inputs'] -
        x, lista_camada_inputs[5] = port_map_dict(
            neuron_dict=neuron_dict,
            ID_camada=ID_camada,
            lista_camada_IO=lista_camada_inputs[5],
            IO_type='IN',
            port_type='SIGNED_num_inputs',
            num_inputs=num_inputs,
            com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
            port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
        )
    except:
        x = ''
    if (x != ''):
        Neuron_IN_port_map = Neuron_IN_port_map + \
            "-- ['IN']['SIGNED_num_inputs'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x

    # --------------------------------------------------

    # ['IN']['manual'] -
    x, lista_camada_inputs[6] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_inputs[6],
        IO_type='IN',
        port_type='manual',
        num_inputs=1,
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if DEBUG:
        print(f"PORT_MAP_utils :: Neuron_port_map_IO_unique -> x: {x}")
        print(
            f"PORT_MAP_utils :: Neuron_port_map_IO_unique -> lista_camada_inputs[6]: {lista_camada_inputs[6]}")
    if (x != ''):
        Neuron_IN_port_map = Neuron_IN_port_map + \
            "-- ['IN']['manual'] \n"
        Neuron_IN_port_map = Neuron_IN_port_map + x

    # ========================== OUT =============================

    # ['OUT']['STD_LOGIC']
    x, lista_camada_outputs[0] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs[0],
        IO_type='OUT',
        port_type='STD_LOGIC',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):  # só irá adicionar texto caso ele não seja nulo
        Neuron_OUT_port_map = Neuron_OUT_port_map + \
            "-- ['OUT']['STD_LOGIC'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------

    # ['OUT']['STD_LOGIC_VECTOR']
    x, lista_camada_outputs[1] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs[1],
        IO_type='OUT',
        port_type='STD_LOGIC_VECTOR',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):  # só irá adicionar texto caso ele não seja nulo
        Neuron_OUT_port_map = Neuron_OUT_port_map + \
            "-- ['OUT']['STD_LOGIC_VECTOR'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------

    # ['OUT']['SIGNED']
    x, lista_camada_outputs[2] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs[2],
        IO_type='OUT',
        port_type='SIGNED',
        num_inputs=1,  # colocar = 1 quando 'com_numero' = False
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):  # só irá adicionar texto caso ele não seja nulo
        Neuron_OUT_port_map = Neuron_OUT_port_map + "-- ['OUT']['SIGNED'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------
    try:
        # ['OUT']['STD_LOGIC_num_inputs']
        x, lista_camada_outputs[3] = port_map_dict(
            neuron_dict=neuron_dict,
            ID_camada=ID_camada,
            lista_camada_IO=lista_camada_outputs[3],
            IO_type='OUT',
            port_type='STD_LOGIC_num_inputs',
            num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
            com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
            port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
        )
    except:
        x = ''

    if (x != ''):  # só irá adicionar texto caso ele não seja nulo
        Neuron_OUT_port_map = Neuron_OUT_port_map + \
            "-- ['OUT']['STD_LOGIC_num_inputs'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------
    try:
        # ['OUT']['STD_LOGIC_VECTOR_num_inputs']
        x, lista_camada_outputs[4] = port_map_dict(
            neuron_dict=neuron_dict,
            ID_camada=ID_camada,
            lista_camada_IO=lista_camada_outputs[4],
            IO_type='OUT',
            port_type='STD_LOGIC_VECTOR_num_inputs',
            num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
            com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
            port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
        )
    except:
        x = ''
    if (x != ''):  # só irá adicionar texto caso ele não seja nulo
        Neuron_OUT_port_map = Neuron_OUT_port_map + \
            "-- ['OUT']['STD_LOGIC_VECTOR_num_inputs'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------
    try:
        # ['OUT']['SIGNED_num_inputs']
        x, lista_camada_outputs[5] = port_map_dict(
            neuron_dict=neuron_dict,
            ID_camada=ID_camada,
            lista_camada_IO=lista_camada_outputs[5],
            IO_type='OUT',
            port_type='SIGNED_num_inputs',
            num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
            com_numero=True,  # True: 'x' se torna 'x1, x2, ...'
            port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
        )
    except:
        x = ''
    if (x != ''):  # só irá adicionar texto caso ele não seja nulo
        Neuron_OUT_port_map = Neuron_OUT_port_map + \
            "-- ['OUT']['SIGNED_num_inputs'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------

    # ['OUT']['manual'] -
    x, lista_camada_outputs[6] = port_map_dict(
        neuron_dict=neuron_dict,
        ID_camada=ID_camada,
        lista_camada_IO=lista_camada_outputs[6],
        IO_type='OUT',
        port_type='manual',
        num_inputs=1,
        com_numero=False,  # True: 'x' se torna 'x1, x2, ...'
        port_map_layers_to_top=port_map_layers_to_top  # se está mapeando o top ou não
    )
    if (x != ''):
        Neuron_OUT_port_map = Neuron_OUT_port_map + \
            "-- ['OUT']['manual'] \n"
        Neuron_OUT_port_map = Neuron_OUT_port_map + x
    # --------------------------------------------------
    # Neuron_OUT_port_map = Neuron_OUT_port_map[:-1] #tirando ultima virgula
    Neuron_OUT_port_map = erase_empty_lines(Neuron_OUT_port_map)[:-1]
    Neuron_OUT_port_map = Neuron_OUT_port_map[:-1]  # retirando última vírgula

    return Neuron_IN_port_map, Neuron_OUT_port_map, lista_camada_inputs, lista_camada_outputs
# Neuron_IN_port_map, Neuron_OUT_port_map = Neuron_port_map_IO(neuron_dict_list= neuron_dict_list, i = 2, num_inputs = 3, ID_camada = 'c1')


def entity_port_map(vhd_name: str,
                    i: int,
                    neuron_dict: dict,
                    num_inputs: int,
                    ID_camada: str,
                    vhd_name_final_str: str = '',
                    port_map_layers_to_top: bool = False
                    ):
    """Função para gerar o instanciamento de 1 componente.
    Exemplo:
    entity_port_map(vhd_name = 'test', i = 1,
          Neuron_IN_port_map = Neuron_IN_port_map,
          Neuron_OUT_port_map = '')
    Output:
      test1: ENTITY work.test
        PORT MAP (
                  ---------- Entradas ----------
                  -- ['IN']['STD_LOGIC']
                  clk=> clk,
                  rst=> rst,
                  -- ['IN']['STD_LOGIC_VECTOR']
                  A=>  c1_n1_A,
                  B=>  c1_n1_B,
                  -- ['IN']['STD_LOGIC_num_inputs']
                  C1=>  c1_n1_C1,
                  C2=>  c1_n1_C2,
                  C3=>  c1_n1_C3,
                  -- ['IN']['SIGNED_num_inputs']
                  x1=> x1,
                  x2=> x2,
                  x3=> x3,
                  -- ['IN']['SIGNED']
                  bias=>  c1_n1_bias,
                  ---------- Saidas ----------

        );

    ------------------------------------------------------------
    Args:
        vhd_name (str): nome arquivo '.vhd' do componente

        vhd_name_final_str: str,

        i (int): número do componente. Exemplo: neurônio_1, neurônio_2, ...

        neuron_dict (dict): Dicionário do neurônio.

        num_inputs (int): Número de entradas do neurônio (para gerar entradas que se repetem mudando apenas o índice: x1, x2, x3, ... até n<num_inputs>).

        ID_camada (str): identificador da camada usado na geração das IO que são únicas. Assim podemos diferenciar entre o peso w3 da camada 0 e da camada 1 por exemplo. Um exemplo para ID_camada = 5 -> Peso número 3 será: c<ID_camada>_n<i>_w3 = c5_n<i>_w3. Sendo 'i' o parâmetro acima explicado.
    """
    # Neuron_IN_port_map, Neuron_OUT_port_map, lista_camada_inputs, lista_camada_outputs = Neuron_port_map_IO(
    #     neuron_dict=neuron_dict,
    #     num_inputs=num_inputs,
    #     i=i,
    #     ID_camada=ID_camada)

    Neuron_IN_port_map, Neuron_OUT_port_map, lista_camada_inputs, lista_camada_outputs = Neuron_port_map_IO_unique(
        neuron_dict=neuron_dict,
        i=i,
        num_inputs=num_inputs,
        ID_camada=ID_camada,
        port_map_layers_to_top=port_map_layers_to_top)
    # adicionando espaço no início de cada linha (formatação de código)
    inputs_txt = txt_add_space_begin(txt=Neuron_IN_port_map, space=6)
    outputs_txt = txt_add_space_begin(txt=Neuron_OUT_port_map, space=6)

    # criando texto
    txt = (f"""
{vhd_name.split('_')[0]}_inst_{i}{vhd_name_final_str}: ENTITY work.{vhd_name}
   PORT MAP (
            ---------- Entradas ----------
{inputs_txt}
            ---------- Saidas ----------
{outputs_txt}
   );
            """)

    return txt, lista_camada_inputs, lista_camada_outputs

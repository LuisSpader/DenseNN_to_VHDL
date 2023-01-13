from standard_dicts import layer_dict_hidden
from txt_utils import erase_empty_lines, txt_add_space_begin
from utils import IO_manager, IO_manager_layer
from dict_utils import dict_list_exceptNone, dict_list_exceptNone_Callable
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
import numpy as np


def entity(name: str,
           bits: int,
           num_inputs: int,
           IO_dict_list: list,
           remove_dict_items=[],
           generic: bool = False,
           tab_space: int = 1) -> str:
    """Função para gerar a escrita de toda a 'entity' do módulo.vhd com base em um dicionário em formato padrão pré-estabelecido. Retorna um texto disso tudo.
    -----------------------------------------------------
    Exemplo de dicionário:
      layer_dict = {
        ... etc
        # --------- Configurações da arquitetura do neurônio ---------
        'Neuron_arch': {
        # -------------------------
          'shared_IO':{ # Entradas & saídas compartilhadas
            'IO':{ # INPUT & OUTPUT
              'IN': { # ENTRADAS
                'STD_LOGIC': ['clk', 'rst'],
                'STD_LOGIC_VECTOR': None,
                'SIGNED': None,
                'STD_LOGIC_num_inputs': None,
                'STD_LOGIC_VECTOR_num_inputs': None,
                'SIGNED_num_inputs': ['x']
                },
              'OUT': { #SAÍDAS
                'STD_LOGIC': None,
                'STD_LOGIC_VECTOR': None,
                'SIGNED': None,
                'STD_LOGIC_VECTOR_num_inputs': None,
                'STD_LOGIC_num_inputs': None,
                'SIGNED_num_inputs': None
              }
              }
            },
          'unique_IO':{ # Entradas únicas ao neurônio
            'IO':{ # INPUT & OUTPUT
              'IN': { # ENTRADAS
                'STD_LOGIC': None,
                'STD_LOGIC_VECTOR': None,
                'SIGNED': ['bias'],
                'STD_LOGIC_num_inputs': None,
                'STD_LOGIC_VECTOR_num_inputs': None,
                'SIGNED_num_inputs': ['w']
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
              }
          ... etc
        }
    -----------------------------------------------------
    Exemplo utilizando a função:
    dict_list_IO = [layer_dict['Neuron_arch']['shared_IO']['IO'], layer_dict['Neuron_arch']
        ['unique_IO']['IO']] # estamos usando as IO 'shared_IO' e 'unique_IO'

    layer_dict['Neuron_arch']['Neuron_name'] = neuron_comb_ReLU_3n_8bit_unsigned_mul1a_v0_add0_v0

      entity(name = layer_dict['Neuron_arch']['Neuron_name'],
               bits = 8,
               num_inputs = 3,
               IO_dict_list = dict_list_IO)

      Output:
        ENTITY  neuron_comb_ReLU_3n_8bit_unsigned_mul1a_v0_add0_v0 IS
          PORT (
            clk, rst: IN STD_LOGIC;
            bias: IN signed(7 DOWNTO 0);
            x1, x2, x3: IN signed(7 DOWNTO 0);
            w1, w2, w3: IN signed(7 DOWNTO 0);
            ----------------------------------------------
            y: OUT signed(7 DOWNTO 0)
            );
        end ENTITY;

    -----------------------------------------------------
    Args:
        name (str): string com nome do módulo '.vhd'. Exemplo: name = 'adder'

        bits (int): define o número de bits para as entradas e pesos

        num_inputs (int): número de entradas e pesos do perceptron

        IO_dict_list (list):  lista de dicionários de INPUTS & OUTPUTS.
          Exemplo:  IO_dict_list = [layer_dict['Neuron_arch']['shared_IO']['IO'], layer_dict['Neuron_arch']['unique_IO']['IO']].
        tab_space (int): Indexação do texto. É o número de 'tabs' de deslocamento à direita

    Returns:
        str: string com toda a escrita da 'entity', conforme 'Output' do exemplo acima.
    """
    if not isinstance(bits, int):
        try:
            bits = bits()
        except:
            print("Error entity(): Formato de dicionário inválido para bit_WIDTH")

    if not isinstance(num_inputs, (int, np.integer)):

        try:
            num_inputs = num_inputs()
        except:
            print("Error entity(): Formato de dicionário inválido para num_inputs.")

    # quando temos 6 tipos de IO, pode ser qualquer '.vhd', logo usamos 'IO_manager'
    # try:
    try:
        # print("tentativa dic 1")
        if (4 != len(IO_dict_list[0]['IN'].keys())):
            IO, traço = IO_manager(
                IO_dict_list, bits, num_inputs, onerow=1, tab_space=2, remove_dict_items=remove_dict_items)

        else:  # quando temos 3 IO é dicionário no formato de uma camada, aí usamos 'IO_manager_layer'
            # print(
            #     f"é layer --> len(IO_dict_list[0]['IN'].keys()):{len(IO_dict_list[0]['IN'].keys())}")
            # print(
            #     f"é layer --> IO_dict_list[0]['IN'].keys():{IO_dict_list[0]['IN'].keys()})")

            IO, traço = IO_manager_layer(
                IO_dict_list, bits, onerow=1, tab_space=2)
    except:
        # print("tentativa dic 2 exceção")
        if (4 != len(IO_dict_list[0]['shared_IO']['IN'].keys())):
            IO, traço = IO_manager(
                IO_dict_list, bits, num_inputs, onerow=1, tab_space=2, remove_dict_items=remove_dict_items)

        else:  # quando temos 3 IO é dicionário no formato de uma camada, aí usamos 'IO_manager_layer'
            IO, traço = IO_manager_layer(
                IO_dict_list, bits, onerow=1, tab_space=2)
    # except:
    #     print("Error entity(): Formato de dicionário inválido")
    #     return
    if generic:
        generic_txt = (f'''
  GENERIC (
      BITS : NATURAL := BITS;
      NUM_INPUTS : NATURAL := {num_inputs};
      TOTAL_BITS : NATURAL := {num_inputs*bits}
  );
    ''')
    else:
        generic_txt = ''

    txt = (f'''

ENTITY  {name} IS
{generic_txt}
  PORT (
{IO}
  );
end ENTITY;
''')
    txt = erase_empty_lines(txt)
    txt = txt_add_space_begin(txt, space=tab_space)
    return txt


def entity2_layer_dict(
        layer_dict: dict = {},
        remove_dict_items=[],
        generic: bool = False,
        tab_space: int = 1) -> str:

    name = layer_dict['Layer_name']
    bits = layer_dict['bits']
    num_inputs = layer_dict['Inputs_number']
    IO_dict_list = [layer_dict['IO']]

    if not isinstance(bits, int):
        try:
            bits = bits()
        except:
            print("Error entity(): Formato de dicionário inválido para bit_WIDTH")

    if not isinstance(num_inputs, (int, np.integer)):

        try:
            num_inputs = num_inputs()
        except:
            print("Error entity(): Formato de dicionário inválido para num_inputs.")

    # quando temos 6 tipos de IO, pode ser qualquer '.vhd', logo usamos 'IO_manager'
    # try:
    try:
        # print("tentativa dic 1")
        if (4 != len(IO_dict_list[0]['IN'].keys())):
            IO, traço = IO_manager(
                IO_dict_list, bits, num_inputs, onerow=1, tab_space=2, remove_dict_items=remove_dict_items)

        else:  # quando temos 3 IO é dicionário no formato de uma camada, aí usamos 'IO_manager_layer'
            # print(
            #     f"é layer --> len(IO_dict_list[0]['IN'].keys()):{len(IO_dict_list[0]['IN'].keys())}")
            # print(
            #     f"é layer --> IO_dict_list[0]['IN'].keys():{IO_dict_list[0]['IN'].keys()})")

            IO, traço = IO_manager_layer(
                layer_dict, bits, onerow=1, tab_space=2)
    except:
        # print("tentativa dic 2 exceção")
        if (4 != len(IO_dict_list[0]['shared_IO']['IN'].keys())):
            IO, traço = IO_manager(
                IO_dict_list, bits, num_inputs, onerow=1, tab_space=2, remove_dict_items=remove_dict_items)

        else:  # quando temos 3 IO é dicionário no formato de uma camada, aí usamos 'IO_manager_layer'
            IO, traço = IO_manager_layer(
                IO_dict_list, bits, onerow=1, tab_space=2)
    # except:
    #     print("Error entity(): Formato de dicionário inválido")
    #     return

    # PEGANDO GENERIC DO DICIONÁRIO DA CAMADA
    # pegando nome das variáveis
    generic_names = dict_list_exceptNone(
        dict_slice=layer_dict['IO']['GENERIC'], return_value_or_key='key', is_list=False)
    print(
        f"vhd_txt_utils.py :: entity2_layer_dict -> generic_names: {generic_names}")

    # pegando o valor das variáveis
    generic_values = dict_list_exceptNone_Callable(
        dict_slice=layer_dict['IO']['GENERIC'], return_value_or_key='value', is_list=False)
    print(
        f"vhd_txt_utils.py :: entity2_layer_dict -> generic_values: {generic_values}")
    for i in generic_values:
        print(f"generic_values():{generic_values}")
    # gerando texto de atribuições
    generic_definiton = ''
    # for i in range(0, len(generic_names)):
    #     generic_definiton += f"{('  '*tab_space)}{generic_names[i]} : NATURAL := {generic_values[i]};\n"

    if generic:
        #         generic_txt = (f'''
        # GENERIC (
        #     BITS : NATURAL := {bits};
        #     NUM_INPUTS : NATURAL := {num_inputs}
        # );
        #   ''')
        # {generic_definiton[:-1]}
        generic_txt = (f'''
GENERIC (
{('  '*tab_space)}BITS : NATURAL := BITS;
{('  '*tab_space)}NUM_INPUTS : NATURAL := {num_inputs};
{('  '*tab_space)}TOTAL_BITS : NATURAL := {num_inputs*bits}
);
  ''')
    else:
        generic_txt = ''

    txt = (f'''

ENTITY  {name} IS
{generic_txt}
PORT (
{IO}
);
end ENTITY;
''')
    txt = erase_empty_lines(txt)
    txt = txt_add_space_begin(txt, space=tab_space)
    return txt

# print(entity(sum_name, bits, num_inputs, [MAC_IO_dict]))
# print(entity(name=layer_dict_hidden['Neuron_arch']['Neuron_name'],
#              bits=8,
#              num_inputs=3,
#              IO_dict_list=[layer_dict_hidden['Neuron_arch']['IO']['shared_IO'],
#                            layer_dict_hidden['Neuron_arch']['IO']['unique_IO']]
#              ))
# print("--------------------")
# print(layer_dict_hidden['Neuron_arch']['IO']['unique_IO'])


def PROCCESS_IF_ELSE(rst_event: bool,
                     clk_event: bool,
                     IF: str,
                     ELSE: str) -> str:
    variables = []
    if (rst_event == 1):
        variables.append('rst')

    if (clk_event == 1):
        variables.append('clk')

    text = (f'''
PROCCESS({','.join(variables)})
BEGIN
END PROCCESS;''')

    #  RESET ------------------
    if (rst_event == 1):
        text = text[:-13] + (f'''
  IF (rst = '1') THEN
{rst_receive_string_MAC}

  ELSE
  END IF;
  ''') + text[-13:]

    # CLK --------------------
    if (clk_event == 1):
        text = text[:-25] + (f'''
  IF (clk'event AND clk = '1') THEN
{clk_receive_string_MAC}
  END IF;
''') + text[-25:]
    # ---------------------------------
    return text


def rom_component(ROM_name: str,
                  input_mem_bits: int,
                  output_mem_bits: int):
    """Função para gerar o texto do COMPONENTE ROM. Exemplo:

    rom_component(ROM_name = 'ROM_fx_8bitaddr_8width',
                  input_mem_bits = 8,
                  output_mem_bits = 8)

    --------------------------------------
    Args:
        ROM_name (str): nome do componente
        input_mem_bits (int): número de bits de entrada da ROM (bits para endereçamento na ROM)
        output_mem_bits (int): número de bits da saída da ROM (bits de dados que a ROM entrega)
    """

    ROM_component = (f'''
  -- ROM
  COMPONENT {ROM_name} IS
    PORT (
      address : IN STD_LOGIC_VECTOR ({str(input_mem_bits - 1)} DOWNTO 0);
      ------------------------------------------
      data_out : OUT STD_LOGIC_VECTOR ({str(output_mem_bits - 1)}  DOWNTO 0)
    );
  -- input: address ({str(input_mem_bits)} bits)
  -- output: data_out ({str(output_mem_bits)} bits)
  END COMPONENT;
  ''')

    # print(ROM_component)
    return (ROM_component)


def PROCCESS_IF_ELSE(rst_event, clk_event, IF, ELSE):
    variables = []
    if (rst_event == 1):
        variables.append('rst')

    if (clk_event == 1):
        variables.append('clk')

    text = (f'''
PROCCESS({','.join(variables)})
BEGIN
END PROCCESS;''')

    #  RESET ------------------
    if (rst_event == 1):
        text = text[:-13] + (f'''
  IF (rst = '1') THEN
{rst_receive_string_MAC}

  ELSE
  END IF;
  ''') + text[-13:]

    # CLK --------------------
    if (clk_event == 1):
        text = text[:-25] + (f'''
  IF (clk'event AND clk = '1') THEN
{clk_receive_string_MAC}
  END IF;
''') + text[-25:]
    # ---------------------------------
    return text


def port_map_ROM(ROM_name: str,
                 input_mem_bits: int,
                 output_mem_bits: int):
    """Função para gerar o texto do PORT MAP da ROM (esta versão está meio 'hard coded' ainda, pois o nome dos sinais para mapeamento ainda estão fixos: out_reg_MAC e out_ROM_act). Exemplo de uso da função:

    port_map_ROM(	ROM_name = 'ROM_fx_8bitaddr_8width',
                                                    input_mem_bits= 8,
                                    output_mem_bits = 8)
     Output:
            U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
                    STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
                    );
            -- input: address (8)
            -- output: data_out (8)

---------------------------------------------
    Args:
                    ROM_name (str): _description_
                    input_mem_bits (int): _description_
                    output_mem_bits (int): _description_
    """

    PORT_MAP_ROM = (f'''
	U_ROM : {ROM_name} PORT MAP(
		STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
		);
	-- input: address ({str(input_mem_bits)})
	-- output: data_out ({str(output_mem_bits)})
	''')
    # print(PORT_MAP_ROM)
    return (PORT_MAP_ROM)

# # # from standard_dicts import layer_dict_hidden
# # from list_utils import remove_all_lista_ocurrences
# # from utils import IO_STDL
# # layer_dict_hidden = {
# #     # ========================== Parâmetros da camada ===========================
# #     'Inputs_number': 3,  # número de entradas da camada
# #     'BIT_WIDTH': 8,
# #     'IO_type': True,     # 1= signed || 0= unsigned
# #     'Neurons_number': 4,  # número de neurônios da camada
# #     'Layer_name': '',  # nome do '.vhd' da camada
# #     'Layer_number': '',  # número da camada
# #     # --------------------------
# #     # DEVE SE ALTERAR AUTOMATICAMENTE COM BASE NA CONFIG DO NEURÔNIO
# #     'IO': {  # INPUT & OUTPUT
# #         'IN': {  # ENTRADAS
# #             'STD_LOGIC': None,
# #             'STD_LOGIC_VECTOR': None,
# #             'SIGNED': None
# #         },
# #         'OUT': {  # SAÍDAS
# #             'STD_LOGIC': None,
# #             'STD_LOGIC_VECTOR': None,
# #             'SIGNED': None
# #         }
# #     },

# #     # ======================= Parâmetros do neurônio ============================

# #     # --------- Configurações da arquitetura do neurônio ---------
# #     'Neuron_arch': {
# #         # número de entradas e pesos do perceptron
# #         'Inputs_number': lambda: layer_dict_hidden['Inputs_number'],
# #         # define o número de bits para as entradas e pesos
# #         'Bit_WIDTH': lambda: layer_dict_hidden['BIT_WIDTH'],
# #         # True= signed || 0= unsigned
# #         'IO_type': lambda: layer_dict_hidden['IO_type'],

# #         # -------------------------
# #         # O dicionário de entradas e saídas deverá ser gerado automaticamente, com base nos parâmetros:
# #         #  - IO_type
# #         #  - por enquanto creio que é só """
# #         # -------------------------

# #         # --------- Geração do nome do neurônio ---------
# #         'neuron_name': '',
# #         # 0 = don't include | 1 = include 'seq' or 'comb' on vhd_names
# #         'Include_MAC_type': True,

# #         # -------------------------
# #         'IO': {  # INPUT & OUTPUT
# #             'shared_IO': {  # Entradas & saídas compartilhadas
# #                 'IN': {  # ENTRADAS
# #                     'STD_LOGIC': ['clk', 'rst'],
# #                     'STD_LOGIC_VECTOR': None,
# #                     'SIGNED': None,
# #                     'STD_LOGIC_num_inputs': None,
# #                     'STD_LOGIC_VECTOR_num_inputs': None,
# #                     'SIGNED_num_inputs': ['x']
# #                 },
# #                 'OUT': {  # SAÍDAS
# #                     'STD_LOGIC': None,
# #                     'STD_LOGIC_VECTOR': None,
# #                     'SIGNED': None,
# #                     'STD_LOGIC_VECTOR_num_inputs': None,
# #                     'STD_LOGIC_num_inputs': None,
# #                     'SIGNED_num_inputs': None
# #                 }
# #             },
# #             'unique_IO': {  # Entradas únicas ao neurônio
# #                 # 'IO':{ # INPUT & OUTPUT
# #                 'IN': {  # ENTRADAS
# #                     'STD_LOGIC': None,
# #                     'STD_LOGIC_VECTOR': None,
# #                     'SIGNED': ['bias'],
# #                     'STD_LOGIC_num_inputs': None,
# #                     'STD_LOGIC_VECTOR_num_inputs': None,
# #                     'SIGNED_num_inputs': ['w']
# #                 },
# #                 'OUT': {  # SAÍDAS
# #                     'STD_LOGIC': None,
# #                     'STD_LOGIC_VECTOR': None,
# #                     'SIGNED': ['y'],
# #                     'STD_LOGIC_VECTOR_num_inputs': None,
# #                     'STD_LOGIC_num_inputs': None,
# #                     'SIGNED_num_inputs': None
# #                 }
# #                 # }
# #             }
# #         },

# #         # -------------
# #         'MAC_type': False,  # False = combinational(árvore) | True = Sequential

# #         # -------------
# #         'Barriers': False,  # True = com barreiras de registradores

# #         # ------------- Versões de multiplicador
# #         'Multiplier': {
# #             '0-Operator': True,  # *
# #             '1-Baugh_Wooley': {
# #                 '1a-Alexandre': False,
# #                 '1b-Luis': False
# #             },
# #             '2-Booth': False,
# #             '3-Shift': False,
# #             '4-Quantized_shift': False
# #         },

# #         # -------------
# #         'Adder': {
# #             '0-Operator': True  # +
# #         },

# #         # -------------
# #         'Activation_function': {
# #             'ReLU': True,
# #             'Leaky_ReLU': {
# #                 'Using': False,        # True = usar versão Leaky_ReLU
# #                 # número de vezes que divide por 2 a ReLU (shift right)
# #                 'Leaky_attenuation': 2
# #             },
# #             'Sigmoid': {
# #                 # True = usar versão Sigmoid (Look Up Table)
# #                 'Using': False,
# #                 'Memory': {
# #                     'bits_mem': 8,
# #                     # 'n' binary digits are the fractional part of `x`; = MANTISSA
# #                     'input_mem_bits': lambda: layer_dict_hidden['Neuron_arch']['Activation_function']['Sigmoid']['Memory']['bits_mem'],
# #                 }
# #             }
# #         }
# #     }


# # }


# # remove = ['clk', 'rst']
# # print(IO_STDL(layer_dict_hidden['Neuron_arch']
# #       ['IO']['shared_IO'], 1, 'IN', remove_dict_items=['clk', 'rst']))

# # IO_dict = layer_dict_hidden['Neuron_arch']['IO']['shared_IO']
# # IO = 'IN'

# # text = []
# # for i in IO_dict[IO]['STD_LOGIC']:
# #     text.append(f"{i}")


# # remove = ['clk', 'rst']
# # text = remove_all_lista_ocurrences(lista=text, occurences_list=remove)
# # if text:
# #     text = ', '.join(map(str, (text)))
# #     text = f"{text}: {IO} STD_LOGIC;"
# #     print(text)
# # else:
# #     pass


# neuron_type = 'relu'        # 'leaky' 'softmax'

# DEBUG = 0

# bits = 8  # define o número de bits para as entradas e pesos
# num_inputs = 4  # número de entradas e pesos do perceptron
# IO_type = 1  # 1= signed || 0= unsigned

# MAC_type = 0  # 0 = combinational(tree:árvore) | 1 = Sequential
# Barriers = 1  # 0 = no Barriers | 1 = with register Barriers (pipeline)
# Include_MAC_type = 1  # 0 = don't include | 1 = include 'seq' or 'tree' on vhd_names
# leaky_attenuation = 2  # número de vezes que divide por 2 a ReLU (shift right)

# bits_mem = 8
# input_mem_bits = bits_mem
# output_mem_bits = bits_mem
# n_bin = bits  # 'n' binary digits are the fractional part of `x`; = MANTISSA

# download_vhd = 1  # 1= para baixar || 0= não baixar

# download_files = download_vhd  # 1= para baixar || 0= não baixar

# bits = 8, num_inputs = 3, IO_type = 1, Barriers = 1, Include_MAC_type = 1, leaky_attenuation = 2, bits_mem = 8, n_bin = bits, download_vhd = 1

camada_inputs = [
    [
        [['clk', 'rst', 'update_weights'], ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['',
         ['c0_n0_Wout1',
          'c0_n0_Wout2', 'c0_n0_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);3', 'c0_n0_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);4', 'c0_n0_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);5']]],
    [
        [
            ['clk', 'rst', 'update_weights'], ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['',
         ['c0_n1_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);1',
          'c0_n1_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);2', 'c0_n1_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);3', 'c0_n1_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);4', 'c0_n1_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);5']]],
    [
        [['clk', 'rst', 'update_weights'], ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['', ''],
        ['',
         ['c0_n2_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);1', 'c0_n2_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);2', 'c0_n2_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);3', 'c0_n2_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);4', 'c0_n2_Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);5']]]]


camada_outputs = [[['', ''], ['', ''], ['', ['c0_n0_y']], ['', ''], ['', ''], ['', ''], []], [['', ''], ['', ''], ['', [
    'c0_n1_y']], ['', ''], ['', ''], ['', ''], []], [['', ''], ['', ''], ['', ['c0_n2_y']], ['', ''], ['', ''], ['', ''], []]]

dict_top = {'Inputs_number': 3,
            'BIT_WIDTH': 8,
            'IO_type': 'signed',
            'Neurons_number': 4,
            'Top_name': 'top',
            'IO': {
                'GENERIC': {
                    'BITS': < function
                    < lambda > at 0x00000285E8022160 > ,
                    'NUM_INPUTS': < function < lambda > at 0x00000285E80221F0 > ,
                    'TOTAL_BITS': None},
                'IN': {
                    'STD_LOGIC': ['clk', 'rst', 'update_weights'],
                    'STD_LOGIC_VECTOR': None,
                    'SIGNED': None,
                    'manual': ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']},
                'OUT': {
                    'STD_LOGIC': None,
                    'STD_LOGIC_VECTOR': None,
                    'SIGNED': ['c1_n0_y', 'c1_n1_y'],
                    'manual': ['c1_n0_Wout', 'c1_n1_Wout']
                }
            }
            }

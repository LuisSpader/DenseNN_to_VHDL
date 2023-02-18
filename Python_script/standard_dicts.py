from dict_utils import find_True_dict_Output_print, find_True_dict_Output_print_above_level
from dict_utils import dict_to_list, find_True_dict_split
from name import vhd_name

prefix_neuron = 'neuron_'
fx_activation_dict = {
    'ReLU': f'{prefix_neuron}ReLU',
    'Leaky ReLU': f'{prefix_neuron}LeakyReLU',
    'Sigmoid': f'{prefix_neuron}Sigmoid'
}

# =============== HIDDEN LAYER =====================
# fazendo uma lista do dicionário
dict_list = dict_to_list(target_dict=fx_activation_dict, key_or_value=True)
# ['ReLU', 'Leaky ReLU', 'Sigmoid']

top_dict = {
    # ========================== Parâmetros da camada ===========================
    'Inputs_number': 3,  # número de entradas da camada
    'bits': 8,
    'Top_name': 'top',  # nome do '.vhd' da camada
    # --------------------------
    # DEVE SE ALTERAR AUTOMATICAMENTE COM BASE NA CONFIG DO NEURÔNIO
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
}

layer_dict_hidden = {
    # ========================== Parâmetros da camada ===========================
    'Inputs_number': 3,  # número de entradas da camada
    'bits': 8,
    'IO_type': 'signed',     # 'signed' | 'unsigned' | 'std_logic_vector'
    'Neurons_number': 4,  # número de neurônios da camada
    'Layer_name': '',  # nome do '.vhd' da camada
    'Layer_num': '',  # número da camada
    # --------------------------
    # DEVE SE ALTERAR AUTOMATICAMENTE COM BASE NA CONFIG DO NEURÔNIO
    'IO': {  # INPUT & OUTPUT
        'GENERIC': {
            'BITS': lambda: layer_dict_hidden['bits'],
            'NUM_INPUTS': lambda: layer_dict_hidden['Inputs_number'],
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
    },

    # ======================= Parâmetros do neurônio ============================

    # --------- Configurações da arquitetura do neurônio ---------
    'Neuron_arch': {
        # número de entradas e pesos do perceptron
        'Inputs_number': lambda: layer_dict_hidden['Inputs_number'],
        # define o número de bits para as entradas e pesos
        'Bit_WIDTH': lambda: layer_dict_hidden['bits'],
        # True= signed || 0= unsigned
        'IO_type': lambda: layer_dict_hidden['IO_type'],

        # -------------------------
        # O dicionário de entradas e saídas deverá ser gerado automaticamente, com base nos parâmetros:
        #  - IO_type
        #  - por enquanto creio que é só """
        # -------------------------

        # --------- Geração do nome do neurônio ---------
        'Neuron_name': '',
        # 0 = don't include | 1 = include 'seq' or 'comb' on vhd_names
        'Include_MAC_type': False,

        # -------------------------
        'IO': {  # INPUT & OUTPUT
            'GENERIC': {
                'BITS': lambda: layer_dict_hidden['bits'],
                'NUM_INPUTS': lambda: layer_dict_hidden['Inputs_number'],
                'TOTAL_BITS': None
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
            },
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
                }
                # }
            }
        },

        # -------------
        'MAC_type': False,  # False = combinational(árvore) | True = Sequential

        # -------------
        'Barriers': False,  # True = com barreiras de registradores

        # ------------- Versões de multiplicador
        'Multiplier': {
            '0-Operator': True,  # *
            '1-Baugh_Wooley': {
                '1a-Alexandre': False,
                '1b-Luis': False
            },
            '2-Booth': False,
            '3-Shift': False,
            '4-Quantized_shift': False
        },

        # -------------
        'Adder': {
            '0-Operator': True  # +
        },

        # -------------
        'Activation_fx': {
            'ReLU': True,
            'Leaky_ReLU': {
                'Using': False,        # True = usar versão Leaky_ReLU
                # número de vezes que divide por 2 a ReLU (shift right)
                'Leaky_attenuation': 2
            },
            'Sigmoid': {
                # True = usar versão Sigmoid (Look Up Table)
                'Using': False,
                'Memory': {
                    'bits_mem': 8,  # por enquanto input_bits = output_bits
                    # 'n' binary digits are the fractional part of `x`; = MANTISSA
                    # deste modo não temos parte 'inteiro', apenas mantissa
                    'mantissa': lambda: layer_dict_hidden['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['bits_mem']
                }
            }
        }
    }

}
# layer_dict_hidden['Neuron_arch']['IO']['GENERIC']['TOTAL_BITS'] = layer_dict_hidden['Neuron_arch']['IO']['GENERIC']['BITS'](
# )*layer_dict_hidden['Neuron_arch']['IO']['GENERIC']['NUM_INPUTS']()


def update_neuron_name_from_LayerDict(layer_dict):
    # ['ReLU', 'Leaky ReLU', 'Sigmoid']
    fx_activation = get_dict_fx_activation(layer_dict=layer_dict)
    # Definindo nome do neurônio
    layer_dict['Neuron_arch']['Neuron_name'] = vhd_name(
        # modelo de função de ativação
        vhd_name=f"neuron_{fx_activation}",
        # Obs: dict_list 0: ReLU, 1: Leaky ReLU, 2: Sigmoid
        # Quantidade de bits para representação
        bits=layer_dict['bits'],
        # 1= signed || 0= unsigned
        IO_type=layer_dict['IO_type'],
        # Quantidade de entradas
        num_inputs=layer_dict['Inputs_number'],
        # 0 = no Barriers | 1 = with register Barriers
        Barriers=layer_dict['Neuron_arch']['Barriers'],
        # 0 = combinational(árvore) | 1 = Sequential
        MAC_type=layer_dict['Neuron_arch']['MAC_type'],
        # 0 = don't include | 1 = include 'seq' or 'tree' on vhd_names
        Include_MAC_type=layer_dict['Neuron_arch']['Include_MAC_type'],
        # Número do modelo de multiplicador. Exemplo: mult_number = 1 (multiplicador do tipo 1) --> mul1
        mult_number=find_True_dict_split(
            split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0),
        # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
        mult_version=0,
        adder_number=find_True_dict_split(
            split_str='-', dict=layer_dict['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
        adder_version=0)


def update_dict_fx_activation(layer_dict: dict):
    fx_activation = find_True_dict_Output_print(
        dict_slice=layer_dict['Neuron_arch']['Activation_fx'])
    if fx_activation == 'Using':  # caso seja uma fx com dicionário interno de parâmetros, devemos pegar o nome dela e não o 'using'
        """Exemplo:
        'Activation_fx':{
            'ReLU': False,
            'Leaky_ReLU': {
                'Using': False,        # True = usar versão Leaky_ReLU
                # número de vezes que divide por 2 a ReLU (shift right)
                'Leaky_attenuation': 2
            },
            'Sigmoid': {
                # True = usar versão Sigmoid (Look Up Table)
                'Using': True,
                'Memory': {
                'bits_mem': 8,
                # 'n' binary digits are the fractional part of `x`; = MANTISSA
                'mantissa': lambda:layer_dict_softmax['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['bits_mem'],
                }
                }
            }
        O que confirma se é a Sigmoid é o {'Using': True }, porém queremos pegar o nome 'Sigmoid', que está um nível de hierarquia acima """
        fx_activation = find_True_dict_Output_print_above_level(
            dict_slice=layer_dict['Neuron_arch']['Activation_fx'])
        # activation_fx = find_True_dict_above_level(dict_slice = output_dict['Neuron_arch']['Activation_fx'])


def get_dict_fx_activation(layer_dict: dict):
    fx_activation = find_True_dict_Output_print(
        dict_slice=layer_dict['Neuron_arch']['Activation_fx'])
    if fx_activation == 'Using':  # caso seja uma fx com dicionário interno de parâmetros, devemos pegar o nome dela e não o 'using'
        """Exemplo:
        'Activation_fx':{
            'ReLU': False,
            'Leaky_ReLU': {
                'Using': False,        # True = usar versão Leaky_ReLU
                # número de vezes que divide por 2 a ReLU (shift right)
                'Leaky_attenuation': 2
            },
            'Sigmoid': {
                # True = usar versão Sigmoid (Look Up Table)
                'Using': True,
                'Memory': {
                'bits_mem': 8,
                # 'n' binary digits are the fractional part of `x`; = MANTISSA
                'mantissa': lambda:layer_dict_softmax['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['bits_mem'],
                }
                }
            }
        O que confirma se é a Sigmoid é o {'Using': True }, porém queremos pegar o nome 'Sigmoid', que está um nível de hierarquia acima """
        fx_activation = find_True_dict_Output_print_above_level(
            dict_slice=layer_dict['Neuron_arch']['Activation_fx'])

    return fx_activation


# print(
#     f"fx_activation: {get_dict_fx_activation(layer_dict = layer_dict_hidden)}")


def update_dict_neuron(layer_dict):
    # upload dos parâmetros do neurônio com base nos parâmetros da camada da NN
    layer_dict['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['mantissa'] = layer_dict['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['bits_mem']

    layer_dict['Neuron_arch']['Inputs_number'] = layer_dict['Inputs_number']
    # define o número de bits para as entradas e pesos
    layer_dict['Neuron_arch']['Bit_WIDTH'] = layer_dict['bits']
    # True= signed || 0= unsigned
    layer_dict['Neuron_arch']['IO_type'] = layer_dict['IO_type']

    layer_dict['Neuron_arch']['IO']['GENERIC']['TOTAL_BITS'] = layer_dict['Neuron_arch']['IO']['GENERIC']['BITS'](
    )*layer_dict['Neuron_arch']['IO']['GENERIC']['NUM_INPUTS']()

    update_neuron_name_from_LayerDict(layer_dict=layer_dict)
    update_dict_fx_activation(layer_dict=layer_dict)

    # print("update_dict(): Dict updated!")


update_dict_neuron(layer_dict=layer_dict_hidden)

# pegando dados do dicionário


def get_neuron_data_from_LayerDict(layer_dict: dict, DEBUG: bool = False):
    update_dict_neuron(layer_dict=layer_dict_hidden)  # primeiro atualiza

    try:
        num_inputs = layer_dict['Neuron_arch']['Inputs_number']()
        bits = layer_dict['Neuron_arch']['Bit_WIDTH']()
        IO_type = layer_dict['Neuron_arch']['IO_type']()
        Include_MAC_type = layer_dict['Neuron_arch']['Include_MAC_type']()

        n_bin = layer_dict['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['mantissa'](
        )
        if DEBUG:
            print(
                f"get_neuron_data_from_LayerDict() -> layer_dict['Neuron_arch']['IO_type'](): {layer_dict['Neuron_arch']['IO_type']()}")
    except:
        bits = layer_dict['Neuron_arch']['Bit_WIDTH']
        n_bin = layer_dict['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['mantissa']
        num_inputs = layer_dict['Neuron_arch']['Inputs_number']
        IO_type = layer_dict['Neuron_arch']['IO_type']
        Include_MAC_type = layer_dict['Neuron_arch']['Include_MAC_type']

        if DEBUG:
            print(
                f"get_neuron_data_from_LayerDict() -> layer_dict['Neuron_arch']['IO_type']: {layer_dict['Neuron_arch']['IO_type']}")

    Neuron_name = layer_dict['Neuron_arch']['Neuron_name']
    if DEBUG:
        print(f"get_neuron_data_from_LayerDict() -> IO_type: {IO_type}")
        print(
            f"get_neuron_data_from_LayerDict() -> Neuron_name: {Neuron_name}")
        print(
            "-------------------- get_neuron_data_from_LayerDict() ------------------------")

    Barriers = layer_dict['Neuron_arch']['Barriers']
    MAC_type = layer_dict['Neuron_arch']['MAC_type']
    fx_activation = get_dict_fx_activation(layer_dict=layer_dict)

    input_mem_bits = n_bin  # por enquanto só temos mantissa, sem inteiros
    output_mem_bits = input_mem_bits  # por enquanto entrada = saída

    return num_inputs, bits, IO_type, Neuron_name, Include_MAC_type, MAC_type, Barriers, fx_activation, n_bin, input_mem_bits, output_mem_bits


# print(f"-------- get_neuron_data_from_LayerDict(layer_dict: dict) ----------- ")
# num_inputs, bits, IO_type, Neuron_name, Include_MAC_type, MAC_type, Barriers, fx_activation, n_bin, input_mem_bits, output_mem_bits = get_neuron_data_from_LayerDict(
#     layer_dict=layer_dict_hidden)
# print(f"num_inputs: {num_inputs}")
# print(f"bits: {bits}")
# print(f"IO_type: {IO_type}")
# print(f"Neuron_name: {Neuron_name}")
# print(f"Include_MAC_type: {Include_MAC_type}")
# print(f"MAC_type: {MAC_type}")
# print(f"Barriers: {Barriers}")
# print(f"fx_activation: {fx_activation}")
# print(f"n_bin: {n_bin}")
# print(f"input_mem_bits: {input_mem_bits}")
# print(f"output_mem_bits: {output_mem_bits}")


# ===================== SOFTMAX LAYER ==================
# fazendo uma lista do dicionário
dict_list = dict_to_list(target_dict=fx_activation_dict, key_or_value=True)
# ['ReLU', 'Leaky ReLU', 'Sigmoid']

layer_dict_softmax = {
    # ========================== Parâmetros da camada ===========================
    'Inputs_number': 3,  # número de entradas da camada
    'bits': 8,
    'IO_type': 'signed',     # 'signed' | 'unsigned' | 'std_logic_vector'
    'Neurons_number': 2,  # número de neurônios da camada
    'Layer_name': '',  # nome do '.vhd' da camada
    'Layer_num': '',  # número da camada
    # --------------------------
    # DEVE SE ALTERAR AUTOMATICAMENTE COM BASE NA CONFIG DO NEURÔNIO
    'IO': {  # INPUT & OUTPUT
        'GENERIC': {
            'BITS': lambda: layer_dict_hidden['bits'],
            'NUM_INPUTS': lambda: layer_dict_hidden['Inputs_number'],
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
    },

    # ======================= Parâmetros do neurônio ============================

    # --------- Configurações da arquitetura do neurônio ---------
    'Neuron_arch': {
        # número de entradas e pesos do perceptron
        'Inputs_number': lambda: layer_dict_softmax['Inputs_number'],
        # define o número de bits para as entradas e pesos
        'Bit_WIDTH': lambda: layer_dict_softmax['bits'],
        # True= signed || 0= unsigned
        'IO_type': lambda: layer_dict_softmax['IO_type'],

        # -------------------------
        # O dicionário de entradas e saídas deverá ser gerado automaticamente, com base nos parâmetros:
        #  - IO_type
        #  - por enquanto creio que é só """
        # -------------------------

        # --------- Geração do nome do neurônio ---------
        'Neuron_name': '',
        # 0 = don't include | 1 = include 'seq' or 'comb' on vhd_names
        'Include_MAC_type': True,

        # -------------------------
        'IO': {  # INPUT & OUTPUT
            'GENERIC': {
                'BITS': lambda: layer_dict_softmax['bits'],
                'NUM_INPUTS': lambda: layer_dict_softmax['Inputs_number'],
                'TOTAL_BITS': None
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
            },
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
                    'manual': None
                }
                # }
            }
        },

        # -------------
        'MAC_type': False,  # False = combinational(árvore) | True = Sequential

        # -------------
        'Barriers': True,  # True = com barreiras de registradores

        # ------------- Versões de multiplicador
        'Multiplier': {
            '0-Operator': True,  # *
            '1-Baugh_Wooley': {
                '1a-Alexandre': False,
                '1b-Luis': False
            },
            '2-Booth': False,
            '3-Shift': False,
            '4-Quantized_shift': False
        },

        # -------------
        'Adder': {
            '0-Operator': True  # +
        },

        # -------------
        'Activation_fx': {
            'ReLU': False,
            'Leaky_ReLU': {
                'Using': False,        # True = usar versão Leaky_ReLU
                # número de vezes que divide por 2 a ReLU (shift right)
                'Leaky_attenuation': 2
            },
            'Sigmoid': {
                # True = usar versão Sigmoid (Look Up Table)
                'Using': True,
                'Memory': {
                    'bits_mem': 8,
                    # 'n' binary digits are the fractional part of `x`; = MANTISSA
                    'mantissa': lambda: layer_dict_softmax['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['bits_mem'],
                }
            }
        }
    }


}
# Definindo nome do neurônio
layer_dict_softmax['Neuron_arch']['Neuron_name'] = vhd_name(
    # modelo de função de ativação
    vhd_name=f"neuron_{dict_list[0]}",
    # Obs: dict_list 0: ReLU, 1: Leaky ReLU, 2: Sigmoid
    # Quantidade de bits para representação
    bits=layer_dict_softmax['bits'],
    # 1= signed || 0= unsigned
    IO_type=layer_dict_softmax['IO_type'],
    # Quantidade de entradas
    num_inputs=layer_dict_softmax['Inputs_number'],
    # 0 = no Barriers | 1 = with register Barriers
    Barriers=layer_dict_softmax['Neuron_arch']['Barriers'],
    # 0 = combinational(árvore) | 1 = Sequential
    MAC_type=layer_dict_softmax['Neuron_arch']['MAC_type'],
    # 0 = don't inluce | 1 = include 'seq' or 'tree' on vhd_names
    Include_MAC_type=layer_dict_softmax['Neuron_arch']['Include_MAC_type'],
    # Número do modelo de multiplicador. Exemplo: mult_number = 1 (multiplicador do tipo 1) --> mul1
    mult_number=find_True_dict_split(
        split_str='-', dict=layer_dict_softmax['Neuron_arch']['Multiplier'], position=0),
    # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
    mult_version=0,
    adder_number=find_True_dict_split(
        split_str='-', dict=layer_dict_softmax['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
    adder_version=0)
# layer_dict_softmax['Neuron_arch']['Neuron_name']

layer_dict_softmax['Neuron_arch']['IO']['GENERIC']['TOTAL_BITS'] = layer_dict_softmax['Neuron_arch']['IO']['GENERIC']['BITS'](
)*layer_dict_softmax['Neuron_arch']['IO']['GENERIC']['NUM_INPUTS']()

# print()
# print(layer_dict_softmax['Neuron_arch']['IO']['GENERIC']['BITS'](
# )*layer_dict_softmax['Neuron_arch']['IO']['GENERIC']['NUM_INPUTS']())

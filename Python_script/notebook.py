# %% [markdown]
# # Functions

# %% [markdown]
# ## <font color=red>**create folder neuron**</font>

# %%
from math import log
import math
import os
import numpy as np


def create_folder_neuron(
    hidden_layer_neurons, softmax_layer_neurons, MAC_type, has_pipe, path_level, create
):  # (hidden,softmax,MAC_type,Barriers,path_level,download )
    # MAC_type:     0 = tree                  | 1 = Sequential
    # has_pipe:     0 = no Barriers           | 1 = with register Barriers (pipeline)
    # path_level:   0 = Same level path       | 1 = Above path
    # create:       0 = Don't Create Folders  | 1 = Create Folders
    #
    #  https://docs.python.org/3/library/pathlib.html
    import os

    # ===================== DIR PATH LEVEL ===================== #
    if path_level == 0:  # SAME LEVEL
        whole_dir = os.path.abspath(".")

    else:  # ABOVE FOLDER
        whole_dir = os.path.abspath("..")

    path = [None] * len(hidden_layer_neurons)
    path_soft = [None] * len(softmax_layer_neurons)

    # ========= # MAC_type = 0 = combinational(tree:árvore) #===========#
    if MAC_type == 0:
        if has_pipe == 0:  # 0 = no Barriers
            for i in range(0, len(hidden_layer_neurons)):
                path[i] = f"Tree/NObarriers/"

        else:  # 1 = with register Barriers (pipeline)
            for i in range(0, len(hidden_layer_neurons)):
                path[i] = f"Tree/BARRIERS/"

    # ----------------# MAC_type = 1 = Sequential #----------------#
    else:
        if has_pipe == 0:  # 0 = no Barriers
            for i in range(0, len(hidden_layer_neurons)):
                path[i] = f"Sequential/NObarriers/"
        else:  # 1 = with register Barriers (pipeline)
            # NAME_dir_MAC = "Sequential/shallow_barriers/"
            for i in range(0, len(hidden_layer_neurons)):
                path[i] = f"Sequential/BARRIERS/"

    # -------------------------------------------------------------------------------------------#

    # ======================== SOFTMAX LAYER ======================== #
    for i in range(0, len(softmax_layer_neurons)):
        path_soft[
            i
        ] = f"{whole_dir}/Neuron/SoftmaxLayer/{path[i]}{softmax_layer_neurons[i]}/{bits}bit/{num_inputs}n"

    # ======================== HIDDEN LAYERS ======================== #
    for i in range(0, len(hidden_layer_neurons)):
        path[
            i
        ] = f"{whole_dir}/Neuron/HiddenLayer/{path[i]}{hidden_layer_neurons[i]}/{bits}bit/{num_inputs}n"

    if create == 1:  # CREATING FOLDERS
        for i in range(0, len(softmax_layer_neurons)):
            os.makedirs(f"{path_soft[i]}", exist_ok=True)  # softmax layer
        for i in range(0, len(hidden_layer_neurons)):
            os.makedirs(f"{path[i]}", exist_ok=True)  # hidden layer
        print("Created Folders!!")

    return (path, path_soft)


# %% [markdown]
# ## <font color=red>  **vhd_name**  </font>

# %%
# def vhd_name(vhd_name, vhd_type, bits, is_signed, num_inputs, Barriers, MAC_type ):
def vhd_name(
    vhd_name, bits, is_signed, num_inputs, Barriers, MAC_type, Include_MAC_type
):

    name = ""
    # defining vhd NAMES
    if (
        is_signed == 1
    ):  # ______________________________COM SINAL (SIGNED)_______________________________________#
        name = f"{vhd_name}_{bits}bit_{num_inputs}n_signed"

    # _________________________________SEM SINAL (UNSIGNED)__________________________________________#
    else:
        name = f"{vhd_name}_{bits}bit_{num_inputs}n_unsigned"

    if Include_MAC_type == 1:
        if MAC_type == 0:  # árvore (combinacional)
            name = insert_string_inside(name, "_", "tree", 1)

        else:  # sequencial (multiciclo: seq)
            name = insert_string_inside(name, "_", "seq", 1)

        if Barriers == 1:  # se tem barreiras (pipeline)
            name = insert_string_inside(name, "_", "Barriers", 2)

    # if (vhd_type == 'neuron'):

    return name
    # print(name)


# %% [markdown]
# ## <font color=red>  **insert_string_inside**  </font>

# %%
def insert_string_inside(original_txt, split_character, insert_txt, position):
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
    return final_txt


# %% [markdown]
# ## <font color=red>  **input_sequences**  </font>

# %%
def input_sequences(sequence_id, num_inputs, list_or_string, port_map, new_line):
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

                        if port_map == 1:  # sequência port_map
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

                            if port_map == 1:  # sequência port_map
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

# %% [markdown]
# # PARAMETROS

# %%
# bits_list_index = 0
# inputs_list_index = -1

# %% [markdown]
# ### <font color=red>  **Parâmetros Gerais**  </font>

# %%
# # gera_automatico = 0

# if (gera_automatico == 1):
#       print("\n bits_index: "+ str(bits_list_index),
#             "\n inputs_index: "+ str(inputs_list_index + 1))


# %%
# inputs_list_gen[inputs_list_index]

# %%
gera_automatico = 0  # 1 = gera | 0 = não gera

bits_list_gen = [4, 6, 8, 10]  # lista de bits para versões
inputs_list_gen = [4, 8, 16, 32, 64]  # lista de inputs ...


print_cells_result = 1  # 1 = mostra outputs no jupyter| 0 = não mostra

if gera_automatico == 1:

    # -------------------- Loop listas ------------------------------#
    if (
        inputs_list_index >= len(inputs_list_gen) - 1
    ):  # Quando chega no final da lista de 'inputs'
        inputs_list_index = 0
        bits_list_index += 1  # Quando ainda não é o final da lista de 'bits'

    else:  # Quando ainda não é o final da lista de 'inputs'
        inputs_list_index += 1

    if bits_list_index >= len(
        bits_list_gen
    ):  # Quando chega no final da lista de 'bits'
        bits_list_index = 0

    bits = bits_list_gen[
        bits_list_index
    ]  # define o número de bits para as entradas e pesos
    num_inputs = inputs_list_gen[inputs_list_index]  # define número de inputs

    # ------------------------- Sem Loop ----------------------------#
else:
    bits = 8  # define o número de bits para as entradas e pesos
    num_inputs = 8  # número de entradas e pesos do perceptron

# -------------------------------------------------------------------------------------------------#

saidas_debug = (
    0  # 1= para colocar saidas nos .vhd || 0= para não colocar saídas de debug
)
is_signed = 1  # 1= signed || 0= unsigned
memory_mux = 0  # 1= ter mux no somatório para não buscar na memória sempre || 0= não ter -> busca sempre na memória

leaky_attenuation = 2  # número de vezes que divide por 2 a ReLU (shift right)
# activ_fx_middle = 1     # 1= ReLU | 2 = Leaky_Relu


MAC_type = 0  # 0 = combinational(tree:árvore) | 1 = Sequential
Include_MAC_type = 0  # 0 = don't incluce | 1 = include 'seq' or 'tree' on vhd_names
Barriers = 1  # 0 = no Barriers | 1 = with register Barriers (pipeline)

bits_mem = 8
input_mem_bits = bits_mem
output_mem_bits = bits_mem

n_bin = bits  # 'n' binary digits are the fractional part of `x`; = MANTISSA

download_vhd = 1  # 1= para baixar || 0= não baixar
download_txt = 0  # 1= para baixar || 0= não baixar

download_files = download_vhd or download_txt  # 1= para baixar || 0= não baixar


# %%
if is_signed == 1:  # versão com sinal
    input_output_type = "signed"
    std_logic_conversion = input_output_type
else:  # versão sem sinal
    input_output_type = "STD_LOGIC_VECTOR"
    std_logic_conversion = "unsigned"

# %%
# bits_list_index = 0
# inputs_list_index = -1

# %%
# import pandas as pd

# import

# %%
# gera_automatico = 0

if gera_automatico == 1:
    print(
        " bits: " + str(bits_list_gen[bits_list_index]),
        "\n inputs: " + str(inputs_list_gen[inputs_list_index]),
        "\n bits_index: " + str(bits_list_index),
        "\n inputs_index: " + str(inputs_list_index + 1),
    )

# %%
# https://colab.research.google.com/drive/12xCU8oNStmXCekDzL-P9hx7ro-obPTUu#scrollTo=GDrWC4BP0gIu
m_bin = bits - n_bin  # `m` binary digits are the integer part
# m_bin = 5 # `m` binary digits are the integer part
# n_bin = n_bits - m_bin # 'n' binary digits are the fractional part of `x`;
n_bin_sigmoid = n_bin * 2

sup_threshold = 2 ** m_bin
inf_threshold = 0

# %% [markdown]
# ### <font color=red>    **Criando Pasta**   </font>

# %%
Neurons_hidden = ["ReLU", "Leaky_ReLU"]
Neurons_softmax = ["Sigmoid"]

path, path_soft = create_folder_neuron(
    Neurons_hidden, Neurons_softmax, MAC_type, Barriers, 1, 1
)
# create_folder_neuron(Neurons_hidden,Neurons_softmax,MAC_type,Barriers,1,download_files)
# (hidden,softmax,MAC_type,Barriers,path_level,create)
# MAC_type:     0 = tree                  | 1 = Sequential
# has_pipe:     0 = no Barriers           | 1 = with register Barriers (pipeline)
# path_level:   0 = Same level path            | 1 = Above path
# create:       0 = Don't Create Folders  | 1 = Create Folders

path_soft = path_soft[0]
path_ReLU = path[0]
path_LeakyReLU = path[1]

if print_cells_result == 1:
    print(f"Relu: {path[0]}")
    print("----------------------")
    print(f"Leaky Relu: {path[1]}")
    print("----------------------")
    print(f"Softmax: {path_soft}")

# %%

for i in range(0, len(Neurons_softmax)):
    os.makedirs(f"{path_soft[i]}", exist_ok=True)  # softmax layer
    print(path_soft[i])
# for i in range(0,len(hidden_layer_neurons)):
#   os.makedirs(f"{path[i]}", exist_ok=True)   # hidden layer

# %%
download_files

# %%
# Pasta testbench
project_folder_path = r'''"C:/Users/luisa/Documents/Materias/UFSC/20201/Lab_EBD_ECL/Perpeptron/NN_Neuron_unsigned_no_components_generic_inputs_python_ROM_2"'''

# %% [markdown]
# # .vhd Names - ok

# %% [markdown]
# ### <font color=green>    **.vhd Names > Sum (MAC)**    </font>

# %% [markdown]
# #### Name

# %%
sum_name = vhd_name(
    "MAC", bits, is_signed, num_inputs, Barriers, MAC_type, Include_MAC_type
)
if print_cells_result == 1:
    sum_name

# %% [markdown]
# ### <font color=green>    **.vhd Names > top_neuron**   </font>

# %% [markdown]
# #### <font color=orange>    **.vhd Names > top_neuron> Name**   </font>

# %%
prefix_neuron = "neuron_"
neurons_dict = {
    "ReLU": f"{prefix_neuron}ReLU",
    "Leaky ReLU": f"{prefix_neuron}LeakyReLU",
    "Sigmoid": f"{prefix_neuron}Sigmoid",
}

# %%
neuron_ReLU_name = vhd_name(
    neurons_dict["ReLU"],
    bits,
    is_signed,
    num_inputs,
    Barriers,
    MAC_type,
    Include_MAC_type,
)
neuron_Leaky_name = vhd_name(
    neurons_dict["Leaky ReLU"],
    bits,
    is_signed,
    num_inputs,
    Barriers,
    MAC_type,
    Include_MAC_type,
)
neuron_Sigmoid = vhd_name(
    neurons_dict["Sigmoid"],
    bits,
    is_signed,
    num_inputs,
    Barriers,
    MAC_type,
    Include_MAC_type,
)

if print_cells_result == 1:
    print(neuron_ReLU_name)
    print(neuron_Leaky_name)
    print(neuron_Sigmoid)

# %% [markdown]
# ### <font color=green>    **.vhd Names > Testbench top neuron**   </font>

# %% [markdown]
# #### <font color=orange>    **.vhd Names > Testbench top neuron > Name**   </font>

# %%
tb_neuron_ReLU_name = vhd_name(
    "tb_neuron_ReLU", bits, is_signed, num_inputs, Barriers, MAC_type, Include_MAC_type
)
tb_neuron_Leaky_name = vhd_name(
    "tb_neuron_LeakyReLU",
    bits,
    is_signed,
    num_inputs,
    Barriers,
    MAC_type,
    Include_MAC_type,
)
tb_neuron_soft_name = vhd_name(
    "tb_neuron_Softmax",
    bits,
    is_signed,
    num_inputs,
    Barriers,
    MAC_type,
    Include_MAC_type,
)

if print_cells_result == 1:
    print(tb_neuron_ReLU_name)
    print(tb_neuron_Leaky_name)
    print(tb_neuron_soft_name)

# %% [markdown]
# # Neuronio

# %% [markdown]
# ## <font color=green>**Sequências**</font>

# %%
# def input_sequences(sequence_id ,num_inputs, list_or_string, port_map, new_line):
#   # sequence_id:      id for this sequence
#   # num_inputs:       number of sequence elements
#   # list_or_string:   'list' = list; 'string' = string
#   # port_map:         1: x1 => x1 | 0: x1, x2, ...'
#   # new_line:         1: 1 string elements per line | 0: all on the same line
#   debug = 0

#   sequence = []
#   i=0

#   while True:
#     for m in range(0,len(sequence_id)):

#       for i in range(0,num_inputs):#Aqui formamos a sequência, exemplo para ID = 'x' | sequência = x1, x2, ...
#         if (list_or_string == 'string'):
#           if (i < (num_inputs)):
#             sequence.append(f"{sequence_id}{str(i+1)}")
#             # print(f"i={i}<{num_inputs-1}, m={m}")
#             if (debug == 1):
#               print(sequence)

#         if (list_or_string == 'list'):
#           if (i < (num_inputs)):
#             sequence.append(f"{sequence_id[m]}{str(i+1)}")
#             # print(f"i={i}<{num_inputs-1}, m={m}")
#             if (debug == 1):
#               print(sequence)

#         if (i == (num_inputs -1)):

#           # print(f"i={i}<{num_inputs-1}, m={m}")

#           #  ==================== APENAS STRING ==================== #
#           # se ID é apenas uma string, exemplo: 'x'
#           if (list_or_string == 'string'):

#             if (port_map == 1): # sequência port_map
#               for k in range(0,(num_inputs)):
#                 sequence[k] =  f"{sequence[k]}=>{sequence[k]}"

#             if ( new_line == 1): #sequência com cada item em uma nova linha
#               for k in range(0,num_inputs):
#                 sequence[k] =  f"{sequence[k]}, \n"
#               return f"".join(map(str, (sequence)))

#             return f", ".join(map(str, (sequence)))

#           #  ==================== LISTA DE STRINGS ==================== #
#           # Se ID é uma lista de strings, exemplo: ['x','w']
#           if (list_or_string == 'list'):
#             if (m == len(sequence_id) -1):

#               if (port_map == 1): # sequência port_map
#                 for k in range(0,(num_inputs*(len(sequence_id))  )):
#                   if (debug == 1):
#                     print(f"max = {(num_inputs*(len(sequence_id))  )}")
#                     print(f"k = {k}")
#                   sequence[k] =  f"{sequence[k]}=>{sequence[k]}"

#               if ( new_line == 1): #sequência com cada item em uma nova linha
#                 for k in range(0,(num_inputs*(len(sequence_id))  )):
#                   sequence[k] =  f"{sequence[k]}, \n"
#                 return f"".join(map(str, (sequence)))

#               return f", ".join(map(str, (sequence)))

# # EXEMPLOS:
# print(input_sequences('x',num_inputs,'string',1,1)) # (sequence_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences(['x','w'] ,num_inputs,'list',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('x' ,num_inputs,'string',1,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# # print(input_sequences('x' ,num_inputs, 'string', port_map, new_line))

# print(input_sequences('sx' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('sw' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('val_x' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences('val_w' ,num_inputs,'string',0,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# print(input_sequences(['x','w'] ,num_inputs,'list',1,0)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line))
# print(input_sequences(['x','w'] ,num_inputs,'list',1,1)) # (sequence_id ,num_inputs, list_or_string, port_map, new_line))

# %%
# x_sequence_string = input_sequences('x' ,num_inputs,'string',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# x_map_tb = input_sequences('x' ,num_inputs,'string',1,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# sx_sequence_string = input_sequences('sx' ,num_inputs,'string',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# valx_sequence_string = input_sequences('val_x' ,num_inputs,'string',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)


# x_w_sequence_string = input_sequences(['x','w'] ,num_inputs,'list',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# xw_map_tb_sequence_string = input_sequences(['x','w'] ,num_inputs,'list',1,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)


# w_sequence_string = input_sequences('w' ,num_inputs,'string',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# w_map_tb = input_sequences('w' ,num_inputs,'string',1,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# sw_sequence_string = input_sequences('sw' ,num_inputs,'string',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
# valw_sequence_string = input_sequences('val_w' ,num_inputs,'string',0,0) # (sequence_id ,num_inputs, list_or_string, port_map, new_line)

# print(x_sequence_string)
# print(sx_sequence_string)
# print(valx_sequence_string)
# print('-----------------')

# print(x_w_sequence_string)
# print(xw_map_tb_sequence_string)
# print('-----------------')
# print(w_sequence_string)
# print(sw_sequence_string)
# print(valw_sequence_string)

# %%
def sequence_string_to_input(input_name, num_inputs):
    x_sequence_string = []
    x_map_tb = []
    sx_sequence_string = []
    valx_sequence_string = []
    x_w_sequence_string = []

    for i in input_name:
        x_sequence_string.append(
            input_sequences(i, num_inputs, "string", 0, 0)
        )  # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        x_map_tb.append(
            input_sequences(i, num_inputs, "string", 1, 0)
        )  # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        sx_sequence_string.append(
            input_sequences(f"s{i}", num_inputs, "string", 0, 0)
        )  # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
        valx_sequence_string.append(
            input_sequences(f"val_{i}", num_inputs, "string", 0, 0)
        )  # (sequence_id ,num_inputs, list_or_string, port_map, new_line)

        # print(x_sequence_string)
        # print(sx_sequence_string)
        # print(valx_sequence_string)
        # print('-----------------')
        # return [x_sequence_string, sx_sequence_string,valx_sequence_string ]

    x_w_sequence_string = input_sequences(
        input_name, num_inputs, "list", 0, 0
    )  # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
    xw_map_tb_sequence_string = input_sequences(
        input_name, num_inputs, "list", 1, 0
    )  # (sequence_id ,num_inputs, list_or_string, port_map, new_line)
    # print(x_w_sequence_string)
    # print(xw_map_tb_sequence_string)
    # print('-----------------')

    return (
        x_sequence_string,
        sx_sequence_string,
        valx_sequence_string,
        x_w_sequence_string,
        xw_map_tb_sequence_string,
    )


# %%
input_sequences("x", num_inputs, "list", 0, 0)

# %%
# x_sequence_string, sx_sequence_string, valx_sequence_string,x_w_sequence_string, xw_map_tb_sequence_string =sequence_string_to_input(['x','w'], num_inputs)

# # w_sequence_string = x_sequence_string[1]
# # sw_sequence_string = sx_sequence_string[1]
# # valw_sequence_string = valx_sequence_string[1]

# # x_sequence_string = x_sequence_string[0]
# # sx_sequence_string = sx_sequence_string[0]
# # valx_sequence_string = valx_sequence_string[0]

# print(x_sequence_string)
# print(sx_sequence_string)
# print(valx_sequence_string)
# print('-----------------')

# print(x_w_sequence_string)
# print(xw_map_tb_sequence_string)
# print('-----------------')
# # print(w_sequence_string)
# # print(sw_sequence_string)
# # print(valw_sequence_string)

# %%
# #INPUTS
# #https://stackoverflow.com/questions/15478127/remove-final-character-from-string
# i = 0

# #input definitions
# x = ""+x_sequence_string+": IN "+input_output_type+"("+str(bits -1)+" DOWNTO 0);"
# w = ""+w_sequence_string+": IN "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

# #Sum SIGNALS
# sx = "SIGNAL "+sx_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "
# sw = "SIGNAL "+sw_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

# #testbench signals
# sx_tb = "SIGNAL "+x_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "
# sw_tb = "SIGNAL "+w_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

#   #I really don't remember if it's from testbench or not
# val_x = "SIGNAL "+valx_sequence_string+": STD_LOGIC_VECTOR("+str(bits -1)+" DOWNTO 0); "
# val_w = "SIGNAL "+valw_sequence_string+": STD_LOGIC_VECTOR("+str(bits -1)+" DOWNTO 0); "

#   #signals to capture values on tb -> from the text files
# val_x_tb = "VARIABLE "+valx_sequence_string+": STD_LOGIC_VECTOR("+str(bits -1)+" DOWNTO 0); "
# val_w_tb = "VARIABLE "+valw_sequence_string+": STD_LOGIC_VECTOR("+str(bits -1)+" DOWNTO 0); "

# print(x)
# print(w)
# print(sx)
# print(sx)
# print(sx_tb)
# print(sw_tb)
# print(val_x)
# print(val_w)
# print(val_x_tb)
# print(val_w_tb)

# %%


def seq_input_output(
    x_seq, type, input_output_type, bits, list_or_string, port_position
):
    x = []
    for i in x_seq:
        x.append(f"{i}: {type} {input_output_type}({str(bits -1)} DOWNTO 0);")

    if list_or_string == "string":  # caso queira o retorno em string

        if (
            port_position == "end"
        ):  # se está no final do 'port (...)' => tira último ';'
            x = "\n".join(map(str, x))
            return x[:-1]
        else:
            return "\n".join(map(str, x))

    else:  # caso queira o retorno em vetor
        return x


# seq_input_output(x_seq,"IN",input_output_type,bits,'vector','begin')


def seq_signal(x_seq, type, input_output_type, bits):
    sx = []
    for i in x_seq:
        sx.append(f"{type} {i}: {input_output_type}({str(bits -1)} DOWNTO 0); ")
    return sx


# seq_signal(x_seq,"SIGNAL",input_output_type,bits)
# seq_signal(valx_seq,"SIGNAL","STD_LOGIC_VECTOR",bits)

# %%
# def inputs(bits,input_output_type, x_seq, sx_seq, valx_seq):
#   #INPUTS
#   #https://stackoverflow.com/questions/15478127/remove-final-character-from-string

#   x= []
#   sx = []
#   sx_tb = []
#   val_x = []
#   val_x_tb = []
#   #input definitions
#   x = seq_input_output(x_seq,"IN",input_output_type,bits,'vector','begin')
#   sx_tb = seq_signal(x_seq,"SIGNAL",input_output_type,bits)
#   sx = seq_signal(sx_seq,"SIGNAL",input_output_type,bits)
#   val_x = seq_signal(valx_seq,"SIGNAL","STD_LOGIC_VECTOR",bits)
#   val_x_tb = seq_signal(valx_seq,"VARIABLE","STD_LOGIC_VECTOR",bits)

#   w = x[1]
#   x = x[0]
#   sw = sx[1]
#   sx = sx[0]
#   sw_tb = sx_tb[1]
#   sx_tb = sx_tb[0]
#   val_w = val_x[1]
#   val_x = val_x[0]
#   val_w_tb = val_x_tb[1]
#   val_x_tb = val_x_tb[0]

#   return(x,w,sx,sw,sx_tb,sw_tb,val_x,val_w,val_x_tb,val_w_tb)

# %%
def inputs_vector(bits, input_output_type, x_seq, sx_seq, valx_seq, is_vector):
    # INPUTS
    # https://stackoverflow.com/questions/15478127/remove-final-character-from-string

    x = []
    sx = []
    sx_tb = []
    val_x = []
    val_x_tb = []
    # input definitions
    x = seq_input_output(x_seq, "IN", input_output_type,
                         bits, "vector", "begin")
    sx_tb = seq_signal(x_seq, "SIGNAL", input_output_type, bits)
    sx = seq_signal(sx_seq, "SIGNAL", input_output_type, bits)
    val_x = seq_signal(valx_seq, "SIGNAL", "STD_LOGIC_VECTOR", bits)
    val_x_tb = seq_signal(valx_seq, "VARIABLE", "STD_LOGIC_VECTOR", bits)

    if is_vector == 0:
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


# %%
# def inputs(bits,input_output_type, x_seq, sx_seq, valx_seq):
#   #INPUTS
#   #https://stackoverflow.com/questions/15478127/remove-final-character-from-string

#   x= []
#   sx = []
#   sx_tb = []
#   val_x = []
#   val_x_tb = []
#   #input definitions

#   # for i in x_seq:
#   #   x.append( f"{i}: IN {input_output_type}({str(bits -1)} DOWNTO 0);")
#   #   # w = f"{w_sequence_string}: IN {input_output_type}({str(bits -1)} DOWNTO 0); "
#   # #testbench signals
#   #   sx_tb.append(f"SIGNAL {i}: {input_output_type}({str(bits -1)} DOWNTO 0); ")
#   #   # sw_tb = "SIGNAL "+w_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

#   # #Sum SIGNALS
#   # for i in sx_seq:
#   #   sx.append(f"SIGNAL {i}: {input_output_type}({str(bits -1)} DOWNTO 0); ")
#   # # sw = f"SIGNAL {sw_sequence_string}: {input_output_type}({str(bits -1)} DOWNTO 0); "


#   #   # I really don't remember if it's from testbench or not
#   # for i in valx_seq:
#   #   val_x.append(f"SIGNAL {i}: STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0); ")
#   #   # val_w = "SIGNAL "+valw_sequence_string+": STD_LOGIC_VECTOR("+str(bits -1)+" DOWNTO 0); "

#   #   #signals to capture values on tb -> from the text files
#   #   val_x_tb.append(f"VARIABLE {i}: STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0); ")
#   #   # val_w_tb = "VARIABLE "+valw_sequence_string+": STD_LOGIC_VECTOR("+str(bits -1)+" DOWNTO 0); "

#   w = x[1]
#   x = x[0]
#   sw = sx[1]
#   sx = sx[0]
#   sw_tb = sx_tb[1]
#   sx_tb = sx_tb[0]
#   val_w = val_x[1]
#   val_x = val_x[0]
#   val_w_tb = val_x_tb[1]
#   val_x_tb = val_x_tb[0]

#   return(x,w,sx,sw,sx_tb,sw_tb,val_x,val_w,val_x_tb,val_w_tb)

#   # return(x,sx,sx_tb,val_x,val_x_tb)

# %%
def all_inputs_signals(num_inputs, bits, input_output_type, is_vector):
    # ------- Parâmetros do início do script --------
    # num_inputs: número de entradas
    # bits: número de bits
    # input_output_type: se é 'signed' ou 'unsigned'
    # -------------- Outros Parâmetros --------------
    # is_vector: 1 = representar retornos em vetores x = [..] | 0 = representar em variáveis diferentes -> x, w, ....

    (
        x_sequence_string,
        sx_sequence_string,
        valx_sequence_string,
        x_w_sequence_string,
        xw_map_tb_sequence_string,
    ) = sequence_string_to_input(["x", "w"], num_inputs)

    if is_vector == 0:
        x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb = inputs_vector(
            bits,
            input_output_type,
            x_sequence_string,
            sx_sequence_string,
            valx_sequence_string,
            is_vector,
        )
        return (x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb)

    else:  # quando é em vetor
        x, sx, sx_tb, val_x, val_x_tb = inputs_vector(
            bits,
            input_output_type,
            x_sequence_string,
            sx_sequence_string,
            valx_sequence_string,
            is_vector,
        )
        return (x, sx, sx_tb, val_x, val_x_tb)


# %%
x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb = all_inputs_signals(
    num_inputs, bits, input_output_type, 0
)
print(x)
print(w)
print(sx)
print(sw)
print(sx_tb)
print(sw_tb)
print(val_x)
print(val_w)
print(val_x_tb)
print(val_w_tb)

# %%
# x,sx,sx_tb,val_x,val_x_tb = all_inputs_signals(num_inputs,bits,input_output_type,1)
# # print(x)
# # # print(w)
# # print(sx)
# # # print(sw)
# # print(sx_tb)
# # # print(sw_tb)
# # print(val_x)
# # # print(val_w)
# # print(val_x_tb)
# # # print(val_w_tb)
# x

# %%
# sx

# %% [markdown]
# ## <font color=red>**ROM**</font>

# %% [markdown]
# ### <font color=green>    **.vhd Names > ROM**    </font>

# %%
# ROM_name = f"ROM_fx_{2**bits}rows_{bits}bitaddr_{bits}width"
ROM_name = f"ROM_fx_{bits}bitaddr_{bits}width"

if print_cells_result == 1:
    print(ROM_name)

# %% [markdown]
# ### <font color=orange>**ROM > COMPONENT**</font>

# %%
input_mem_bits

# %%


def rom_component(ROM_name, input_mem_bits, output_mem_bits):
    ROM_component = f"""
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
	"""

    # print(ROM_component)
    return ROM_component


ROM_component = rom_component(ROM_name, input_mem_bits, output_mem_bits)
print(ROM_component)

# %% [markdown]
# ### <font color=orange>**ROM > PORT MAP**</font>

# %%


def port_map_ROM(ROM_name, input_mem_bits, output_mem_bits):
    PORT_MAP_ROM = f"""
	U_ROM : {ROM_name} PORT MAP(
		STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
		);
	-- input: address ({str(input_mem_bits)})
	-- output: data_out ({str(output_mem_bits)})  
	"""
    # print(PORT_MAP_ROM)
    return PORT_MAP_ROM


PORT_MAP_ROM = port_map_ROM(ROM_name, input_mem_bits, output_mem_bits)
print(PORT_MAP_ROM)

# %% [markdown]
# ## <font color=red>**Sum (MAC)**</font>

# %%
# MAC = Multiply and Accumulate (multiplica e acumula)

# %% [markdown]
# ### <font color=orange> **Sum (MAC)  > tree -> Combinacional (tree: árvore)** </font>

# %%
spacebar_1 = "  "
rst_space = "      "  # rst_receive (quando rst = '1')
clk_space = "        "  # quando clk = '1'

# %% [markdown]
# #### <font color=yellow> **Sum (MAC) > tree > Sequencias** </font>

# %%

log(num_inputs, 2)

# %%
# if (activ_fx_middle == 0): #_____________________COM LOOK UP TABLE________________________#
#   output_sum = ('''output: out STD_LOGIC_VECTOR(bits-1 DOWNTO 0) --output signal result \n ''')
#   sum_all_receive = ('sum_all<= signed(zero_middle_memory);\n')
# else:#______________________________SEM   MEMÓRIA____________________________________________#
#   output_sum = ('''output: out signed(bits-1 DOWNTO 0) --output signal result \n''')
#   sum_all_receive = ("sum_all<= (OTHERS => '0');\n")

output_sum = seq_input_output(
    ["output"], "OUT", input_output_type, bits, "string", "end"
)
output_sum

# %% [markdown]
# ##### <font color=#66FF00	> **Sum (MAC) > tree > Sequencias > Árvore de soma** </font>

# %%


def sum_mult_seq(num_inputs):
    sum_sequence = []
    mult_sequence = []

    # n=4 -> sum_all <= ((signed(sx1)*signed(sw1))+ (signed(sx2)*signed(sw2)) + (signed(sx3)*signed(sw3))+ (signed(sx4)*signed(sw4)) + signed(bias));

    for i in range(
        1, int(num_inputs) + 1
    ):  # árvore de somas + 1 pelo range que começa em 1
        sum_sequence.append("soma_" + str(i))
    # print (sum_sequence)

    for i in range(1, num_inputs + 1):
        mult_sequence.append("mult_" + str(i))
    # print (mult_sequence)

    sum_sequence_string = ", ".join(map(str, (sum_sequence)))
    mult_sequence_string = ", ".join(map(str, (mult_sequence)))
    sum_sequence_string = [sum_sequence_string]
    mult_sequence_string = [mult_sequence_string]
    return (sum_sequence_string, mult_sequence_string, sum_sequence, mult_sequence)


# sum_sequence_string, mult_sequence_string, sum_sequence, mult_sequence = sum_mult_seq(num_inputs)
# print (sum_sequence_string)
# print (mult_sequence_string)
# print (sum_sequence)
# print (mult_sequence)

# %%
# s_sum = "SIGNAL "+sum_sequence_string+": "+input_output_type+"("+str(2*bits)+"-1 DOWNTO 0); "
# s_mult = "SIGNAL "+mult_sequence_string+": "+input_output_type+"("+str(2*bits)+"-1 DOWNTO 0); "

# print(s_sum)
# print(s_mult)

# %%
# s_sum = seq_signal(sum_sequence_string,"SIGNAL",input_output_type,(2*bits))
# s_mult = seq_signal(mult_sequence_string,"SIGNAL",input_output_type,(2*bits))
# print(s_sum)
# print(s_mult)

# %%
# signal_receive = []

# for i in range(1,num_inputs+1):
# 	signal_receive.append("sx"+str(i)+" <= x"+str(i)+";")

# for i in range(1,num_inputs+1):
# 	signal_receive.append("sw"+str(i)+" <= w"+str(i)+";")

# signal_receive_string = '\n'.join(map(str, (signal_receive)))
# print(signal_receive_string)

# %%
def signal_receive_input(num_inputs, tab_space):
    signal_receive = []

    tab_space = 2
    tab_space = ["  "] * tab_space
    tab_space = "".join(map(str, tab_space))

    for i in range(1, num_inputs + 1):
        signal_receive.append(f"{tab_space}sx{str(i)} <= x{str(i)};")

    for i in range(1, num_inputs + 1):
        signal_receive.append(f"{tab_space}sw{str(i)} <= w{str(i)};")

    signal_receive_string = "\n".join(map(str, (signal_receive)))
    return signal_receive_string


# signal_receive_string = signal_receive_input(num_inputs,1)
# print(signal_receive_string)

# %%
# rst_receive = []
# rst_receive.append(rst_space + "output <= (OTHERS => '0');")

# for i in range(0,len(sum_sequence)):
#   rst_receive.append(rst_space + sum_sequence[i]+" <= (OTHERS => '0');")

# for i in  range(0,len(mult_sequence)):
#   rst_receive.append(rst_space + mult_sequence[i]+" <= (OTHERS => '0');")

# rst_receive_string = '\n'.join(map(str, (rst_receive)))
# print(rst_receive_string)

# %%
def signal_receive_rst(rst_space, sum_sequence, mult_sequence):
    rst_receive = []
    rst_receive.append(rst_space + "output <= (OTHERS => '0');")

    for i in range(0, len(sum_sequence)):
        rst_receive.append(
            rst_space + sum_sequence[i] + " <= (OTHERS => '0');")

    for i in range(0, len(mult_sequence)):
        rst_receive.append(
            rst_space + mult_sequence[i] + " <= (OTHERS => '0');")

    rst_receive_string = "\n".join(map(str, (rst_receive)))
    return rst_receive_string


# rst_receive_string = signal_receive_rst(rst_space, sum_sequence_string,mult_sequence_string)
# rst_receive_string = signal_receive_rst(rst_space, sum_sequence,mult_sequence)
# print(rst_receive_string)

# %%
def replace_chars(text):
    chars = "[]'"  # caracteres desejados para se substituir
    chars_subs = ""  # caracteres que serão colocados no lugar

    final_text = str(text).replace(chars[0:1], chars_subs)
    for c in chars:
        final_text = final_text.replace(c, chars_subs)
    return final_text


# %%
# last_sum_name = replace_chars(sum_sequence[-1:])
# last_sum_name

# %%
# clk_receive = []
# clk_receive.append(clk_space + "output <= " + input_output_type + "("+last_sum_name+"(("+str(bits+n_bin)+") - 1 DOWNTO ("+str(n_bin)+")));")

# for i in  range(0,len(mult_sequence)):
#   clk_receive.append(clk_space + mult_sequence[i]+" <= (" + input_output_type + "(sx"+str(i+1)+") * " + input_output_type + "(sw"+str(i+1)+"));")

#   # (signed(sx1) * signed(sw1));

# clk_receive_string = '\n'.join(map(str, (clk_receive)))
# print(clk_receive_string)

# %%
def clk_receive_logic(
    clk_space, input_output_type, bits, n_bin, sum_sequence, mult_sequence
):

    clk_receive = []

    last_sum_name = replace_chars(sum_sequence[-1:])
    last_sum_name
    clk_receive.append(
        f"{clk_space}output <= {input_output_type}({last_sum_name}({str(bits+n_bin - 1)} DOWNTO {str(n_bin)}));"
    )

    for i in range(0, len(mult_sequence)):
        clk_receive.append(
            f"{clk_space}{mult_sequence[i]} <= ({input_output_type}(sx{str(i+1)}) * {input_output_type}(sw{str(i+1)}));"
        )

        # (signed(sx1) * signed(sw1));

    clk_receive_string = "\n".join(map(str, (clk_receive)))
    return (clk_receive_string, clk_receive)


# clk_receive_string, clk_receive = clk_receive_logic(clk_space,input_output_type,bits,n_bin,mult_sequence)
# print(clk_receive_string)
# print(clk_receive)

# %%
# # ------------------------------------------------------ ÁRVORE DE SOMA ------------------------------------------------------ #
# import math
# from math import log

# sum_receive = []
# i_sum= 0
# i_sum_2 = 1
# i_mult = 0

# op_mult = len(mult_sequence)
# op_soma = len(sum_sequence) - 1

# for j in range(1, int( log(num_inputs,2)+1+1 )): #+1 bias +1 começa em 1

#   if (j == 1):
#   #-------------------- AQUI FAZ A SOMA DAS MULTIPLICAÇÕES -------------------#

#       # ----------------- ÁRVORE PAR -----------------#
#       for i in range(0,math.floor(num_inputs/2)):  #OP: SOMA <= MULT + MULT
#         sum_receive.append(clk_space + "soma_" + str(i+1) + " <=  mult_" + str(((2*i)+1)) +" + mult_" + str((2*i)+2) +";")

#         print(sum_receive[-1:])
#         i_sum = i_sum + 1

#         op_soma = op_soma - 1
#         op_mult = op_mult - 2

#   else:
#     # --------------------- AQUI FAZ A ÁRVORE DE SOMAS ---------------------#

#     while (op_soma > op_mult): #OP: SOMA <= SOMA + SOMA

#       i_sum = i_sum + 1
#       sum_receive.append(clk_space+"soma_"
#       + str( i_sum )
#       +" <=  soma_" + str( i_sum_2) + " + soma_"+ str( i_sum_2 + 1 ) +";")

#       # Luis Antonio Spader Simon - luisspaders@gmail.com
#       print(sum_receive[-1:])
#       i_sum_2 = i_sum_2 + 2

#       op_soma = op_soma - 1

# if ( op_mult > 0): #OP: SOMA <= SOMA + MULT

#   i = i + 1
#   i_sum = i_sum + 1
#   sum_receive.append(clk_space+"soma_"
#   + str( i_sum )
#   +" <=  soma_" + str( i_sum_2) + " + mult_"+ str( i_sum_2 + 2 ) +";")

#   print(sum_receive[-1:])

#   op_soma = op_soma - 1
#   op_mult = op_mult - 1

# # Luis Antonio Spader Simon - luisspaders@gmail.com


# %%
def tree_sum_algorithm(num_inputs, clk_space, sum_sequence, mult_sequence):
    # ------------------------------------------------------ ÁRVORE DE SOMA ------------------------------------------------------ #
    import math
    from math import log

    sum_receive = []
    i_sum = 0
    i_sum_2 = 1
    i_mult = 0

    op_mult = len(mult_sequence)
    op_soma = len(sum_sequence) - 1

    for j in range(1, int(log(num_inputs, 2) + 1 + 1)):  # +1 bias +1 começa em 1

        if j == 1:
            # -------------------- AQUI FAZ A SOMA DAS MULTIPLICAÇÕES -------------------#

            # ----------------- ÁRVORE PAR -----------------#
            for i in range(0, math.floor(num_inputs / 2)):  # OP: SOMA <= MULT + MULT
                sum_receive.append(
                    clk_space
                    + "soma_"
                    + str(i + 1)
                    + " <=  mult_"
                    + str(((2 * i) + 1))
                    + " + mult_"
                    + str((2 * i) + 2)
                    + ";"
                )

                # print(sum_receive[-1:])
                i_sum = i_sum + 1

                op_soma = op_soma - 1
                op_mult = op_mult - 2

        else:
            # --------------------- AQUI FAZ A ÁRVORE DE SOMAS ---------------------#

            while op_soma > op_mult:  # OP: SOMA <= SOMA + SOMA

                i_sum = i_sum + 1
                sum_receive.append(
                    clk_space
                    + "soma_"
                    + str(i_sum)
                    + " <=  soma_"
                    + str(i_sum_2)
                    + " + soma_"
                    + str(i_sum_2 + 1)
                    + ";"
                )

                # Luis Antonio Spader Simon - luisspaders@gmail.com
                # print(sum_receive[-1:])
                i_sum_2 = i_sum_2 + 2

                op_soma = op_soma - 1

    if op_mult > 0:  # OP: SOMA <= SOMA + MULT

        i = i + 1
        i_sum = i_sum + 1
        sum_receive.append(
            clk_space
            + "soma_"
            + str(i_sum)
            + " <=  soma_"
            + str(i_sum_2)
            + " + mult_"
            + str(i_sum_2 + 2)
            + ";"
        )

        print(sum_receive[-1:])

        op_soma = op_soma - 1
        op_mult = op_mult - 1

    # Luis Antonio Spader Simon - luisspaders@gmail.com
    return sum_receive


# sum_receive = tree_sum_algorithm(num_inputs,clk_space,sum_sequence,mult_sequence)

# sum_receive

# %%
# last_sum_name = replace_chars(sum_sequence[-1:])
# last_sum = last_sum_name+" <= "+ replace_chars(sum_sequence[-2:-1]) +" + sbias; \n"
# last_sum = str(last_sum)
# last_sum

# %%
# clk_receive_string = '\n'.join(map(str, (clk_receive + sum_receive)))  + "\n"

# clk_receive_string = clk_receive_string + clk_space + last_sum + "\n"
# print(clk_receive_string)

# %%
def arvore_de_soma_strings(
    num_inputs, bits, n_bin, input_output_type, rst_space, clk_space
):

    (
        sum_sequence_string,
        mult_sequence_string,
        sum_sequence,
        mult_sequence,
    ) = sum_mult_seq(num_inputs)
    # print (sum_sequence_string)
    # print (mult_sequence_string)
    # print (sum_sequence)
    # print (mult_sequence)

    s_sum = seq_signal(sum_sequence_string, "SIGNAL",
                       input_output_type, (2 * bits))
    s_mult = seq_signal(mult_sequence_string, "SIGNAL",
                        input_output_type, (2 * bits))
    # print(s_sum)
    # print(s_mult)

    signal_receive_string = signal_receive_input(num_inputs, 1)
    # print(signal_receive_string)

    rst_receive_string = signal_receive_rst(
        rst_space, sum_sequence, mult_sequence)
    # print(rst_receive_string)

    clk_receive_string, clk_receive = clk_receive_logic(
        clk_space, input_output_type, bits, n_bin, sum_sequence, mult_sequence
    )
    # print(clk_receive_string)

    sum_receive = tree_sum_algorithm(
        num_inputs, clk_space, sum_sequence, mult_sequence)
    last_sum_name = replace_chars(sum_sequence[-1:])
    last_sum = (
        last_sum_name + " <= " +
        replace_chars(sum_sequence[-2:-1]) + " + sbias; \n"
    )
    last_sum = str(last_sum)
    # last_sum
    clk_receive_string = "\n".join(
        map(str, (clk_receive + sum_receive))) + "\n"

    clk_receive_string = clk_receive_string + clk_space + last_sum + "\n"
    # print(clk_receive_string)

    s_sum = "\n".join(map(str, s_sum))
    s_mult = "\n".join(map(str, s_mult))

    return (
        s_sum,
        s_mult,
        signal_receive_string,
        rst_receive_string,
        clk_receive_string,
    )


(
    s_sum,
    s_mult,
    signal_receive_string,
    rst_receive_string,
    clk_receive_string,
) = arvore_de_soma_strings(
    num_inputs, bits, n_bin, input_output_type, rst_space, clk_space
)

if print_cells_result == 1:
    print(clk_receive_string)

# %%
# clk_receive_string = '\n'.join(map(str, (clk_receive_string + sum_receive)))  + "\n"

# clk_receive_string = clk_receive_string + clk_space + last_sum + "\n"
# print(clk_receive_string)

# %% [markdown]
# #### <font color=yellow> **Sum (MAC) > tree > Texto** </font>
#

# %%
if print_cells_result == 1:
    print(clk_receive_string)

# %% [markdown]
# ###### <font color=#66FF00	> **Sum (MAC) > tree > Texto > Com barreiras temporais** </font>

# %%
TXT_MAC = ""
Barriers = 1
if Barriers == 1:  # COM BARREIRA
    TXT_MAC = f"""
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
--use work.STD_DT.ALL;

ENTITY  {sum_name} IS
	--generic (input_bit:integer:= {str(bits -1)}; output_bit:integer:= {str(bits -1)};	 n_input:integer:={str(num_inputs)}); 
	PORT (
	clk, rst : IN STD_LOGIC;
	{x}
	{w}
	bias: IN {input_output_type}({str(bits -1)} DOWNTO 0) ; -- offset
	------------------------------------------
	{output_sum}
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 


ARCHITECTURE behavior of {sum_name} is
	SIGNAL sbias : {input_output_type}({str(bits -1)} DOWNTO 0);
	SIGNAL sum_all : signed( {str((2*bits) -1)} DOWNTO 0);
	{sx}
	{sw}
	{s_sum}
	{s_mult}

BEGIN
{signal_receive_string}
	sbias <= bias;

	--sum_all <= ((signed(sx1)*signed(sw1))+ (signed(sx2)*signed(sw2)) + (signed(sx3)*signed(sw3))+ (signed(sx4)*signed(sw4)) + signed(bias));

	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN 

	{rst_receive_string}

		ELSE
			IF (clk'event AND clk = '1') THEN --se tem evento de clock 

{clk_receive_string}

			END IF;
		END IF;
	END PROCESS;

END behavior;"""


# init_text = 0
# print(TXT_MAC[init_text : (init_text+2000) ]) #Separa em linhas
# print(TXT_MAC[init_text: ]) #Separa em linhas
print(TXT_MAC)

# %%
inputs_dict = {
    "STD_LOGIC": ["clk", "rst"],  #
    "STD_LOGIC_VECTOR": ["A", "B"],
    "STD_LOGIC_num_inputs": ["C", "D"],
    "STD_LOGIC_VECTOR_num_inputs": ["x", "w"],
}
inputs_dict

# %%


def INPUTS_STDL(inputs_dict, onerow):
    text = []
    if onerow == 1:  # tudo em uma linha
        for i in inputs_dict["STD_LOGIC"]:
            text.append(f"{i}")
        text = ", ".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of
        text = f"{text}: IN STD_LOGIC;"

    else:
        for i in inputs_dict["STD_LOGIC"]:
            text.append(f"{i}: IN STD_LOGIC;")
            # print(f"{i}: IN STD_LOGIC;\n")
            # print(i)
        text = "\n".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of texts

    return text


if print_cells_result == 1:
    print(INPUTS_STDL(inputs_dict, 1))

# %%


def INPUTS_STDL_V(inputs_dict, bits, onerow):
    text = []
    if onerow == 1:  # tudo em uma linha
        for i in inputs_dict["STD_LOGIC_VECTOR"]:
            text.append(f"{i}")
        text = ", ".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of
        text = f"{text}: IN STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);"

    else:
        for i in inputs_dict["STD_LOGIC_VECTOR"]:
            text.append(f"{i}: IN STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);")
            # print(f"{i}: IN STD_LOGIC;\n")
            # print(i)
        text = "\n".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of texts

    return text


if print_cells_result == 1:
    print(INPUTS_STDL_V(inputs_dict, bits, 1))

# %%
inputs_dict = {
    "STD_LOGIC": ["clk", "rst"],  #
    "STD_LOGIC_VECTOR": ["A", "B"],
    "STD_LOGIC_num_inputs": ["C", "D"],
    "STD_LOGIC_VECTOR_num_inputs": ["x", "w"],
}
inputs_dict

# %%
inputs_dict["STD_LOGIC_num_inputs"]

# %%
(
    x_sequence_string,
    sx_sequence_string,
    valx_sequence_string,
    x_w_sequence_string,
    xw_map_tb_sequence_string,
) = sequence_string_to_input(["x", "w"], num_inputs)
print(x_sequence_string)

# %%


def INPUTS_STD_num_inputs(inputs_dict, num_inputs, onerow):
    (
        x_sequence_string,
        sx_sequence_string,
        valx_sequence_string,
        x_w_sequence_string,
        xw_map_tb_sequence_string,
    ) = sequence_string_to_input(inputs_dict["STD_LOGIC_num_inputs"], num_inputs)

    text = []
    if onerow == 1:  # tudo em uma linha
        for i in x_sequence_string:
            text.append(f"{i}")
        text = ", ".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of
        text = f"{text}: IN STD_LOGIC;"

    else:
        for i in x_sequence_string:
            text.append(f"{i}: IN STD_LOGIC;")
            # print(f"{i}: IN STD_LOGIC;\n")
            # print(i)
        text = "\n".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of texts

    return text


if print_cells_result == 1:
    print(INPUTS_STD_num_inputs(inputs_dict, num_inputs, 0))

# %%


def INPUTS_STDL_V_num_inputs(inputs_dict, bits, onerow):
    (
        x_sequence_string,
        sx_sequence_string,
        valx_sequence_string,
        x_w_sequence_string,
        xw_map_tb_sequence_string,
    ) = sequence_string_to_input(inputs_dict["STD_LOGIC_VECTOR_num_inputs"], num_inputs)

    text = []
    if onerow == 1:  # tudo em uma linha
        for i in x_sequence_string:
            text.append(f"{i}")
        text = ", ".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of
        text = f"{text}: IN STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);"

    else:
        for i in x_sequence_string:
            text.append(f"{i}: IN STD_LOGIC_VECTOR({str(bits -1)} DOWNTO 0);")
            # print(f"{i}: IN STD_LOGIC;\n")
            # print(i)
        text = "\n".join(
            map(str, (text))
        )  # text_list can be an splitted text or a list of texts

    return text


if print_cells_result == 1:
    print(INPUTS_STDL_V_num_inputs(inputs_dict, bits, 0))

# %%


def INPUTS_ALL(inputs_dict, bits, num_inputs, onerow):
    stdl = INPUTS_STDL(inputs_dict, onerow)
    stdl_v = INPUTS_STDL_V(inputs_dict, bits, onerow)
    stdl_num_inputs = INPUTS_STD_num_inputs(inputs_dict, num_inputs, onerow)
    stdl_v_num_inputs = INPUTS_STDL_V_num_inputs(inputs_dict, bits, 0)

    text = [
        stdl,
        stdl_v,
        stdl_num_inputs,
        "----------------------------------------------",
        stdl_v_num_inputs,
    ]
    text = "\n".join(
        map(str, (text))
    )  # text_list can be an splitted text or a list of texts
    traço = "\n --".join(map(str, (inputs_dict.items())))
    return (text, traço)


inputs, traço = INPUTS_ALL(inputs_dict, bits, num_inputs, 1)

if print_cells_result == 1:
    print(inputs)
    print(traço)

# %%


def entity(
    name, bits, input_output_type, num_inputs, stdl_in, stdlv_in, stdl_out, stdlv_out
):
    txt = f"""
         ENTITY  {name} IS
	--generic (input_bit:integer:= {str(bits -1)}; output_bit:integer:= {str(bits -1)};	 n_input:integer:={str(num_inputs)}); 
	PORT (
	{inputs}
);-- clk, rst, inputs, weigths, bias, output
end ENTITY; 
         """


# %% [markdown]
# ###### <font color=#66FF00	> **Sum (MAC) > tree > Texto > Sem barreiras** </font>

# %%
# SOMATÓRIO -> operação de soma ponderada no sum.vhd
sum_all = []
i = 0

while True:
    if i == 0:
        sum_all.append(
            "sum_all <= (("
            + std_logic_conversion
            + "(sx"
            + str(i + 1)
            + ")*"
            + std_logic_conversion
            + "(sw"
            + str(i + 1)
            + "))+"
        )
        i = i + 1

    else:
        if i < num_inputs - 1:
            sum_all.append(
                "("
                + std_logic_conversion
                + "(sx"
                + str(i + 1)
                + ")*"
                + std_logic_conversion
                + "(sw"
                + str(i + 1)
                + "))+"
            )
            i = i + 1
        else:
            sum_all.append(
                "("
                + std_logic_conversion
                + "(sx"
                + str(i + 1)
                + ")*"
                + std_logic_conversion
                + "(sw"
                + str(i + 1)
                + "))+"
                + std_logic_conversion
                + "(sbias));"
            )
            i = 0
            break

sum_all_string = "\n".join(map(str, sum_all))

if print_cells_result == 1:
    print(sum_all_string)

# %%
space = "  "
signal_receive = []

for i in signal_receive_string.splitlines():
    signal_receive.append(space + i)
    # print(space + i)

signal_receive = "\n".join(map(str, signal_receive))
signal_receive_string = signal_receive

if print_cells_result == 1:
    print(signal_receive_string)

# %%
if Barriers == 0:  # SEM BARREIRA
    TXT_MAC = (
        """
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
--use work.STD_DT.ALL;

ENTITY  """
        + sum_name
        + """ IS
	--generic (input_bit:integer:="""
        + str(bits - 1)
        + """; output_bit:integer:="""
        + str(bits - 1)
        + """;	 n_input:integer:="""
        + str(num_inputs)
        + """); 
	PORT (
	clk, rst : IN STD_LOGIC;
	"""
        + x
        + """
	"""
        + w
        + """
	bias: IN """
        + input_output_type
        + """("""
        + str(bits - 1)
        + """ DOWNTO 0) ; -- offset
	------------------------------------------
	"""
        + output_sum
        + """
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 

ARCHITECTURE behavior of """
        + sum_name
        + """ is
	SIGNAL sbias : """
        + input_output_type
        + """("""
        + str(bits - 1)
        + """ DOWNTO 0);
	SIGNAL sum_all : signed("""
        + str((2 * bits) - 1)
        + """ DOWNTO 0);
	"""
        + sx
        + """
	"""
        + sw
        + """

BEGIN
"""
        "" + signal_receive_string + ""
        """
	sbias <= bias;
 
	"""
        + sum_all_string
        + """

	--sum_all <= ((signed(sx1) * signed(sw1)) + (signed(sx2) * signed(sw2)) + (signed(sx3) * signed(sw3)) + (signed(sx4) * signed(sw4)) + signed(bias));

	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
			output <= (OTHERS => '0');
		ELSE
			IF (clk'event AND clk = '1') THEN --se tem evento de clock 
				output <= sum_all("""
        + str((2 * n_bin) - 1)
        + """ DOWNTO ("""
        + str(n_bin)
        + """));

			END IF;
		END IF;
	END PROCESS;

END behavior;

"""
    )
if print_cells_result == 1:
    print(TXT_MAC)

# %% [markdown]
# #### <font color=yellow> **Sum (MAC) > tree > Imprimindo texto** </font>

# %%
# init_text = 0
# print(TXT_MAC[init_text : (init_text+2000) ]) #Separa em linhas
# print(TXT_MAC[init_text: ]) #Separa em linhas
# print(TXT_MAC)

# %%
f"{path_ReLU}/{sum_name}.vhd"

# %%
with open(f"{path_ReLU}/{sum_name}.vhd", "w") as writer:
    writer.write(TXT_MAC)

# %%
# text_file = open(sum_name+".txt", "w")
# text_file.write(sum_text)
# text_file.close()

# text_file = open(sum_name+".vhd", "w")
# text_file.write(sum_text)
# text_file.close()

if download_vhd == 1:  # ---------------- VHD ----------------#
    # ReLU
    with open(f"{path_ReLU}/{sum_name}.vhd", "w") as writer:
        writer.write(TXT_MAC)

    # Leaky ReLU
    with open(f"{path_LeakyReLU}/{sum_name}.vhd", "w") as writer:
        writer.write(TXT_MAC)

    # SOFTMAX
    with open(f"{path_soft}/{sum_name}.vhd", "w") as writer:
        writer.write(TXT_MAC)

if download_txt == 1:  # ---------------- TEXTO ----------------#
    # ReLU
    with open(f"{path_ReLU}/{sum_name}.txt", "w") as writer:
        writer.write(TXT_MAC)

    # Leaky ReLU
    with open(f"{path_LeakyReLU}/{sum_name}.txt", "w") as writer:
        writer.write(TXT_MAC)

    # SOFTMAX
    with open(f"{path_soft}/{sum_name}.txt", "w") as writer:
        writer.write(TXT_MAC)

# %% [markdown]
# #### <font color=yellow> **Sum (MAC) > tree > Component** </font>

# %%
MAC_component = f"""
	COMPONENT {str(sum_name)} IS
	PORT (
		clk, rst : IN STD_LOGIC;
		{x}
 		{w}
		bias: IN {input_output_type}({str(bits -1)} DOWNTO 0) ; -- offset 
		------------------------------------------ 
		{output_sum}
	); -- clk, rst, inputs, weigths, bias, output
	END COMPONENT;                            
"""
if print_cells_result == 1:
    print(MAC_component)

# %% [markdown]
# #### <font color=yellow> **Sum (MAC) > PORT MAP** </font>

# %%
reg_x_sequence = []
reg_w_sequence = []

reg_x_sequence_string = []
reg_w_sequence_string = []

i = 0

while True:
    if i < num_inputs:
        # reg_xi e reg_wi
        reg_x_sequence.append("reg_x" + str(i + 1))
        reg_w_sequence.append("reg_w" + str(i + 1))
        print()
        i = i + 1

    else:
        i = 0
        break

reg_x_sequence_string = ", ".join(map(str, (reg_x_sequence)))
reg_w_sequence_string = ", ".join(map(str, (reg_w_sequence)))

reg_x_sequence_string = reg_x_sequence_string + ","
reg_w_sequence_string = reg_w_sequence_string + ","


# https://stackoverflow.com/questions/15478127/remove-final-character-from-string
# reg_xi e reg_wi

s_reg_x = (
    "SIGNAL "
    + reg_x_sequence_string[:-1]
    + ": "
    + input_output_type
    + "("
    + str(bits - 1)
    + " DOWNTO 0); "
)

s_reg_w = (
    "SIGNAL "
    + reg_w_sequence_string[:-1]
    + ": "
    + input_output_type
    + "("
    + str(bits - 1)
    + " DOWNTO 0); "
)

if print_cells_result == 1:
    print(reg_x_sequence_string)
    print(reg_w_sequence_string)
    print(s_reg_x)
    print(s_reg_w)

# %%
PORT_MAP_MAC = (
    """
	-- MAC ja registra a saida \n"""
    "	U_MAC : " + str(sum_name) + " PORT MAP("
    """
		clk, rst, \n"""
    "	    	" + reg_x_sequence_string + "\n"
    " 	   	" + reg_w_sequence_string + " \n"
    "		reg_bias, \n"
    "		out_reg_MAC);"
)
print(PORT_MAP_MAC)

# %%


# %% [markdown]
# ### <font color=orange> **Sum (MAC)  > seq -> Sequencial (multiciclo)** </font>

# %% [markdown]
# #### <font color=66FF00> **Basics** </font>

# %% [markdown]
# ##### <font color=1ECE03> **Adder** </font>

# %%
name_adder = "adder_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_adder

# %%
txt_adder = (
    """
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
"""
    "ENTITY " + name_adder + " is "
    """
port(
		"""
    "a,b: IN signed(" + str(2 * bits) + "-1 DOWNTO 0); --inputs"
    """
		output: OUT signed("""
    + str(2 * bits)
    + """-1 DOWNTO 0) --output result 
);
END ENTITY;
"""
    "ARCHITECTURE behavior of " + name_adder + " is \n"
    "SIGNAL sa,sb: signed(" + str(2 * bits) + "-1 DOWNTO 0); "
    """

begin 

 sa<=(a);
 sb<=(b);

end behavior; 
             """
)
# print(txt_adder)

# %%
# print(txt_adder)

# %% [markdown]
# ##### <font color=1ECE03> **Mult** </font>

# %%
name_mult = "mult_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_mult

# %%
txt_mult = (
    """
LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_1164.ALL;
USE work.STD_DT.ALL;

ENTITY """
    + name_mult
    + """ IS
	PORT (
		x, w : IN signed("""
    + str(bits - 1)
    + """ DOWNTO 0); --inputs
		output : OUT signed("""
    + str(2 * bits - 1)
    + """ DOWNTO 0) -- mult_out
	); --x,w,resultado
END ENTITY;

ARCHITECTURE behavior OF """
    + name_mult
    + """ IS
	SIGNAL sx, sw : signed("""
    + str(bits - 1)
    + """ DOWNTO 0); --SIGNAL 

BEGIN
	sx <= (x);
	sw <= (w);

	output <= ((signed(sx) * signed(sw)));

END behavior;
             """
)
print(txt_mult)

# %%
# print(txt_mult)

# %% [markdown]
# ##### <font color=1ECE03> **Mux 2 -> 1** </font>

# %%
name_mux_2_1 = "mux_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_mux_2_1

# %%
txt_mux_2_1 = (
    """
LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_1164.ALL;
USE work.STD_DT.ALL;

ENTITY """
    + name_mux_2_1
    + """ IS
     PORT (
          a, b : IN signed("""
    + str(bits - 1)
    + """ DOWNTO 0);
          sel : IN STD_LOGIC;
          y : OUT signed("""
    + str(bits - 1)
    + """ DOWNTO 0)
     );--a,b,sel,output
END ENTITY;

ARCHITECTURE behavior OF """
    + name_mux_2_1
    + """ IS
BEGIN
     WITH sel SELECT
          y <= a WHEN '0',
          b WHEN OTHERS;
END behavior;               
               """
)
# print(txt_mux_2_1)

# %%
# print(txt_mux_2_1)

# %% [markdown]
# ##### <font color=1ECE03> **Mux 2 -> 1 x2** </font>

# %%
name_mux_2_1_2x = "mux_2_1_" + str(bits) + "bit"  # + str(num_inputs) +"input"
name_mux_2_1_2x

# %%
txt_mux_2_1_2x = (
    """
LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_1164.ALL;
USE work.STD_DT.ALL;

ENTITY """
    + name_mux_2_1_2x
    + """ IS
     PORT (
          a, b : IN signed(("""
    + str(2 * bits - 1)
    + """) DOWNTO 0);
          sel : IN STD_LOGIC;
          y : OUT signed(("""
    + str(2 * bits - 1)
    + """) DOWNTO 0)
     );--a,b,sel,output
END ENTITY;

ARCHITECTURE behavior OF """
    + name_mux_2_1_2x
    + """ IS
BEGIN
     WITH sel SELECT
          y <= a WHEN '0',
          b WHEN OTHERS;
END behavior;               
               """
)
# print(txt_mux_2_1_2x)

# %%
# print(txt_mux_2_1_2x)

# %% [markdown]
# ##### <font color=1ECE03> **Mux 4 -> 1** </font>

# %%
name_mux_4_1 = "mux_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_mux_4_1

# %%
states_mux = math.ceil(log(num_inputs, 2))
states_mux

# %%


# %%
txt_mux_4_1 = (
    """
LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_1164.ALL;
USE work.STD_DT.ALL;

ENTITY """
    + name_mult
    + """ IS
	PORT (
		a, b, c, d : IN signed("""
    + str(bits - 1)
    + """ DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR("""
    + str(states_mux - 1)
    + """ DOWNTO 0);
		y : OUT signed("""
    + str(bits - 1)
    + """ DOWNTO 0)); --a,b,c,d,sel,y
END ENTITY;

ARCHITECTURE comportamento OF """
    + name_mult
    + """ IS
	SIGNAL reg_y : signed("""
    + str(bits - 1)
    + """ DOWNTO 0);
BEGIN
	--process(rst,clk,a,b,c,d,bias) 
	PROCESS (sel, a, b, c, d)
	BEGIN

		CASE sel IS
			WHEN "00" => --estado de rst
				reg_y <= a;
			WHEN "01" => --estado de rst
				reg_y <= b;
			WHEN "10" => --estado de rst
				reg_y <= c;
			WHEN "11" => --estado de rst
				reg_y <= d;

			WHEN OTHERS => reg_y <= (OTHERS => '0');

		END CASE;
	END PROCESS;

	y <= reg_y;
END comportamento;               
               """
)
# print(txt_mux_4_1)

# %%
# print(txt_mux_4_1)

# %% [markdown]
# ##### NAME

# %%
name_NAME = "NAME_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_NAME

# %%
txt_NAME = """
               
               """
print(txt_NAME)

# %% [markdown]
# ##### NAME

# %%
name_NAME = "NAME_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_NAME

# %%
txt_NAME = """
               
               """
print(txt_NAME)

# %% [markdown]
# ##### NAME

# %%
name_NAME = "NAME_" + str(bits) + "bit_" + str(num_inputs) + "input"
name_NAME

# %%
txt_NAME = """
               
               """
print(txt_NAME)

# %% [markdown]
# #### <font color=66FF00> **Sum (MAC)  > seq > Sequencias** </font>

# %%


# %% [markdown]
# ##### Sum (MAC)  > seq > Texto

# %%
# MAC_seq_text = ('''LIBRARY ieee;
# USE ieee.std_logic_1164.ALL;
# USE ieee.std_logic_unsigned.ALL;
# USE ieee.numeric_std.ALL;
# USE ieee.math_real.ALL;
# --use work.STD_DT.ALL;
# '''
# "ENTITY  "+sum_name+" IS " '''
# 	--generic (input_bit:integer:=8; output_bit:integer:=8;	 n_input:integer:=3);
# 	PORT (
# 	clk, rst  : IN STD_LOGIC;'''
# '	\n'
# '	'+x+''
# ' 	'+w+''
# "	bias: IN "+input_output_type+"(" +str(bits -1)+ " DOWNTO 0) ; -- offset \n"
# "	------------------------------------------ \n"
# '	'+output_sum+''
# ");"
# '''
# -- clk, rst,
# -- inputs,
# -- weigths,
# -- bias,
# -- output
# end ENTITY;

# '''
# "ARCHITECTURE behavior of "+sum_name+" is\n"
# "	SIGNAL sbias : signed(8 - 1 DOWNTO 0); "
# '	'+sx+''
# ' 	'+sw+' '
# ' '+s_sum+''
# ' 	'+s_mult+''
# '''
# BEGIN \n'''
# ""+signal_receive_string+""
# "\n	sbias <= bias; \n"
# '''
#  	--sum_all <= ((signed(sx1)*signed(sw1))+ (signed(sx2)*signed(sw2)) + (signed(sx3)*signed(sw3))+ (signed(sx4)*signed(sw4)) + signed(bias));

# 	PROCESS (rst, clk)
# 	BEGIN
# 		IF (rst = '1') THEN \n'''

# ""+rst_receive_string+" \n"
# '''
#  		ELSE
#  			IF (clk'event AND clk = '1') THEN --se tem evento de clock
# '''
# ""+clk_receive_string+""

# 			# output <= (OTHERS => '0');

# 			# mult_1 <= (OTHERS => '0');
# 			# mult_2 <= (OTHERS => '0');
# 			# mult_3 <= (OTHERS => '0');
# 			# mult_4 <= (OTHERS => '0');

# 			# soma_1 <= (OTHERS => '0');
# 			# soma_2 <= (OTHERS => '0');
# 			# sum_all <= (OTHERS => '0');

# # 		ELSE
# # 			IF (clk'event AND clk = '1') THEN --se tem evento de clock
# # 				output <= sum_all((11) - 1 DOWNTO (3));

# # 				mult_1 <= (signed(sx1) * signed(sw1));
# # 				mult_2 <= (signed(sx2) * signed(sw2));
# # 				mult_3 <= (signed(sx3) * signed(sw3));
# # 				mult_4 <= (signed(sx4) * signed(sw4));

# # 				soma_1 <= mult_1 + mult_2;
# # 				soma_2 <= mult_3 + mult_4;
# # 				sum_all <= soma_1 + soma_2;
# '''
# 			END IF;
# 		END IF;
# 	END PROCESS;

# END behavior;'''
# )

# init_text = 0
# print(MAC_seq_text[init_text : (init_text+2000) ]) #Separa em linhas
# # print(MAC_seq_text[init_text: ]) #Separa em linhas
# # print(MAC_seq_text)

# %% [markdown]
# ##### Sum (MAC)  > seq > Imprimindo texto

# %%


# %% [markdown]
# ##### Sum (MAC)  > seq > Component

# %%


# %% [markdown]
# ##### Sum (MAC)  > seq > PORT MAP

# %%


# %% [markdown]
# ## <font color=red>**Top Neuronio**</font>

# %%
rst_space = "      "  # rst_receive (quando rst = '1')
clk_space = "        "  # quando clk = '1'

# %% [markdown]
# ### <font color=orange> **Top Neuronio > tree** </font>

# %% [markdown]
# #### <font color=yellow> **Top Neuronio > tree > Sequencias** </font>

# %%
num_inputs

# %%
# reg_x_sequence = []
# reg_w_sequence = []

# reg_x_sequence_string = []
# reg_w_sequence_string = []

# i= 0

# while True:
#   if (i < num_inputs):
#     #reg_xi e reg_wi
#     reg_x_sequence.append("reg_x"+str(i+1))
#     reg_w_sequence.append("reg_w"+str(i+1))
#     print()
#     i= i+1

#   else:
#     i= 0
#     break

# reg_x_sequence_string   = ', '.join(map(str, (reg_x_sequence)))
# reg_w_sequence_string   = ', '.join(map(str, (reg_w_sequence)))

# #https://stackoverflow.com/questions/15478127/remove-final-character-from-string
# ##reg_xi e reg_wi

# s_reg_x = "SIGNAL "+reg_x_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

# s_reg_w = "SIGNAL "+reg_w_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

# print(s_reg_x,s_reg_w)

# %%
rst_receive = []
rst_receive.append(rst_space + "reg_out_ROM_act <= (OTHERS => '0');")
rst_receive.append("")

for i in range(0, len(reg_x_sequence)):
    rst_receive.append(rst_space + reg_x_sequence[i] + " <= (OTHERS => '0');")

rst_receive.append("")

for i in range(0, len(reg_w_sequence)):
    rst_receive.append(rst_space + reg_w_sequence[i] + " <= (OTHERS => '0');")

rst_receive_string = "\n".join(map(str, (rst_receive)))
rst_receive_string = (
    rst_receive_string + "\n" + rst_space + "reg_bias <= (OTHERS => '0');"
)
# print(rst_receive_string)

# %%
x

# %%
x_sequence = input_sequences("x", num_inputs, "list", 0, 0)
x_sequence

# %%
clk_receive = []
clk_receive.append(
    clk_space[:-2] + "reg_out_ROM_act <=  signed(out_ROM_act); ")
clk_receive.append(clk_space + "IF update_weights = '0' THEN ")


for i in range(0, len(reg_x_sequence)):
    clk_receive.append(
        clk_space + "  " + reg_x_sequence[i] + " <= " + x_sequence[i] + ";"
    )

clk_receive.append("")
clk_receive.append(clk_space + "ELSE")


for i in range(0, len(reg_w_sequence)):
    clk_receive.append(
        clk_space + "  " + reg_w_sequence[i] + " <= " + x_sequence[i] + ";"
    )
clk_receive.append("")

clk_receive.append(clk_space + "END IF;")


clk_receive_string = "\n".join(map(str, (clk_receive)))
clk_receive_string = clk_receive_string + \
    "\n" + clk_space + "reg_bias <= bias;"

print(clk_receive_string)

# %%
# print(rst_receive_string)

# %% [markdown]
# #### <font color=yellow>**Top Neuronio > tree > NEURON_SOFT_INPUT_NET**</font>

# %%
NEURON_SOFT_INPUT_NET = (
    """
	PROCESS (clk, rst, update_weights)
	BEGIN
		IF rst = '1' THEN \n"""
    "" + rst_receive_string + " \n"
    """
		ELSIF clk'event AND clk = '1' THEN
"""
    "" + clk_receive_string + ""
    """

		END IF;
	END PROCESS;
"""
)
print(NEURON_SOFT_INPUT_NET)

# %% [markdown]
# #### <font color=yellow>**Top Neuronio > tree > NEURON_ReLU_INPUT_NET**</font>

# %%
rst_receive_string_middle = "\n".join(rst_receive_string.splitlines()[2:])
# rst_receive_string_middle = rst_space + "y <= (OTHERS => '0'); \n" + rst_receive_string_middle

# print(rst_receive_string_middle)

# %%
clk_receive_string_middle = "\n".join(clk_receive_string.splitlines()[1:])
# clk_receive_string_middle = clk_space + mux_LeakyReLU + clk_receive_string_middle

print(clk_receive_string_middle)

# %%
mux_ReLU = """
			IF out_reg_MAC > 0 THEN
				y <= out_reg_MAC;
			ELSE
				y <= (OTHERS => '0');
			END IF;
"""
# print(mux_LeakyReLU)

# %%
NEURON_ReLU_INPUT_NET = (
    """
	PROCESS (clk, rst, update_weights)
	BEGIN
		IF rst = '1' THEN \n"""
    "" + rst_receive_string_middle + " \n"
    """
		ELSIF clk'event AND clk = '1' THEN
"""
    + mux_ReLU
    + ""
    + clk_receive_string_middle
    + ""
    """
		END IF;
	END PROCESS;
"""
)

print(NEURON_ReLU_INPUT_NET)

# %% [markdown]
# #### <font color=yellow>**Top Neuronio > tree > NEURON_LeakyReLU_INPUT_NET**</font>

# %%
ones_leaky = str(np.ones(leaky_attenuation))
ones_leaky = ones_leaky.replace(".", "")
ones_leaky = ones_leaky.replace("[", "")
ones_leaky = ones_leaky.replace("]", "")
ones_leaky = ones_leaky.replace(" ", "")
ones_leaky

# %%
mux_LeakyReLU = f"""
			IF out_reg_MAC > 0 THEN
				y <= out_reg_MAC;
			ELSE
				y <=  {ones_leaky} & out_reg_MAC(
     {str(bits -1)}  DOWNTO {str(leaky_attenuation)});
			END IF;
"""
# print(mux_LeakyReLU)

# %%
NEURON_LeakyReLU_INPUT_NET = f"""
	PROCESS (clk, rst, update_weights)
	BEGIN
		IF rst = '1' THEN \n

{rst_receive_string_middle}

		ELSIF clk'event AND clk = '1' THEN
 {mux_LeakyReLU} 
{clk_receive_string_middle}

		END IF;
	END PROCESS;
"""

print(NEURON_LeakyReLU_INPUT_NET)

# %% [markdown]
# #### <font color=yellow> **Top Neuronio > tree > Função neuronio (não foi feita)** </font>

# %%
# rst_space = "     " #rst_receive (quando rst = '1')
# clk_space = "      " #quando clk = '1'

# def Funcao_Neuronio (num_inputs,) {

#   #------------------------------ reg_xi e reg_wi ---------------------#
#   reg_x_sequence = []
#   reg_w_sequence = []

#   reg_x_sequence_string = []
#   reg_w_sequence_string = []

#   i= 0

#   while True:
#     if (i < num_inputs):
#       #reg_xi e reg_wi
#       reg_x_sequence.append("reg_x"+str(i+1))
#       reg_w_sequence.append("reg_w"+str(i+1))
#       print()
#       i= i+1

#     else:
#       i= 0
#       break

#   reg_x_sequence_string   = ', '.join(map(str, (reg_x_sequence)))
#   reg_w_sequence_string   = ', '.join(map(str, (reg_w_sequence)))

#   #https://stackoverflow.com/questions/15478127/remove-final-character-from-string
#   ##reg_xi e reg_wi

#   s_reg_x = "SIGNAL "+reg_x_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

#   s_reg_w = "SIGNAL "+reg_w_sequence_string+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

#   #------------------------------ rst Xi Wi SEQUENCE ---------------------#
#   rst_receive = []
#   rst_receive.append(rst_space + "reg_out_rom_act <= (OTHERS => '0');")
#   rst_receive.append("")

#   for i in range(0,len(reg_x_sequence)):
#     rst_receive.append(rst_space + reg_x_sequence[i]+" <= (OTHERS => '0');")

#   rst_receive.append("")

#   for i in  range(0,len(reg_w_sequence)):
#     rst_receive.append(rst_space + reg_w_sequence[i]+" <= (OTHERS => '0');")

#   rst_receive_string = '\n'.join(map(str, (rst_receive)))
#   rst_receive_string =  (rst_receive_string + "\n" +
#                           rst_space + "reg_bias <= (OTHERS => '0');")
#   #------------------------------ CLK Xi Wi SEQUENCE ---------------------#

#   clk_receive = []
#   clk_receive.append( clk_space + "reg_out_rom_act <=  signed(out_rom_act); ")
#   clk_receive.append("")

#   for i in range(0,len(reg_x_sequence)):
#     clk_receive.append(clk_space + reg_x_sequence[i]+" <= " +  x_sequence[i]  + ";")

#   clk_receive.append("")

#   for i in  range(0,len(reg_w_sequence)):
#     clk_receive.append(clk_space + reg_w_sequence[i]+" <= " +  x_sequence[i]  + ";")

#   clk_receive_string = '\n'.join(map(str, (clk_receive)))
#   clk_receive_string =  (clk_receive_string + "\n" +
#                           clk_space + "reg_bias <= bias;")


#   NEURON_SOFT_INPUT_NET = ('''
#     PROCESS (clk, rst)
#     BEGIN
#       IF rst = '1' THEN \n'''

#   ""+rst_receive_string+" \n"
#   '''
#       ELSIF clk'event AND clk = '1' THEN
#   '''
#   ""+clk_receive_string+""
#   '''

#         END IF;
#       END PROCESS;
#   ''')


#   return (NEURON_SOFT_INPUT_NET)
# }

# %% [markdown]
# #### <font color=yellow> **Top Neuronio > tree > Texto** </font>

# %% [markdown]
# ##### <font color=lime> **Top Neuronio > tree > Texto > Softmax** </font>

# %%
print(MAC_component)

# %%
top_neuron_soft_txt = (
    """LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

"""
    "ENTITY  " + neuron_Sigmoid + " IS \n"
    "	-- GENERIC ( \n"
    " -- 	input_bit:integer:="
    + str(bits)
    + "; output_bit:integer:="
    + str(bits)
    + ";	 n_input:integer:="
    + str(num_inputs)
    + "\n"
    "	-- );"
    """
	PORT (
	clk, rst, update_weights : IN STD_LOGIC;"""
    "	\n"
    "	" + x + "\n"
    "-- 	" + w + "\n"
    "	bias: IN " + input_output_type +
    "(" + str(bits - 1) + " DOWNTO 0) ; -- offset \n"
    "	------------------------------------------ \n"
    " 	y: OUT "
    + input_output_type
    + "("
    + str(bits - 1)
    + " DOWNTO 0) --output  result"
    """
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 

"""
    "ARCHITECTURE behavior of " + neuron_Sigmoid + " is		\n"
    "" + MAC_component + ""
    "" + ROM_component + ""
    "\n"
    "	SIGNAL out_reg_MAC : "
    + input_output_type
    + "(("
    + str(bits - 1)
    + ") DOWNTO 0);	--reg da saida do MAC	\n"
    # "	SIGNAL out_reg_MAC : STD_LOGIC_VECTOR(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"
    "	SIGNAL out_ROM_act : STD_LOGIC_VECTOR("
    + str(bits - 1)
    + " DOWNTO 0); --saida da ROM		\n"
    "	SIGNAL reg_out_ROM_act : "
    + input_output_type
    + "("
    + str(bits)
    + " - 1 DOWNTO 0); --reg saida da ROM		\n"
    "	" + s_reg_x + ""
    " 	" + s_reg_w + " "
    "	SIGNAL reg_bias : " + input_output_type + \
    "(" + str(bits - 1) + " DOWNTO 0); "
    """
 BEGIN \n"""
    "	" + PORT_MAP_MAC + "\n"
    "	" + PORT_MAP_ROM + "\n"
    "	" + NEURON_SOFT_INPUT_NET + "\n"
    ""
    " 	y <= " + input_output_type + "(reg_out_ROM_act);"
    "\n"
    "END behavior;"
)

# init_text = 1450
# print(top_neuron_soft_txt[init_text : (init_text+2000) ]) #Separa em linhas
# print(top_neuron_soft_txt[init_text: ]) #Separa em linhas
print(top_neuron_soft_txt)

# %% [markdown]
# ##### <font color=lime> **Top Neuronio > tree > Texto > Middle NN** </font>

# %% [markdown]
# ###### <font color=00FFE6> **Top Neuronio > tree > Texto > Middle NN > ReLU** </font>

# %%
top_neuron_ReLU_txt = (
    """LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

"""
    "ENTITY  " + neuron_ReLU_name + " IS \n"
    "	-- GENERIC ( \n"
    " -- 	input_bit:integer:="
    + str(bits)
    + "; output_bit:integer:="
    + str(bits)
    + ";	 n_input:integer:="
    + str(num_inputs)
    + "\n"
    "	-- );"
    """
	PORT (
	clk, rst, update_weights : IN STD_LOGIC;"""
    "	\n"
    "	" + x + "\n"
    "-- 	" + w + "\n"
    "	bias: IN " + input_output_type +
    "(" + str(bits - 1) + " DOWNTO 0) ; -- offset \n"
    "	------------------------------------------ \n"
    " 	y: OUT "
    + input_output_type
    + "("
    + str(bits - 1)
    + " DOWNTO 0) --output  result"
    """
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 

"""
    "ARCHITECTURE behavior of " + neuron_ReLU_name + " is		\n"
    "" + MAC_component + ""
    # '' + ROM_component + ''
    "\n"
    "	SIGNAL out_reg_MAC : "
    + input_output_type
    + "(("
    + str(bits - 1)
    + ") DOWNTO 0);	--reg da saida do MAC	\n"
    # "	SIGNAL out_reg_MAC : STD_LOGIC_VECTOR(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"
    "	" + s_reg_x + ""
    " 	" + s_reg_w + " "
    "	SIGNAL reg_bias : " + input_output_type + \
    "(" + str(bits - 1) + " DOWNTO 0); "
    """

 BEGIN \n"""
    "	" + PORT_MAP_MAC + "\n"
    # '	' + PORT_MAP_ROM + '\n'
    "	" + NEURON_ReLU_INPUT_NET + "\n"
    """
END behavior;"""
)

# init_text = 1450
# print(top_neuron_ReLU_txt[init_text : (init_text+2000) ]) #Separa em linhas
# print(top_neuron_ReLU_txt[init_text: ]) #Separa em linhas
print(top_neuron_ReLU_txt)

# %% [markdown]
# ###### <font color=00FFE6> **Top Neuronio > tree > Texto > Middle NN > Leaky ReLU** </font>

# %%
# leaky_shift_text = ('')
# for i in range(0,leaky_attenuation):
#   leaky_shift_text = leaky_shift_text + "sum_result(bits-1) & "
# leaky_shift_text

# %%
top_neuron_Leaky_txt = (
    """LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

"""
    "ENTITY  " + neuron_Leaky_name + " IS \n"
    "	-- GENERIC ( \n"
    " -- 	input_bit:integer:="
    + str(bits)
    + "; output_bit:integer:="
    + str(bits)
    + ";	 n_input:integer:="
    + str(num_inputs)
    + "\n"
    "	-- );"
    """
	PORT (
	clk, rst, update_weights : IN STD_LOGIC;"""
    "	\n"
    "	" + x + "\n"
    "-- 	" + w + "\n"
    "	bias: IN " + input_output_type +
    "(" + str(bits - 1) + " DOWNTO 0) ; -- offset \n"
    "	------------------------------------------ \n"
    " 	y: OUT "
    + input_output_type
    + "("
    + str(bits - 1)
    + " DOWNTO 0) --output  result"
    """
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 

"""
    "ARCHITECTURE behavior of " + neuron_Leaky_name + " is		\n"
    "" + MAC_component + ""
    # '' + ROM_component + ''
    "\n"
    "	SIGNAL out_reg_MAC : "
    + input_output_type
    + "(("
    + str(bits - 1)
    + ") DOWNTO 0);	--reg da saida do MAC	\n"
    # "	SIGNAL out_reg_MAC : STD_LOGIC_VECTOR(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"
    "	" + s_reg_x + ""
    " 	" + s_reg_w + " "
    "	SIGNAL reg_bias : " + input_output_type + \
    "(" + str(bits - 1) + " DOWNTO 0); "
    """

 BEGIN \n"""
    "	" + PORT_MAP_MAC + "\n"
    # '	' + PORT_MAP_ROM + '\n'
    "	" + NEURON_LeakyReLU_INPUT_NET + "\n"
    """
END behavior;"""
)

# init_text = 1450
# print(top_neuron_Leaky_txt[init_text : (init_text+2000) ]) #Separa em linhas
# print(top_neuron_Leaky_txt[init_text: ]) #Separa em linhas
print(top_neuron_Leaky_txt)

# %% [markdown]
# #### <font color=yellow> **Top Neuronio > tree > Imprimindo texto** </font>

# %%
# init_text = 1450
# print(top_neuron_soft_txt[init_text : (init_text+2000) ]) #Separa em linhas
# print(top_neuron_soft_txt)

# %%
# ---------------- VHD ----------------#
if download_vhd == 1:
    # ReLU
    with open(f"{path_ReLU}/{neuron_ReLU_name}.vhd", "w") as writer:
        writer.write(top_neuron_ReLU_txt)

    # Leaky ReLU
    with open(f"{path_LeakyReLU}/{neuron_Leaky_name}.vhd", "w") as writer:
        writer.write(top_neuron_Leaky_txt)

    # SOFTMAX
    with open(f"{path_soft}/{neuron_Sigmoid}.vhd", "w") as writer:
        writer.write(top_neuron_soft_txt)

# ---------------- TEXTO ----------------#
if download_txt == 1:
    # ReLU
    with open(f"{path_ReLU}/{neuron_ReLU_name}.txt", "w") as writer:
        writer.write(top_neuron_ReLU_txt)

    # Leaky ReLU
    with open(f"{path_LeakyReLU}/{neuron_Leaky_name}.txt", "w") as writer:
        writer.write(top_neuron_Leaky_txt)

    # SOFTMAX
    with open(f"{path_soft}/{neuron_Sigmoid}.txt", "w") as writer:
        writer.write(top_neuron_soft_txt)

# %% [markdown]
# ### <font color=orange> **Top Neuronio > seq -> Sequencial (multiciclo)** </font>

# %%


# %% [markdown]
# ## <font color=red>**Testbench neuronio**</font>

# %% [markdown]
# # New section

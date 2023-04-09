# sourcery skip: avoid-builtin-shadow
from fxpmath import Fxp
import copy
import math
import os
import numpy as np
whole_dir = os.path.abspath(".")

REVERSE_WEIGHTS = False
BIAS_ENDING = True  # if True, bias is at the end of the shift_registers
# ---------------- treating layers_array ----------------


# layers_array = np.array()
layers_array = []

# path = "models/model_conversion/arrays/"
path = "models/model_conversion/mini/arrays"  # 64inp -> 4 3 2 3 4 64
path_log = "models/model_conversion/mini/logs"
listdir = sorted(os.listdir(path))


# array of layer_arrays
for i in range(0, len(listdir), 2):
    print(f"{listdir[i]}, {listdir[i+1]}")
    layers_array.append(
        [np.load(f"{path}/{listdir[i]}"), np.load(f"{path}/{listdir[i+1]}")])  # [bias, weights]

# layers_array = [
#     [bias_array, weights_array], # layer0
#     [bias_array, weights_array], # layer1
#     [bias_array, weights_array], # layer2
#     ...
# ]


# ---------------- treating weights_list ----------------
def flatten_weights(layers_array):
    """
    Converts a list of nested arrays of weights to a flattened list of weights.
    Each weight in the nested arrays is represented as a list with a single element.

    Args:
    - weights_array: a list of nested arrays of weights

    Returns:
    - flattened_weights: a list of weights flattened from the nested arrays
    """

    # Convert 1-item arrays to lists of 1 item
    for l, layer in enumerate(layers_array):
        layers_array[l][1] = layers_array[l][1].tolist()

    # Flatten list of weights by removing nested arrays
    #  removing list of 1 item to be just the item (made on weights_array)
    for l, layer in enumerate(layers_array):
        for n, neuron in enumerate(layer[1]):
            flat_list = []
            for weight in neuron:
                flat_list.append(weight[0])
            layers_array[l][1][n] = flat_list


def save_file(path_log, neurons, file_name="neurons.py"):
    with open(f"{path_log}/{file_name}", "w") as writer:
        writer.write(f"{file_name.split('.')[0]} = ")
        writer.write(str(neurons))


flatten_weights(layers_array)


def new_func(layers_array, path_log, save_file):
    # create a deepcopy of layers_array to not change the original
    layers_array_copy = copy.deepcopy(layers_array)

    #  separating bias and weights by layers[neuron_0, neuron_1, ...]
    neurons = []
    for l, layer in enumerate(layers_array_copy):
        n = 0
        neurons_layer = []

    # check if a numpy array is empty
    # https://stackoverflow.com/questions/53501376/how-to-check-if-a-numpy-array-is-empty
        while np.size(layer[0]):
            neurons_layer.append([f'layer{l}_n{n}', layer[0][0], layer[1][0]])
            n += 1
            layers_array_copy[l][0] = np.delete(layers_array_copy[l][0], 0)
            layers_array_copy[l][1] = layers_array_copy[l][1][1:]

        neurons.append(neurons_layer)

    # save neurons to a python file
    save_file(path_log, neurons)
    return neurons


neurons = new_func(layers_array, path_log, save_file)


def neurons_list_gen_save(layers_array, path_log):
    """
    Separates the bias and weights of each neuron in the given layers array,
    saves them to a python file, and returns a list of the neurons.

    Args:
    - layers_array: a list of tuples representing the bias and weights of each neuron in each layer
    - path_log: a string representing the file path where the neurons will be saved
    - save_file: a function that saves an object to a file

    Returns:
    - neurons: a list of lists, where each nested list contains a neuron's name, bias, and weights
        neurons = [
                    [
                        ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
                        ['layer0_n1', 0.17614965, [...]],
                        ['layer0_n2', 0.8049891, [...]],
                        ['layer0_n3', 0.38902378, [...]]
                    ],
                    [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
                    [[...], [...]],                         # 'layer2_n0', bias, [weights]
                    [[...], [...], [...]],
                    [[...], [...], [...], [...]],
                    [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
                ]
    """

    # Create a deep copy of layers_array to avoid changing the original
    layers_array_copy = copy.deepcopy(layers_array)

    # Separate bias and weights by layers[neuron_0, neuron_1, ...]
    neurons = []
    for l, layer in enumerate(layers_array_copy):
        n = 0
        neurons_layer = []

        # Check if a numpy array is empty
        while np.size(layer[0]):
            neurons_layer.append([f'layer{l}_n{n}', layer[0][0], layer[1][0]])
            n += 1
            layers_array_copy[l][0] = np.delete(layers_array_copy[l][0], 0)
            layers_array_copy[l][1] = layers_array_copy[l][1][1:]

        neurons.append(neurons_layer)

    # Save neurons to a python file
    save_file(path_log, neurons, file_name="neurons.py")

    return neurons

# neurons = [
#     [
#         ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
#         ['layer0_n1', 0.17614965, [...]],
#         ['layer0_n2', 0.8049891, [...]],
#         ['layer0_n3', 0.38902378, [...]]
#     ],
#     [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
#     [[...], [...]],                         # 'layer2_n0', bias, [weights]
#     [[...], [...], [...]],
#     [[...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
# ]


# -------------------------------------------------
# getting max number of neurons in a layer from all NN layers
neurons_number_max = 0
for l, layer in enumerate(layers_array):
    if len(layer[0]) > neurons_number_max:
        neurons_number_max = len(layer[0])

# joining together neurons with same index (ex: neuron_0 'n0')
neurons_joined_PortMap_structure = []
for n in range(0, neurons_number_max):
    neurons_joined = []

    for l, layer in enumerate(neurons):
        if len(layer) > n:
            neurons_joined.append(layer[n])

    neurons_joined_PortMap_structure.append(neurons_joined)

print("neurons_joined done")

# neurons_joined_PortMap_structure = [
#     [['layer0_n0', -0.12465311, [-0.006545105017721653, ...]],
#      ['layer1_n0', -0.098881, [0.12465202808380127, ...]],
#      ['layer2_n0', -0.00024540332, [0.43135038018226624, ...]],
#      ['layer3_n0', -0.0042404337, [0.6779475212097168, ...]],
#      ['layer4_n0', 0.0, [-0.9987852573394775, ...]],
#      ['layer5_n0', -0.18265386, [0.24596863985061646, ...]]
#      ],
#     [['layer0_n1', 0.17614965, [0.0708584263920784, ...]],
#      ['layer1_n1', 0.30869168, [0.17154280841350555, ...]],
#      [...],
#      [...],
#      [...],
#      [...]
#      ],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...]],
#     ...
# ]
# -------------------------------------------------
# getting max number of neurons in a layer from all NN layers
max_number_of_layers = 0
for n, neuron_level in enumerate(neurons_joined_PortMap_structure):
    if len(neuron_level) > max_number_of_layers:
        max_number_of_layers = len(neuron_level)

# creating 1 ghost neuron for each layer
ghost_neuron_models = []
layers_num_sequence = []
for l, layer in enumerate(neurons):
    ghost_neuron_models.append([f'layer{l}_model', 0, [0] * len(layer[0][2])])
    layers_num_sequence.append(l)


# Adding ghost neurons layers with less neurons
neurons_with_ghosts = copy.deepcopy(neurons_joined_PortMap_structure)
for level, neuron_level in enumerate(neurons_with_ghosts):
    neuron_level_length = len(neuron_level)

    if neuron_level_length < max_number_of_layers:
        # discovering which layer has no neurons in neuron_level
        remove_list = []
        for n, neuron in enumerate(neuron_level):
            # get the layer number from neuron name
            layer_num = int(neuron[0].split('_')[0].replace('layer', ''))
            remove_list.append(layer_num)

        layers_without_neuron_list = list(
            set(layers_num_sequence) - set(remove_list))

        # adding ghost neurons to neuron_level
        I = max_number_of_layers - neuron_level_length
        for i in range(I):
            neurons_with_ghosts[level].append(
                ghost_neuron_models[layers_without_neuron_list[i]])
print("ghosts done")

# neurons_with_ghosts = [
#     [
#         ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
#         ['layer0_n1', 0.17614965, [...]],
#         ['layer0_n2', 0.8049891, [...]],
#         ['layer0_n3', 0.38902378, [...]],
#         ['layer0_n4', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]], # ghost
#         ['layer0_n5', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]], # ghost
#         ...
#     ],
#     [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
#     [[...], [...]],                         # 'layer2_n0', bias, [weights]
#     [[...], [...], [...]],
#     [[...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
# ]

# ----------------------------------------------------------------
# transforming PM_matrix to a list of lists (without the layer name, only the weights and bias)
PM_matrix_list = []
for neuron_level in neurons_with_ghosts:
    PM_matrix_neuron = []

    # for neuron in neuron_level:
    for n in range(len(neuron_level)-1, -1, -1):
        # inverse order, because the last layer is the first to be passed the values on the FPGA
        PM_matrix_neuron.append(neuron_level[n])
    PM_matrix_list.append(PM_matrix_neuron)

# PM_matrix_list = [
#     [[-0.18265386, [0.24596863985061646, ...]],   # layer5_n0
#      [0.0, [-0.9987852573394775, ...]],           # layer4_n0
#      [-0.0042404337, [0.6779475212097168,...]],   # layer3_n0
#      [...],                                       # layer2_n0
#      [...],                                       # layer1_n0
#      [...]],                                      # layer0_n0
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     ...
#     ]
# ----------------------------------------------------------------
# transforming PM_matrix_list sublists to have bias and weights in the same list
PM_matrix_list2 = []
for neuron_level in PM_matrix_list:
    PM_matrix_neuron = []
    for neuron in neuron_level:

        weights = neuron[2]
        if REVERSE_WEIGHTS:
            weights = neuron[2].reverse()  # reverse the weights list

        # if BIAS_ENDING == True, bias is at the end of the shift_registers (passed first to the FPGA)
        if BIAS_ENDING:
            bias_weights = copy.deepcopy(weights)
            # add bias to the beginning of the weights list = ending of 'shift registers'
            bias_weights.insert(0, neuron[1])
            PM_matrix_neuron.append([neuron[0], bias_weights])
            # ! attention: if you need to insert the bias in the beginning of the list, use the above code
        else:
            # ! attention: if you need to insert the bias in the end of the list, use the below code
            weights_bias = copy.deepcopy(weights)  # weights
            # add bias to the end of the weights list
            weights_bias.insert(len(weights_bias), neuron[1])
            PM_matrix_neuron.append([neuron[0], weights_bias])

    PM_matrix_list2.append(PM_matrix_neuron)

# save PM_matrix_list2 to a python file
with open(f"{path_log}/PM_matrix_list2.py", "w") as writer:
    writer.write("PM_matrix_list2 = \n")
    writer.write(str(PM_matrix_list2))

print("PM_matrix_list2: done")

# PM_matrix_list2 = [
#     [ # neuron 0
#         ['layer5_n0', [...]], # [bias, weights] float list
#         ['layer4_n0', [...]],
#         ['layer3_n0', [...]],
#         ['layer2_n0', [...]],
#         ['layer1_n0', [...]]
#     ],
#     [[...], [...], [...], [...], [...]],  # neuron 1
#     [[...], [...], [...], [...], [...]],  # neuron 2
#     [[...], [...], [...], [...], [...]],  # neuron 3
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     ...
# ]
# ----------------------------------------------------------------
# Creating a binary list of lists with the weights and bias of each neuron
BIT_WIDTH = 8
is_signed = True
#         #   0  1  2  3  4  5  6  7  8  9
# num_list = [3, 2, 1, 32, 4, 15, 21, 0, 61, 12]
fractional = BIT_WIDTH - 1

if is_signed:
    rescale = 2**(BIT_WIDTH-1)
else:
    rescale = 2**(BIT_WIDTH)

PM_matrix_bin = copy.deepcopy(PM_matrix_list2)


with open(f"{path_log}/weights_bin_log.txt", "w") as writer:

    for neuron_level in PM_matrix_bin:
        writer.write(
            f" ===================== NEURON LEVEL {neuron_level[0][0][-1:]} ===================== \n")
        for neuron in neuron_level:
            writer.write(
                f" ----------------------- {neuron[0]} ----------------------- \n")
            # write in a new line of text file

            weights_bias_list = []
            for item in neuron[1]:
                weights_bias_list.append(
                    Fxp(item, signed=is_signed, n_word=BIT_WIDTH, n_frac=fractional).bin())
                # print in a text file the code line below

                writer.write(
                    f"{str(item).ljust(20, ' ')} -> {str(item * rescale).ljust(20, ' ')}:     {Fxp(item, signed=is_signed, n_word=BIT_WIDTH, n_frac=fractional).bin()} \n")
            writer.write('\n')
            neuron[1] = weights_bias_list
        writer.write('\n')


# save PM_matrix_bin to a python file
with open(f"{path_log}/PM_matrix_bin.py", "w") as writer:
    writer.write("PM_matrix_bin = \n")
    writer.write(str(PM_matrix_bin))

print("PM_matrix_bin: done")

# PM_matrix_bin = [
#     [ # neuron 0
#         ['layer5_n0', ['11101001', ...]], # [bias, weights] bin list
#         ['layer4_n0', [...]],
#         ['layer3_n0', [...]],
#         ['layer2_n0', [...]],
#         ['layer1_n0', [...]]
#     ],
#     [[...], [...], [...], [...], [...]],  # neuron 1
#     [[...], [...], [...], [...], [...]],  # neuron 2
#     [[...], [...], [...], [...], [...]],  # neuron 3
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     [[...], [...], [...], [...], [...]],
#     ...
# ]
# ----------------------------------------------------------------
neurons_bin = copy.deepcopy(neurons)
for layer in neurons_bin:

    for neuron in layer:

        weights_bias_list = []
        neuron[1] = Fxp(neuron[1], signed=is_signed,
                        n_word=BIT_WIDTH, n_frac=fractional).bin()
        for item in neuron[2]:
            weights_bias_list.append(
                Fxp(item, signed=is_signed, n_word=BIT_WIDTH, n_frac=fractional).bin())
            # print in a text file the code line below

        neuron[2] = weights_bias_list
# save neurons_bin to a python file
with open(f"{path_log}/neurons_bin.py", "w") as writer:
    writer.write("neurons_bin = ")
    writer.write(str(neurons_bin))

# ----------------------------------------------------------------
# Creating a binary list of lists with the just the weights and bias of each neuron
PM_matrix_to_testbench = []
for neuron_level in PM_matrix_bin:
    level_list = []
    for neuron in neuron_level:
        # level_list.extend(neuron)
        level_list.extend(neuron[1])
    PM_matrix_to_testbench.append(level_list)

print("PM_matrix_to_testbench: done")

# write PM_matrix_to_testbench to a text file
save_path = "models/model_conversion/mini/testbench"

with open(f"{save_path}/weights_bin.txt", "w") as writer:
    for i in range(len(PM_matrix_to_testbench[0])):  # width range
        for n, neuron_level in enumerate(PM_matrix_to_testbench):
            writer.write(f"{neuron_level[i]} ")
            #     writer.write(f"{neuron} ")
        writer.write("\n")


with open(f"{save_path}/weights_bin_log.txt", "w") as writer:
    for i in range(len(PM_matrix_to_testbench[0])):  # width range
        for n, neuron_level in enumerate(PM_matrix_to_testbench):
            writer.write(str(f"it{i}_n{n}").ljust(
                8, ' ') + f":{neuron_level[i]}  ")
            #     writer.write(f"{neuron} ")
        writer.write("\n")

# ----------------------------------------------------------------
# saving weights_bin.txt to the NNs folder
whole_dir = os.getcwd()
NN_save_path = f"{whole_dir}/NNs/NN_6Layers_8bits_4_3_2_3_4_64/tb_Files"
with open(f"{NN_save_path}/weights_bin.txt", "w") as writer:
    for i in range(len(PM_matrix_to_testbench[0])):  # width range
        for n, neuron_level in enumerate(PM_matrix_to_testbench):
            writer.write(f"{neuron_level[i]} ")
            #     writer.write(f"{neuron} ")
        writer.write("\n")

print("weights_bin.txt: done")

# # write each item on a new line in a text file
# with open(f"{path}/weights_layer_{l}.txt", "w") as writer:
#     for neuron_level in PM_matrix_bin:
#         for neuron in neuron_level:
#             writer.write(f"{neuron[0]}: {neuron[1]}

# for item in num_list:
#     print(f"{item}:     {Fxp(item, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin()}")
# ----------------------------------------------------------------
# with open(f'{path}/arrays/weights_layer_{l}.txt', "w") as writer:
#     # writer.write(str(weights_bias_list))

#     for weight_bias in weights_bias_list:
#         for item in weight_bias:

#             # write each item on a new line
#             writer.write("%s\n" % item)
# Save dict to a file

# with open(f"{path}/dicts/{layer_dict['class_name']}_{l}.json", "w") as f:
#     json.dump(layer_dict, f, cls=NumpyFloatValuesEncoder)
# print(
#     f"tf_to_dict() -> Creating : {path}/dicts/{layer_dict['class_name']}_{l}.json")

# if layer_dict['class_name'] == 'QDense' or layer_dict['class_name'] == 'Dense':
#     # is QDense or Dense
#     with open(f"{path}/dicts/{layer_dict['class_name']}_{l}.json", "w") as f:
#         json.dump(layer_dict, f, cls=NumpyFloatValuesEncoder)
#         # json.dump(layer_dict, f)
# else:
#     # is not QDense
#     with open(f"{path}/dicts/{layer_dict['class_name']}_{l}.json", "w") as f:
#         json.dump(layer_dict, f)

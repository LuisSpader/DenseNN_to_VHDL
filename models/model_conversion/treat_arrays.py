# sourcery skip: avoid-builtin-shadow
from fxpmath import Fxp
import copy
import math
import os
import numpy as np
whole_dir = os.path.abspath(".")

REVERSE_WEIGHTS = False
BIAS_FIRST = False
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

print('----------------------')
# print(layers_array[0])

# ---------------- treating weights_list ----------------
# weights_list is made of 1_item_arrays -> so this method pass it to be a list of 1 item
for l, layer in enumerate(layers_array):
    layers_array[l][1] = layers_array[l][1].tolist()

#  removing list of 1 item to be just the item (made on weights_array)
for l, layer in enumerate(layers_array):
    for n, neuron in enumerate(layer[1]):
        flat_list = []
        for weight in neuron:
            flat_list.append(weight[0])
        layers_array[l][1][n] = flat_list
        # layers_array[l][1][n].tolist()


# create a deepcopy of layers_array to not change the original
layers_array_copy = copy.deepcopy(layers_array)

#  separating bias and weights by layers[neuron_0, neuron_1, ...]
neurons = []
for l, layer in enumerate(layers_array_copy):
    n = 0

    neurons_layer = []
    # check if a numpy array is empty
    # https://stackoverflow.com/questions/53501376/how-to-check-if-a-numpy-array-is-empty
    # while layer[0][1] != []:
    while np.size(layer[0]):
        neurons_layer.append([f'layer{l}_n{n}', layer[0][0], layer[1][0]])
        n += 1

        layers_array_copy[l][0] = np.delete(layers_array_copy[l][0], 0)
        # np.delete(layers_array_copy[l][1], 0)
        layers_array_copy[l][1] = layers_array_copy[l][1][1:]
        # layer[0] = layer[0][1:]
        # layer[1] = layer[1][1:]
        # del layer[0][0]
        # del layer[1][0]
    # for b_w in layer:
    #     neurons.append(b_w[0].tolist())
    neurons.append(neurons_layer)

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
max = 0
# getting max
for l, layer in enumerate(layers_array):
    if len(layer[0]) > max:
        max = len(layer[0])
# Adding ghost neurons layers with less neurons
neurons_with_ghosts = copy.deepcopy(neurons)
for l, layer in enumerate(neurons_with_ghosts):
    if len(layer) < max:
        layer_length = len(layer)
        N = max - layer_length
        for n in range(N):
            neurons_with_ghosts[l].append(
                [f'layer{l}_n{layer_length + n}', 0, [0] * len(layer[0][2])])
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

# -------------------------------------------------
# joining together neurons with same index (ex: neuron_0 'n0')
neurons_joined_PortMap_structure = []
for n in range(0, max):
    neurons_joined = []

    for l, layer in enumerate(neurons_with_ghosts):
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

# ----------------------------------------------------------------
# transforming PM_matrix to a list of lists (without the layer name, only the weights and bias)
PM_matrix_list = []
for neuron_level in neurons_joined_PortMap_structure:
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
        if BIAS_FIRST:
            weights_bias = weights
            # add bias to the beginning of the weights list
            weights_bias.insert(0, neuron[1])
            PM_matrix_neuron.append([neuron[0], weights_bias])
            # ! attention: if you need to insert the bias in the beginning of the list, use the above code
        else:
            # ! attention: if you need to insert the bias in the end of the list, use the below code
            bias_weights = weights  # weights
            # add bias to the end of the weights list
            bias_weights.insert(len(bias_weights), neuron[1])
            PM_matrix_neuron.append([neuron[0], bias_weights])

    PM_matrix_list2.append(PM_matrix_neuron)


print("PM_matrix_list2: done")

# PM_matrix_list2 = [
#     [
#         ['layer5_n0', [...]],
#         ['layer4_n0', [...]],
#         ['layer3_n0', [...]],
#         ['layer2_n0', [...]],
#         ['layer1_n0', [...]]
#     ],
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

print("PM_matrix_bin: done")

PM_matrix_to_testbench = []
for neuron_level in PM_matrix_bin:
    level_list = []
    for neuron in neuron_level:
        # level_list.extend(neuron)
        level_list.extend(neuron[1])
    PM_matrix_to_testbench.append(level_list)

print("PM_matrix_to_testbench: done")

# write PM_matrix_to_testbench to a text file
with open(f"models/model_conversion/mini/testbench/weights_bin.txt", "w") as writer:
    for i in range(len(PM_matrix_to_testbench[0])):  # width range
        for n, neuron_level in enumerate(PM_matrix_to_testbench):
            writer.write(f"{neuron_level[i]} ")
            #     writer.write(f"{neuron} ")
        writer.write("\n")

with open(f"models/model_conversion/mini/testbench/weights_bin_log.txt", "w") as writer:
    for i in range(len(PM_matrix_to_testbench[0])):  # width range
        for n, neuron_level in enumerate(PM_matrix_to_testbench):
            writer.write(str(f"it{i}_n{n}").ljust(
                8, ' ') + f":{neuron_level[i]}  ")
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

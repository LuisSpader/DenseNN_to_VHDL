# sourcery skip: avoid-builtin-shadow
from os import listdir
from fxpmath import Fxp
import copy
import math
import os
import numpy as np


# ---------------- Functions ----------------
def process_file(filename):
    """
    Reads the content of a Python file, performs specific string replacements to format
    the content, and saves the updated content back to the same file.

    Args:
        filename (str): The path to the input Python file.

    Raises:
        FileNotFoundError: If the input file does not exist or is inaccessible.
        PermissionError: If the user does not have the necessary permissions to read or write the file.
    """
    with open(filename, 'r') as file:
        content = file.read()

    content = content.replace("[[['", "[\n\t[\n\t['")
    content = content.replace("]], ['", "]],\n\t\t['")
    content = content.replace("]]], [['", "]]\n\t], \n\t[\n\t\t['")
    content = content.replace("]]]]", "]]\n\t]\n]")

    with open(filename, 'w') as file:
        file.write(content)

# Usage
# filename = 'filename.py'
# process_file(filename)


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
    # creath path_log if not exists
    if not os.path.exists(path_log):
        os.makedirs(path_log)
    with open(f"{path_log}/{file_name}", "w") as writer:
        writer.write(f"{file_name.split('.')[0]} = ")
        writer.write(str(neurons))
    process_file(f"{path_log}/{file_name}")


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


def join_neurons_by_index(layers_array, neurons):
    """
    Joins together neurons with the same index (e.g. neuron_0 'n0') from each layer of a neural network
    and returns them as a list of lists.

    Args:
    - layers_array: a list of tuples representing the bias and weights of each neuron in each layer
    - neurons: a list of lists, where each nested list contains a neuron's name, bias, and weights

    Returns:
    - neurons_joined_PortMap_structure: a list of lists, where each nested list contains neurons with the same index
    neurons_joined_PortMap_structure = [
        [   
            ['layer0_n0', -0.12465311, [-0.006545105017721653, ...]],
            ['layer1_n0', -0.098881, [0.12465202808380127, ...]],
            ['layer2_n0', -0.00024540332, [0.43135038018226624, ...]],
            ['layer3_n0', -0.0042404337, [0.6779475212097168, ...]],
            ['layer4_n0', 0.0, [-0.9987852573394775, ...]],
            ['layer5_n0', -0.18265386, [0.24596863985061646, ...]]
        ],
        [
            ['layer0_n1', 0.17614965, [0.0708584263920784, ...]],
            ['layer1_n1', 0.30869168, [0.17154280841350555, ...]],
            [...],
            [...],
            [...],
            [...]
        ],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...]],
        ...
    ]
    """

    # Getting the maximum number of neurons in a layer from all neural network layers
    neurons_number_max = 0
    for layer in layers_array:
        if len(layer[0]) > neurons_number_max:
            neurons_number_max = len(layer[0])

    # Joining together neurons with the same index
    neurons_joined_PortMap_structure = []
    for n in range(neurons_number_max):
        neurons_joined = [layer[n] for layer in neurons if len(layer) > n]
        neurons_joined_PortMap_structure.append(neurons_joined)

    return neurons_joined_PortMap_structure


def create_ghost_neurons(neurons):

    # ghost_neuron_models = [
    # ['layer0_model', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],
    # ['layer1_model', 0, [0, 0, 0, 0]],
    # ['layer2_model', 0, [0, 0, 0]],
    # ['layer3_model', 0, [0, 0]],
    # ['layer4_model', 0, [0, 0, 0]],
    # ['layer5_model', 0, [0, 0, 0, 0]]
    # ]
    # creating 1 ghost neuron for each layer
    ghost_neuron_models = []

    # sequence of layers numbers -> used to know which layer will need ghost neurons
    layers_num_sequence = []

    for l, layer in enumerate(neurons):
        ghost_neuron_models.append(
            [f'layer{l}_model', 0, [0] * len(layer[0][2])])
        layers_num_sequence.append(l)
    return ghost_neuron_models, layers_num_sequence


def add_ghost_neurons(neurons_joined, max_num_layers, ghost_neuron_models, layer_num_sequence):
    """Add ghost neurons to layers with fewer neurons.

    Args:
        neurons_joined (list): List of neurons joined together based on their index.
        max_num_layers (int): Maximum number of neurons in a layer from all NN layers.
        ghost_neuron_models (list): List of ghost neurons to add to layers with fewer neurons.
        layer_num_sequence (list): List of layer numbers in sequence.

    Returns:
        list: List of neurons with added ghost neurons.
        neurons_with_ghosts = \ 
    [
        [
            ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
            ['layer0_n1', 0.17614965, [...]],
            ['layer0_n2', 0.8049891, [...]],
            ['layer0_n3', 0.38902378, [...]],
            ['layer0_n4', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],  # ghost
            ['layer0_n5', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],  # ghost
            ...
        ],
        [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
        [
            ['layer0_n2', 0.8049891, [...]],    # 'layer2_n0', bias, [weights]
            ['layer1_n2', 0.14208536, [...]],
            ['layer3_n2', 0.0, [...]],
            ['layer4_n2', 0.0060660695, [...]],
            ['layer5_n2', 0.025634281, [...]],
            ['layer2_model', 0, [...]]          # ghost !!
        ],
        [[...], [...], [...]],
        [[...], [...], [...], [...]],
        [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
    ]
    """

    # Creating a deep copy of the list to avoid modifying the original.
    neurons_with_ghosts = copy.deepcopy(neurons_joined)

    # Adding ghost neurons to layers with fewer neurons.
    for level, neuron_level in enumerate(neurons_with_ghosts):
        neuron_level_length = len(neuron_level)

        if neuron_level_length < max_num_layers:
            # Discovering which layer has no neurons in neuron_level.
            remove_list = []
            for n, neuron in enumerate(neuron_level):
                # Get the layer number from neuron name.
                layer_num = int(neuron[0].split('_')[0].replace('layer', ''))
                remove_list.append(layer_num)

            layers_without_neuron_list = list(
                set(layer_num_sequence) - set(remove_list))

            # Adding ghost neurons to neuron_level.
            I = max_num_layers - neuron_level_length
            for i in range(I):
                neurons_with_ghosts[level].append(
                    ghost_neuron_models[layers_without_neuron_list[i]])

    return neurons_with_ghosts


def convert_neuron_structure_to_PM_matrix(neurons_with_ghosts):
    """
    Converts a neuron structure to a PM (Port Mapping) matrix.

    Args:
    - neurons_with_ghosts: list of lists of neurons with ghost neurons added

    Returns:
    - PM_matrix_list: list of lists representing the PM matrix
        PM_matrix_list = [
        [
            [-0.18265386, [0.24596863985061646, ...]],      # layer5_n0
            [0.0, [-0.9987852573394775, ...]],              # layer4_n0
            [-0.0042404337, [0.6779475212097168,...]],      # layer3_n0
            [...],                                          # layer2_n0
            [...],                                          # layer1_n0
            [...]                                           # layer0_n0
        ],                                         
        [[...], [...], [...], [...], [...]],                # next neuron
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        ...
        ]
    """

    # transforming neurons_with_ghosts to a list of lists (without the layer name, only the weights and bias)
    PM_matrix_list = []
    for neuron_level in neurons_with_ghosts:
        PM_matrix_neuron = []

        # inverse order, because the last layer is the first to be passed the values on the FPGA
        for n in range(len(neuron_level)-1, -1, -1):
            PM_matrix_neuron.append(neuron_level[n])
        PM_matrix_list.append(PM_matrix_neuron)

    return PM_matrix_list

# def prepare_PM_matrix(REVERSE_WEIGHTS, BIAS_ENDING, path_log, PM_matrix_list):
#     PM_matrix_list2 = []
#     for neuron_level in PM_matrix_list:
#         PM_matrix_neuron = []
#         for neuron in neuron_level:
#             weights = neuron[2]
#             if REVERSE_WEIGHTS:
#                 weights = neuron[2].reverse()  # reverse the weights list

#         # if BIAS_ENDING == True, bias is at the end of the shift_registers (passed first to the FPGA)
#             if BIAS_ENDING:
#                 bias_weights = copy.deepcopy(weights)
#             # add bias to the beginning of the weights list = ending of 'shift registers'
#                 bias_weights.insert(0, neuron[1])
#                 PM_matrix_neuron.append([neuron[0], bias_weights])
#             # ! attention: if you need to insert the bias in the beginning of the list, use the above code
#             else:
#                 # ! attention: if you need to insert the bias in the end of the list, use the below code
#                 weights_bias = copy.deepcopy(weights)  # weights
#             # add bias to the end of the weights list
#                 weights_bias.insert(len(weights_bias), neuron[1])
#                 PM_matrix_neuron.append([neuron[0], weights_bias])

#         PM_matrix_list2.append(PM_matrix_neuron)

#     # save PM_matrix_list2 to a python file
#     save_file(path_log, PM_matrix_list2, file_name="PM_matrix_list2.py")
#     return PM_matrix_list2


def prepare_PM_matrix(REVERSE_WEIGHTS: bool, BIAS_ENDING: bool, path_log: str, PM_matrix_list: list) -> list:
    """
    Transform the PM_matrix to a list of lists (weights and bias on same sublist).

    Args:
    - REVERSE_WEIGHTS: boolean indicating whether to reverse the weights list.
    - BIAS_ENDING: boolean indicating whether to place bias at the end of the shift_registers.
    - path_log: string representing the file path to save the transformed PM_matrix.
    - PM_matrix_list(List[List[Tuple[str, float, List[float]]]]): list of lists of tuples representing the PM_matrix.

    Returns:
    - PM_matrix_list2: list of lists of tuples representing the transformed PM_matrix.
    PM_matrix_list2 = \
    [
        [ # neuron 0
            ['layer5_n0', [...]], # [bias, weights] float list
            ['layer4_n0', [...]],
            ['layer3_n0', [...]],
            ['layer2_n0', [...]],
            ['layer1_n0', [...]]
        ],
        [[...], [...], [...], [...], [...]],  # neuron 1
        [[...], [...], [...], [...], [...]],  # neuron 2
        [[...], [...], [...], [...], [...]],  # neuron 3
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        ...
    ]
    """

    PM_matrix_list2 = []
    for neuron_level in PM_matrix_list:
        PM_matrix_neuron = []
        for neuron in neuron_level:
            weights = neuron[2]
            if REVERSE_WEIGHTS:
                weights = neuron[2][::-1]  # reverse the weights list

            # ! if BIAS_ENDING == True, bias is at the end of the shift_registers (passed first to the FPGA)
            if BIAS_ENDING:
                # If bias comes at the end, append the bias to the end of the weights list
                # add bias to the beginning of the weights list = ending of 'shift registers'
                bias_weights = copy.deepcopy(weights)
                bias_weights.append(neuron[1])
                PM_matrix_neuron.append([neuron[0], bias_weights])
            else:
                # If bias comes at the beginning, insert the bias at the beginning of the weights list
                weights_bias = copy.deepcopy(weights)
                # add bias to the end of the weights list
                weights_bias.insert(0, neuron[1])
                PM_matrix_neuron.append([neuron[0], weights_bias])

        PM_matrix_list2.append(PM_matrix_neuron)

    # Save PM_matrix_list2 to a Python file
    save_file(path_log, PM_matrix_list2, file_name="PM_matrix_list2.py")

    return PM_matrix_list2

# def write_weights_log(path_log, BIT_WIDTH, IS_SIGNED, fractional, rescale, PM_matrix_bin):
#     with open(f"{path_log}/weights_bin_log.txt", "w") as writer:
#         for neuron_level in PM_matrix_bin:
#             writer.write(
#                 f" ===================== NEURON LEVEL {neuron_level[0][0][-1:]} ===================== \n")
#             for neuron in neuron_level:
#                 writer.write(
#                     f" ----------------------- {neuron[0]} ----------------------- \n")
#             # write in a new line of text file

#                 weights_bias_list = []
#                 for item in neuron[1]:
#                     weights_bias_list.append(
#                         Fxp(item, signed=IS_SIGNED, n_word=BIT_WIDTH, n_frac=fractional).bin())
#                 # print in a text file the code line below

#                     writer.write(
#                         f"{str(item).ljust(20, ' ')} -> {str(item * rescale).ljust(20, ' ')}:     {Fxp(item, signed=IS_SIGNED, n_word=BIT_WIDTH, n_frac=fractional).bin()} \n")
#                 writer.write('\n')
#                 neuron[1] = weights_bias_list
#             writer.write('\n')

#     # save PM_matrix_bin to a python file
#     save_file(path_log, PM_matrix_bin, file_name="PM_matrix_bin.py")


def write_weights_log(path_log: str, bit_width: int, IS_SIGNED: bool, fractional: int, rescale: float, pm_matrix_bin: list) -> None:
    """
    Write the binary weights and biases of a given PM_matrix_bin to a text file in the specified directory.

    Args:
    - path_log (str): the path of the directory where the text file will be saved.
    - bit_width (int): the number of bits used to represent each weight and bias in binary format.
    - IS_SIGNED (bool): whether the weights and biases can be negative or not.
    - fractional (int): the number of bits reserved for the fractional part of each weight and bias.
    - rescale (float): a scaling factor used to reduce the size of each weight and bias.
    - pm_matrix_bin (List[List[Tuple[str, List[float]]]]): the PM_matrix_bin to be logged.

    Returns:
    - None: the function does not return any value, it only saves the log file to disk.
    PM_matrix_bin = \
    [
        [ # neuron 0
            ['layer5_n0', ['11101001', ...]], # [bias, weights] bin list
            ['layer4_n0', [...]],
            ['layer3_n0', [...]],
            ['layer2_n0', [...]],
            ['layer1_n0', [...]]
        ],
        [[...], [...], [...], [...], [...]],  # neuron 1
        [[...], [...], [...], [...], [...]],  # neuron 2
        [[...], [...], [...], [...], [...]],  # neuron 3
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        [[...], [...], [...], [...], [...]],
        ...
    ]
    """
    with open(f"{path_log}/weights_bin_log.txt", "w") as writer:
        for neuron_level in pm_matrix_bin:
            writer.write(
                f" ===================== NEURON LEVEL {neuron_level[0][0][-1:]} ===================== \n")
            for neuron in neuron_level:
                writer.write(
                    f" ----------------------- {neuron[0]} ----------------------- \n")

                weights_bias_list = []
                for item in neuron[1]:
                    # Convert each weight or bias to binary format using the Fxp class
                    binary_item = Fxp(item, signed=IS_SIGNED,
                                      n_word=bit_width, n_frac=fractional).bin()
                    # Append the binary string to the weights_bias_list
                    weights_bias_list.append(binary_item)

                    # Write the original value, the rescaled value and the binary string to the log file
                    bin_str = f"0b{binary_item}"

                    writer.write(
                        f"{str(item).ljust(25, ' ')} -> {str(item * rescale).ljust(25, ' ')}:     {binary_item} = {str(Fxp(val= bin_str, signed=IS_SIGNED, n_word=bit_width, n_frac=fractional).base_repr(base=10, frac_dot=True)).ljust(5, ' ')} \n")
                # Update the weights and biases in the neuron with their binary string representation
                neuron[1] = weights_bias_list
            writer.write('\n')
    print(f"weights_bin_log.txt saved to {path_log}.")

    # save PM_matrix_bin to a python file
    save_file(path_log, pm_matrix_bin, file_name="PM_matrix_bin.py")

# def save_neurons_logs(path_log, neurons, BIT_WIDTH, IS_SIGNED, fractional):
#     neurons_bin = copy.deepcopy(neurons)
#     for layer in neurons_bin:
#         for neuron in layer:
#             neuron[1] = Fxp(neuron[1], signed=IS_SIGNED,
#                             n_word=BIT_WIDTH, n_frac=fractional).bin()
#             weights_bias_list = [
#                 Fxp(
#                     item, signed=IS_SIGNED, n_word=BIT_WIDTH, n_frac=fractional
#                 ).bin()
#                 for item in neuron[2]
#             ]
#             neuron[2] = weights_bias_list

#     # save neurons_bin to a python file
#     with open(f"{path_log}/neurons_bin.py", "w") as writer:
#         writer.write("neurons_bin = ")
#         writer.write(str(neurons_bin))


def save_neurons_logs(SAVE_PATH: str, neurons: list, bit_width: int, IS_SIGNED: bool, fractional: int) -> None:
    """
    Save a list of neural network neurons informations (name, bias, weights) to a Python file with fixed-point binary representation.

    Args:
    - SAVE_PATH (str): Path to save the file.
    - neurons (List[List[List[Union[str, List[float]]]]]): List of neural network neurons to be saved.
    - bit_width (int): Number of bits to represent the fixed-point number.
    - IS_SIGNED (bool): Indicates whether the fixed-point number is signed.
    - fractional (int): Number of fractional bits.

    Returns:
    - None: This function returns nothing.
    """
    neurons_bin = copy.deepcopy(neurons)
    for layer in neurons_bin:
        for neuron in layer:
            # Convert the bias of the neuron to binary representation.
            neuron[1] = Fxp(neuron[1], signed=IS_SIGNED,
                            n_word=bit_width, n_frac=fractional).bin()

            # Convert the weights of the neuron to binary representation.
            weights_bias_list = [
                Fxp(
                    item, signed=IS_SIGNED, n_word=bit_width, n_frac=fractional
                ).bin()
                for item in neuron[2]
            ]
            neuron[2] = weights_bias_list

    # Save neurons_bin to a Python file.
    with open(f"{SAVE_PATH}/neurons_bin.py", "w") as writer:
        writer.write("neurons_bin = ")
        writer.write(str(neurons_bin))

    process_file(f"{SAVE_PATH}/neurons_bin.py")

# def create_binary_neuron_list(PM_matrix_bin):
#     # Creating a binary list of lists with the just the weights and bias of each neuron
#     PM_matrix_to_testbench = []
#     for neuron_level in PM_matrix_bin:
#         level_list = []
#         for neuron in neuron_level:
#             # level_list.extend(neuron)
#             level_list.extend(neuron[1])
#         PM_matrix_to_testbench.append(level_list)
#     return PM_matrix_to_testbench


def create_binary_neuron_list(PM_matrix_bin: list) -> list:
    """
    Creates a binary list of lists with just the weights and bias of each neuron from a list of tuples containing the neuron's information.

    Args:
    - PM_matrix_bin (List[List[Tuple[float, float, List[float]]]]): List of tuples containing information about the neurons.

    Returns:
    - PM_matrix_to_testbench (List[List[float]]): Binary list of lists with just the weights and bias of each neuron.
    """
    PM_matrix_to_testbench = []
    for neuron_level in PM_matrix_bin:
        level_list = []
        for neuron in neuron_level:
            level_list.extend(neuron[1])
        PM_matrix_to_testbench.append(level_list)
    return PM_matrix_to_testbench


def save_weights(SAVE_PATH, NN_SAVE_PATH, PM_matrix_to_testbench):

    # write PM_matrix_to_testbench to a text file
    if not os.path.exists(SAVE_PATH):
        os.makedirs(SAVE_PATH)
    path_log_file = f"{SAVE_PATH}/weights_bin.txt"

    with open(path_log_file, "w") as writer:
        for i in range(len(PM_matrix_to_testbench[0])):  # width range
            for neuron_level in PM_matrix_to_testbench:
                writer.write(f"{neuron_level[i]} ")
            writer.write("\n")

    with open(f"{SAVE_PATH}/weights_bin_log.txt", "w") as writer:
        for i in range(len(PM_matrix_to_testbench[0])):  # width range
            for n, neuron_level in enumerate(PM_matrix_to_testbench):
                writer.write(str(f"it{i}_n{n}").ljust(
                    8, ' ') + f":{neuron_level[i]}  ")
            #     writer.write(f"{neuron} ")
            writer.write("\n")

# ----------------------------------------------------------------
# saving weights_bin.txt to the NNs folder

    with open(f"{NN_SAVE_PATH}/weights_bin.txt", "w") as writer:
        for i in range(len(PM_matrix_to_testbench[0])):  # width range
            for neuron_level in PM_matrix_to_testbench:
                writer.write(f"{neuron_level[i]} ")
            writer.write("\n")

    print("weights_bin.txt: done")


def generate_weights_file(
        ARRAYS_PATH: str,
        path_log: str,
        SAVE_PATH: str,
        NN_SAVE_PATH: str,
        IS_SIGNED: bool,
        BIT_WIDTH: int,
        REVERSE_WEIGHTS: bool,
        BIAS_ENDING: bool
):
    """
    Generate a weights file to be used in a neural network in hardware.

    Args:
    - ARRAYS_PATH (str): Path to the directory containing the bias and weight files.
    - path_log (str): Path to the directory where the logs will be saved.
    - SAVE_PATH (str): Path to the directory where the binary weights will be saved.
    - NN_SAVE_PATH (str): Path to the directory where the neural network model will be saved.
    - IS_SIGNED (bool): Whether the weights are signed or not.
    - BIT_WIDTH (int): The number of bits used to represent the weights.
    - REVERSE_WEIGHTS (bool): Whether the order of the weights should be reversed or not.
    - BIAS_ENDING (bool): Whether the bias should be at the end of the binary weights or not.
    """

    layers_array = []
    list_dir = sorted(os.listdir(ARRAYS_PATH))

    # Iterate through the list of files in the directory to create an array of layer arrays
    for i in range(0, len(list_dir), 2):
        print(f"{listdir(ARRAYS_PATH)[i]}, {listdir(ARRAYS_PATH)[i+1]}")
        layers_array.append(
            [np.load(f"{ARRAYS_PATH}/{listdir(ARRAYS_PATH)[i]}"), np.load(f"{ARRAYS_PATH}/{listdir(ARRAYS_PATH)[i+1]}")])  # [bias, weights]
    # layers_array = [
    #     [bias_array, weights_array], # layer0
    #     [bias_array, weights_array], # layer1
    #     [bias_array, weights_array], # layer2
    #     ...
    # ]
    flatten_weights(layers_array)

    neurons = neurons_list_gen_save(layers_array, path_log)

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
    # ----------------------------------------------------------------
    neurons_joined_PortMap_structure = join_neurons_by_index(
        layers_array, neurons)
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
    max_number_of_layers = 0

    # Find the maximum number of layers in the neural network
    for neuron_level in neurons_joined_PortMap_structure:
        if len(neuron_level) > max_number_of_layers:
            max_number_of_layers = len(neuron_level)

    ghost_neuron_models, layers_num_sequence = create_ghost_neurons(neurons)
    # ghost_neuron_models = [
    #     ['layer0_model', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],
    #     ['layer1_model', 0, [0, 0, 0, 0]],
    #     ['layer2_model', 0, [0, 0, 0]],
    #     ['layer3_model', 0, [0, 0]],
    #     ['layer4_model', 0, [0, 0, 0]],
    #     ['layer5_model', 0, [0, 0, 0, 0]]
    #     ]

    # Add ghost neurons to layers with fewer neurons.
    neurons_with_ghosts = add_ghost_neurons(neurons_joined_PortMap_structure,
                                            max_number_of_layers, ghost_neuron_models, layers_num_sequence)
    print("ghosts done")
    # neurons_with_ghosts = [
    #     [
    #         ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
    #         ['layer0_n1', 0.17614965, [...]],
    #         ['layer0_n2', 0.8049891, [...]],
    #         ['layer0_n3', 0.38902378, [...]],
    #         ['layer0_n4', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],  # ghost
    #         ['layer0_n5', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],  # ghost
    #         ...
    #     ],
    #     [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
    #     [
    #         ['layer0_n2', 0.8049891, [...]],    # 'layer2_n0', bias, [weights]
    #         ['layer1_n2', 0.14208536, [...]],
    #         ['layer3_n2', 0.0, [...]],
    #         ['layer4_n2', 0.0060660695, [...]],
    #         ['layer5_n2', 0.025634281, [...]],
    #         ['layer2_model', 0, [...]]          # ghost
    #     ],
    #     [[...], [...], [...]],
    #     [[...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
    # ]

    # ----------------------------------------------------------------

    PM_matrix_list = convert_neuron_structure_to_PM_matrix(neurons_with_ghosts)
    # PM_matrix_list = [
    #     [
    #         [-0.18265386, [0.24596863985061646, ...]],      # layer5_n0
    #         [0.0, [-0.9987852573394775, ...]],              # layer4_n0
    #         [-0.0042404337, [0.6779475212097168,...]],      # layer3_n0
    #         [...],                                          # layer2_n0
    #         [...],                                          # layer1_n0
    #         [...]                                           # layer0_n0
    #     ],
    #     [[...], [...], [...], [...], [...]],                # next neuron
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
    # Transform the PM_matrix to a list of lists (weights and bias on same sublist).
    PM_matrix_list2 = prepare_PM_matrix(
        REVERSE_WEIGHTS, BIAS_ENDING, path_log, PM_matrix_list)
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
    fractional = BIT_WIDTH - 1
    rescale = 2**(BIT_WIDTH-1) if IS_SIGNED else 2**(BIT_WIDTH)

    PM_matrix_bin = copy.deepcopy(PM_matrix_list2)
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
    write_weights_log(path_log, BIT_WIDTH, IS_SIGNED,
                      fractional, rescale, PM_matrix_bin)  # log files (for debug)

    save_neurons_logs(path_log, neurons, BIT_WIDTH,
                      IS_SIGNED, fractional)  # log files (for debug)

    PM_matrix_to_testbench = create_binary_neuron_list(PM_matrix_bin)

    save_weights(SAVE_PATH, NN_SAVE_PATH, PM_matrix_to_testbench)

# ==============================================================


whole_dir = os.getcwd()

REVERSE_WEIGHTS = False
BIAS_ENDING = True  # if True, bias is at the end of the shift_registers

# ARRAYS_PATH = "models/model_conversion/arrays/"
ARRAYS_PATH = "models/model_conversion/mini/arrays"  # 64inp -> 4 3 2 3 4 64
# list_dir = sorted(os.listdir(ARRAYS_PATH))

# LOG_PATH = "models/model_conversion/mini/logs"
# SAVE_PATH = "models/model_conversion/mini/testbench"
LOG_PATH = "models/model_conversion/logs"
SAVE_PATH = "models/model_conversion/testbench"

NN_SAVE_PATH = f"{whole_dir}/NNs/NN_6Layers_8bits_4_3_2_3_4_64/tb_Files"
BIT_WIDTH = 8
IS_SIGNED = True

generate_weights_file(ARRAYS_PATH,
                      LOG_PATH,
                      SAVE_PATH,
                      NN_SAVE_PATH,
                      IS_SIGNED,
                      BIT_WIDTH,
                      REVERSE_WEIGHTS,
                      BIAS_ENDING)
# todo: add a function to use 'generate_weights_file' based on a list of paths containing: the model.json and the 'weight_&_bias' arrays of each layer
# ARRAYS_PATH must contain: the model
# Ok path_log must be created if no exists
# OK SAVE_PATH must exists (path of NN) or it can be created??

# todo: make or find a simulator to get the expected results from the NN

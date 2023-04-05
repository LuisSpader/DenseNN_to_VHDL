# sourcery skip: avoid-builtin-shadow
import copy
import math
import os
import numpy as np
whole_dir = os.path.abspath(".")


# layers_array = np.array()
layers_array = []

# path = "models/model_conversion/arrays/"
path = "models/model_conversion/mini/arrays/"
listdir = sorted(os.listdir(path))

# array of layer_arrays
for i in range(0, len(listdir), 2):
    print(f"{listdir[i]}, {listdir[i+1]}")
    layers_array.append(
        [np.load(f"{path}{listdir[i]}"), np.load(f"{path}{listdir[i+1]}")])  # [bias, weights]

print('----------------------')
print(layers_array[0])

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


# for each item in layers_array, for each subitem in item, append it to a new list  (flatten_list)
# create a deepcopy of layers_array to not change the original
layers_array_copy = copy.deepcopy(layers_array)

#  separating bias and weights by neurons
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

# -------------------------------------------------
max = 0
# getting max
for l, layer in enumerate(layers_array):
    if len(layer[0]) > max:
        max = len(layer[0])

# joining together neurons with same index (ex: neuron_0 'n0')
neurons_joined_PortMap_structure = []
for n in range(0, max):
    neurons_joined = []

    for l, layer in enumerate(neurons):
        if len(layer[n]):
            neurons_joined.append(layer[n])

    neurons_joined_PortMap_structure.append(neurons_joined)

#
N = max - len(layers_array[0][0])

layers_array[1][0] = np.pad(
    layers_array[0][0],
    # where: how much to add on (beginning of array, end of array)
    # (math.floor(N/2), math.ceil(N/2)),
    # (0, math.ceil(N/2)),
    (0, math.ceil(N)),
    'constant',
    constant_values=(0, 0))  # what: values to add on 'where'

N = max - len(layers_array[0][1])
# layers_array[0][1] = np.pad(layers_array[0][1], (0, N), 'constant')

layer_n = 1
zeroed_array = np.zeros_like(layers_array[layer_n][1][0])
layers_array[0][1] = np.pad(layers_array[layer_n][1], (0, N), 'constant')

# layers_array[0][1] = np.pad(
#     layers_array[0][1],
#     (math.floor(N/2), math.ceil(N/2)),
#     'constant',
#     constant_values=(0, 0))

for l, layer in enumerate(layers_array):
    zeroed_array_bias = np.zeros_like(layer[0])
    zeroed_array_weights = np.zeros_like(layer[1])


# ----------------------------------------------------------------

flatten_list = []
len = len(layers_array)
# for l in range(len, 0, -1):
#     for b_w in layers_array[l-1]:
#         flatten_list.append(b_w.tolist())
for l in range(0, len-1):
    for b_w in layers_array[l]:
        flatten_list.append(b_w.tolist())
    # flatten_list.extend(b_w.tolist for b_w in layers_array[l-1])


for i, item in enumerate(flatten_list):
    # item      = [[bias], [weights]]
    # [bias]    = [0:14]
    # [weights] = [0:14][0:63][1]

    if isinstance(item[0], list):
        for w_l, weight_list in enumerate(item):
            # weight_list = [0:63][1]
            flat_list = []
            for sublist in weight_list:
                # len(sublist) = 1
                for item2 in sublist:
                    flat_list.append(item2)
            flatten_list[i][w_l] = flat_list
a = 0

# ----------------------------------------------------------------
# for item in weights_and_biases[0]:  # appendin weights
#     weights.append(item.tolist())

# neurons_bias = []
# for item in weights_and_biases[1]:  # appendin bias
#     neurons_bias.append(item)

# weights_bias_list = [weights, neurons_bias]
# weights_bias_list = [neurons_weights, neurons_bias]

# layer_dict["weights_and_biases"] = weights_bias_list
# layer_dict["weights_and_biases"] = weights_and_biases
# layer_dict['weights_and_biases'][0] = layer_dict['weights_and_biases'][0].to_list()
# layer_dict['weights_and_biases'][1] = layer_dict['weights_and_biases'][1].to_list()
# layer_dict['weights_and_biases'][0] = layer_dict['weights_and_biases'][0].tolist()
# print(
#     f"layer_dict['weights_and_biases'][0]: {layer_dict['weights_and_biases'][0].tolist()}")
# print(
#     f"layer_dict['weights_and_biases'][0][0:64]: {layer_dict['weights_and_biases'][0][0:64]}")

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

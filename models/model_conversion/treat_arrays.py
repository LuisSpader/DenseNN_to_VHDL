import os
import numpy as np
whole_dir = os.path.abspath(".")

# arrays_list = np.array()
arrays_list = []

path: str = f"models/model_conversion/arrays/"
listdir = sorted(os.listdir(path))

for i in range(0, len(listdir), 2):
    print(f"{listdir[i]}, {listdir[i+1]}")
    arrays_list.append(
        [np.load(f"{path}{listdir[i]}"), np.load(f"{path}{listdir[i+1]}")])  # [bias, weights]

print('----------------------')
print(arrays_list[0])


flatten_list = []
len = len(arrays_list)
# for l in range(len, 0, -1):
#     for b_w in arrays_list[l-1]:
#         flatten_list.append(b_w.tolist())
for l in range(0, len-1):
    for b_w in arrays_list[l]:
        flatten_list.append(b_w.tolist())
    # flatten_list.extend(b_w.tolist for b_w in arrays_list[l-1])


for i, item in enumerate(flatten_list):
    if isinstance(item[0], list):
        for w_l, weight_list in enumerate(item):
            flat_list = []
            for sublist in weight_list:
                for item in sublist:
                    flat_list.append(item)
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

import tensorflow as tf
import json


def get_weights_by_neuron(model):
    weights_by_neuron = []
    for layer in model.layers:
        # Check if the layer has weights (Dense layers do, others might not)
        if len(layer.get_weights()) > 0:
            weights, biases = layer.get_weights()
            weights = weights.T  # Transpose weights to align with your desired format
            layer_weights = []
            for i, neuron_weights in enumerate(weights):
                # Convert numpy array to list
                neuron_weights = list(neuron_weights)
                neuron_weights.append(biases[i])  # Append the bias
                layer_weights.append(neuron_weights)
            weights_by_neuron.append(layer_weights)
    return weights_by_neuron
# Example usage:
# model_dir = r"C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\models\normal\model_15_2_15_64_0.06858loss"
# model = tf.keras.models.load_model(f"{model_dir}/KERAS_check_best_model.model")
# weights_by_layer_neuron = get_weights_by_neuron(model)
# for i, layer in enumerate(weights_by_neuron):
#     print(f"Layer {i+1}")
#     for j, neuron in enumerate(layer):
#         print(f"  Neuron {j+1}: weights {neuron[:-1]}, bias {neuron[-1]}")


def save_weights_by_neuron_to_json(model, filename):
    weights_by_neuron = {}
    for l, layer in enumerate(model.layers):
        if len(layer.get_weights()) > 0:  # Check if the layer has weights
            weights, biases = layer.get_weights()
            weights = weights.T  # Transpose weights to align with your desired format
            layer_weights = {}
            for i, neuron_weights in enumerate(weights):
                neuron_weights = neuron_weights.tolist()  # Convert numpy array to list
                # Convert numpy floats to native Python floats
                neuron_weights = [float(w) for w in neuron_weights]
                # ! the bias is on the end of the list
                # Append the bias, also converted to a Python float
                neuron_weights.append(float(biases[i]))
                layer_weights[f"Neuron_{i+1}"] = neuron_weights
            weights_by_neuron[f"Layer_{l+1}"] = layer_weights

    # Write to JSON file
    with open(filename, 'w') as f:
        json.dump(weights_by_neuron, f)


def transform_weights(weights_by_neuron):
    # Determine the maximum number of neurons across all layers
    max_neurons = max(len(layer) for layer in weights_by_neuron)

    neurons_joined_PortMap_structure = []
    for neuron_idx in range(max_neurons):
        neuron_layers = []
        for layer_idx, layer in enumerate(weights_by_neuron):
            # Check if there's a neuron at this index in the current layer
            if neuron_idx < len(layer):
                neuron = layer[neuron_idx]
                bias = neuron[-1]
                weights = neuron[:-1]
                neuron_layers.append(
                    [f'layer{layer_idx}_n{neuron_idx}', bias, weights])
        neurons_joined_PortMap_structure.append(neuron_layers)

    return neurons_joined_PortMap_structure

# def rearrange_weights_by_neuron(weights_by_layer):
#     weights_by_neuron = []
#     for layer_weights in weights_by_layer:
#         for i, neuron_weights in enumerate(layer_weights):
#             if len(weights_by_neuron) <= i:
#                 weights_by_neuron.append([])
#             weights_by_neuron[i].extend(neuron_weights)
#             # weights_by_neuron[i].append(neuron_weights)

#     return weights_by_neuron
# weights_by_neuron = rearrange_weights_by_neuron(weights_by_layer_neuron)
# for i, neuron in enumerate(weights_by_neuron):
#     print(f"Neuron {i+1}: weights {neuron[:-1]}, bias {neuron[-1]}")

# ---------------


# model_dir = r"C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\models\normal\model_15_2_15_64_0.06858loss"
# model = tf.keras.models.load_model(f"{model_dir}/KERAS_check_best_model.model")


# # Example usage:
# save_weights_by_neuron_to_json(
#     model, f'{model_dir}/saved_objects/arrays/weights_by_neuron.json')


# weights_by_layer_neuron = get_weights_by_neuron(model)
# neurons_joined_PortMap_structure = transform_weights(weights_by_layer_neuron)
# for i, neuron in enumerate(neurons_joined_PortMap_structure):
#     print(f"Neuron {i+1}")
#     for layer in neuron:
#         print(f"  {layer[0]}: weights {layer[2]}, bias {layer[1]}")

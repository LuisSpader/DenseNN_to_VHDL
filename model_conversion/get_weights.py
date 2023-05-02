import tensorflow as tf
import json


def get_weights_by_neuron(model):
    """Get this weigths a biases but rearrange to get a list like this that each sublist is a layer and each subsublist is a neuron with its weights and bias
    """
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


# def save_weights_by_neuron_to_json(model: tf.keras.Model, filename: str, bit_width: int = 8):
#     """
#     This function saves the weights and biases of a Keras model to a JSON file. The weights and biases are organized
#     by layer and neuron. It also generates a second JSON file with the weights and biases scaled by a factor of 2**bit_width.

#     Parameters:
#     model (tensorflow.keras.Model): The Keras model to save weights from.
#     filename (str): The name of the JSON file to save the weights and biases to.
#                     The scaled weights and biases will be saved to a file named by appending '_scaled' to this filename.
#     bit_width (int): The number of bits by which to scale the weights and biases in the second JSON file.

#     Returns:
#     None

#     Note:
#     This function only saves weights and biases from layers that have them (i.e., Dense layers).
#     Other layers (such as Dropout or Flatten) are ignored.
#     """
#     weights_by_neuron = {}
#     weights_by_neuron_scaled = {}
#     scale_factor = 2 ** bit_width
#     for l, layer in enumerate(model.layers):
#         get_weights = layer.get_weights()
#         if l > 1 and len(get_weights) > 0:  # Check if the layer has weights
#             biases = get_weights[1]
#             # Transpose weights to align with your desired format
#             weights = get_weights[0].T
#             layer_weights = {}
#             layer_weights_scaled = {}
#             for i, neuron_weights in enumerate(weights):
#                 neuron_weights = neuron_weights.tolist()  # Convert numpy array to list
#                 # Convert numpy floats to native Python floats
#                 neuron_weights = [float(w) for w in neuron_weights]
#                 neuron_weights_scaled = [
#                     w * scale_factor for w in neuron_weights]
#                 bias = float(biases[i])  # Convert bias to a Python float
#                 bias_scaled = bias * scale_factor
#                 # ! the bias is on the end of the list
#                 neuron_weights.append(bias)
#                 neuron_weights_scaled.append(bias_scaled)
#                 layer_weights[f"Neuron_{i+1}"] = neuron_weights
#                 layer_weights_scaled[f"Neuron_{i+1}"] = neuron_weights_scaled
#             weights_by_neuron[f"Layer_{l+1}"] = layer_weights
#             weights_by_neuron_scaled[f"Layer_{l+1}"] = layer_weights_scaled

#     # Write to JSON file
#     with open(filename, 'w') as f:
#         json.dump(weights_by_neuron, f)

#     # Write scaled weights to another JSON file
#     with open(filename.replace('.json', '_scaled.json'), 'w') as f:
#         json.dump(weights_by_neuron_scaled, f)

def save_weights_by_neuron_to_json(model: tf.keras.Model, filename: str, bit_width: int = 8, LOAD_QUANTIZED_MODEL: bool = True):
    """
    This function saves the weights and biases of a Keras model to a JSON file. The weights and biases are organized 
    by layer and neuron. It also generates a second JSON file with the weights and biases scaled by a factor of 2**bit_width
    and a third JSON file with the weights and biases rounded to the nearest integer.

    Parameters:
    model (tensorflow.keras.Model): The Keras model to save weights from.
    filename (str): The name of the JSON file to save the weights and biases to. 
                    The scaled weights and biases will be saved to a file named by appending '_scaled' to this filename.
                    The rounded weights and biases will be saved to a file named by appending '_rounded' to this filename.
    bit_width (int): The number of bits by which to scale the weights and biases in the second JSON file.

    Returns:
    None

    Note:
    This function only saves weights and biases from layers that have them (i.e., Dense layers). 
    Other layers (such as Dropout or Flatten) are ignored.
    """
    weights_by_neuron = {}
    weights_by_neuron_scaled = {}
    weights_by_neuron_rounded = {}
    scale_factor = 2 ** bit_width

    start = 2 if LOAD_QUANTIZED_MODEL else 0

    for l, layer in enumerate(model.layers[start:]):
        get_weights = layer.get_weights()

        if len(get_weights) > 0:  # Check if the layer has weights
            biases = get_weights[1]
            # Transpose weights to align with your desired format
            weights = get_weights[0].T
            layer_weights = {}
            layer_weights_scaled = {}
            layer_weights_rounded = {}
            for i, neuron_weights in enumerate(weights):
                neuron_weights = neuron_weights.tolist()  # Convert numpy array to list
                # Convert numpy floats to native Python floats
                neuron_weights = [float(w) for w in neuron_weights]
                neuron_weights_scaled = [
                    w * scale_factor for w in neuron_weights]
                neuron_weights_rounded = [round(w)
                                          for w in neuron_weights_scaled]
                bias = float(biases[i])  # Convert bias to a Python float
                bias_scaled = bias * scale_factor
                bias_rounded = round(bias)
                # ! the bias is on the end of the list
                neuron_weights.append(bias)
                neuron_weights_scaled.append(bias_scaled)
                neuron_weights_rounded.append(bias_rounded)
                layer_weights[f"Neuron_{i}"] = neuron_weights
                layer_weights_scaled[f"Neuron_{i}"] = neuron_weights_scaled
                layer_weights_rounded[f"Neuron_{i}"] = neuron_weights_rounded
            weights_by_neuron[f"Layer_{l}"] = layer_weights
            weights_by_neuron_scaled[f"Layer_{l}"] = layer_weights_scaled
            weights_by_neuron_rounded[f"Layer_{l}"] = layer_weights_rounded

    # Write to JSON file
    with open(filename, 'w') as f:
        json.dump(weights_by_neuron, f)

    # Write scaled weights to another JSON file
    with open(filename.replace('.json', '_scaled.json'), 'w') as f:
        json.dump(weights_by_neuron_scaled, f)

    # Write rounded weights to another JSON file
    with open(filename.replace('.json', '_rounded.json'), 'w') as f:
        json.dump(weights_by_neuron_rounded, f)


def transform_weights(weights_by_neuron):
    """
    Can you create a function that get the 'get_weights_by_neuron' output and rearrange so that the outermost list is indexed by neuron, rather than by layer. Futhermore I want the list to look like this (add the text identifiers 'layer{layer_number}_n{neuron_number}' ):  neurons_joined_PortMap_structure = [
        [['layer0_n0', bias, [w0, w1, ...]],
         ['layer1_n0', bias, [w0, w1, ...]],
         ['layer2_n0', bias, [w0, w1, ...]],
         ['layer3_n0', bias, [w0, w1, ...]],
         ['layer4_n0', bias, [w0, w1, ...]],
         ['layer5_n0', bias, [w0, w1, ...]],
         ],
        [['layer0_n1', bias, [w0, w1, ...]]
         ['layer1_n1', bias, [w0, w1, ...]]
         [...],
         [...],
         [...],
         [...]
         ],
        ...
]
    """
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

import tensorflow as tf
import json
import os
from qkeras.utils import _add_supported_quantized_objects

whole_dir = os.path.abspath(".")
co = {}
_add_supported_quantized_objects(co)

# Load the Tensorflow model
# model = tf.keras.models.load_model("model.h5")
model_path = f"{whole_dir}\models\QAE_model\KERAS_check_model_wo_classifier.h5"
print(model_path)
model = tf.keras.models.load_model(model_path, custom_objects=co)


def tf_to_dict(model):
    """
    Converts an Tensorflow format Artificial Neural Network model to a Python dictionary

    Parameters:
        model (tf.keras.Model): The Tensorflow format Artificial Neural Network model to be converted

    Returns:
        Dict: A dictionary representation of the input model, containing the model's architecture

    """
    # Create an empty dictionary to store the model's architecture
    model_dict = {}

    # Iterate over the model's layers
    for layer in model.layers:
        layer_dict = {
            "name": layer.name,
            "input_shape": layer.input_shape,
            "output_shape": layer.output_shape,
            "trainable_weights": [
                weight.shape for weight in layer.trainable_weights
            ],
            "non_trainable_weights": [
                weight.shape for weight in layer.non_trainable_weights
            ],
            "trainable": layer.trainable,
            "weights": [weight.shape for weight in layer.weights],
            # "inputs": [input.name for input in layer.inputs],
            # "outputs": [output.name for output in layer.outputs],
            # "inbound_nodes": layer.inbound_nodes,
            # "outbound_nodes": layer.outbound_nodes,
            "inbound_nodes": [node.name for node in layer.inbound_nodes],
            "outbound_nodes": [node.name for node in layer.outbound_nodes],
            "input_mask": layer.compute_mask(layer.input, None),
        }
        layer_dict["output_mask"] = layer.compute_mask(layer.output, None)
        layer_dict["losses"] = [loss.name for loss in layer.losses]
        layer_dict["updates"] = [update.name for update in layer.updates]

        # Add the layer to the model's dictionary
        model_dict[layer.name] = layer_dict
    return model_dict


tf_dict = tf_to_dict(model)
print(json.dumps(tf_dict, indent=4))

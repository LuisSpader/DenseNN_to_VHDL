import tensorflow as tf
import json
import os
from qkeras.utils import _add_supported_quantized_objects

whole_dir = os.path.abspath(".")
co = {}
_add_supported_quantized_objects(co)

# Load the Tensorflow model
# model = tf.keras.models.load_model("model.h5")
# model_path = f"{whole_dir}\models\QAE_model\KERAS_check_model_wo_classifier.h5"
model_path = f"{whole_dir}\models\QAE_model\KERAS_check_best_model.model"
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
    # for layer in model.layers:

    tf_dict = {}
    for layer in model.layers:
        layer_dict = {}
        layer_dict["class_name"] = layer.__class__.__name__
        layer_dict["config"] = layer.get_config()
        # layer_dict["inbound_nodes"] = [node.input_tensors[0].name.split(
        #     ':')[0] for node in layer._inbound_nodes]
        tf_dict[layer.name] = layer_dict
        # # Include the layer weights as a list of numpy arrays
        # weights = layer.get_weights()
        # layer_dict["weights"] = [w.tolist() for w in weights]
        weights = layer.get_weights()
        if weights:
            print(layer.name)
            for w in weights:
                print(w.shape)
                print(w)

        layer_dict["weights"] = weights

        # Add the layer to the model's dictionary
        model_dict[layer.name] = layer_dict
    return model_dict


tf_dict = tf_to_dict(model)
print(json.dumps(tf_dict, indent=4))


# for layer in model.layers:
#     weights = layer.get_weights()
#     if weights:
#         print(layer.name)
#         for w in weights:
#             print(w.shape)
#             print(w)

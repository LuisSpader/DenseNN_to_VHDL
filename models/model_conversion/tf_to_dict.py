import tensorflow as tf
import json
import os
from qkeras.utils import _add_supported_quantized_objects
import json
import numpy as np
whole_dir = os.path.abspath(".")
co = {}
_add_supported_quantized_objects(co)

# Load the Tensorflow model
# model = tf.keras.models.load_model("model.h5")
# model_path = f"{whole_dir}\models\QAE_model\KERAS_check_model_wo_classifier.h5"
# model_path = f"{whole_dir}\models\QAE_model\KERAS_check_best_model.model"
model_path = r"C:\Users\luisa\OneDrive\Documentos\GitHub\Autoencoder-for-FPGA\model\QAE_model8bits\KERAS_check_best_model.model"
# print(model_path)
model = tf.keras.models.load_model(model_path, custom_objects=co)
save_path = "models/model_conversion/"


class NumpyFloatValuesEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.float32):
            return float(obj)
        # return JSONEncoder.default(self, obj)
        return json.JSONEncoder.default(self, obj)
# json.dumps(d, cls=NumpyFloatValuesEncoder)


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
    tf_dict = {}

    # Iterate over the model's layers
    for l, layer in enumerate(model.layers):
        layer_dict = {}
        layer_dict["class_name"] = layer.__class__.__name__
        layer_dict["config"] = layer.get_config()
        if layer_dict["class_name"] == 'QActivation':
            layer_dict["config"] = {'name': layer_dict["config"]['name'],
                                    'dtype': layer_dict["config"]['dtype']
                                    # 'bits': layer_dict["config"]['activation']['bits']
                                    }

        tf_dict[layer.name] = layer_dict

        # Include the layer weights_and_biases
        weights_and_biases = layer.get_weights()
        if weights_and_biases:
            print(layer.name)
            for w in weights_and_biases:
                print(w.shape)
                print(w)

        # for weight_bias in weights_and_biases:
        weights = []
        if weights_and_biases != []:
            for item in weights_and_biases[0]:  # appendin weights
                weights.append(item.tolist())

            bias = []
            for item in weights_and_biases[1]:  # appendin bias
                bias.append(item)

            weights_bias_list = [weights, bias]
            layer_dict["weights_and_biases"] = weights_bias_list
            # layer_dict["weights_and_biases"] = weights_and_biases
            # layer_dict['weights_and_biases'][0] = layer_dict['weights_and_biases'][0].to_list()
            # layer_dict['weights_and_biases'][1] = layer_dict['weights_and_biases'][1].to_list()
            # layer_dict['weights_and_biases'][0] = layer_dict['weights_and_biases'][0].tolist()
            # print(
            #     f"layer_dict['weights_and_biases'][0]: {layer_dict['weights_and_biases'][0].tolist()}")
            # print(
            #     f"layer_dict['weights_and_biases'][0][0:64]: {layer_dict['weights_and_biases'][0][0:64]}")

            with open(f'{save_path}weights_layer_{l}.txt', "w") as writer:
                writer.write(str(weights_bias_list))
            print(
                f"tf_to_dict() -> Creating : {save_path}weights_layer_{l}.txt")

        # Save dict to a file
        if layer_dict['class_name'] == 'QDense' or layer_dict['class_name'] == 'Dense':
            # is QDense or Dense
            with open(f"{save_path}{layer_dict['class_name']}.json", "w") as f:
                json.dump(layer_dict, f, cls=NumpyFloatValuesEncoder)
        else:
            # is not QDense
            with open(f"{save_path}{layer_dict['class_name']}.json", "w") as f:
                json.dump(layer_dict, f)
        print(
            f"tf_to_dict() -> Creating : {save_path}{layer_dict['class_name']}.json")

        # Add the layer to the model's dictionary
        model_dict[layer.name] = layer_dict

    # Save model dicts to a file
    with open(f"{save_path}model.json", "w") as f:
        # json.dump(model_dict, f)
        json.dump(model_dict, f, cls=NumpyFloatValuesEncoder)
    print(f"tf_to_dict() -> Creating : {save_path}model.json")

    return model_dict


tf_dict = tf_to_dict(model)
# print(json.dumps(tf_dict, indent=4))
print(json.dump(tf_dict, cls=NumpyFloatValuesEncoder))


# for layer in model.layers:
#     weights_and_biases = layer.get_weights()
#     if weights_and_biases:
#         print(layer.name)
#         for w in weights_and_biases:
#             print(w.shape)
#             print(w)

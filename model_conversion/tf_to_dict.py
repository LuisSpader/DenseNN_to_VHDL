import tensorflow as tf
import qkeras as qk
import json
# from qkeras.utils import _add_supported_quantized_objects
import json
import numpy as np
import os


class NumpyFloatValuesEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.float32):
            return float(obj)
        return json.JSONEncoder.default(self, obj)


def tf_to_dict(model, save_path: str = "models/model_conversion") -> None:
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

    path_arrays = f"{save_path}/arrays"
    if not os.path.exists(f"{path_arrays}"):
        os.makedirs(f"{path_arrays}")

    # Iterate over the model's layers
    # n = 0
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

        # Add the layer to the model's dictionary
        model_dict[layer.name] = layer_dict

    # Save model dicts to a file
    dict_to_JSON(save_path, model_dict)


def dict_to_JSON(save_path, model_dict, file_name="model"):
    with open(f"{save_path}/{file_name}.json", "w") as f:
        # json.dump(model_dict, f)
        json.dump(model_dict, f, cls=NumpyFloatValuesEncoder)
    print(f"tf_to_dict() -> created: {save_path}/model.json")


# custom_object_quant = {'QActivation': qk.qlayers.QActivation}
# qk.utils._add_supported_quantized_objects(custom_object_quant)

# Load the Tensorflow model
# model = tf.keras.models.load_model("model.h5")

# model_path = r"C:\Users\luisa\OneDrive\Documentos\GitHub\Autoencoder-for-FPGA\model\QAE_model8bitsmini\KERAS_check_best_model.model"
# # model_path = r"C:\Users\luisa\OneDrive\Documentos\GitHub\Autoencoder-for-FPGA\model\QAE_model8bits\KERAS_check_best_model.model"
# model = tf.keras.models.load_model(
#     model_path, custom_objects=custom_object_quant)
# tf_to_dict(model, save_path="models/model_conversion")


# model_path = r"C:\Users\luisa\OneDrive\Documentos\GitHub\Autoencoder-for-FPGA\model\QAE_model8bitsmini\KERAS_check_best_model.model"
# model = tf.keras.models.load_model(model_path, custom_objects=custom_object_quant)
# tf_to_dict(model, save_path="models/model_conversion/mini")

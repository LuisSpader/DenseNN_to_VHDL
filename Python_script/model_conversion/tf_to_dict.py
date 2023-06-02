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


def tf_to_dict(model, BIT_WIDTH: int, save_path: str = "models/model_conversion") -> None:
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

    # path_arrays = f"{save_path}/arrays"
    if not os.path.exists(f"{save_path}"):
        os.makedirs(f"{save_path}")

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

        # Include the layer weights_and_biases
        # weights_and_biases = layer.g:et_weights()

        # weights = layer.weights
        # bias = layer.bias.np()

        # if weights_and_biases:
        #     # print(layer.name)
        #     for w in weights_and_biases:
        # print(w.shape)
        # print(w)
        # for weight_bias in weights_and_biases:
        # weights = []
        # if weights_and_biases != []:

        #     # split the weights array into num_neurons subarrays
        #     # neurons_weights is a list of num_neurons numpy arrays, each with shape (input_dim, 1)
        #     # i.e., each subarray contains the weights for a single neuron
        #     neurons_weights = np.split(
        #         weights_and_biases[0], weights_and_biases[0].shape[1], axis=1)
        #     neurons_bias = weights_and_biases[1]

        #     # -------------------------------------------------------------------------
        #     # saving numpy arrays on '.npy' file format

        #     '''
        #     https://numpy.org/doc/stable/reference/generated/numpy.save.html
        #     numpy.save(file, arr, allow_pickle=True, fix_imports=True)

        #     Parameters:
        #     file: file, str, or pathlib.Path
        #         File or filename to which the data is saved. If file is a file-object, then the filename is unchanged. If file is a string or Path, a .npy extension will be appended to the filename if it does not already have one.

        #     arr: array_like
        #         Array data to be saved.

        #     allow_pickle: bool, optional
        #         Allow saving object arrays using Python pickles. Reasons for disallowing pickles include security (loading pickled data can execute arbitrary code) and portability (pickled objects may not be loadable on different Python installations, for example if the stored objects require libraries that are not available, and not all pickled data is compatible between Python 2 and Python 3). Default: True

        #     fix_imports: bool, optional
        #         Only useful in forcing objects in object arrays on Python 3 to be pickled in a Python 2 compatible way. If fix_imports is True, pickle will try to map the new Python 3 names to the old module names used in Python 2, so that the pickle data stream is readable with Python 2.
        #     '''
        #     # -------------------------------------------------------------------------

        # Add the layer to the model's dictionary
        # check if item exists in dictionary
        model_dict[layer.name] = layer_dict

    if not "InputLayer" in model_dict:
        model_dict["InputLayer"] = {"config": {}, "class_name": "InputLayer"}
        model_dict["InputLayer"]['config']['batch_input_shape'] = [None,None]
        try:
        # a = model.__class__.input_spec
        # ['input_spec']
            model_dict["InputLayer"]['config']['batch_input_shape'] = model.input_shape
        except AttributeError:
            print("InputLayer and model['input_spech'][0]['ndim'] not found. They're used as information for the number of inputs 'INPUTS_NUMBER' in the model.json file. Please, add them manually.")
            inputs_number = input("Enter the Neural Network number of inputs (on 1st layer): ")
            model_dict["InputLayer"]['config']['batch_input_shape'][1] = int(inputs_number)
            
    model_dict["general_config"] = {}
    model_dict["general_config"]["bit_width"] = BIT_WIDTH
    model_dict["general_config"]["class_name"] = "general_config"


    # Save model dicts to a file
    dict_to_JSON(save_path, model_dict)


def dict_to_JSON(save_path, model_dict, file_name="model"):
    with open(f"{save_path}/{file_name}.json", "w") as f:
        # json.dump(model_dict, f)
        json.dump(model_dict, f, cls=NumpyFloatValuesEncoder)
    print(f"tf_to_dict() -> created: {save_path}/model.json")


custom_object_quant = {'QActivation': qk.qlayers.QActivation}
qk.utils._add_supported_quantized_objects(custom_object_quant)

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

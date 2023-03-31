import tensorflow as tf
import json
from qkeras.utils import _add_supported_quantized_objects
import json
import numpy as np

co = {}
_add_supported_quantized_objects(co)

# Load the Tensorflow model
# model = tf.keras.models.load_model("model.h5")
model_path = r"C:\Users\luisa\OneDrive\Documentos\GitHub\Autoencoder-for-FPGA\model\QAE_model8bits\KERAS_check_best_model.model"
model = tf.keras.models.load_model(model_path, custom_objects=co)


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
        weights_and_biases = layer.get_weights()

        if weights_and_biases:
            print(layer.name)
            for w in weights_and_biases:
                print(w.shape)
                print(w)

        # for weight_bias in weights_and_biases:
        weights = []
        if weights_and_biases != []:

            # split the weights array into num_neurons subarrays
            # neurons_weights is a list of num_neurons numpy arrays, each with shape (input_dim, 1)
            # i.e., each subarray contains the weights for a single neuron
            neurons_weights = np.split(
                weights_and_biases[0], weights_and_biases[0].shape[1], axis=1)
            neurons_bias = weights_and_biases[1]

            # -------------------------------------------------------------------------
            # saving numpy arrays on '.npy' file format
            path_name = f"{save_path}/arrays/layer_{l:03}_{layer_dict['class_name']}_weights_array"
            np.save(path_name, neurons_weights,
                    allow_pickle=True, fix_imports=True)
            print(f"tf_to_dict() -> Creating : {path_name}.txt")

            path_name = f"{save_path}/arrays/layer_{l:03}_{layer_dict['class_name']}_bias_array"
            np.save(path_name, neurons_bias,
                    allow_pickle=True, fix_imports=True)
            print(f"tf_to_dict() -> Creating : {path_name}.txt")

            '''
            https://numpy.org/doc/stable/reference/generated/numpy.save.html
            numpy.save(file, arr, allow_pickle=True, fix_imports=True)

            Parameters:
            file: file, str, or pathlib.Path
                File or filename to which the data is saved. If file is a file-object, then the filename is unchanged. If file is a string or Path, a .npy extension will be appended to the filename if it does not already have one.

            arr: array_like
                Array data to be saved.

            allow_pickle: bool, optional
                Allow saving object arrays using Python pickles. Reasons for disallowing pickles include security (loading pickled data can execute arbitrary code) and portability (pickled objects may not be loadable on different Python installations, for example if the stored objects require libraries that are not available, and not all pickled data is compatible between Python 2 and Python 3). Default: True

            fix_imports: bool, optional
                Only useful in forcing objects in object arrays on Python 3 to be pickled in a Python 2 compatible way. If fix_imports is True, pickle will try to map the new Python 3 names to the old module names used in Python 2, so that the pickle data stream is readable with Python 2.
            '''
            # -------------------------------------------------------------------------

        # Add the layer to the model's dictionary
        model_dict[layer.name] = layer_dict

    # Save model dicts to a file
    with open(f"{save_path}/dicts/model.json", "w") as f:
        # json.dump(model_dict, f)
        json.dump(model_dict, f, cls=NumpyFloatValuesEncoder)
    print(f"tf_to_dict() -> Creating : {save_path}/dicts/model.json")


tf_to_dict(model)

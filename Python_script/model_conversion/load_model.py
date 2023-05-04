import pickle
from model_conversion.Qaware.class_QAutoencoder import *


def load_objects(model_dir: str):

    # model_obj.model.save('model_obj_keras_model.h5')
    # Load the TensorFlow model
    loaded_model = tf.keras.models.load_model(
        f"{model_dir}/KERAS_check_best_model.model")

    with tfmot.quantization.keras.quantize_scope():
        q_aware_model = tf.keras.models.load_model(
            f"{model_dir}/saved_objects/q_aware.h5")

    # q_aware_model = tf.keras.models.load_model(
    #     f"{model_dir}/saved_objects/q_aware.h5", custom_objects=custom_object_quant)

    # Load the Keras model
    # loaded_keras_model = tf.keras.models.load_model(f'{model_dir}/model_obj_keras_model.h5')

    # Load the .tflite model
    with open(f"{model_dir}/saved_objects/tflite_model.tflite", "rb") as file:
        loaded_tflite_model = file.read()

    # Load other attributes
    with open(f'{model_dir}/saved_objects/model_obj_attributes.pickle', 'rb') as f:
        loaded_attributes = pickle.load(f)

    # Create a new QAutoencoder object and set the attributes
    loaded_model_obj = QAutoencoder(data_zoom, bit_width=loaded_attributes['BIT_WIDTH'], model_name=loaded_attributes['model_name'],
                                    EPOCHS=loaded_attributes['EPOCHS'], Q_EPOCHS=loaded_attributes['Q_EPOCHS'])

    loaded_model_obj.q_aware_model = q_aware_model
    loaded_model_obj.model = loaded_model
    # loaded_model_obj.model = loaded_keras_model
    loaded_model_obj.quantized_tflite_model = loaded_tflite_model

    loaded_model_obj.x_train = loaded_attributes['x_train']
    # loaded_model_obj.y_train = loaded_attributes['y_train']
    loaded_model_obj.x_test = loaded_attributes['x_test']
    # loaded_model_obj.y_test = loaded_attributes['y_test']
    loaded_model_obj.input_min = loaded_attributes['input_min']
    loaded_model_obj.input_max = loaded_attributes['input_max']
    loaded_model_obj.input_shape = loaded_attributes['input_shape']
    loaded_model_obj.BIT_WIDTH = loaded_attributes['BIT_WIDTH']
    loaded_model_obj.EPOCHS = loaded_attributes['EPOCHS']
    loaded_model_obj.Q_EPOCHS = loaded_attributes['Q_EPOCHS']
    loaded_model_obj.model_name = loaded_attributes['model_name']
    loaded_model_obj.history = loaded_attributes['history']
    loaded_model_obj.loss = loaded_attributes['loss']
    loaded_model_obj.float_model_predictions = loaded_attributes['float_model_predictions']
    loaded_model_obj.path_to_model = loaded_attributes['path_to_model']

    loaded_model_obj.path_to_quantized_model = loaded_attributes['path_to_quantized_model']
    loaded_model_obj.q_aware_loss = loaded_attributes['q_aware_loss']
    loaded_model_obj.quantized_tflite_model = loaded_attributes['quantized_tflite_model']
    # loaded_model_obj.interpreter = loaded_attributes['interpreter']
    # loaded_model_obj.input_details = loaded_attributes['input_details']
    # loaded_model_obj.output_details = loaded_attributes['output_details']
    loaded_model_obj.quantized_model_predictions = loaded_attributes[
        'quantized_model_predictions']
    loaded_model_obj.save_objects_path = loaded_attributes['save_objects_path']

    # loaded_model_obj.interpreter = loaded_tflite_model
    # loaded_model_obj.mse = loaded_attributes['mse']

    # Recreate the TFLite interpreter
    loaded_model_obj.interpreter = tf.lite.Interpreter(
        model_content=loaded_tflite_model)
    loaded_model_obj.interpreter.allocate_tensors()
    loaded_model_obj.input_details = loaded_model_obj.interpreter.get_input_details()
    loaded_model_obj.output_details = loaded_model_obj.interpreter.get_output_details()
    # loaded_model_obj.convert_to_Q_aware()

    return loaded_model_obj

# # Load the objects and create a new model_obj
# loaded_model_obj = load_objects()


# ------------------------------------------------------------
# ax = plt.subplot(1, 1, 1)
# plt.imshow(data_zoom.x_train[0].reshape(size_final, size_final), cmap='gray_r')
# ax.get_xaxis().set_visible(False)
# ax.get_yaxis().set_visible(False)

# whole_dir = os.path.abspath(".")


# model2_dict_and_testbench(MINI_MODEL=True, model_path='')

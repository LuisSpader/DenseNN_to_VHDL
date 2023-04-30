import os
import pickle

from Qaware.class_QAutoencoder import *
from fxpmath import Fxp
from tf_to_dict import tf_to_dict


def get_best_model_path(path):
    if directories := [
        d
        for d in os.listdir(path)
        if d.startswith('model_') and d.endswith('loss')
    ]:
        # Extract loss value from each directory name
        losses = [float(d.split('_')[1].replace('loss', ''))
                  for d in directories]

    # Select directory with lowest loss value
        lowest_loss_index = losses.index(min(losses))
        lowest_loss_dir = directories[lowest_loss_index]
        print(f"The directory with the lowest loss is {lowest_loss_dir}")
        return f"{path}/{lowest_loss_dir}"

    else:
        print("No directories found with name pattern 'model_*loss'")
        return ""


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


def tb_inputs_gen(loaded_model_obj: QAutoencoder, TB_FILES_DIR: str):
    quantized_model_predictions = []
    pred_len = len(loaded_model_obj.quantized_model_predictions)

    with open(f'{TB_FILES_DIR}/tb_inputs.txt', 'w') as f:
        for img in range(pred_len):
            # Prepare input data
            input_data = np.array([(loaded_model_obj.x_test[img] - loaded_model_obj.input_min) / (
                loaded_model_obj.input_max - loaded_model_obj.input_min) * (2 ** (loaded_model_obj.BIT_WIDTH))], dtype=np.int8)

            for pixel in input_data[0]:
                fxp_item = Fxp(pixel, signed=True,
                               n_word=loaded_model_obj.BIT_WIDTH, n_frac=0)
            # print(pixel, " = ", fxp_item, " : ", fxp_item.bin())

                f.write(fxp_item.bin())
            f.write("\n")
            # print(f"input_data: {input_data}")
    print(f"created: {TB_FILES_DIR}/tb_inputs.txt")
# tb_inputs_gen(loaded_model_obj, TB_FILES_DIR)


def expected_results_gen(loaded_model_obj: QAutoencoder, TB_FILES_DIR: str, is_signed: bool = True):
    #  generating expected results for testbench: BINARY!
    with open(f'{TB_FILES_DIR}/expected_results_bin.txt', 'w') as f:
        for img in loaded_model_obj.quantized_model_predictions:
            for row in img:
                for pixel in row:
                    # print(pixel, " : ", Fxp(pixel, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin())
                    f.write(Fxp(pixel, signed=is_signed,
                            n_word=loaded_model_obj.BIT_WIDTH, n_frac=0).bin())
            # print(" ")
            f.write('\n')
    print(f"created: {TB_FILES_DIR}/expected_results_bin.txt")

    #  generating expected results for testbench: DECIMAL!
    with open(f'{TB_FILES_DIR}/expected_results_dec.txt', 'w') as f:
        for img in loaded_model_obj.quantized_model_predictions:
            for row in img:
                for pixel in row:
                    # print(pixel, " : ", Fxp(pixel, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin())
                    f.write(f"{str(pixel)} ")

        # print(" ")
            f.write('\n')
    print(f"created: {TB_FILES_DIR}/expected_results_dec.txt")

# expected_results_gen(loaded_model_obj, TB_FILES_DIR)


def get_model_path(whole_dir, MINI_MODEL, model_path):
    if model_path:
        return model_path
    path = f'{whole_dir}/models/normal'
    if MINI_MODEL:
        path = f'{whole_dir}/models/mini'

    return get_best_model_path(path)


def model2_dict_and_testbench(MINI_MODEL: bool = False, model_path: str = ''):

    # whole_dir defined on 'class_Autoencoder.py' file
    # --------------- Getting model with lowest loss ---------------
    best_model_path = get_model_path(whole_dir, MINI_MODEL, model_path)
    print(f"best_model_path: {best_model_path}")

    TB_FILES_DIR = f'{best_model_path}/testbench_files'
    if not os.path.exists(TB_FILES_DIR):
        os.makedirs(TB_FILES_DIR)

    # Load the objects and create a new model_obj
    loaded_model_obj = load_objects(model_dir=best_model_path)
    loaded_model_obj.model.summary()

    # --- Plotins models predictions ---
    # loaded_model_obj.plot_float_model()
    # loaded_model_obj.plot_quantized_model()
    # # loaded_model_obj.quantized_predictions(n=20)
    # # loaded_model_obj.plot_quantized_model(n=20)

    tb_inputs_gen(loaded_model_obj, TB_FILES_DIR)
    # todo: 'is_signed' deve ser definida em um arquivo centralizado
    expected_results_gen(loaded_model_obj, TB_FILES_DIR, is_signed=True)

    tf_to_dict(loaded_model_obj.model,
               save_path=loaded_model_obj.save_objects_path
               )

# ------------------------------------------------------------
# ax = plt.subplot(1, 1, 1)
# plt.imshow(data_zoom.x_train[0].reshape(size_final, size_final), cmap='gray_r')
# ax.get_xaxis().set_visible(False)
# ax.get_yaxis().set_visible(False)

# whole_dir = os.path.abspath(".")


model2_dict_and_testbench(MINI_MODEL=True, model_path='')

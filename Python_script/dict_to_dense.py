# a- reads JSON format
# b- generates>> INPUTS_NUMBER, BIT_WIDTH, LAYER_NEURONS_NUMBER_LIST, FX_ACTIVATION_LIST
import json
import os
from fxpmath import Fxp
import sys
from model_conversion.Qaware.model_utils import whole_dir, get_model_path
from model_conversion.Qaware.class_QAutoencoder import QAutoencoder, np
from model_conversion.tf_to_dict import tf_to_dict
from model_conversion.load_model import load_objects
from model_conversion.treat_arrays import generate_weights_file
from GEN_TOP_LEVEL_HDL import *

# todo depois: fazer função para gerar o dict através das configurações do website


def tb_inputs_gen(loaded_model_obj: QAutoencoder, tb_files_dir: str):
    pred_len = len(loaded_model_obj.quantized_model_predictions)

    with open(f'{tb_files_dir}/tb_inputs.txt', 'w') as f:
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
    print(f"created: {tb_files_dir}/tb_inputs.txt")
# tb_inputs_gen(loaded_model_obj, tb_files_dir)


def expected_results_gen(loaded_model_obj: QAutoencoder, tb_files_dir: str, is_signed: bool = True):
    #  generating expected results for testbench: BINARY!
    with open(f'{tb_files_dir}/expected_results_bin.txt', 'w') as f:
        for img in loaded_model_obj.quantized_model_predictions:
            for row in img:
                for pixel in row:
                    # print(pixel, " : ", Fxp(pixel, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin())
                    f.write(Fxp(pixel, signed=is_signed,
                            n_word=loaded_model_obj.BIT_WIDTH, n_frac=0).bin())
            # print(" ")
            f.write('\n')
    print(f"created: {tb_files_dir}/expected_results_bin.txt")

    #  generating expected results for testbench: DECIMAL!
    with open(f'{tb_files_dir}/expected_results_dec.txt', 'w') as f:
        for img in loaded_model_obj.quantized_model_predictions:
            for row in img:
                for pixel in row:
                    # print(pixel, " : ", Fxp(pixel, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin())
                    f.write(f"{str(pixel)} ")

        # print(" ")
            f.write('\n')
    print(f"created: {tb_files_dir}/expected_results_dec.txt")
# expected_results_gen(loaded_model_obj, tb_files_dir)


def model2_testbench(loaded_model_obj, model_path: str, NN_VHDL_path: str = None, IS_SIGNED: bool = True):

    tb_files_dir = f'{NN_VHDL_path}/testbench_files'
    if not os.path.exists(tb_files_dir):
        os.makedirs(tb_files_dir)

    # --- Plotins models predictions ---
    # loaded_model_obj.plot_float_model()
    # loaded_model_obj.plot_quantized_model()
    # # loaded_model_obj.quantized_predictions(n=20)
    # # loaded_model_obj.plot_quantized_model(n=20)

    tb_inputs_gen(loaded_model_obj, tb_files_dir)
    # todo: 'is_signed' deve ser definida em um arquivo centralizado
    expected_results_gen(loaded_model_obj, tb_files_dir, is_signed=True)

    generate_weights_file(
        model_path,
        tb_files_dir,
        # best_model_path,
        IS_SIGNED,
        BIT_WIDTH=loaded_model_obj.BIT_WIDTH,
        REVERSE_WEIGHTS=False,
        BIAS_ENDING=True,
        LOAD_QUANTIZED_MODEL=True)


def load_model_obj_AND_gen_dict(model_path: str = None):
    # whole_dir defined on 'class_Autoencoder.py' file
    # --------------- Getting model with lowest loss ---------------
    # best_model_path = get_model_path(whole_dir, MINI_MODEL, model_path)

    if not model_path:
        print('load_model.py -> model2_dict_and_testbench(): model_path is empty, please provide a valid path')
        sys.exit()

    # Load the objects and create a new model_obj
    loaded_model_obj = load_objects(model_dir=model_path)
    # print(loaded_model_obj.model.summary())

    # generates the model_dict
    tf_to_dict(loaded_model_obj.model,
               loaded_model_obj.BIT_WIDTH,
               save_path=loaded_model_obj.save_objects_path
               )

    return loaded_model_obj


def dict_to_dense(MINI_MODEL: bool = False, model_path: str = None):

    IO_TYPE_STR = 'signed'

    BASE_DICT_HIDDEN = layer_dict_hidden
    BASE_DICT_SOFTMAX = layer_dict_softmax
    # get the model with the lowest loss
    best_model_path = get_model_path(
        whole_dir, MINI_MODEL=MINI_MODEL, model_path=model_path)
    # OUTPUT_BASE_DIR_PATH = './NNs'
    OUTPUT_BASE_DIR_PATH = f"{best_model_path}/VHDL"

    DOWNLOAD_VHD = True  # True= para baixar || False = não baixar
    DEAD_NEURONS = False  # gera neurônios mortos

    INCLUDE_PARAMETERS_ON_FOLDERNAME = True
    # INCLUDE_MAC_TYPE: Include MAC parameters on MAC.vhd? (good for organization, bad for customization)
    INCLUDE_MAC_TYPE = True
    BASE_DICT_HIDDEN['Neuron_arch']['Include_MAC_type'] = INCLUDE_MAC_TYPE
    BASE_DICT_SOFTMAX['Neuron_arch']['Include_MAC_type'] = INCLUDE_MAC_TYPE
    BARRIERS = False

    # NUMBER_OF_LAYERS = len(LAYER_NEURONS_NUMBER_LIST)
    BASE_DICT_HIDDEN['Neuron_arch']['Barriers'] = BARRIERS
    BASE_DICT_SOFTMAX['Neuron_arch']['Barriers'] = BARRIERS

    # loads model, generates testbench files and saves model_dict
    IS_SIGNED = False
    if IO_TYPE_STR == 'signed':
        IS_SIGNED = True

    loaded_model_obj = load_model_obj_AND_gen_dict(model_path=best_model_path)

    model_dict_dir = f"{best_model_path}/saved_objects/model.json"
    # open a JSON file as dictionary
    with open(model_dict_dir) as json_file:
        model_dict = json.load(json_file)

    BIT_WIDTH = model_dict['general_config']['bit_width']

    # iterate through the dictionary
    for layer_name, layer_dict in model_dict.items():
        if layer_dict['class_name'] == 'InputLayer':
            INPUTS_NUMBER = layer_dict['config']['batch_input_shape'][1]

    LAYER_NEURONS_NUMBER_LIST = []
    FX_ACTIVATION_LIST = []
    for layer_name, layer_dict in model_dict.items():
        if layer_dict['class_name'] == 'Dense':
            LAYER_NEURONS_NUMBER_LIST.append(layer_dict['config']['units'])
            FX_ACTIVATION_LIST.append(layer_dict['config']['activation'])
    # ------------------------------

    GEN_TOP_LEVEL_HDL(INPUTS_NUMBER=INPUTS_NUMBER,
                      BIT_WIDTH=BIT_WIDTH,
                      IO_TYPE_STR=IO_TYPE_STR,
                      LAYER_NEURONS_NUMBER_LIST=LAYER_NEURONS_NUMBER_LIST,
                      BASE_DICT_HIDDEN=BASE_DICT_HIDDEN,
                      BASE_DICT_SOFTMAX=BASE_DICT_SOFTMAX,
                      OUTPUT_BASE_DIR_PATH=OUTPUT_BASE_DIR_PATH,
                      INCLUDE_PARAMETERS_ON_FOLDERNAME=INCLUDE_PARAMETERS_ON_FOLDERNAME,
                      DOWNLOAD_VHD=DOWNLOAD_VHD,
                      DEAD_NEURONS=DEAD_NEURONS,
                      DEBUG=False
                      )

    model2_testbench(loaded_model_obj, model_path=best_model_path,
                     NN_VHDL_path=PARAMS.path, IS_SIGNED=IS_SIGNED)


dict_to_dense(MINI_MODEL=True, model_path='')

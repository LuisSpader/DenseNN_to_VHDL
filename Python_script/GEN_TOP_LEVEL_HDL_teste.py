from GEN_TOP_LEVEL_HDL import *

INPUTS_NUMBER = 10
BIT_WIDTH = 8
# LAYER_NEURONS_NUMBER_LIST = [4, 3, 2, 3, 4, 64]
# LAYER_NEURONS_NUMBER_LIST = [15, 11, 7, 3, 2]
# LAYER_NEURONS_NUMBER_LIST = [16, 12, 8, 4, 2]
# LAYER_NEURONS_NUMBER_LIST = [10, 10]
LAYER_NEURONS_NUMBER_LIST = [20, 20]
# LAYER_NEURONS_NUMBER_LIST = [30, 30]
# LAYER_NEURONS_NUMBER_LIST = [40, 40]
# LAYER_NEURONS_NUMBER_LIST = [50, 50]
# LAYER_NEURONS_NUMBER_LIST = [10, 10]



IO_TYPE_STR = 'signed'

BASE_DICT_HIDDEN = layer_dict_hidden
BASE_DICT_SOFTMAX = layer_dict_softmax
OUTPUT_BASE_DIR_PATH = './NNs'

DOWNLOAD_VHD = True  # True= para baixar || False = não baixar
DEAD_NEURONS = False  # gera neurônios mortos

INCLUDE_PARAMETERS_ON_FOLDERNAME = True
# INCLUDE_MAC_TYPE: Include MAC parameters on MAC.vhd? (good for organization, bad for customization)
INCLUDE_MAC_TYPE = True
BASE_DICT_HIDDEN['Neuron_arch']['Include_MAC_type'] = INCLUDE_MAC_TYPE
BASE_DICT_SOFTMAX['Neuron_arch']['Include_MAC_type'] = INCLUDE_MAC_TYPE
BARRIERS = False
# BARRIERS = True


NUMBER_OF_LAYERS = len(LAYER_NEURONS_NUMBER_LIST)
BASE_DICT_HIDDEN['Neuron_arch']['Barriers'] = BARRIERS
BASE_DICT_SOFTMAX['Neuron_arch']['Barriers'] = BARRIERS

archs = [
    
]
for i in archs:

    
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
# print("====================== FIM =========================")

from GEN_TOP_LEVEL_HDL import *

INPUTS_NUMBER = 20
BIT_WIDTH = 10
# LAYER_NEURONS_NUMBER_LIST = [4, 3, 2, 3, 4, 64]
LAYER_NEURONS_NUMBER_LIST = [20, 20, 20, 20, 20, 20, 20]
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
BARRIERS = True


NUMBER_OF_LAYERS = len(LAYER_NEURONS_NUMBER_LIST)
BASE_DICT_HIDDEN['Neuron_arch']['Barriers'] = BARRIERS
BASE_DICT_SOFTMAX['Neuron_arch']['Barriers'] = BARRIERS

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

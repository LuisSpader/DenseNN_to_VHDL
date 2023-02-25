from GEN_TOP_LEVEL_HDL import *
from datetime import date


# INPUTS_NUMBER = 5
INPUTS_NUMBER = 10
BIT_WIDTH = 8
IO_TYPE_STR = 'signed'
LAYER_NEURONS_NUMBER_LIST = [6, 5, 3, 1]
# LAYER_NEURONS_NUMBER_LIST = [2, 3, 2, 1]
# LAYER_NEURONS_NUMBER_LIST = [32, 64, 32, 3]
# LAYER_NEURONS_NUMBER_LIST = [4, 1, 2, 3]
# LAYER_NEURONS_NUMBER_LIST = [75, 25, 75]
# LAYER_NEURONS_NUMBER_LIST = [128, 64, 32, 16, 32, 64, 128]
# LAYER_NEURONS_NUMBER_LIST = [500, 300, 100, 300, 500]
NUMBER_OF_LAYERS = len(LAYER_NEURONS_NUMBER_LIST)

BASE_DICT_HIDDEN = layer_dict_hidden
BASE_DICT_SOFTMAX = layer_dict_softmax
OUTPUT_BASE_DIR_PATH = './NN'
# today = date.today()
# PATH = f'./NN{today}'

DOWNLOAD_VHD = True  # True= para baixar || False = não baixar
DEAD_NEURONS = False  # gera neurônios mortos
# TODO: tamanho padrao da camada oculta (somente usado quando dead neurons = True)
# MAX_HIDDEN_LAYER_SIZE = 8
'''DEAD_NEURONS:
       só colocar pesos zerados'''
PATH_LEVEL = False  # True: pasta acima | False: Pasta paralela à deste .py
#! remover PATH_LEVEL


INCLUDE_PARAMETERS_ON_FOLDERNAME = True
# Include MAC parameters on MAC.vhd? (good for organization, bad for customization)
INCLUDE_MAC_TYPE = True
BASE_DICT_HIDDEN['Neuron_arch']['Include_MAC_type'] = INCLUDE_MAC_TYPE
BASE_DICT_SOFTMAX['Neuron_arch']['Include_MAC_type'] = INCLUDE_MAC_TYPE

# TODO: colocar opção inteiramente combinacional -> Reg só dps FX ACTIVATION
# TODO: gerar top level e controles(update_NN)
BARRIERS = True
BASE_DICT_HIDDEN['Neuron_arch']['Barriers'] = BARRIERS
BASE_DICT_SOFTMAX['Neuron_arch']['Barriers'] = BARRIERS

print("====================== COMEÇO =========================")

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
print("====================== FIM =========================")

# a- reads JSON format
# b- generates>> INPUTS_NUMBER, BIT_WIDTH, LAYER_NEURONS_NUMBER_LIST, FX_ACTIVATION_LIST


from Qaware.model_utils import model2_dict_and_testbench

model2_dict_and_testbench(MINI_MODEL=False, model_path='')

# https://youtu.be/9tG1pxmNxnE
from utils.general.txt_utils import txt_add_space_begin
# from standard_dicts import layer_dict_hidden


class Signals():
    def __init__(self) -> None:
        self.signals_stack = []
        self.signals_dec = []
        self.signals_txt = ''
        # self.signals_assign_stack = []
        # self.signals_assign_txt = []

    def append_signals_stack(self, item, layer_number) -> None:
        if not [item, layer_number] in self.signals_stack:
            self.signals_stack.append([item, layer_number])

    def signals_to_text(self):
        if self.signals_dec != []:
            self.signals_txt = '\n'.join(map(str, (self.signals_dec)))
            self.signals_txt = txt_add_space_begin(
                txt=self.signals_txt, space=1)

    def Get_signals_txt(self):
        return self.signals_txt


signals = Signals()


class Port_map():
    def __init__(self) -> None:
        self.neurons_PM_matrix = []


class Params():
    def __init__(self) -> None:
        # self.ADDER_expansion = 1
        self.layers_dict_list = []
        self.signals = Signals()
        self.path = './'
        self.layer_iteration = 0
        # self.neuron_iteration = 0


PARAMS = Params()


# PM = Port_map()

def reset_objects():
    # global signals, PARAMS
    PARAMS = Params()
    signals = Signals()
    return PARAMS, signals
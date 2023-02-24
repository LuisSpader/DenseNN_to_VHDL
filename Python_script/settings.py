# https://youtu.be/9tG1pxmNxnE
from txt_utils import txt_add_space_begin


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
        self.signals_txt = '\n'.join(map(str, (self.signals_dec)))
        self.signals_txt = txt_add_space_begin(txt=self.signals_txt, space=1)

    def Get_signals_txt(self):
        return self.signals_txt


signals = Signals()


class Port_map():
    def __init__(self) -> None:
        self.neurons_PM_matrix = []


PM = Port_map()

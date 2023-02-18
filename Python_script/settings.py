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


def init():
    global signals, signals_stack, signals_txt
    signals = []
    signals_stack = []
    signals_txt = ''


# def signals_to_text():
#     signals_txt = '\n'.join(map(str, (signals)))
#     signals_txt = txt_add_space_begin(txt=signals_txt, space=1)


# def append_signals_stack(item, layer_number):
#     if not [item, layer_number] in signals_stack:
#         signals_stack.append([item, layer_number])


# def append_signals(signal_name, signal_type):
#     existant = False

#     for i in range(0, len(signals)):
#         for item in range(0, len(signal_type)):
#             if signal_type[item] in signals[i]:
#                 existant = True
#                 if not signal_name in signals[i][0]:
#                     signals[i][0] = f"{signals[i][0]},{signal_name}"

#     if not existant:
#         signals.append([signal_name, signal_type])


# def append_signals_stack_to_signals():

#     for i in range(0, len(signals)):
#         for item in signals_stack:
#             txt_depois = '_'.join(
#                 map(str, (item.split(f"_")[-2:])))
#             if txt_depois in signals_stack[i]:
#                 # existant = True
#                 signals[i][0] = f"{signals[i][0]},{item}"

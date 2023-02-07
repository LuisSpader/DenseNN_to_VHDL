# https://youtu.be/9tG1pxmNxnE


def init():
    global signals, signals_stack
    signals = []
    signals_stack = []


def append_signals_stack(item, layer_number):
    if not [item, layer_number] in signals_stack:
        signals_stack.append([item, layer_number])


def append_signals(signal_name, signal_type):
    existant = False

    for i in range(0, len(signals)):
        for item in range(0, len(signal_type)):
            if signal_type[item] in signals[i]:
                existant = True
                if not signal_name in signals[i][0]:
                    signals[i][0] = f"{signals[i][0]},{signal_name}"

    if not existant:
        signals.append([signal_name, signal_type])


def append_signals_stack_to_signals():

    for i in range(0, len(signals)):
        for item in signals_stack:
            txt_depois = '_'.join(
                map(str, (item.split(f"_")[-2:])))
            if txt_depois in signals_stack[i]:
                # existant = True
                signals[i][0] = f"{signals[i][0]},{item}"

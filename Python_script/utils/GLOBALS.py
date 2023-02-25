from utils.components.Adders import Adders
from utils.SETTINGS import Port_map


class Global_objects():
    def __init__(self) -> None:
        self.ADDERS = Adders()
        # self.PARAMS = Params()
        self.PM_MATRIX = Port_map()


GLOBAL = Global_objects()

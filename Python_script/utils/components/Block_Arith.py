import os
# from utils.SETTINGS import PARAMS
from utils.general.components import entity_to_component
from utils.general.dict_utils import find_True_dict_split
# from SETTINGS import PARAMS
# from general.components import entity_to_component
# from general.dict_utils import find_True_dict_split
# import sys
# print(sys.path)
# sys.path.insert(0, '..')
# sys.path.insert(0, '../general/')

# layer_dict = {}


def adder_multiplier_number(layer_dict: dict = {}, type: str = 'Adder') -> int:
    arch_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch'][type], position=0)

    arch_number = int(arch_number)
    return arch_number


class Block_Arith:

    def __init__(self, layer_dict) -> None:
        self.layer_dict = layer_dict
        self.name = ''
        self.signals_txt = ''
        self.entity = ''
        self.component_txt = ''
        self.logic_text = ''
        self.txt = ''

        self.arch_id = 0
        self.arch_version = 0

        self.bit_width_multiplication = 1

    def Update_with_dict(self, create=False, PARAMS=None):
        self.Set_name()  # child method
        self.Set_arch()  # child method
        self.Set_component()
        self.Set_block_text()
        self.VHD_gen(path=PARAMS.path,
                     create=create)

    def Set_name(self):
        pass

    def Set_arch(self):
        pass

    def Set_component(self):
        self.component_txt = entity_to_component(self.entity)

    def Set_block_text(self):
        self.txt = (f'''
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
{self.entity}

ARCHITECTURE rtl OF {self.name} IS
{self.signals_txt}
BEGIN
{self.logic_text}
END ARCHITECTURE;
    ''')

    def VHD_gen(self, path: str = "./",
                create: bool = False
                ):

        if create:
            # creating folder if not exists
            os.makedirs(f"{path}/", exist_ok=True)
            # print(f"create_folder_{self.name}() -> Created: {path}")

        with open(f"{path}/{self.name}.vhd", "w") as writer:
            # creating '.vhd' file
            writer.write(self.txt)  # download MAC
        print(
            f"VHD_gen() -> criando arquivo: {path}/{self.name}.vhd")

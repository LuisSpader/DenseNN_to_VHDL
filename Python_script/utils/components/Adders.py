import os
from utils.general.dict_utils import find_True_dict_split
from utils.general.components import entity_to_component
# layer_dict = {}
from utils.SETTINGS import PARAMS


def adder_multiplier_number(layer_dict: dict = {}, type: str = 'Adder') -> int:
    arch_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch'][type], position=0)

    arch_number = int(arch_number)
    return arch_number


class Adder:

    def __init__(self) -> None:
        self.name = ''
        self.entity = ''
        self.txt = ''
        self.component_txt = ''
        self.adder_number = 0
        self.adder_version = 0
        self.ADDER_expansion = 1
        # self.Update_with_dict(layer_dict)

    def Update_with_dict(self, layer_dict):
        self.adder_number = adder_multiplier_number(layer_dict, type='Adder')
        if layer_dict['Neuron_arch']['Barriers']:
            self.ADDER_expansion = 2

        self.Adder_name()
        self.Adder_entity(layer_dict)
        self.Adder_component()
        self.Adder_VHD_gen(path=PARAMS.path,
                           create_path_folder=True)

    def Adder_name(self):
        self.name = (f"add{self.adder_number}_v{self.adder_version}")

    def Adder_entity(self, layer_dict):
        self.entity = (f'''
    ENTITY {self.name} IS
        GENERIC (
            BITS : NATURAL := {layer_dict['Neuron_arch']['Bit_WIDTH']}
        );
        PORT (
            X : IN signed(({self.ADDER_expansion}* BITS) - 1 DOWNTO 0);
            W : IN signed(({self.ADDER_expansion}* BITS) - 1 DOWNTO 0);
            Y : OUT signed(({self.ADDER_expansion}* BITS) - 1 DOWNTO 0)
        );
    END ENTITY;''')

    def Adder_component(self):
        self.component_txt = entity_to_component(self.entity)

    def Adder_0_Operator_txt_gen(self):
        self.txt = (f'''
    LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.parameters.ALL;
    {self.entity}

    ARCHITECTURE rtl OF {self.name} IS
    BEGIN
        Y <= X + W;
    END ARCHITECTURE;
    ''')

    def Adder_VHD_gen(self,
                      path: str = "./",
                      create_path_folder: bool = False
                      ):

        if self.adder_number == 0:
            self.Adder_0_Operator_txt_gen()

            if create_path_folder:
                os.makedirs(f"{path}/", exist_ok=True)  # softmax layer
                print(f"create_folder_neuron() -> Created: {path}")

            with open(f"{path}/{self.name}.vhd", "w") as writer:
                writer.write(self.txt)  # download MAC
            print(
                f"Adder_0_Operator_txt_gen() -> criando arquivo: {path}/{self.name}.vhd")


class Adders:
    def __init__(self) -> None:
        self.adders_obj_list = []

    def New_adder(self, layer_dict):
        obj = Adder()
        obj.Update_with_dict(layer_dict)
        self.adders_obj_list.append(obj)

# ADDERS = Adders()

# 0-Operator
from utils.components.Block_Arith import *

from utils.general.dict_utils import find_True_dict_split
# from standard_dicts import layer_dict_hidden
import os
# layer_dict = layer_dict_hidden

# mult_version = 0


# def multiplier_txt_gen(
#     layer_dict: dict,
#     path: str = "./",
#     create_path_folder: bool = False
# ):
#     multiplier_version = 0

#     bits = layer_dict['bits']
#     multiplier_number = find_True_dict_split(
#         split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'])
#     multiplier_number = int(multiplier_number)
#     # print(f"multiplier_number: {multiplier_number}")

#     multiplier_name = f"mult{multiplier_number}_v{multiplier_version}"

#     if multiplier_number == 0:
#         multiplier_0_Operator_txt_gen(
#             bits=bits,
#             multiplier_name=multiplier_name,
#             path=path,
#             create_path_folder=create_path_folder
#         )


# def multiplier_0_Operator_txt_gen(
#     bits: int,
#     multiplier_name: str,
#     path: str = "./",
#     create_path_folder: bool = False
# ):
#     # Multiplier_component = (f'''  COMPONENT {multiplier_name} IS
#     #   GENERIC (
#     #     BITS : NATURAL := {bits}
#     #   );
#     #   PORT (
#     #     X : IN signed((BITS) - 1 DOWNTO 0);
#     #     W : IN signed((BITS) - 1 DOWNTO 0);
#     #     Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
#     #   );
#     # END COMPONENT;''')

#     Multiplier_vhd_txt = (f'''
#   LIBRARY ieee;
#   USE ieee.std_logic_1164.ALL;
#   USE ieee.numeric_std.ALL;
#   USE work.parameters.ALL;

#   ENTITY {multiplier_name} IS
#       GENERIC (
#           BITS : NATURAL := {bits}
#       );
#       PORT (
#           X : IN signed((BITS) - 1 DOWNTO 0);
#           W : IN signed((BITS) - 1 DOWNTO 0);
#           Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
#       );
#   END ENTITY;

#   ARCHITECTURE rtl OF {multiplier_name} IS
#   BEGIN
#       Y <= X * W;
#   END ARCHITECTURE;
#   ''')

#   #   Multiplier_signals_txt = (f'''
#   #   SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);

#   #   TYPE mult_array_type IS ARRAY (1 TO NUM_INPUTS) OF signed((2 * BITS) - 1 DOWNTO 0);
#   #   SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
#   # ''')

#     if create_path_folder:
#         os.makedirs(f"{path}", exist_ok=True)  # softmax layer
#         print(f"create_folder_neuron() -> Created: {path}")

#     with open(f"{path}/{multiplier_name}.vhd", "w") as writer:
#         writer.write(Multiplier_vhd_txt)  # download MAC
#     print(
#         f"multiplier_0_Operator_txt_gen() -> criando arquivo: {path}/{multiplier_name}.vhd")

# # ------


def mult0(name, Bit_WIDTH, bit_width_multiplication):
    entity = (f'''
ENTITY {name} IS
    GENERIC (
        BITS : NATURAL := {Bit_WIDTH}
    );
    PORT (
        X : IN signed(({bit_width_multiplication}* BITS) - 1 DOWNTO 0);
        W : IN signed(({bit_width_multiplication}* BITS) - 1 DOWNTO 0);
        Y : OUT signed(({bit_width_multiplication}*2 * BITS) - 1 DOWNTO 0)
    );
END ENTITY;''')
    signals = ''
    logic_text = "    Y <= X * W;"
    return {
        'entity': entity,
        'signals': signals,
        'logic_text': logic_text
    }


class Multiplier(Block_Arith):
    # MULTIPLIERS = []

    def __init__(self, layer_dict, create) -> None:
        super().__init__(layer_dict)
        self.Update_with_dict(layer_dict, create)  # updt da arch

    def Update_with_dict(self, layer_dict, create=False):
        self.layer_dict = layer_dict
        self.arch_id = adder_multiplier_number(
            self.layer_dict, type='Multiplier')
        # if layer_dict['Neuron_arch']['Barriers']:
        #     self.bit_width_multiplication = 2
        # self.Set_arch(layer_dict)
        super().Update_with_dict(create)

    def Set_name(self):
        self.name = (f"mult{self.arch_id}_v{self.arch_version}")

    def Set_arch(self):
        if self.arch_id == 0:
            result_dict = mult0(
                self.name, self.layer_dict['Neuron_arch']['Bit_WIDTH'], self.bit_width_multiplication)
        else:
            result_dict = {''}
            print(f"Arquitetura {self.arch_id} não cadastrada")

        self.entity = result_dict['entity']
        self.signals = result_dict['signals']
        self.logic_text = result_dict['logic_text']


class Multipliers:
    def __init__(self) -> None:
        self.mult_obj_list = []

    def New_obj(self, layer_dict, create):
        self.mult_obj_list.append(Multiplier(layer_dict, create))

# multiplier = Multiplier()
# print(multiplier.txt)

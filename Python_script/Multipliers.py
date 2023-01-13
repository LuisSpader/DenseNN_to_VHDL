# 0-Operator
from dict_utils import find_True_dict_split
# from standard_dicts import layer_dict_hidden
import os
# layer_dict = layer_dict_hidden

mult_version = 0

# --------------
# mult_number = find_True_dict_split(
#     split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0)
# multiplier_name = (f"mult{mult_number}_v{mult_version}")
# ----------


def multiplier_txt_gen(
    layer_dict: dict,
    path: str = "./",
    create_path_folder: bool = False
):
    multiplier_version = 0

    bits = layer_dict['bits']
    multiplier_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'])
    multiplier_number = int(multiplier_number)
    # print(f"multiplier_number: {multiplier_number}")

    multiplier_name = f"mult{multiplier_number}_v{multiplier_version}"

    if multiplier_number == 0:
        multiplier_0_Operator_txt_gen(
            bits=bits,
            multiplier_name=multiplier_name,
            path=path,
            create_path_folder=create_path_folder
        )


def multiplier_0_Operator_txt_gen(
    bits: int,
    multiplier_name: str,
    path: str = "./",
    create_path_folder: bool = False
):
    # Multiplier_component = (f'''  COMPONENT {multiplier_name} IS
    #   GENERIC (
    #     BITS : NATURAL := {bits}
    #   );
    #   PORT (
    #     X : IN signed((BITS) - 1 DOWNTO 0);
    #     W : IN signed((BITS) - 1 DOWNTO 0);
    #     Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    #   );
    # END COMPONENT;''')

    Multiplier_vhd_txt = (f'''
  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE work.parameters.ALL;

  ENTITY {multiplier_name} IS
      GENERIC (
          BITS : NATURAL := {bits}
      );
      PORT (
          X : IN signed((BITS) - 1 DOWNTO 0);
          W : IN signed((BITS) - 1 DOWNTO 0);
          Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
      );
  END ENTITY;

  ARCHITECTURE rtl OF {multiplier_name} IS
  BEGIN
      Y <= X * W;
  END ARCHITECTURE;
  ''')

  #   Multiplier_signals_txt = (f'''
  #   SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);

  #   TYPE mult_array_type IS ARRAY (1 TO NUM_INPUTS) OF signed((2 * BITS) - 1 DOWNTO 0);
  #   SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
  # ''')

    if create_path_folder:
        os.makedirs(f"{path}", exist_ok=True)  # softmax layer
        print(f"create_folder_neuron() -> Created: {path}")

    with open(f"{path}/{multiplier_name}.vhd", "w") as writer:
        writer.write(Multiplier_vhd_txt)  # download MAC
    print(
        f"multiplier_0_Operator_txt_gen() -> criando arquivo: {path}/{multiplier_name}.vhd")

# Multiplier_signals_txt = (f'''
# ''')

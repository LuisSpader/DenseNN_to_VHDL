import os
from dict_utils import find_True_dict_split


def adder_txt_gen(
    layer_dict: dict,
    path: str = "./",
    create_path_folder: bool = False
):
    bits = layer_dict['bits']
    adder_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch']['Adder'])
    adder_number = int(adder_number)

    adder_version = 0
    adder_name = f"add{adder_number}_v{adder_version}"

    if adder_number == 0:
        adder_0_Operator_txt_gen(
            bits=bits,
            adder_name=adder_name,
            path=path,
            create_path_folder=create_path_folder
        )


def adder_0_Operator_txt_gen(
    bits: int,
    adder_name: str,
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

    Adder_vhd_txt = (f'''
  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE work.parameters.ALL;

  ENTITY {adder_name} IS
      GENERIC (
          BITS : NATURAL := {bits}
      );
      PORT (
          X : IN signed((BITS) - 1 DOWNTO 0);
          W : IN signed((BITS) - 1 DOWNTO 0);
          Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
      );
  END ENTITY;

  ARCHITECTURE rtl OF {adder_name} IS
  BEGIN
      Y <= X * W;
  END ARCHITECTURE;
  ''')

#     Multiplier_signals_txt = (f'''
#     SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);

#     TYPE mult_array_type IS ARRAY (1 TO NUM_INPUTS) OF signed((2 * BITS) - 1 DOWNTO 0);
#     SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
#   ''')

    if create_path_folder:
        os.makedirs(f"{path}", exist_ok=True)  # softmax layer
        print(f"create_folder_neuron() -> Created: {path}")

    with open(f"{path}/{adder_name}.vhd", "w") as writer:
        writer.write(Adder_vhd_txt)  # download MAC
    print(
        f"adder_0_Operator_txt_gen() -> criando arquivo: {path}/{adder_name}.vhd")

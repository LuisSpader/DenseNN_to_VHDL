# from vhd_txt_utils import entity2_layer_dict
from utils.standard_dicts import layer_dict_hidden
# from layer_utils import layer_neurons_port_map_ALL
from utils.layer_utils import entity_port_map
from utils.general.vhd_txt_utils import *
from utils.general.utils import IO_manager_Top
INPUTS_NUMBER = 5


# # output_dict = copy.deepcopy(layer_dict_arg)
# output_dict = layer_dict_hidden
# # output_dict['Layer_num'] = Layer_num

# # gerando o nome da camada com base nos parâmetros passados no dicionário
# # output_dict['Layer_name'] = layer_name(layer_dict_arg=output_dict)
# # ID_camada = f"c{Layer_num}"

# txt, camada_inputs, camada_outputs = (entity_port_map(
#     vhd_name='topname',
#     i=0,
#     neuron_dict=layer_dict_hidden,
#     num_inputs=INPUTS_NUMBER,
#     ID_camada='id',
#     port_map_layers_to_top=True))
# print(" ================== TOP ================== ")
# print(txt)

# # # todo: fazer layer_port_map_ALL()
# # port_map_txt, output_dict = layer_neurons_port_map_ALL(
# #     layer_dict_arg=output_dict,
# #     ID_camada='top',
# #     n_max=0)

# # # TODO FAZER NOVA entity2_layer_dict()
# # top_text = (f'''LIBRARY ieee;
# # USE ieee.std_logic_1164.ALL;
# # USE ieee.numeric_std.ALL;
# # USE work.parameters.ALL;

# # {entity2_layer_dict(top_dict = output_dict,
# #                     remove_dict_items=[],
# #                     generic = True
# #              )}

# # ARCHITECTURE arch OF  {output_dict['Layer_name']}  IS
# # BEGIN
# # {port_map_txt}
# # END ARCHITECTURE;
# # '''
# #             )

# # print(" ================== TOP ================== ")
# # print(top_text)


def topDict_to_entityTxt(
        top_dict: dict = {},
        IO_dict_compare: dict = {},
        remove_dict_items=[],
        generic: bool = False,
        tab_space: int = 1,
        DEBUG: bool = False) -> str:
    # https://youtu.be/hdPC2G8NPHI

    bits = top_dict['bits']
    num_inputs = top_dict['Inputs_number']

    if not isinstance(bits, int):
        try:
            bits = bits()
        except:
            print("Error entity(): Formato de dicionário inválido para bit_WIDTH")
    if not isinstance(num_inputs, (int, np.integer)):

        try:
            num_inputs = num_inputs()
        except:
            print("Error entity(): Formato de dicionário inválido para num_inputs.")

    IO, traço = IO_manager_Top(
        top_dict, IO_dict_compare, bits, onerow=1, tab_space=2, remove_dict_items=remove_dict_items
    )

    # PEGANDO GENERIC DO DICIONÁRIO DA CAMADA
    # pegando nome das variáveis
    generic_names = dict_list_exceptNone(
        dict_slice=top_dict['IO']['GENERIC'], return_value_or_key='key', is_list=False)
    if DEBUG:
        print(
            f"vhd_txt_utils.py :: entity2_layer_dict -> generic_names: {generic_names}")

    # pegando o valor das variáveis
    generic_values = dict_list_exceptNone_Callable(
        dict_slice=top_dict['IO']['GENERIC'], return_value_or_key='value', is_list=False)

    if DEBUG:
        print(
            f"vhd_txt_utils.py :: entity2_layer_dict -> generic_values: {generic_values}")
        for i in generic_values:
            print(f"generic_values():{generic_values}")

    # gerando texto de atribuições
    if generic:
        generic_txt = (f'''
GENERIC (
{('  '*tab_space)}BITS : NATURAL := BITS;
{('  '*tab_space)}NUM_INPUTS : NATURAL := {num_inputs};
{('  '*tab_space)}TOTAL_BITS : NATURAL := {num_inputs*bits}
);
  ''')
    else:
        generic_txt = ''

    txt = (f'''

ENTITY  {top_dict['Top_name']} IS
{generic_txt}
PORT (
{IO}
);
end ENTITY;
''')
    txt = erase_empty_lines(txt)
    txt = txt_add_space_begin(txt, space=tab_space)
    return txt

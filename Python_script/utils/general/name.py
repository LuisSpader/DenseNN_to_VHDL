# Vhd name
#
# Cria o nome do arquivo VHD
# def vhd_name(vhd_name, vhd_type, bits, is_signed, num_inputs, Barriers, MAC_type ):
from utils.general.utils import insert_string_inside


def vhd_name(
    vhd_name: str,
    BIT_WIDTH: int,
    IO_type: bool,
    num_inputs: int,
    Barriers: bool,
    MAC_type: bool,
    Include_MAC_type: bool,
    mult_number: str = '0',
    mult_version: int = 0,
    adder_number: str = '0',
    adder_version: int = 0
) -> str:
    """ Função para criar uma string com identificação de diversos parâmetros no nome. Exemplo:
    sum_name = vhd_name('MAC', 
         bits = 8, 
         IO_type = True, 
         num_inputs = 3, 
         Barriers = False, 
         MAC_type = False, 
         Include_MAC_type = True)

    sum_name = 'MAC_tree_8bit_3n_signed'

    Args:
        vhd_name (str): string com nome do vhd que deseja identificar, exemplo: 'neuronio'

        bits (int): número de bits de representação

        IO_type (bool): True = ponto fixo com sinal (complemento de 2)| Fals = sem sinal

        num_inputs (int): número de entradas do '.vhd'

        Barriers (bool): Se tem camadas de registradores entre as operações (para aumentar a freq de clock) -> 0 = no Barriers | 1 = with register Barriers (pipeline)

        MAC_type (bool): Tipo de MAC (multiplicação e acumulação) -> 0 = tree (combinacional) | 1 = Sequencial (multi ciclo)

        Include_MAC_type (bool): Se inclui alguma identificação do tipo de MAC no nome do vhd -> tree ou seq (sequencial) ou Barriers (possui barreiras de registradores)

        mult_number (str): Número do modelo de multiplicador. Exemplo: mult_number = '1' (multiplicador do tipo 1) --> mul1

        mult_version (int): Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4

        adder_number (str): Número do modelo de adder. Exemplo: adder_number = '3' (adder do tipo 3) --> add3

        adder_version (int): Versão do modelo de adder (pois podem existir melhorias em um modelo). Exemplo: adder_version = 9 --> v9

        !! As especificações sobre o que representa cada número de multiplicador (mul1 ou mul2, ...) e sua versão (v1, v2, ...) é especificada com base na lista 'Multiplider_Adders_List.txt'

    Returns:
        str: retorna uma string com o nome (exemplo dado acima)
    """

    name = ""
    # defining vhd NAMES
    # print(f" vhd_name() -> IO_type == signed: {IO_type == 'signed'}")
    if Include_MAC_type == True:

        if (IO_type == 'signed'):  # _____________COM SINAL (SIGNED)______________#
            name = f"{vhd_name}_{num_inputs}n_{BIT_WIDTH}bit_signed"

        # ___________SEM SINAL (UNSIGNED)__________#
        else:
            name = f"{vhd_name}_{num_inputs}n_{BIT_WIDTH}bit_unsigned"

    # ___________ Combinacional OU sequencial , Barriers OU '' ___________
        if MAC_type == False:  # árvore (combinacional)
            name = insert_string_inside(original_txt=name, split_character="_",
                                        insert_txt="comb", position=1)

        else:  # sequencial (multiciclo: seq)
            name = insert_string_inside(original_txt=name, split_character="_",
                                        insert_txt="seq", position=1)

        if Barriers == True:  # se tem barreiras (pipeline)
            name = insert_string_inside(original_txt=name, split_character="_",
                                        insert_txt="Barriers", position=2)

        pos = 7
        # ___________ Multiplier number & version: mul1v1, mul1v2, mul2v1 ___________
        name = insert_string_inside(original_txt=name, split_character="_",
                                    insert_txt=(
                                        f"mult{mult_number}_v{mult_version}"),
                                    position=pos)
        pos = 8
        # ___________ Adder number & version: add1v1, add1v2, add2v1 ___________
        name = insert_string_inside(original_txt=name, split_character="_",
                                    insert_txt=(
                                        f"add{adder_number}_v{adder_version}"),
                                    position=pos)
    else:
        name = f"{vhd_name}_{num_inputs}n"
    return name

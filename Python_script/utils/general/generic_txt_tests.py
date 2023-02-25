from utils.standard_dicts import layer_dict_hidden
dict = {'manual': [
    'Xi : IN signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);',
    'Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);',
    'Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);',
    'Wout2 : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);'
]
}
camada_inputs = [['clk', 'rst', 'update_weights'], [], [],
                 [], [], [], ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']]


def concat_func(x, y): return x + "" + y


def IO_manual(IO_dict: dict, IO: str = 'IN') -> str:
    find = ":"

    nomes = []
    tipos = []

    # for item in IO_dict[IO]['manual']:
    for item in IO_dict['manual']:
        position = item.find(f"{find}")
        txt_antes = item[:position].strip()  # nome variavel
        txt_depois = item[position:].strip()  # tipo de variavel
        # print(f"txt_antes: {txt_antes}")
        # print(f"txt_depois: {txt_depois}")

        # print(f"item: {item}")

        if not nomes:  # se está vazio (1ª vez)
            nomes.append(txt_antes)
            tipos.append(txt_depois)
            # print("1st")

        else:  # se n está vazio (a partir da 2ª vez)
            # print(f"tipos: {tipos}")

            if txt_depois in tipos:
                # print(" ------------ igualdade !! ---------------- ")

                for i in range(0, len(tipos)):  # verificando os tipos que são iguais
                    # print(f"tipos[{i}]: {tipos[i]}")

                    if txt_depois == tipos[i]:

                        nomes[i] = f"{nomes[i]}, {txt_antes}"
                        # print(f"nomes: {nomes}")
                        # print(f"tipos: {tipos}")
                        # print('---')
                        # break
            else:
                nomes.append(txt_antes)
                tipos.append(txt_depois)
                # print(" ------------ novo !! ---------------- ")
                # print(f"nomes: {nomes}")
                # print('---')

        #     print("=======")
        # print("////////////////////////////")

    # print(f"nomes: {nomes}")
    # print(f"tipos: {tipos}")
    text_list = list(map(concat_func, nomes, tipos))  # list the map function
    # text_list can be an splitted text or a list of texts
    final_string = '\n'.join(map(str, (text_list)))
    # print(final_string)
    return final_string


# IO_dict_list = [layer_dict_hidden['IO']]
# for i in range(0, len(IO_dict_list)):
#     # print(IO_dict_list[i])

#     print(f"saida[{i}]: {IO_manual(IO_dict=IO_dict_list[i], IO='IN')}")

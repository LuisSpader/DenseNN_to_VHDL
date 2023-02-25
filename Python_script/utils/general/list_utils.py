def list_concatenation(lista: list):
    total = []
    for i in lista:
        total += i

    return total


def list_concatenation_all_sublists(lista: list):
    import itertools
    # total = []
    # for i in lista:
    #     total += i

    # return list(itertools.chain(*lista))
    lista_retorno = lista
    while (any(isinstance(i, list) for i in lista_retorno) == True):
        lista_retorno = list(itertools.chain.from_iterable(lista_retorno))

    return lista_retorno


def swap_empty_for_None(lista: list) -> list:
    """Função para trocar listas vazias '[]' por 'None'. Dessa forma conseguimos utilizar a função 'entity' sem mapear indevidamente listas vazias como IO no '.vhd'

    Args:
        lista (list): lista que contém alguma lista vazia internamente. Exemplo: 
            test_list = [[], [1], ['sdsf']]
            *Note que test_list[0] == []

    Returns:
        list: Retorna lista substituindo '[]' por 'None'. Usando o mesmo exemplo acima:
            test_list_swap =  swap_empty_for_None(lista = test_list)
            print(test_list_swap)
            Output: [None, [1], ['sdsf']]
    """
    for i in range(0, len(lista)):
        if lista[i] == []:
            lista[i] = None

    return lista


def remove_all_lista_ocurrences(lista: list, occurences_list: list) -> list:
    """Função para remover itens de 'lista', com base em outra lista: 'occurences_list'
    Exemplo: 
        print(remove_all_lista_ocurrences(lista=['a', 'b', 'c'], occurences_list=['a', 'c']))

        Output: ['b']


    Args:
        lista (list): _description_
        occurences_list (list): _description_

    Returns:
        _type_: _description_
    """
    for i in occurences_list:
        lista = [x for x in lista if x != i]
    return lista
# print(remove_all_lista_ocurrences(lista=['a', 'b', 'c'], occurences_list=['a', 'c']))


def remove_all_lista_ocurrences2(lista: list, occurences_list: list) -> list:
    """Função para remover itens de 'lista', com base em outra lista: 'occurences_list'
    Exemplo: 
        print(remove_all_lista_ocurrences(lista=[['a'], ['b'], ['c']], occurences_list=['a', 'c']))

        Output: ['b']


    Args:
        lista (list): _description_
        occurences_list (list): _description_

    Returns:
        _type_: _description_
    """
    # for i in occurences_list:
    #     lista = [x for x in lista if x != i]

    # for i, item in enumerate(lista):
    for j in occurences_list:
        buff = [f"{j}"]
        for i, item in enumerate(lista):
            if item == buff:
                del lista[i]
        # if buff in lista:
        #     lista.remove([j])
        # lista = [x for x in lista if x != [j]]
        # lista = [x for x in lista if x[0] != j]
    return lista
# print(remove_all_lista_ocurrences(lista=['a', 'b', 'c'], occurences_list=['a', 'c']))

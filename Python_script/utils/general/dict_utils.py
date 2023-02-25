from io import StringIO
import sys


def dict_list_exceptNone(dict_slice: dict, return_value_or_key: str = 'key', is_list: bool = True) -> list:
    """Função para retornar uma lista com as 'keys' em que o 'value' != None

    Args:
        dict_slice (dict): dicionário

    Returns:
        list: lista de 'keys' do dicionário em que o 'value' respectivo é diferente de None
    """
    s_k = []
    s_v = []
    if (dict_slice == None):
        return ''
    else:
        if is_list:  # se é lista
            for i in dict_slice:  # itera sobre as 'keys' e os 'values'
                # print(f"Não é None: {k}")
                s_k.append(i)
            return s_k

        else:  # se é dict
            for k, v in dict_slice.items():  # itera sobre as 'keys' e os 'values'

                if (v != None):
                    # print(f"Não é None: {k}")
                    s_k.append(k)
                    s_v.append(v)
                # s.append(i)
            if (return_value_or_key == 'key'):
                return s_k
            elif (return_value_or_key == 'value'):
                return s_v


def dict_list_exceptNone_Callable(dict_slice: dict, return_value_or_key: str = 'key', is_list: bool = True) -> list:
    """Função para retornar uma lista com as 'keys' em que o 'value' != None

    Args:
        dict_slice (dict): dicionário

    Returns:
        list: lista de 'keys' do dicionário em que o 'value' respectivo é diferente de None
    """
    s_k = []
    s_v = []
    if (dict_slice == None):
        return ''
    else:
        if is_list:  # se é lista
            for i in dict_slice:  # itera sobre as 'keys' e os 'values'
                # print(f"Não é None: {k}")
                try:
                    s_k.append(i())
                except:
                    s_k.append(i)
            return s_k

        else:  # se é dict
            for k, v in dict_slice.items():  # itera sobre as 'keys' e os 'values'

                if (v != None):
                    # print(f"Não é None: {k}")
                    try:
                        s_k.append(k())
                    except:
                        s_k.append(k)
                    try:
                        s_v.append(v())
                    except:
                        s_v.append(v)
                # s.append(i)
            if (return_value_or_key == 'key'):
                return s_k
            elif (return_value_or_key == 'value'):
                return s_v

# s = dict_list_exceptNone(dict_slice = Neuron_IO_dict["IN"]["STD_LOGIC"])
# print(s)


def dict_to_list(target_dict: dict,
                 key_or_value: bool = True) -> list:
    """Função para fazer de um dicionário uma lista

    Args:
        target_dict (dict): dicionário que será feita a lista
        key_or_value (bool, optional): True = se quer 'key' (esquerda) | 0 = 'value' (direita). Defaults to True.

    Returns:
        list: Lista do dicionário passado
    """
    dictlist = []

    # pega apenas 'keys'
    if (key_or_value == True):
        for key, value in target_dict.items():
            temp = key
            dictlist.append(temp)

    else:  # faz lista apenas com 'value'
        for key, value in target_dict.items():
            temp = value
            dictlist.append(temp)

    return dictlist


def find_True_dict(dict_slice: dict):
    """Função para encontrar em um dicionário (com subdicionários = nested dict), quando que um 'dict.value()' == True e retornar a 'key' (dict.key()) desse respectivo.

    Args:
        dict_slice (dict): dicionário para encontrar o valor 'True'

    Returns:
        str: será a 'key' de quando o 'value' é 'True'. Retorna a string da 'key'
    """
    retorno = ''
    for k, v in dict_slice.items():  # itera sobre as 'keys' e os 'values'
        # key_tmp = dict_slice[k]
        key_tmp = k
        if (v == True):  # se 'value' == True -> já encontramos
            # print(f"True key: {key_tmp}")
            print(key_tmp)  # NÃO EDITAR !!!!

            return key_tmp  # retorna a 'key'
        else:  # caso seja diferente de 'True', ele pode ser 'False' ou pode ainda ser outro dicionário
            if (v != False):  # se não é 'False', pode ser outro dicionário ou qualquer outra coisa
                if isinstance(v, dict):  # caso seja um dicionário
                    # como é outro dicionário, chamamos novamente a função
                    find_True_dict(v)

    # deste modo, a função chamando a si mesma (nested procedures), conseguimos encontrar 'True' independente de quantos níveis dicionário tenhamos um dentro do outro.


def find_True_dict_above_level(
        dict_slice: dict,
        saved: str = None):
    """Função para encontrar em um dicionário (com subdicionários = nested dict), quando que um 'dict.value()' == True e retornar a 'key' (dict.key()) desse respectivo.

    Args:
        dict_slice (dict): dicionário para encontrar o valor 'True'

    Returns:
        str: será a 'key' de quando o 'value' é 'True'. Retorna a string da 'key'
    """
    retorno = ''
    for k, v in dict_slice.items():  # itera sobre as 'keys' e os 'values'
        # key_tmp = dict_slice[k]
        key_tmp = k
        if (v == True):  # se 'value' == True -> já encontramos
            # print(f"True key: {key_tmp}")
            # print(key_tmp)  # NÃO EDITAR !!!! ESTÁ SENDO PEGO COMO RETORNO

            if saved != None:  # se tem 'key' salva, retorna ela
                print(saved)  # NÃO EDITAR !!!! ESTÁ SENDO PEGO COMO RETORNO
                return saved

            # caso não tenha 'key' salva antes (nível acima), pega 'key' do nível atual em que o 'value' == True
            else:
                print(key_tmp)  # NÃO EDITAR !!!! ESTÁ SENDO PEGO COMO RETORNO
                return key_tmp  # retorna a 'key'
        else:  # caso seja diferente de 'True', ele pode ser 'False' ou pode ainda ser outro dicionário
            if (v != False):  # se não é 'False', pode ser outro dicionário ou qualquer outra coisa
                if isinstance(v, dict):  # caso seja um dicionário
                    # como é outro dicionário, chamamos novamente a função
                    find_True_dict_above_level(
                        dict_slice=v, saved=k)  # aqui salvamos a 'key'

    # deste modo, a função chamando a si mesma (nested procedures), conseguimos encontrar 'True' independente de quantos níveis dicionário tenhamos um dentro do outro.


class Capturing(list):
    """Função para pegar a saída 'print()' pois não conseguimos fazer o 'return' do python conseguir retornar a 'key'
    https://stackoverflow.com/questions/16571150/how-to-capture-stdout-output-from-a-python-function-call

    Args:
        list (list): lista de 'output' já usado anteriormente, caso queiramos acumular as saídas numa lista. 
          Exemplo:
            with Capturing() as output:
              print('hello world')

            with Capturing(output) as output:  # note the constructor argument
                print('hello world2')

            Output:
              output: ['hello world', 'hello world2']


    """

    def __enter__(self):
        self._stdout = sys.stdout
        sys.stdout = self._stringio = StringIO()
        return self

    def __exit__(self, *args):
        self.extend(self._stringio.getvalue().splitlines())
        del self._stringio    # free up some memory
        sys.stdout = self._stdout


def find_True_dict_Output_print(dict_slice: dict) -> str:
    """Função para unir as 2 anteriores 'find_True_dict' e 'Capturing' e conseguirmos retornar a 'key' como string, de quando seu 'value' == True.

    Args:
        dict_slice (dict): dicionário o qual estamos fazendo a busca pelo value == 'True'

    Returns:
        str: 'key' em formato string
    """
    with Capturing() as output:
        find_True_dict(dict_slice)
    return output[0]
    # return output


def find_True_dict_Output_print_above_level(dict_slice: dict) -> str:
    """Função para unir as 2 anteriores 'find_True_dict' e 'Capturing' e conseguirmos retornar a 'key' como string, de quando seu 'value' == True.

    Args:
        dict_slice (dict): dicionário o qual estamos fazendo a busca pelo value == 'True'

    Returns:
        str: 'key' em formato string
    """
    with Capturing() as output:
        find_True_dict_above_level(dict_slice)
    return output[0]
    # return output


def find_True_dict_split(split_str: str = '-',
                         dict={},
                         position: int = 0):
    """Nesta funçaõ, após pegarmos o 'key' o qual seu 'value == True', dividimos este texto da 'key conforme o caractere 'split_str' e é jogado na saída apenas a fatia indicada pela posição do parãmetro 'position'. Esta função é usada para pegar os nomes identificadores dos 'adders' ou 'multipliers' do dicionário.

    Args:
        split_str (str, optional): Caractere utilizado para fazer a separação do texto em partes. Defaults to '-'.
        dict (dict, optional): _description_. Defaults to {}.
        position (int, optional): Posição da lista gerada por 'string.split()' que queremos pegar . Defaults to 0.

    Returns:
        _type_: _description_
    """
    # return find_True_dict_Output_print(dict).split(split_str)[position]
    return find_True_dict_Output_print(dict).split(split_str)[position]

# Exemplo:
# dict_slice = layer_dict['Neuron_arch']['Multiplier']
# find_True_dict_split(split_str = '-',
#                      dict = dict_slice,
#                      position= 0)

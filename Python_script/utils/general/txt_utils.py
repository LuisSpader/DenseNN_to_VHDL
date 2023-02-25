def txt_add_space_begin(txt: str, space: int):
    """Função para adicionar espaços no início da linha (para formatação de código)

    Args:
        txt (str): texto o qual será alterado
        space (int): número de 'tabs' (vezes em que o código será deslocado para a direita)

    Returns:
        _type_: _description_
    """
    space = ['  ']*space
    space = ''.join(map(str, space))
    temp = ''

    for line in txt.splitlines():
        temp = temp + '\n' + (space + line)

    temp = temp.splitlines()[1:]
    temp = '\n'.join(map(str, temp))
    return temp
# print(txt_add_space_begin(txt = Neuron_IN_port_map, space = 2))


def replace_chars(text: str, chars: str = "[]'", chars_subs: str = ""):
    """Função para apenas substituir caracteres numa string. Note que está 'hard coded' para sempre substituir os mesmos caracteres "[]'"

    Args:
        text (str): string para substituir caractere

    Returns:
        str: retorna string(texto) com caracteres substituídos
    """
    # chars = "[]'"  # caracteres desejados para se substituir
    # chars_subs = ""  # caracteres que serão colocados no lugar

    final_text = str(text).replace(chars[0:1], chars_subs)
    for c in chars:
        final_text = final_text.replace(c, chars_subs)
    return final_text


def replace_word(text: str, word: str = "palavra", word_subs: str = ""):
    """Função para apenas substituir caracteres numa string. Note que está 'hard coded' para sempre substituir os mesmos caracteres "[]'"

    Args:
        text (str): string para substituir caractere

    Returns:
        str: retorna string(texto) com caracteres substituídos
    """
    # chars = "[]'"  # caracteres desejados para se substituir
    # chars_subs = ""  # caracteres que serão colocados no lugar

    final_text = str(text).replace(word, word_subs)
    return final_text


def erase_empty_lines(string_with_empty_lines):  # REMOVE LINHAS EM BRANCO

    lines = string_with_empty_lines.split("\n")  # divide texto por linhas
    # pega apenas linhas diferentes de: ""
    non_empty_lines = [line for line in lines if line.strip() != ""]

    string_without_empty_lines = ""
    for line in non_empty_lines:
        # concatena linhas não vazias com '\n' no final de cada linha
        string_without_empty_lines += line + "\n"

    return string_without_empty_lines[:-1]  # tira ultima linha em branco
# ------------------------------------------------------------------


def erase_empty_lines_2(string_with_empty_lines: str
                        # last_rows: int = -1
                        ):  # REMOVE LINHAS EM BRANCO
    lines = string_with_empty_lines.split("\n")
    non_empty_lines = [line for line in lines if line.strip() != ""]

    string_without_empty_lines = ""
    for line in non_empty_lines:
        string_without_empty_lines += line + "\n"

    # tira ultima linha em branco
    return string_without_empty_lines
# ------------------------------------------------------------------


def tab_lines(string_without_tab, tab_space):  # ADICIONA ESPAÇOS A ESQUERDA NO TEXTO
    tab_space = ['  ']*tab_space
    tab_space = ''.join(map(str, tab_space))

    lines = string_without_tab.split("\n")

    string_with_tab = ""
    for line in lines:
        string_with_tab += f"{tab_space}{line}\n"

    return (string_with_tab)

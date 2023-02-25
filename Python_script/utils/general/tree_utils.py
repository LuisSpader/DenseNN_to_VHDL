from utils.general.txt_utils import erase_empty_lines, replace_chars
from utils.general.utils import seq_signal


def sum_mult_seq(num_inputs: int):
    """ Primeira das funções para geração automática da árvore de somas e multiplicações. Ela retorna algumas strings relacionadas a isso, exemplo:

    sum_sequence_string, mult_sequence_string, sum_sequence, mult_sequence = sum_mult_seq(num_inputs)
      Output:
        ['soma_1, soma_2, soma_3'] = sum_sequence_string
        ['mult_1, mult_2, mult_3'] = mult_sequence_string
        ['soma_1', 'soma_2', 'soma_3'] = sum_sequence
        ['mult_1', 'mult_2', 'mult_3'] = mult_sequence

    -----------------------------------
    Args:
        num_inputs (int): número de entradas da árvore de soma
    """
    sum_sequence = []
    mult_sequence = []

    # n=4 -> sum_all <= ((signed(sx1)*signed(sw1))+ (signed(sx2)*signed(sw2)) + (signed(sx3)*signed(sw3))+ (signed(sx4)*signed(sw4)) + signed(bias));

    for i in range(1, int(num_inputs)+1):  # árvore de somas + 1 pelo range que começa em 1
        sum_sequence.append("soma_"+str(i))
    # print (sum_sequence)

    for i in range(1, num_inputs+1):
        mult_sequence.append("mult_"+str(i))
    # print (mult_sequence)

    sum_sequence_string = ', '.join(map(str, (sum_sequence)))
    mult_sequence_string = ', '.join(map(str, (mult_sequence)))
    sum_sequence_string = [sum_sequence_string]
    mult_sequence_string = [mult_sequence_string]

    return (sum_sequence_string, mult_sequence_string, sum_sequence, mult_sequence)
# sum_sequence_string, mult_sequence_string, sum_sequence, mult_sequence = sum_mult_seq(num_inputs)
# print (sum_sequence_string)
# print (mult_sequence_string)
# print (sum_sequence)
# print (mult_sequence)


def signal_receive_input(num_inputs: int,
                         tab_space: int):
    """Função para fazer as atribuições das entradas aos sinais. Exemplo:
    #Exemplo 1
    signal_receive_string = signal_receive_input(num_inputs,1)
      Output:
          sx1 <= x1;
          sx2 <= x2;
          sx3 <= x3;
          sw1 <= w1;
          sw2 <= w2;
          sw3 <= w3;

    #Exemplo 2
    signal_receive_string = signal_receive_input(num_inputs,6)
      Output:
                      sx1 <= x1;
                      sx2 <= x2;
                      sx3 <= x3;
                      sw1 <= w1;
                      sw2 <= w2;
                      sw3 <= w3;
    -----------------------------------------------------
    Args:
        num_inputs (int): número de entradas
        tab_space (str): número de 'espaços tab' que terá antes de cada linha do texto
    """
    signal_receive = []

    # tab_space = 2
    tab_space = ['  ']*tab_space
    tab_space = ''.join(map(str, tab_space))

    for i in range(1, num_inputs+1):
        signal_receive.append(f"{tab_space}sx{str(i)} <= x{str(i)};")

    for i in range(1, num_inputs+1):
        signal_receive.append(f"{tab_space}sw{str(i)} <= w{str(i)};")

    signal_receive_string = '\n'.join(map(str, (signal_receive)))
    return (signal_receive_string)
# signal_receive_string = signal_receive_input(num_inputs,1)
# print(signal_receive_string)


def signal_receive_rst(rst_space: int,
                       sum_sequence: list,
                       mult_sequence: list):
    """Função para gerar a atribuição dos somadores e multiplicadores, quando o reset é ativado (others => '0'). Exemplo:

    #Exemplo 1
    rst_receive_string = signal_receive_rst(rst_space = 0, 
    sum_sequence = ['soma_1', 'soma_2', 'soma_3'],
    mult_sequence= ['mult_1', 'mult_2', 'mult_3'])

    Output:
      --output <= (OTHERS => '0');
      soma_1 <= (OTHERS => '0');
      soma_2 <= (OTHERS => '0');
      soma_3 <= (OTHERS => '0');
      mult_1 <= (OTHERS => '0');
      mult_2 <= (OTHERS => '0');
      mult_3 <= (OTHERS => '0');

    #Exemplo 2
    rst_receive_string = signal_receive_rst(rst_space = 3, 
    sum_sequence = ['soma_1', 'soma_2'],
    mult_sequence= ['mult_1', 'mult_2'])

    Output:
            -- output <= (OTHERS => '0');
            soma_1 <= (OTHERS => '0');
            soma_2 <= (OTHERS => '0');
            mult_1 <= (OTHERS => '0');
            mult_2 <= (OTHERS => '0');

    ----------------------------------------------------------
    Args:
        rst_space (int): número de 'tabs' a esquerda de cada linha. Serve para melhor formatação do código
        sum_sequence (list): lista de somadores. Exemplo: ['soma1','soma2']. Esta lista será gerada automaticamente pelas funções anteriores
        mult_sequence (list): lista de multiplicadores. Exemplo: ['mult1','mult2']
    """
    rst_space = ['  ']*rst_space
    rst_space = ''.join(map(str, rst_space))

    rst_receive = []
    # rst_receive.append(rst_space + "output <= (OTHERS => '0');")

    for i in range(0, len(sum_sequence)):
        rst_receive.append(rst_space + sum_sequence[i]+" <= (OTHERS => '0');")

    for i in range(0, len(mult_sequence)):
        rst_receive.append(rst_space + mult_sequence[i]+" <= (OTHERS => '0');")

    rst_receive_string = '\n'.join(map(str, (rst_receive)))
    rst_receive_string = erase_empty_lines(rst_receive_string)

    return (rst_receive_string)
# rst_receive_string = signal_receive_rst(rst_space, sum_sequence_string,mult_sequence_string)
# rst_receive_string = signal_receive_rst(rst_space, sum_sequence,mult_sequence)
# print(rst_receive_string)


def clk_receive_logic(clk_space, IO_type, bits, n_bin, sum_sequence, mult_sequence, output: str = 'y'):
    clk_space = ['  ']*clk_space
    clk_space = ''.join(map(str, clk_space))

    clk_receive = []

    last_sum_name = replace_chars(sum_sequence[-1:])
    last_sum_name
    clk_receive.append(
        f"{clk_space}{output} <= {IO_type}({last_sum_name}({str(bits+n_bin - 1)} DOWNTO {str(n_bin)}));")

    for i in range(0, len(mult_sequence)):
        clk_receive.append(
            f"{clk_space}{mult_sequence[i]} <= ({IO_type}(sx{str(i+1)}) * {IO_type}(sw{str(i+1)}));")

        # (signed(sx1) * signed(sw1));

    clk_receive_string = '\n'.join(map(str, (clk_receive)))
    clk_receive_string = erase_empty_lines(clk_receive_string)

    return (clk_receive_string, clk_receive)
# clk_receive_string, clk_receive = clk_receive_logic(clk_space,IO_type,bits,n_bin,mult_sequence)
# print(clk_receive_string)
# print(clk_receive)


def tree_sum_algorithm(num_inputs, clk_space, sum_sequence, mult_sequence):
    # ------------------------------------------------------ ÁRVORE DE SOMA ------------------------------------------------------ #
    import math
    from math import log
    clk_space = ['  ']*clk_space
    clk_space = ''.join(map(str, clk_space))

    sum_receive = []
    i_sum = 0
    i_sum_2 = 1
    i_mult = 0

    op_mult = len(mult_sequence)
    op_soma = len(sum_sequence) - 1

    for j in range(1, int(log(num_inputs, 2)+1+1)):  # +1 bias +1 começa em 1

        if (j == 1):
            # -------------------- AQUI FAZ A SOMA DAS MULTIPLICAÇÕES -------------------#

            # ----------------- ÁRVORE PAR -----------------#
            for i in range(0, math.floor(num_inputs/2)):  # OP: SOMA <= MULT + MULT
                sum_receive.append(clk_space + "soma_" + str(i+1) + " <=  mult_" +
                                   str(((2*i)+1)) + " + mult_" + str((2*i)+2) + ";")

                # print(sum_receive[-1:])
                i_sum = i_sum + 1

                op_soma = op_soma - 1
                op_mult = op_mult - 2

        else:
            # --------------------- AQUI FAZ A ÁRVORE DE SOMAS ---------------------#

            while (op_soma > op_mult):  # OP: SOMA <= SOMA + SOMA

                i_sum = i_sum + 1
                sum_receive.append(clk_space+"soma_"
                                   + str(i_sum)
                                   + " <=  soma_" + str(i_sum_2) + " + soma_" + str(i_sum_2 + 1) + ";")

                # Luis Antonio Spader Simon - luisspaders@gmail.com
                # print(sum_receive[-1:])
                i_sum_2 = i_sum_2 + 2

                op_soma = op_soma - 1

    if (op_mult > 0):  # OP: SOMA <= SOMA + MULT

        i = i + 1
        i_sum = i_sum + 1
        sum_receive.append(clk_space+"soma_"
                           + str(i_sum)
                           + " <=  soma_" + str(i_sum_2) + " + mult_" + str(i_sum_2 + 2) + ";")

        # print(sum_receive[-1:])

        op_soma = op_soma - 1
        op_mult = op_mult - 1

    # Luis Antonio Spader Simon - luisspaders@gmail.com
    return sum_receive
# sum_receive = tree_sum_algorithm(num_inputs,clk_space,sum_sequence,mult_sequence)


def arvore_de_soma_strings(num_inputs: int,
                           bits: int,
                           n_bin: int,
                           IO_type: str,
                           rst_space: int,
                           clk_space: int,
                           output: str = 'y'):

    # rst_space = ['  ']*rst_space
    # rst_space = ''.join(map(str, rst_space))

    sum_sequence_string, mult_sequence_string, sum_sequence, mult_sequence = sum_mult_seq(
        num_inputs)
    # print (sum_sequence_string)
    # print (mult_sequence_string)
    # print (sum_sequence)
    # print (mult_sequence)

    s_sum = seq_signal(sum_sequence_string, "SIGNAL", IO_type, (2*bits))
    s_mult = seq_signal(mult_sequence_string, "SIGNAL", IO_type, (2*bits))
    # print(s_sum)
    # print(s_mult)

    signal_receive_string = signal_receive_input(num_inputs, 1)
    # print(signal_receive_string)

    rst_receive_string = signal_receive_rst(
        rst_space, sum_sequence, mult_sequence)
    # print(rst_receive_string)

    clk_receive_string, clk_receive = clk_receive_logic(
        clk_space, IO_type, bits, n_bin, sum_sequence, mult_sequence, output=output)
    # print(clk_receive_string)

    sum_receive = tree_sum_algorithm(
        num_inputs, clk_space, sum_sequence, mult_sequence)
    last_sum_name = replace_chars(sum_sequence[-1:])
    last_sum = last_sum_name+" <= " + \
        replace_chars(sum_sequence[-2:-1]) + " + sbias; \n"
    last_sum = str(last_sum)
    # last_sum

    clk_space = ['  ']*clk_space
    clk_space = ''.join(map(str, clk_space))
    clk_receive_string = '\n'.join(
        map(str, (clk_receive + sum_receive))) + "\n"

    clk_receive_string = clk_receive_string + clk_space + last_sum + "\n"
    # print(clk_receive_string)

    s_sum = '\n'.join(map(str, s_sum))
    s_mult = '\n'.join(map(str, s_mult))

    return (s_sum, s_mult, signal_receive_string, rst_receive_string, clk_receive_string)
# s_sum,s_mult,signal_receive_string_MAC,rst_receive_string_MAC,clk_receive_string_MAC = arvore_de_soma_strings(num_inputs,bits,n_bin,IO_type,rst_space,clk_space)
# if (print_cells_result == 1):
#   print(rst_receive_string_MAC)
#   print('------------------------')
#   print(clk_receive_string_MAC)

# ----------------- COM BARREIRAS --------------

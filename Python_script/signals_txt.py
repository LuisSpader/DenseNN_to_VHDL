[
    ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
    ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
    ['c0_n2_W_out', 'c3_n2_W_out'],
    ['c0_n3_W_out']
]
# c3_n0_W_out => c2_n0_W_out;
# c3_n1_W_out => c2_n1_W_out;
# c3_n2_W_out => c0_n2_W_out;
[
    ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out'],
    ['c0_n1_W_out', 'c2_n1_W_out'],
    ['c0_n2_W_out'],
    ['c0_n3_W_out']
]
# c2_n0_W_out => c1_n0_W_out;
# c2_n1_W_out => c0_n1_W_out;
[
    ['c0_n0_W_out'],
    ['c0_n1_W_out'],
    ['c0_n2_W_out'],
    ['c0_n3_W_out']
]
# c1_n0_W_out = > c0_n0_W_out


# ir dando append em uma outra lista em cada iteração
# planificar ambas as listas
# remover algo igual entre os 2
# a lista tendo só 1 item, procurar isso em alguma linha do texto:
#     a linha do texto que tiver isso, deve ser removida,
#     a linha anterior, deve ser removida o último caractere
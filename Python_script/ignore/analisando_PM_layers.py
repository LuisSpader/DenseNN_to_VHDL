#   SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out                  : signed(BITS - 1 DOWNTO 0); --todo
#   SIGNAL c1_n0_W_out                                            : signed(BITS - 1 DOWNTO 0); --todo
#   SIGNAL c2_n0_W_out, c2_n1_W_out                               : signed(BITS - 1 DOWNTO 0); --todo

# layer0		layer1		layer2		layer3
# n0_out	    n0_out	    n0_out	    n0
# n1_out			        n1_out	    n1
# n2_out					            n2
# n3

neurons_PM_matrix = [
    ['c0_n0_W_out', 'c0_n1_W_out', 'c0_n2_W_out', 'c0_n3_W_out'],
    ['c1_n0_W_out'],
    ['c2_n0_W_out', 'c2_n1_W_out'],
    ['c3_n0_W_out', 'c3_n1_W_out', 'c3_n2_W_out']
]
# ===================================================================
# ----- ITERAÇÃO 0 -----
neurons_PM_matrix = [
    ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
    ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
    ['c0_n2_W_out', 'c3_n2_W_out'],
    ['c0_n3_W_out']
]

# c0_n0_W_out = > c0_n0_W_out;  neurons_PM_matrix[0][0] => neurons_PM_matrix[0][0];
# c0_n1_W_out = > c0_n1_W_out;  neurons_PM_matrix[1][0] => neurons_PM_matrix[1][0];
# c0_n2_W_out = > c0_n2_W_out;  neurons_PM_matrix[2][0] => neurons_PM_matrix[2][0];
# c0_n3_W_out retirar
del neurons_PM_matrix[3]

# ----- ITERAÇÃO 1 -----
neurons_PM_matrix = [
    ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
    ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
    ['c0_n2_W_out', 'c3_n2_W_out']
]

# (c1_n0_W_out).replace('out','in') => c0_n0_W_out;
# neurons_PM_matrix[0][1].replace('out','in') => neurons_PM_matrix[0][0];
del neurons_PM_matrix[0][0]

# (c2_n1_W_out).replace('out','in') => c0_n1_W_out;
# neurons_PM_matrix[1][1].replace('out','in') => neurons_PM_matrix[1][0];
del neurons_PM_matrix[1][0]

# (c3_n2_W_out).replace('out','in') => c0_n2_W_out;
# neurons_PM_matrix[2][1].replace('out','in') => neurons_PM_matrix[2][0];
del neurons_PM_matrix[2][0]

# ----- ITERAÇÃO 3 -----
neurons_PM_matrix = [
    ['c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
    ['c2_n1_W_out', 'c3_n1_W_out'],
    ['c3_n2_W_out']
]

# (c2_n0_W_out).replace('out','in') => c1_n0_W_out;
# neurons_PM_matrix[0][1].replace('out','in') => neurons_PM_matrix[0][0];
del neurons_PM_matrix[0][0]

# (c3_n1_W_out).replace('out','in') => c2_n1_W_out;
# neurons_PM_matrix[1][1].replace('out','in') => neurons_PM_matrix[1][0];
del neurons_PM_matrix[1][0]

# c3_n2_W_out retirar
del neurons_PM_matrix[2]

# ----- ITERAÇÃO 4 -----
neurons_PM_matrix = [
    ['c2_n0_W_out', 'c3_n0_W_out'],
    ['c3_n1_W_out']
]

# (c3_n0_W_out).replace('out','in') => c2_n0_W_out;
# neurons_PM_matrix[0][1].replace('out','in') => neurons_PM_matrix[0][0];
del neurons_PM_matrix[0][0]

# c3_n1_W_out retirar
del neurons_PM_matrix[1]

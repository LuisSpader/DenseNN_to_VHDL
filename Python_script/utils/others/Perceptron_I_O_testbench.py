from bitstring import BitArray
import math
import pandas as pd
import numpy as np

# defining bias and input values
n_bits = int(8)
n_bits_input = n_bits
num_inputs = 4
is_signed = 1  # 1= signed || 0= unsigned
is_sigmoid_signed = 1  # 1= signed || 0= unsigned
weights_on_memory = 1  # 1: on memory || 0: weights = inputs

m_bin = 0  # 'm' binary digits are the integer part
n_bin = n_bits - m_bin    # 'n' binary digits are the fractional part of `x`;
n_bin_sigmoid = n_bin  # + 3 #número de casas decimais sigmoide memória

download_files = 0  # 1= para baixar || 0= não baixar

# atenuacao_rescale = 0.95
atenuacao_rescale = 1

# ------------------- ROM DEFINITIONS -------------
rom_clk = 0  # 1= rom com clock || 0= sem clock

# nome_rom = "rom_fx_addwidth"+str(memory_depth)+"_addbit"+str(int(math.log2(memory_depth)))+"_datawidth"+str(memory_width)
nome_rom = "ROM_fixedpoint_8bit"

# -------------------------
# general parameters
# bias = ((2**m_bin)/2) -4             #117(8b)
bias = 0
w_value = 0.125
n_inputs_wich_increase = num_inputs  # nro de inputs que crescem seu valor
# n_inputs_wich_increase = 1            #nro de inputs que crescem seu valor


sigmoid_range = 2  # tamanho eixo x, sigmoide antes tratamento
range_tb_df = (2**m_bin)  # tamanho do dataframe do tb

# mult_factor = 2                       # expande sigmoide
# mult_factor =(2**m_bin)/sigmoid_range # expande sigmoide
mult_factor = 1


if (is_signed == 1):
    unsigned_offset = 0
    offset_df_memory = 0
    # norm_y = (2**(m_bin-1))                   # normalização em y: 256(8bits)
    norm_y = 1
    # dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input
    dx_sigmoid_final = 1/(2**(n_bin_sigmoid-1))

else:
    unsigned_offset = int((2**m_bin)/2)  # 128
    offset_df_memory = unsigned_offset - ((sigmoid_range/2)*mult_factor)
    norm_y = (2**(m_bin))                   # normalização em y: 256(8bits)
    # dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input
    dx_sigmoid_final = 1/(2**(n_bin_sigmoid))

# dx_sigmoid = 1/(2**n_bin_sigmoid)     #dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input

dx_sigmoid = dx_sigmoid_final/mult_factor  # dx necessário antes da expansão

dx_input = 1/(2**n_bin)  # dx das entradas do tb -> depende das casas .fixo

# 0= int(n) ; 1= float(address)|| indice da memoria int ou float
memory_address_type = 1
# 1= memória com endereços para valor zero || 0=memória apenas com valores
mem_zeros = 0
# ----------------------------------
# DX SIGMOID
if (dx_sigmoid == 1):
    total_dx = range_tb_df+1
else:

    total_dx = (1/dx_sigmoid)*sigmoid_range + 1

# total_dx = range_tb_df+1
# total_dx
# -----------------------------------------
# DX INPUTS TB-> define numero total de linhas dataframe inputs_tb
if (dx_input == 1):
    total_dx_input = range_tb_df+1

else:
    total_dx_input = (1/dx_input)*range_tb_df + 1

# total_dx = range_tb_df+1
# total_dx_input
# ----------------------------------------
# Functions Calculus
exp = math.exp


def sigmoid(x):
    return (1/(1+(exp(-1*x))))


sigmoid(2)

# ----------------------------------------
## Bin | float >> functions
# !pip install bitstring


def int2bin(a, lenght):
    b = BitArray(int=a, lenght=lenght)
    return b.bin

# INT -> BINARY conversion (with 2 complement)


def int_to_bin(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

# Function used to replace zeros by ones and vice versa


def transform(x):
    text = ''
    for i in x:
        if i == '1':
            text += "0"  # directly add the `.`
        else:
            text += "1"  # directly add the `_`
    return text


transform('01111100')  # call the function


ones = str(np.ones(m_bin+n_bin_sigmoid-1))
ones = ones.replace(".", "")
ones = ones.replace("[", "")
ones = ones.replace("]", "")
ones = ones.replace(" ", "")

# ------------------------------
# Começo df_inputs
a = int(((2**n_bits)/2)-7)  # 128 - 7 = 121
b = int(((2**n_bits)/2)+7)  # 128 + 7 = 135

testes_x1 = range(0, 14, 1)  # start, end, step
testes_x2 = range(0, 14, 1)  # start, end, step
testes_x3 = range(0, 14, 1)  # start, end, step
testes_w1 = range(0, 14, 1)  # start, end, step
testes_w2 = range(0, 14, 1)  # start, end, step
testes_w3 = range(0, 14, 1)  # start, end, step

input_increment = dx_sigmoid
dataframe_range = np.linspace(
    (-range_tb_df/2), (range_tb_df/2), int(total_dx_input))
# dataframe_range

df_inputs = pd.DataFrame()
i = 0
# Xi
while True:
    if (i < n_inputs_wich_increase):
        df_inputs["testes_x"+str(i+1)] = dataframe_range
        i = i+1
    elif (i < num_inputs):
        df_inputs["testes_x"+str(i+1)] = 1
        i = i+1
    else:
        i = 0
        break


# PESOS W_i

while True:
    if (i < n_inputs_wich_increase):
        df_inputs["testes_w"+str(i+1)] = w_value  # testes_w1
        i = i+1
    elif (i < num_inputs):
        df_inputs["testes_w"+str(i+1)] = 1  # testes_w1
        i = i+1
    else:
        df_inputs['bias'] = bias  # testes_w3
        i = 0
        break

df_weights = pd.DataFrame()
df_weights = df_inputs.iloc[:, 4:]
if (weights_on_memory == 1):  # pesos na memória
    df_inputs.drop(df_inputs.iloc[:, 4:], axis=1, inplace=True)
# df_inputs
# df_weights

# SUM
df_inputs["sum"] = 0
while True:
    if (weights_on_memory == 1):  # pesos na memória
        if (i < num_inputs):
            df_inputs["sum"] = df_inputs["sum"] + \
                (df_inputs["testes_x"+str(i+1)] *
                 df_weights["testes_w"+str(i+1)])
            i = i+1
        else:
            df_inputs["sum"] = df_inputs["sum"] + df_weights["bias"]
            i = 0
            break

    else:  # pesos na entrada
        if (i < num_inputs):
            df_inputs["sum"] = df_inputs["sum"] + \
                (df_inputs["testes_x"+str(i+1)]
                 * df_inputs["testes_w"+str(i+1)])
            i = i+1
        else:
            df_inputs["sum"] = df_inputs["sum"] + df_inputs["bias"]
            i = 0
            break
# --------------------------------------------
# Sigmoid
# range_tb_df
# vai de -128 a 127, dividido em 256 pontos (8 bits)
sigmoid_dx_list = np.linspace(-(sigmoid_range/2),
                              (sigmoid_range/2), int(total_dx))
# sigmoid_dx_list
# df_sigmoid = pd.DataFrame((range(-int(range_tb_df/2),int(range_tb_df/2)+1,1))) #start, end, step
df_sigmoid = pd.DataFrame(np.linspace(-(sigmoid_range/2),
                          (sigmoid_range/2), int(total_dx)))  # start, end, step
df_sigmoid.columns = ['n']  # INPUTS_df
# df_sigmoid['dx'] = sigmoid_dx_list
df_sigmoid = df_sigmoid*atenuacao_rescale

# ((1/(1+(exp(-1*(testes_x1))))).astype(float)).tolist()
# df[0].apply(lambda x: float(x))
sigmoide_rescale = (8/(sigmoid_range/2))*0.8
multiplied_list = [(1/(1+(exp(-1*(element*sigmoide_rescale)))))
                   for element in sigmoid_dx_list]
# multiplied_list
df_sigmoid['sigmoid'] = multiplied_list
# df_sigmoid

# -------------------------------------
# Sigmoid expansion (change 'x' rescale)

# n_re_scale = (df_sigmoid['n'])*mult_factor
n_re_scale = (df_sigmoid['n'])*mult_factor

# df_sigmoid['n'] = (df_sigmoid['n'] + (unsigned_offset/2))*mult_factor
df_sigmoid['n'] = n_re_scale

# zeros para serem salvos na memória
df_sigmoid['n_zeros'] = (df_sigmoid['n'] + dx_sigmoid)

df_sigmoid['sig_norm'] = df_sigmoid['sigmoid']*norm_y

# --------------------------------
# df_sigmoid_bin

# SIGMOID MEMORY
df_sigmoid_bin = pd.DataFrame()
df_sigmoid_bin['address'] = (df_sigmoid['n'])
df_sigmoid_bin['sigmoid'] = (df_sigmoid['sig_norm'])
df_sigmoid_bin['address_bin'] = (df_sigmoid['n'].apply(lambda x: Fxp(
    x, signed=is_signed, n_word=n_bin_sigmoid, n_frac=n_bin_sigmoid).bin()))
# df_sigmoid_bin['address_zeros'] = (df_sigmoid['n_zeros'].apply(lambda x: Fxp(x, signed=is_signed, n_word= n_bin_sigmoid, n_frac= n_bin_sigmoid).bin() ))
df_sigmoid_bin['sigmoid_bin'] = (df_sigmoid['sig_norm'].apply(lambda x: Fxp(
    x, signed=is_sigmoid_signed, n_word=n_bin_sigmoid, n_frac=n_bin_sigmoid).bin()))
df_sigmoid_bin
#!!coluna address_zeros está repetindo endereços do address_bin!!

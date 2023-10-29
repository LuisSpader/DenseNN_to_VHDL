
import plotly.offline as py
import plotly.graph_objects as go
# import seaborn as sns
import matplotlib.pyplot as plt
from fxpmath import Fxp
import math
import pandas as pd
import numpy as np


# -----------------------------------------------------


def ROM_internal_param(BIT_WIDTH: int, is_signed: bool, is_sigmoid_signed: bool, n_integer: int) -> tuple:
    """
    Calcula os parâmetros internos para uma tabela de consulta ROM.

    Args:
    BIT_WIDTH (int): largura em bits da palavra a ser armazenada na tabela de consulta ROM.
    is_signed (bool): sinal da palavra a ser armazenada na tabela de consulta ROM.
    is_sigmoid_signed (bool): se True, a função de ativação sigmoid terá valores negativos; caso contrário, 
        ela terá apenas valores positivos.
    n_integer (int): o número de bits alocados para a parte inteira da palavra.

    Returns:
    Uma tupla com os seguintes elementos:
    - offset_df_memory (int): deslocamento necessário para armazenar valores na memória.
    - norm_y (int): fator de normalização em y.
    - dx_sigmoid (float): incremento necessário para armazenar a função sigmoid na memória.
    - total_dx (float): incremento total necessário para armazenar valores na tabela de consulta ROM.
    - memory_address_type (bool): indica se o endereço da memória é representado por um inteiro ou um float.
    - n_mantissa_sigmoid (int): número de bits alocados para a parte fracionária da função sigmoid.
    - memory_address_type (bool): indica se o endereço da memória é representado por um inteiro ou um float.
    - integer_mult_factor (int): fator de conversão para inteiro.
    - sigmoid_range (int): tamanho do eixo x antes do tratamento para a função sigmoid.

    """
    # 'x' binary digits are the fractional part of `x`;
    n_mantissa = BIT_WIDTH - n_integer
    n_mantissa_sigmoid = n_mantissa         # casas decimais
    # 0= int(n) ; 1= float(address)|| indice da memoria int ou float
    memory_address_type = True

    sigmoid_range = 2  # tamanho eixo x, sigmoide antes tratamento
    range_tb_df = (2**n_integer)  # tamanho do dataframe do tb
    integer_mult_factor = 2 ** (BIT_WIDTH-1)  # conversão para inteiros
    # integer_mult_factor = 1 # conversão para inteiros

    # DX SIGMOID
    is_signed = True  # 1= signed || 0= unsigned
    if is_signed:
        unsigned_offset = 0
        offset_df_memory = 0
    # dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input
        dx_sigmoid_final = 1/(2**(n_mantissa_sigmoid))

    else:
        unsigned_offset = int((2**n_integer)/2)  # 128
        offset_df_memory = unsigned_offset - \
            ((sigmoid_range/2)*integer_mult_factor)
        # dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input
        dx_sigmoid_final = 1/(2**(n_mantissa_sigmoid))

    if is_sigmoid_signed:  # normalizando para utilizar todos os bits
        norm_y = 1
    else:
        # normalização em y: 256(8bits)
        norm_y = (2**(n_integer))
    # dx_sigmoid = dx_sigmoid_final/mult_factor   #dx necessário antes da expansão
    # dx_sigmoid = dx_sigmoid_final/integer_mult_factor   #dx necessário antes da expansão
    dx_sigmoid = dx_sigmoid_final  # dx necessário antes da expansão

    if (dx_sigmoid == 1):
        total_dx = range_tb_df+1
    else:
        total_dx = (1/dx_sigmoid)*sigmoid_range + 1
    return offset_df_memory, norm_y, dx_sigmoid, total_dx, memory_address_type, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, sigmoid_range


def df_ROM_gen(integer_mult_factor: int, sigmoid_range: int, norm_y: int, total_dx: int) -> pd.DataFrame:
    """
    Generate a pandas DataFrame containing the values of the sigmoid function and its normalized representation.

    Args:
        integer_mult_factor (int): A factor to convert the fractional part of x to an integer.
        sigmoid_range (int): The size of the x-axis before normalization.
        norm_y (int): The normalization factor for the y-axis.
        total_dx (int): The total number of samples for the sigmoid function.

    Returns:
        pd.DataFrame: A DataFrame with columns for the input x, the rescaled input x, the sigmoid function, the rescaled sigmoid function, and the normalized sigmoid function.
    """
    # Create a list of points for the sigmoid function
    sigmoid_dx_list = np.linspace(-(sigmoid_range/2),
                                  (sigmoid_range/2), int(total_dx))

    # Create a DataFrame for the inputs
    df = pd.DataFrame(np.linspace(-(sigmoid_range/2),
                      (sigmoid_range/2), int(total_dx)))
    df.columns = ['x']
    df['x_resc'] = df * integer_mult_factor

    # Define the sigmoid function and rescale it
    sigmoid_width_rescale = 0.7
    sigmoide_rescale = (8/(sigmoid_range/2)) * sigmoid_width_rescale
    multiplied_list = [(1/(1+(np.exp(-1*(element*sigmoide_rescale)))))
                       for element in sigmoid_dx_list]
    df['sigmoid'] = multiplied_list
    df['sigmoid_resc'] = df['sigmoid'] * integer_mult_factor

    # Rescale the sigmoid function to the normalized range
    df['sig_norm'] = df['sigmoid_resc'] * norm_y

    return df


def df_bin_gen(BIT_WIDTH: int, is_signed: bool, is_sigmoid_signed: bool, df: pd.DataFrame) -> pd.DataFrame:
    """
    Generates a binary representation of the input and sigmoid data.

    Parameters:
    BIT_WIDTH (int): The number of bits used to represent the binary number.
    is_signed (bool): Whether the binary number is signed or not.
    is_sigmoid_signed (bool): Whether the sigmoid is signed or not.
    df (pd.DataFrame): A pandas DataFrame containing the input and sigmoid data.

    Returns:
    pd.DataFrame: A pandas DataFrame containing the binary representation of the input and sigmoid data.
    """
    # X
    df_bin = pd.DataFrame()
    df_bin['address'] = (df['x_resc'])
    df_bin['address_bin'] = (df_bin['address'].apply(lambda x:  Fxp(
        x, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin()))
    address_bin_converted = df_bin['address_bin'].apply(lambda x:  Fxp(
        f"0b{x}", signed=is_signed, n_word=BIT_WIDTH, n_frac=0).astype(float))
    df_bin['address_bin_conv'] = address_bin_converted

    # Y (sigmoid)
    df_bin['sigmoid'] = (df['sig_norm'])
    df_bin['sigmoid_bin'] = (df_bin['sigmoid'].apply(lambda x:  Fxp(
        x, signed=is_sigmoid_signed, n_word=BIT_WIDTH, n_frac=0).bin()))
    df_bin['sigmoid_bin_conv'] = df_bin['sigmoid_bin'].apply(lambda x:  Fxp(
        f"0b{x}", signed=is_sigmoid_signed, n_word=BIT_WIDTH, n_frac=0).astype(float))
    df_bin.drop(df_bin.tail(1).index, inplace=True)  # drop last n rows
    # # AJUSTANTO DATAFRAME CONFORME LIMITES DE REPRESENTAÇÃO
    # upper_limit = (sigmoid_range/2 - (1/2**(BIT_WIDTH-1))) * (2**(BIT_WIDTH-1))
    # low_limit = -(sigmoid_range/2) * (2**(BIT_WIDTH-1))
    # print(upper_limit,low_limit)

    # df_bin['sigmoid'].loc[df_bin['sigmoid'] > upper_limit] = upper_limit # substituindo valores maiores que o limite superior, pelo próprio limite superior
    # df_bin['address'].loc[df_bin['address'] > upper_limit] = upper_limit # substituindo valores maiores que o limite superior, pelo próprio limite superior

    # # conferir quantas linhas de endereço duplicadas tem
    # len(df_bin['address_bin'])-len(df_bin['address_bin'].drop_duplicates())

    return df_bin


# colocando na memória com o Index
def ROM_txt_values(n_integer: int, n_mantissa_sigmoid: int,
                   memory_address_type: bool, integer_mult_factor: int,
                   offset_df_memory: float, dx_sigmoid: float,
                   df: pd.DataFrame, df_bin: pd.DataFrame):
    """
    Converts a DataFrame with normalized sigmoid values to binary and generates a 
    text file with ROM values in VHDL format. The ROM can be addressed with integer or
    float addresses depending on the `memory_address_type` argument.

    Args:
    - n_integer (int): number of integer bits in the output binary values
    - n_mantissa_sigmoid (int): number of mantissa bits in the output binary values
    - memory_address_type (bool): if False, the ROM will be addressed with integer values;
      if True, it will be addressed with float values
    - integer_mult_factor (int): multiplier factor for integer address values
    - offset_df_memory (float): offset value for the memory address
    - dx_sigmoid (float): step size between consecutive sigmoid values
    - df (pd.DataFrame): DataFrame containing the sigmoid values
    - df_bin (pd.DataFrame): DataFrame containing the binary representation of the sigmoid values

    Returns:
    - text_rom_to_asic (str): text containing the ROM values in VHDL format
    - ROM_clk (int): 0 if the ROM doesn't have a clock, 1 otherwise
    - memory_width (int): width of the ROM memory
    - memory_depth (int): depth of the ROM memory
    """
    df_sigmoid_first = float(df['x'].iloc[:1])
    i = 0
    text = str('')
# texto para fazer lógica 'signed' funcionar no std_logic_vector
    text_rom_to_asic = str(
        '--"int_f_x",--(address)  =integer_MAC|| f(x)               = int_f_x \n')  # 0 a 1 e -1 a 0

# ------------------------------- ROM ASIC -------------------------------#
# texto rom -> vhd (asic) || índice por 'x'
    for i in range(int(len(df_bin)/2), len(df_bin)):
        text_rom_to_asic = (
            text_rom_to_asic+'"'
            + str(df_bin['sigmoid_bin'][i]) + '",-- '
            + f"({(df_bin['address_bin'][i])})"
            + f" = {str(df_bin['address_bin_conv'][i]).ljust(9, ' ')}"
            + f" || {str(df['sig_norm'][i]).ljust(18, ' ')} = {str(df_bin['sigmoid_bin_conv'][i])}\n")

    for i in range(0, int(len(df_bin)/2)):
        text_rom_to_asic = (
            text_rom_to_asic+'"'  # pega o q já tem de texto
            + str(df_bin['sigmoid_bin'][i]) + \
            '",-- '  # pega elemento i da sigmoide
            + f"({df_bin['address_bin'][i]})"
            + f" = {str(df_bin['address_bin_conv'][i]).ljust(9, ' ')}"
            + f" || {str(df['sig_norm'][i]).ljust(18, ' ')} = {str(df_bin['sigmoid_bin_conv'][i])}\n")


# ------------------------------- ROM .mif -------------------------------#
# define se o endereço será com 'x' ou 'address'
    if (memory_address_type == False):  # 0= int(n)
        for i in range(0, len(df_bin)):  # caso seja por 'x'
            text = (text+'' + str(df_bin.index[i]) + ':' + str(df_bin['sigmoid_bin'][i]) + ';-- '+str(
                offset_df_memory + df_sigmoid_first+(i*dx_sigmoid*integer_mult_factor))+' || '+str(df['sig_norm'][i]) + '\n')
        # )
    else:  # 1= float(address)
        for i in range(0, len(df_bin)):
            text = (text+'' + str(df_bin['address_bin'][i]) + ':' + str(df_bin['sigmoid_bin'][i]) + ';-- '+str(
                offset_df_memory + df_sigmoid_first+(i*dx_sigmoid*integer_mult_factor))+' || '+str(df['sig_norm'][i]) + '\n')


# ## ROM Definitions
    ROM_clk = 0  # 1= rom com clock || 0= sem clock

    memory_width = n_integer + n_mantissa_sigmoid
    memory_depth = len(df_bin)

    if memory_address_type == False:  # 0= int(n)
        # Enter BIN, DEC, HEX, OCT, or UNS; #because memory is with (signed/unsigned) bin address
        memory_value_type = 'DEC'
    else:  # 1= float(address)
        # Enter BIN, DEC, HEX, OCT, or UNS; #because memory is with (signed/unsigned) bin address
        memory_value_type = 'BIN'
    return text_rom_to_asic, ROM_clk, memory_width, memory_depth


def ROM_txt_gen(text_rom_to_asic: str, ROM_clk: bool, ROM_name: str, memory_width: int, memory_depth: int) -> str:
    """
    Generate text for a ROM in VHDL.

    Args:
        text_rom_to_asic (str): A string representing the contents of the ROM.
        ROM_clk (bool): A boolean indicating whether the ROM should be clocked.
        ROM_name (str): A string representing the name of the ROM.
        memory_width (int): An integer representing the width (in bits) of each element of the ROM.
        memory_depth (int): An integer representing the depth (number of elements) of the ROM.

    Returns:
        A string representing the text of the VHDL code for the ROM.
    """
    if ROM_clk:
        rom_text_asic = (
            f'''--https://stackoverflow.com/questions/17579716/implementing-rom-in-xilinx-vhdl
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;
----------------
ENTITY {ROM_name} is
generic(addr_heigth : integer := {str(memory_depth)}; -- store {str(memory_depth)} elements
				addr_bits  : integer := {str(int(math.log2(memory_depth)))}; -- required bits to store {str(memory_depth)} elements
				data_width : integer := {str(memory_width)}  -- each element has {str(memory_width)}-bits
				);
port ( clk : in std_logic ;
		address : in std_logic_vector(addr_bits-1 downto 0);
		data_out : out std_logic_vector(data_width-1 downto 0)
		) ;
end entity ;
------------------
architecture arch of {ROM_name} is
	signal reg_address: std_logic_vector(addr_bits-1 downto 0);
	type memory is array ( 0 to addr_heigth-1 ) of std_logic_vector(data_width-1 downto 0 ) ;
	constant myrom : memory := (
{text_rom_to_asic}
--	2 => "11111111" , --255
--	3 => "11010101" ,
others => "{str(memory_width*'0')}"
) ;
begin
	process(clk)
		begin
		if( clk'event and clk = '1' ) then
			reg_address <= address ;
		end if ;
	end process ;
---------------
data_out <= myrom(to_integer(unsigned(reg_address))) ;
end architecture ;
''')

    else:
        rom_text_asic = (f'''
--https://stackoverflow.com/questions/17579716/implementing-rom-in-xilinx-vhdl
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;
----------------
ENTITY {ROM_name} is
generic(addr_heigth : integer := {str(memory_depth)}; -- store {str(memory_depth)} elements
				addr_bits  : integer := {str(int(math.log2(memory_depth)))}; -- required bits to store {str(memory_depth)} elements
				data_width : integer := {str(memory_width)}  -- each element has {str(memory_width)}-bits
				);
  PORT (
    address : IN STD_LOGIC_VECTOR(addr_bits - 1 DOWNTO 0);
    data_out : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
  );
END ENTITY;
------------------
architecture arch of {ROM_name} is
	type memory is array ( 0 to addr_heigth-1 ) of std_logic_vector(data_width-1 downto 0 ) ;
	constant myrom : memory := (
{text_rom_to_asic}
--	2 => "11111111" , --255
--	3 => "11010101" ,
others => "{str(memory_width*'0')}"
) ;
begin
---------------
data_out <= myrom(to_integer(unsigned(address))) ;
end architecture ;
''')

    return rom_text_asic


def ROM_Sigmoid_gen(
    DOWNLOAD: bool,
    ROM_name: str,
    BIT_WIDTH: int,
    is_signed: bool,
    is_sigmoid_signed: bool = False,
    n_integer: int = 1,
    path: str = './'
):
    """Generates the VHDL code for a ROM that stores the values of a sigmoid function.

    Args:
        DOWNLOAD (bool): If True, the VHDL code will be saved to a file.
        ROM_name (str): The name of the ROM.
        BIT_WIDTH (int): The bit width of the data stored in the ROM.
        is_signed (bool): If True, the data stored in the ROM is signed.
        is_sigmoid_signed (bool, optional): If True, the sigmoid function will produce signed output. Defaults to False.
        n_integer (int, optional): The number of integer bits in the data stored in the ROM. Defaults to 1.
        path (str, optional): The path where the VHDL file will be saved. Defaults to './'.

    Returns:
        str or None: The VHDL code for the ROM, if DOWNLOAD is False. Otherwise, None.

    Raises:
        ValueError: If BIT_WIDTH is less than 2 or greater than 32.
    """
    offset_df_memory, norm_y, dx_sigmoid, total_dx, memory_address_type, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, sigmoid_range = ROM_internal_param(
        BIT_WIDTH, is_signed, is_sigmoid_signed, n_integer)
    df = df_ROM_gen(integer_mult_factor, sigmoid_range, norm_y, total_dx)

    df_bin = df_bin_gen(BIT_WIDTH, is_signed, is_sigmoid_signed, df)

    text_rom_to_asic, ROM_clk, memory_width, memory_depth = ROM_txt_values(
        n_integer, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, offset_df_memory, dx_sigmoid, df, df_bin)

    rom_text_asic = ROM_txt_gen(
        text_rom_to_asic, ROM_clk, ROM_name, memory_width, memory_depth)

    if DOWNLOAD:
        final_path = f"{path}/{ROM_name}.vhd"
        text_file = open(final_path, "w")
        text_file.write(rom_text_asic)
        text_file.close()
        print(f"arquivo gerado: {final_path}")


# ------------------------------------
# # defining bias and input values
# BIT_WIDTH = int(8)
# is_signed = True
# is_sigmoid_signed = False
# n_integer = 1                           # 'm' binary digits are the integer part
# DOWNLOAD = True  # 1= para baixar || 0= não baixar
# path = "./Python_script/utils/components/"

# ROM_Sigmoid_gen(
#     DOWNLOAD,
#     f"ROM_Sigmoid_{BIT_WIDTH}bit",
#     BIT_WIDTH,
#     is_signed,
#     is_sigmoid_signed,
#     n_integer,
#     path)
# ============================================================== old functions ====================================
# def ROM_internal_param(BIT_WIDTH: int, is_signed: bool, is_sigmoid_signed: bool, n_integer: int) -> tuple:
#     """
#     # 'x' binary digits are the fractional part of `x`;
#     n_mantissa = BIT_WIDTH - n_integer
#     n_mantissa_sigmoid = n_mantissa         # casas decimais
#     # 0= int(n) ; 1= float(address)|| indice da memoria int ou float
#     memory_address_type = True

#     sigmoid_range = 2  # tamanho eixo x, sigmoide antes tratamento
#     range_tb_df = (2**n_integer)  # tamanho do dataframe do tb
#     integer_mult_factor = 2 ** (BIT_WIDTH-1)  # conversão para inteiros
#     # integer_mult_factor = 1 # conversão para inteiros

#     # DX SIGMOID
#     is_signed = True  # 1= signed || 0= unsigned
#     if is_signed:
#         unsigned_offset = 0
#         offset_df_memory = 0
#     # dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input
#         dx_sigmoid_final = 1/(2**(n_mantissa_sigmoid))

#     else:
#         unsigned_offset = int((2**n_integer)/2)  # 128
#         offset_df_memory = unsigned_offset - \
#             ((sigmoid_range/2)*integer_mult_factor)
#         # dx da sigmoid na memória -> depende das casas .fixo com adicional para resolução de dx_input
#         dx_sigmoid_final = 1/(2**(n_mantissa_sigmoid))

#     if is_sigmoid_signed:  # normalizando para utilizar todos os bits
#         norm_y = 1
#     else:
#         # normalização em y: 256(8bits)
#         norm_y = (2**(n_integer))
#     # dx_sigmoid = dx_sigmoid_final/mult_factor   #dx necessário antes da expansão
#     # dx_sigmoid = dx_sigmoid_final/integer_mult_factor   #dx necessário antes da expansão
#     dx_sigmoid = dx_sigmoid_final  # dx necessário antes da expansão

#     if (dx_sigmoid == 1):
#         total_dx = range_tb_df+1
#     else:
#         total_dx = (1/dx_sigmoid)*sigmoid_range + 1
#     return offset_df_memory, norm_y, dx_sigmoid, total_dx, memory_address_type, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, sigmoid_range

# def df_ROM_gen(integer_mult_factor, sigmoid_range, norm_y, total_dx):
#     # vai de -128 a 127, dividido em 256 pontos (8 bits)
#     sigmoid_dx_list = np.linspace(-(sigmoid_range/2),
#                                   (sigmoid_range/2), int(total_dx))

#     df = pd.DataFrame(np.linspace(-(sigmoid_range/2),
#                                   (sigmoid_range/2), int(total_dx)))  # start, end, step
#     df.columns = ['x']  # INPUTS_df
#     df['x_resc'] = df*integer_mult_factor
#     exp = math.exp

#     # reescala manualmente a largura da sigmoid (eixo x)
#     sigmoid_width_rescale = 0.7
#     sigmoide_rescale = (8/(sigmoid_range/2)) * sigmoid_width_rescale
#     # (1/(1+(e^(-1*(x*sigmoide_rescale)))))
#     multiplied_list = [(1/(1+(exp(-1*(element*sigmoide_rescale)))))
#                        for element in sigmoid_dx_list]
#     df['sigmoid'] = multiplied_list
#     df['sigmoid_resc'] = df['sigmoid']*integer_mult_factor

#     # ## Sigmoid expansion (change 'x' rescale)
#     df['sig_norm'] = df['sigmoid_resc']*norm_y
#     return df

# def df_bin_gen(BIT_WIDTH, is_signed, is_sigmoid_signed, df):
#     # X
#     df_bin = pd.DataFrame()
#     df_bin['address'] = (df['x_resc'])
#     df_bin['address_bin'] = (df_bin['address'].apply(lambda x:  Fxp(
#         x, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin()))
#     address_bin_converted = df_bin['address_bin'].apply(lambda x:  Fxp(
#         f"0b{x}", signed=is_signed, n_word=BIT_WIDTH, n_frac=0).astype(float))
#     df_bin['address_bin_conv'] = address_bin_converted

#     # Y (sigmoid)
#     df_bin['sigmoid'] = (df['sig_norm'])
#     df_bin['sigmoid_bin'] = (df_bin['sigmoid'].apply(lambda x:  Fxp(
#         x, signed=is_sigmoid_signed, n_word=BIT_WIDTH, n_frac=0).bin()))
#     df_bin['sigmoid_bin_conv'] = df_bin['sigmoid_bin'].apply(lambda x:  Fxp(
#         f"0b{x}", signed=is_sigmoid_signed, n_word=BIT_WIDTH, n_frac=0).astype(float))
#     df_bin.drop(df_bin.tail(1).index, inplace=True)  # drop last n rows
#     # # AJUSTANTO DATAFRAME CONFORME LIMITES DE REPRESENTAÇÃO
#     # upper_limit = (sigmoid_range/2 - (1/2**(BIT_WIDTH-1))) * (2**(BIT_WIDTH-1))
#     # low_limit = -(sigmoid_range/2) * (2**(BIT_WIDTH-1))
#     # print(upper_limit,low_limit)

#     # df_bin['sigmoid'].loc[df_bin['sigmoid'] > upper_limit] = upper_limit # substituindo valores maiores que o limite superior, pelo próprio limite superior
#     # df_bin['address'].loc[df_bin['address'] > upper_limit] = upper_limit # substituindo valores maiores que o limite superior, pelo próprio limite superior

#     # # conferir quantas linhas de endereço duplicadas tem
#     # len(df_bin['address_bin'])-len(df_bin['address_bin'].drop_duplicates())

#     return df_bin
# # colocando na memória com o Index
# def ROM_txt_values(BIT_WIDTH, n_integer, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, offset_df_memory, dx_sigmoid, df, df_bin):
#     df_sigmoid_first = float(df['x'].iloc[:1])
#     i = 0
#     text = str('')
# # texto para fazer lógica 'signed' funcionar no std_logic_vector
#     text_rom_to_asic = str(
#         '--"int_f_x",--(address)  =integer_MAC|| f(x)               = int_f_x \n')  # 0 a 1 e -1 a 0

# # ------------------------------- ROM ASIC -------------------------------#
# # texto rom -> vhd (asic) || índice por 'x'
#     for i in range(int(len(df_bin)/2), len(df_bin)):
#         text_rom_to_asic = (
#             text_rom_to_asic+'"'
#             + str(df_bin['sigmoid_bin'][i]) + '",-- '
#             + f"({(df_bin['address_bin'][i])})"
#             + f" = {str(df_bin['address_bin_conv'][i]).ljust(9, ' ')}"
#             + f" || {str(df['sig_norm'][i]).ljust(18, ' ')} = {str(df_bin['sigmoid_bin_conv'][i])}\n")

#     for i in range(0, int(len(df_bin)/2)):
#         text_rom_to_asic = (
#             text_rom_to_asic+'"'  # pega o q já tem de texto
#             + str(df_bin['sigmoid_bin'][i]) + \
#             '",-- '  # pega elemento i da sigmoide
#             + f"({df_bin['address_bin'][i]})"
#             + f" = {str(df_bin['address_bin_conv'][i]).ljust(9, ' ')}"
#             + f" || {str(df['sig_norm'][i]).ljust(18, ' ')} = {str(df_bin['sigmoid_bin_conv'][i])}\n")


# # ------------------------------- ROM .mif -------------------------------#
# # define se o endereço será com 'x' ou 'address'
#     if (memory_address_type == False):  # 0= int(n)
#         for i in range(0, len(df_bin)):  # caso seja por 'x'
#             text = (text+'' + str(df_bin.index[i]) + ':' + str(df_bin['sigmoid_bin'][i]) + ';-- '+str(
#                 offset_df_memory + df_sigmoid_first+(i*dx_sigmoid*integer_mult_factor))+' || '+str(df['sig_norm'][i]) + '\n')
#         # )
#     else:  # 1= float(address)
#         for i in range(0, len(df_bin)):
#             text = (text+'' + str(df_bin['address_bin'][i]) + ':' + str(df_bin['sigmoid_bin'][i]) + ';-- '+str(
#                 offset_df_memory + df_sigmoid_first+(i*dx_sigmoid*integer_mult_factor))+' || '+str(df['sig_norm'][i]) + '\n')


# # ## ROM Definitions
#     ROM_clk = 0  # 1= rom com clock || 0= sem clock

#     memory_width = n_integer + n_mantissa_sigmoid
#     memory_depth = len(df_bin)

#     if memory_address_type == False:  # 0= int(n)
#         # Enter BIN, DEC, HEX, OCT, or UNS; #because memory is with (signed/unsigned) bin address
#         memory_value_type = 'DEC'
#     else:  # 1= float(address)
#         # Enter BIN, DEC, HEX, OCT, or UNS; #because memory is with (signed/unsigned) bin address
#         memory_value_type = 'BIN'
#     return text_rom_to_asic, ROM_clk, memory_width, memory_depth


# def ROM_txt_gen(text_rom_to_asic, ROM_clk, ROM_name, memory_width, memory_depth):
#     if ROM_clk:
#         rom_text_asic = (
#             f'''--https://stackoverflow.com/questions/17579716/implementing-rom-in-xilinx-vhdl
# LIBRARY ieee ;
# USE ieee.std_logic_1164.all ;
# USE ieee.numeric_std.all;
# ----------------
# ENTITY {ROM_name} is
# generic(addr_heigth : integer := {str(memory_depth)}; -- store {str(memory_depth)} elements
# 				addr_bits  : integer := {str(int(math.log2(memory_depth)))}; -- required bits to store {str(memory_depth)} elements
# 				data_width : integer := {str(memory_width)}  -- each element has {str(memory_width)}-bits
# 				);
# port ( clk : in std_logic ;
# 		address : in std_logic_vector(addr_bits-1 downto 0);
# 		data_out : out std_logic_vector(data_width-1 downto 0)
# 		) ;
# end entity ;
# ------------------
# architecture arch of {ROM_name} is
# 	signal reg_address: std_logic_vector(addr_bits-1 downto 0);
# 	type memory is array ( 0 to addr_heigth-1 ) of std_logic_vector(data_width-1 downto 0 ) ;
# 	constant myrom : memory := (
# {text_rom_to_asic}
# --	2 => "11111111" , --255
# --	3 => "11010101" ,
# others => "00000000000"
# ) ;
# begin
# 	process(clk)
# 		begin
# 		if( clk'event and clk = '1' ) then
# 			reg_address <= address ;
# 		end if ;
# 	end process ;
# ---------------
# data_out <= myrom(to_integer(unsigned(reg_address))) ;
# end architecture ;
# ''')

#     else:
#         rom_text_asic = (f'''
# --https://stackoverflow.com/questions/17579716/implementing-rom-in-xilinx-vhdl
# LIBRARY ieee ;
# USE ieee.std_logic_1164.all ;
# USE ieee.numeric_std.all;
# ----------------
# ENTITY {ROM_name} is
# generic(addr_heigth : integer := {str(memory_depth)}; -- store {str(memory_depth)} elements
# 				addr_bits  : integer := {str(int(math.log2(memory_depth)))}; -- required bits to store {str(memory_depth)} elements
# 				data_width : integer := {str(memory_width)}  -- each element has {str(memory_width)}-bits
# 				);
#   PORT (
#     address : IN STD_LOGIC_VECTOR(addr_bits - 1 DOWNTO 0);
#     data_out : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
#   );
# END ENTITY;
# ------------------
# architecture arch of {ROM_name} is
# 	type memory is array ( 0 to addr_heigth-1 ) of std_logic_vector(data_width-1 downto 0 ) ;
# 	constant myrom : memory := (
# {text_rom_to_asic}
# --	2 => "11111111" , --255
# --	3 => "11010101" ,
# others => "00000000000"
# ) ;
# begin
# ---------------
# data_out <= myrom(to_integer(unsigned(address))) ;
# end architecture ;
# ''')

#     return rom_text_asic


# def ROM_Sigmoid_gen(
#         DOWNLOAD: bool,
#         ROM_name: str,
#         BIT_WIDTH: int,
#         is_signed: bool,
#         is_sigmoid_signed: bool = False,
#         n_integer: int = 1,
#         path: str = './'
# ):

#     offset_df_memory, norm_y, dx_sigmoid, total_dx, memory_address_type, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, sigmoid_range = ROM_internal_param(
#         BIT_WIDTH, is_signed, is_sigmoid_signed, n_integer)
#     df = df_ROM_gen(integer_mult_factor, sigmoid_range, norm_y, total_dx)

#     df_bin = df_bin_gen(BIT_WIDTH, is_signed, is_sigmoid_signed, df)

#     text_rom_to_asic, ROM_clk, memory_width, memory_depth = ROM_txt_values(
#         BIT_WIDTH, n_integer, n_mantissa_sigmoid, memory_address_type, integer_mult_factor, offset_df_memory, dx_sigmoid, df, df_bin)

#     rom_text_asic = ROM_txt_gen(
#         text_rom_to_asic, ROM_clk, ROM_name, memory_width, memory_depth)

#     if DOWNLOAD:
#         final_path = f"{path}/{ROM_name}.vhd"
#         text_file = open(final_path, "w")
#         text_file.write(rom_text_asic)
#         text_file.close()
#         print(f"arquivo gerado: {final_path}.vhd")

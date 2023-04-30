# from Block_Arith import *

# vhd_block = Block_Arith
from utils.general.components import entity_to_component
from utils.SETTINGS import PARAMS
import os
from utils.general.dict_utils import find_True_dict_Output_print, find_True_dict_Output_print_above_level


def find_fx_activation(layer_dict_arg):
    fx_activation = find_True_dict_Output_print(
        dict_slice=layer_dict_arg['Neuron_arch']['Activation_function'])
    if fx_activation == 'Using':  # caso seja uma fx com dicionário interno de parâmetros, devemos pegar o nome dela e não o 'using'
        """Exemplo:
           'Activation_function':{
                'ReLU': False,
                'Leaky_ReLU': {
                    'Using': False,        # True = usar versão Leaky_ReLU
                    #número de vezes que divide por 2 a ReLU (shift right)
                    'Leaky_attenuation': 2
                },
                'Sigmoid': {
                    # True = usar versão Sigmoid (Look Up Table)
                    'Using': True,
                    'Memory': {
                    'bits_mem': 8,
                    # 'n' binary digits are the fractional part of `x`; = MANTISSA
                    'input_mem_bits': lambda:layer_dict_softmax['Neuron_arch']['Activation_function']['Sigmoid']['Memory']['bits_mem'],
                    }
                    }
                }
            O que confirma se é a Sigmoid é o {'Using': True }, porém queremos pegar o nome 'Sigmoid', que está um nível de hierarquia acima """
        fx_activation = find_True_dict_Output_print_above_level(
            dict_slice=layer_dict_arg['Neuron_arch']['Activation_function'])
    return fx_activation


ReLU_entity = ('''
ENTITY ReLU IS
    PORT (
        fx_in : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END ENTITY;''')

ReLU_txt = (f'''
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
{ReLU_entity}

ARCHITECTURE rtl OF ReLU IS

BEGIN

    PROCESS (fx_in)
    BEGIN
        IF fx_in > 0 THEN -- X > 0
            -- s_fx_out <= fx_in;
            IF fx_in > signed_max_2xbit THEN
                fx_out <= to_signed(to_integer(signed_max), fx_out'length);
            ELSE
                fx_out <= to_signed(to_integer(fx_in), fx_out'length); -- Numeric_std

            END IF;

        ELSE -- X < 0
            fx_out <= (OTHERS => '0');
        END IF;
    END PROCESS;

END ARCHITECTURE;''')


Leaky_entity = ('''
ENTITY Leaky_ReLU IS
    PORT (
        fx_in : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END ENTITY;''')

Leaky_ReLU_txt = (f'''
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
{Leaky_entity}

ARCHITECTURE rtl OF Leaky_ReLU IS

BEGIN

    PROCESS (fx_in)
    BEGIN
        IF fx_in > 0 THEN -- X > 0
            -- fx_out <= fx_in;
            IF fx_in > signed_max_2xbit THEN
                fx_out <= to_signed(to_integer(signed_max), fx_out'length);
            ELSE
                fx_out <= to_signed(to_integer(fx_in), fx_out'length); -- Numeric_std

            END IF;

        ELSE -- X < 0
            -- fx_out <= (OTHERS => '0');
            fx_out <= signed((Leaky_ReLU_ones & fx_in(BITS_FX_IN - 1 DOWNTO Leaky_attenuation)));

        END IF;
    END PROCESS;

END ARCHITECTURE;''')


def activation_fx_vhd_gen(ReLU_entity: str,
                          Leaky_entity: str,
                          ACTIVATION_TYPE: int):
    activation_fx_entity = f'''
ENTITY activation_fx IS
    GENERIC (
        BITS_FX_IN        : NATURAL := BITS_FX_IN;
        BITS_FX_OUT       : NATURAL := BITS_FX_OUT;
        ACTIVATION_TYPE   : NATURAL := {ACTIVATION_TYPE}; -- 0: ReLU, 1: Leaky ReLU, 2: Sigmoid, 3: linear
        Leaky_attenuation : NATURAL := Leaky_attenuation;
        Leaky_ReLU_ones   : signed  := Leaky_ReLU_ones
    );
    PORT (
        clk, rst : IN STD_LOGIC;
        fx_in    : IN signed(BITS_FX_IN - 1 DOWNTO 0);
        fx_out   : OUT signed (BITS_FX_OUT - 1 DOWNTO 0)
    );
END ENTITY;'''

    activation_fx_txt = (f'''
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;
{activation_fx_entity}
ARCHITECTURE arch OF activation_fx IS
    -------------------- COMPONENTS --------------------
{entity_to_component(ReLU_entity)}
{entity_to_component(Leaky_entity)}

    -- ROM
    COMPONENT ROM_fx_8bitaddr_8width IS
        PORT (
            address  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            ------------------------------------------
            data_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
        -- input: address (8 bits)
        -- output: data_out (8 bits)
    END COMPONENT;
    -------------------- SIGNALS --------------------
    SIGNAL s_fx_out     : signed(BITS_FX_OUT - 1 DOWNTO 0);
    SIGNAL s_fx_out_std : STD_LOGIC_VECTOR(BITS_FX_OUT - 1 DOWNTO 0);
    SIGNAL fx_in_ROM    : signed(BITS - 1 DOWNTO 0);

BEGIN

    ReLU_inst : IF ACTIVATION_TYPE = 0 GENERATE
        ReLU_inst : ReLU PORT MAP(fx_in, s_fx_out);
    END GENERATE;

    Leaky_ReLU_inst : IF ACTIVATION_TYPE = 1 GENERATE
        Leaky_ReLU_inst : Leaky_ReLU PORT MAP(fx_in, s_fx_out);
    END GENERATE;

    Sigmoid_ROM_inst : IF ACTIVATION_TYPE = 2 GENERATE -- it's even
        -- BEGIN
        -- fx_in_ROM <= to_signed(to_integer(fx_in), fx_in_ROM'length); -- Numeric_std
        fx_in_ROM <= fx_in((2 * BITS) - 1 DOWNTO BITS);
        U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
            STD_LOGIC_VECTOR(fx_in_ROM),
            s_fx_out_std
        ); -- input: address (8), output: data_out (8)
        -- END PROCESS fx_activation_inst;
        s_fx_out <= signed(s_fx_out_std);
    END GENERATE;

    linear_inst : IF ACTIVATION_TYPE = 3 GENERATE
        fx_in_ROM <= fx_in((2 * BITS) - 1 DOWNTO BITS);
        s_fx_out  <= fx_in_ROM;
    END GENERATE;

    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            fx_out <= (OTHERS => '0');
        ELSE
            IF clk'event AND clk = '1' THEN
                fx_out <= s_fx_out;
            END IF;
        END IF;
    END PROCESS;
    
END ARCHITECTURE;''')

    return activation_fx_entity, activation_fx_txt

# activation_fx_entity, activation_fx_txt = activation_fx_vhd_gen(
#     ReLU_entity, Leaky_entity)


def VHD_gen(name: str, txt: str, path: str = "./",
            create: bool = False
            ):

    if create:
        # creating folder if not exists
        os.makedirs(f"{path}/", exist_ok=True)
        # print(f"create_folder_{self.name}() -> Created: {path}")

    with open(f"{path}/{name}.vhd", "w") as writer:
        # creating '.vhd' file
        writer.write(txt)  # download MAC
    print(
        f"VHD_gen() -> criando arquivo: {path}/{name}.vhd")


def activation_fx_gen(ReLU_txt: str = ReLU_txt,
                      ReLU_entity: str = ReLU_entity,
                      Leaky_entity: str = Leaky_entity,
                      Leaky_ReLU_txt: str = Leaky_ReLU_txt,
                      layer_dict_arg: dict = None):

    if layer_dict_arg is None:
        layer_dict_arg = {}
    fx_activation = find_fx_activation(layer_dict_arg)

    if fx_activation == 'ReLU':
        ACTIVATION_TYPE = 0
    elif fx_activation == 'Leaky_ReLU':
        ACTIVATION_TYPE = 1
    elif fx_activation == 'Sigmoid':
        ACTIVATION_TYPE = 2

    activation_fx_entity, activation_fx_txt = activation_fx_vhd_gen(ReLU_entity=ReLU_entity,
                                                                    Leaky_entity=Leaky_entity,
                                                                    ACTIVATION_TYPE=ACTIVATION_TYPE)

    VHD_gen(name='ReLU', txt=ReLU_txt, path=PARAMS.path, create=True)
    VHD_gen(name='Leaky_ReLU', txt=Leaky_ReLU_txt,
            path=PARAMS.path, create=True)
    VHD_gen(name='activation_fx', txt=activation_fx_txt,
            path=PARAMS.path, create=True)
    return entity_to_component(activation_fx_entity)


# activation_fx_gen(ReLU_txt, Leaky_ReLU_txt, activation_fx_txt)

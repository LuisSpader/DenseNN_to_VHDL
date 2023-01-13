from name import vhd_name
from tree_utils import *
from utils import all_inputs_signals
from standard_dicts import *
from vhd_txt_utils import entity
from dict_utils import dict_list_exceptNone
from path import *
from components import entity_to_component


def MAC_Txt_Gen(IO_type: str = 'signed', num_inputs: int = 3, receive_sum_all: str = 'sum_all', tab_space: int = 1, DEBUG: bool = False) -> str:
    """Função para gerar o texto de multiplicação entre todas as entradas e pesos. Exemplo:
    MAC_Txt_Gen(num_inputs = 3, sum_all = 'sum_all'):
        sum_all <= ((signed(sx1)*signed(sw1))+
                    (signed(sx2)*signed(sw2))+
                    (signed(sx3)*signed(sw3))+ signed(sbias));

    Args:
        IO_type (str, optional): Tipo do sinal 'signed' ou 'unsigned'. Defaults to 'signed'.
        num_inputs (int, optional): número de entradas e pesos (Xi e Wi). Defaults to 3.
        receive_sum_all (str, optional): Sinal que irá receber todo o MAC, exemplo: sum_all <= x1*w1 + x2*w2 + ... . Defaults to 'sum_all'.
        DEBUG (bool, optional): Para imprimir o texto de saída. Defaults to False.

    Returns:
        str: Texto do MAC, conforme exemplo acima '
    """
    # SOMATÓRIO -> operação de soma ponderada no sum.vhd
    text = []
    i = 0
    tab_space = ['  ']*tab_space
    tab_space = ''.join(map(str, tab_space))

    while True:
        if (i == 0):
            text.append(
                f"{tab_space}{receive_sum_all} <= (({IO_type}(sx{str(i+1)})*{IO_type}(sw{str(i+1)}))+ ")
            i = i+1

        else:
            if (i < num_inputs-1):
                text.append(
                    f"({IO_type}(sx{str(i+1)})*{IO_type}(sw{str(i+1)}))+ ")
                i = i+1
            else:
                text.append(
                    f"({IO_type}(sx{str(i+1)})* {IO_type}(sw{str(i+1)}))+ {IO_type}(sbias));")
                i = 0
                break
    # tab_space = ''
    text = ('\n'+tab_space).join(map(str, text))

    if (DEBUG == 1):
        print(text)

    return text
# print(MAC_Txt_Gen(IO_type='signed', num_inputs=3,
#       receive_sum_all='sum_all', DEBUG=False))


def MAC_Txt_Gen2(IO_type: str = 'signed',
                 num_inputs: int = 3,
                 receive_sum_all: str = 'sum_all',
                 tab_space: int = 1,
                 signal_name: str = 's_mult',
                 Multiplier_name: str = 'Multiplier',
                 DEBUG: bool = False
                 ):
    # ---------- MULTIPLICADORES --------------
    multipliers_gen_txt = (f'''loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    {Multiplier_name}_inst_loop : {Multiplier_name}
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;''')

    tab_space = ['  ']*tab_space
    tab_space = ''.join(map(str, tab_space))
    text = []
    for i in range(0, num_inputs):
        if i == 0:
            text.append(
                f"{tab_space}{receive_sum_all} <= ({signal_name}(((2 * BITS) * ({i} + 1)) - 1 DOWNTO ((2 * BITS) * ({i}))) + ")
        else:
            text.append(
                f"{tab_space}{tab_space}{signal_name}(((2 * BITS) * ({i} + 1)) - 1 DOWNTO ((2 * BITS) * ({i}))) + ")
        if DEBUG:
            print(f"{i}: {((2 * 8) * (i + 1)) - 1} downto {((2 * 8) * (i))}")

    text.append(
        f"{tab_space}{tab_space}s_Win((BITS * ({num_inputs} + 1)) - 1 DOWNTO (BITS * ({num_inputs})))); \n")

    text.append(multipliers_gen_txt)

    # text_list can be an splitted text or a list of texts
    text = '\n'.join(map(str, (text)))

    if DEBUG:
        print(text)
    return text
# print(MAC_Txt_Gen2(num_inputs=5,
#                    receive_sum_all='sum_all',
#                    tab_space=1,
#                    signal_name='s_mult',
#                    DEBUG=False))


def multiplication_mantissa(bits: int = 8, n_bin: int = 8, last_sum_name: str = 'sum_all', output_name: str = 'y', IO_type: str = 'signed', tab_space: int = 1) -> str:
    tab_space = ['  ']*tab_space
    tab_space = ''.join(map(str, tab_space))

    clk_receive = []
    clk_receive.append(
        f"{tab_space}{output_name} <= {IO_type}({last_sum_name}({str(bits+n_bin - 1)} DOWNTO {str(n_bin)}));")

    clk_receive_string = ''.join(map(str, (clk_receive)))
    clk_receive_string = erase_empty_lines(clk_receive_string)
    return clk_receive_string
# print(multiplication_mantissa(bits=8, n_bin=8, MAC_name='sum_all',
#                               IO_type='signed', tab_space=1*4))


def MAC_Tree_TxtGen_Barriers_Logic(ReceiveStr_list: list):
    """Função para gerar o texto
    Exemplo:
    print(MAC_Tree_Txt_Gen_Barriers()):

        sx1 <= x1;
        sx2 <= x2;
        sx3 <= x3;
        sw1 <= w1;
        sw2 <= w2;
        sw3 <= w3;
        sbias <= bias;
        ------------------
        PROCESS (rst, clk)
        BEGIN
                IF (rst = '1') THEN
                    sx1 <= x1;
                    sx2 <= x2;
                    sx3 <= x3;
                    sw1 <= w1;
                    sw2 <= w2;
                    sw3 <= w3;
                ELSE
                        IF (clk'event AND clk = '1') THEN --se tem evento de clock
                            -- output <= signed(soma_3(15 DOWNTO 8));
                            mult_1 <= (signed(sx1) * signed(sw1));
                            mult_2 <= (signed(sx2) * signed(sw2));
                            mult_3 <= (signed(sx3) * signed(sw3));
                            soma_1 <=  mult_1 + mult_2;
                            soma_2 <=  soma_1 + mult_3;
                            soma_3 <= soma_2 + sbias;
                        END IF;
                END IF;
        END PROCESS;

    Args:
        ReceiveStr_list (list, optional): Textos de sinal ou multiplicação gerados através da função 'arvore_de_soma_strings()':
            s_sum,s_mult,signal_receive_string_MAC,rst_receive_string_MAC,clk_receive_string_MAC = arvore_de_soma_strings(
                num_inputs,bits,n_bin,IO_type,rst_space,clk_space)
            Defaults to [signal_receive_string_MAC, signal_receive_string_MAC, clk_receive_string_MAC].
    """

#   sbias <= bias;
    MAC_Tree_Txt = (f'''
{ReceiveStr_list[0]}
	------------------
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
{ReceiveStr_list[1]}
		ELSE
			IF (clk'event AND clk = '1') THEN --se tem evento de clock
{ReceiveStr_list[2]}
			END IF;
		END IF;
	END PROCESS;
'''
                    )
    return MAC_Tree_Txt
# Exemplo desta está na função abaixo 'MAC_Tree_Barriers_TxtGen'


def MAC_Tree_Barriers_TxtGen_from_dict(MAC_name='MAC',
                                       Include_MAC_type: bool = False,
                                       rst_space: int = 3,
                                       clk_space: int = 4,
                                       layer_dict: dict = layer_dict_hidden
                                       ) -> str:
    """Função para gerar o texto de todo o VHDL do MAC versão árvore, para uma versão com barreiras temporais de registradores entre cada camada da árvore de multiplicações e somas.

    Args:
        MAC_name (str, optional): Nome do arquivo VHDL. Defaults to 'MAC'.
        Include_MAC_type (bool, optional): Se você deseja que o nome contenha algumas descrições de parâmetros. Defaults to False.
        rst_space (int, optional): Espaço de indexação (apenas para organização visual), na parte de declaração quando acontece o 'reset'. Defaults to 3.
        clk_space (int, optional): Espaço de indexação (apenas para organização visual) na parte de declaração de cada ciclo de clock. Defaults to 4.
        layer_dict (dict, optional): dicionário da camada. Defaults to layer_dict_list[0].
    """
    mult_version = 0
    # pegando dados do dicionário
    num_inputs, bits, IO_type, Neuron_name, Include_MAC_type, MAC_type, Barriers, fx_activation, n_bin, input_mem_bits, output_mem_bits = get_neuron_data_from_LayerDict(
        layer_dict=layer_dict)

    output_name = dict_list_exceptNone(
        dict_slice=layer_dict['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)
    output_name = output_name[0][0]  # problema aqui que não está generalizado

    # # txt= ''.join(map(str, txt_list))

    # if layer_dict['Neuron_arch']['IO_type']():
    #     IO_type = 'signed'
    # else:
    #     IO_type = 'unsigned'

    # Adiciona parâmetros no nome, caso (Include_MAC_type == True)
    # if (Include_MAC_type):
    MAC_name = vhd_name(vhd_name=MAC_name,
                        bits=bits, IO_type=IO_type, num_inputs=num_inputs,
                        Barriers=Barriers, MAC_type=MAC_type, Include_MAC_type=Include_MAC_type,
                        mult_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0),
                        # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
                        mult_version=mult_version,
                        adder_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
                        adder_version=0)

    s_sum, s_mult, signal_receive_string_MAC, rst_receive_string_MAC, clk_receive_string_MAC = arvore_de_soma_strings(
        num_inputs, bits, n_bin, IO_type, rst_space, clk_space, output=output_name)

    x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb = all_inputs_signals(inputs_list=['x', 'w'],
                                                                                      num_inputs=num_inputs, bits=bits, IO_type=IO_type, is_list=0)
    # adicionando output: y<= ...
    signal_receive_string_MAC = signal_receive_string_MAC + "\n" + \
        multiplication_mantissa(
            bits=bits, n_bin=n_bin, output_name='sum_all', IO_type=IO_type, tab_space=1)
    #  ---------- SINAIS ----------
    MAC_signals = (f'''
    SIGNAL sbias : {IO_type}({str(bits -1)} DOWNTO 0);
	SIGNAL sum_all : signed( {str((2*bits) -1)} DOWNTO 0);
	{sx}
	{sw}
	{s_sum}
	{s_mult}
    ''')
#     # ---------- MULTIPLICADORES --------------
#     multipliers_gen_txt = ('''loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
#     Multiplier_inst_loop : Multiplier
#     PORT MAP(
#       X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
#       W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
#       Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
#     );
#   END GENERATE;''')

    # ---------- TEXTO VHDL ----------
    mac_entity = entity(name=MAC_name,
                        bits=layer_dict['Neuron_arch']['Bit_WIDTH'],
                        num_inputs=layer_dict['Neuron_arch']['Inputs_number'],
                        IO_dict_list=[layer_dict['Neuron_arch']['IO']['shared_IO'],
                                      layer_dict['Neuron_arch']['IO']['unique_IO']],
                        remove_dict_items=[
                            'Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);', 'update_weights'],
                        generic=True
                        )
    mac_entity = entity_to_component(
        entity_text=mac_entity,
        word=layer_dict['Neuron_arch']['IO']['unique_IO']['IN']['manual'][0],
        word_subs="Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);")

    vhd_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

{mac_entity}

ARCHITECTURE arch OF  {MAC_name}  IS
------------- SINAIS -------------
{MAC_signals}

BEGIN
{MAC_Tree_TxtGen_Barriers_Logic(ReceiveStr_list = [signal_receive_string_MAC,
                                rst_receive_string_MAC, clk_receive_string_MAC])}
END arch;
'''
               )
# {MAC_Tree_TxtGen_Barriers_Logic(ReceiveStr_list = [
#                                 signal_receive_string_MAC, rst_receive_string_MAC, clk_receive_string_MAC])}
    return vhd_txt


def MAC_Tree_Barriers_TxtGen_from_dict2(MAC_name='MAC',
                                        Include_MAC_type: bool = False,
                                        rst_space: int = 3,
                                        clk_space: int = 4,
                                        layer_dict: dict = layer_dict_hidden,
                                        DEBUG: bool = False) -> str:
    """Função para gerar o texto de todo o VHDL do MAC versão árvore, para uma versão com barreiras temporais de registradores entre cada camada da árvore de multiplicações e somas.

    Args:
        MAC_name (str, optional): Nome do arquivo VHDL. Defaults to 'MAC'.
        Include_MAC_type (bool, optional): Se você deseja que o nome contenha algumas descrições de parâmetros. Defaults to False.
        rst_space (int, optional): Espaço de indexação (apenas para organização visual), na parte de declaração quando acontece o 'reset'. Defaults to 3.
        clk_space (int, optional): Espaço de indexação (apenas para organização visual) na parte de declaração de cada ciclo de clock. Defaults to 4.
        layer_dict (dict, optional): dicionário da camada. Defaults to layer_dict_list[0].
    """
    mult_version = 0
    adder_version = 0

    # pegando dados do dicionário
    num_inputs, bits, IO_type, Neuron_name, Include_MAC_type, MAC_type, Barriers, fx_activation, n_bin, input_mem_bits, output_mem_bits = get_neuron_data_from_LayerDict(
        layer_dict=layer_dict)

    output_name = dict_list_exceptNone(
        dict_slice=layer_dict['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)
    output_name = output_name[0][0]  # problema aqui que não está generalizado

    # Adiciona parâmetros no nome, caso (Include_MAC_type == True)
    # if (Include_MAC_type):
    MAC_name = vhd_name(MAC_name, bits, IO_type, num_inputs,
                        Barriers=Barriers, MAC_type=MAC_type, Include_MAC_type=Include_MAC_type,
                        mult_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0),
                        # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
                        mult_version=mult_version,
                        adder_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
                        adder_version=0)

    x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb = all_inputs_signals(
        inputs_list=['x', 'w'], num_inputs=num_inputs, bits=bits, IO_type=IO_type, is_list=0)
    # signal_receive_string = signal_receive_input(num_inputs, 1)
    mult_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0)
    multiplier_name = (f"mult{mult_number}_v{mult_version}")
    adder_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch']['Adder'], position=0)
    adder_name = (f"add{adder_number}_v{adder_version}")

    sum_all_string = MAC_Txt_Gen2(IO_type=IO_type, num_inputs=num_inputs,
                                  receive_sum_all='sum_all', Multiplier_name=multiplier_name, DEBUG=DEBUG)

    # signal_receive_string = signal_receive_string + "\n" + sum_all_string
    #  ---------- SINAIS ----------
    MAC_signals = (f'''
    ---------- SINAIS ----------
  SIGNAL s_Xi : signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult, s_mult_reg : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);
  SIGNAL bias : signed(BITS - 1 DOWNTO 0);
  SIGNAL sbias : signed((2 * BITS) - 1 DOWNTO 0); -- barriers
	SIGNAL sum_all : signed((2*BITS) - 1 DOWNTO 0);
  TYPE mult_array_type IS ARRAY (1 TO NUM_INPUTS) OF signed((2 * BITS) - 1 DOWNTO 0);
  SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
    ''')
    rst_space = ['  ']*rst_space
    rst_space = ''.join(map(str, rst_space))

    Multiplier_component = (f'''  COMPONENT {multiplier_name} IS
    GENERIC (
      BITS : NATURAL := BITS
    );
    PORT (
      X : IN signed((BITS) - 1 DOWNTO 0);
      W : IN signed((BITS) - 1 DOWNTO 0);
      Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;''')

    Adder_component = (f'''  COMPONENT {adder_name} IS
    GENERIC (
      BITS : NATURAL := BITS
    );
    PORT (
      A : IN signed((2 * BITS) - 1 DOWNTO 0);
      B : IN signed((2 * BITS) - 1 DOWNTO 0);
      S : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;''')
    MAC_components = '\n'.join(
        map(str, [Multiplier_component, Adder_component]))
    # ---------- TEXTO VHDL ----------
    mac_entity = entity(name=MAC_name,
                        bits=layer_dict['Neuron_arch']['Bit_WIDTH'],
                        num_inputs=layer_dict['Neuron_arch']['Inputs_number'],
                        IO_dict_list=[layer_dict['Neuron_arch']['IO']['shared_IO'],
                                      layer_dict['Neuron_arch']['IO']['unique_IO']],
                        remove_dict_items=[
                            'Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);', 'update_weights'],
                        generic=True
                        )
    mac_entity = entity_to_component(
        entity_text=mac_entity,
        word=layer_dict['Neuron_arch']['IO']['unique_IO']['IN']['manual'][0],
        word_subs="Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);")
    print(
        f"------------------------ ///////// ))))))))))) mac_entity: {mac_entity}")
    vhd_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

{mac_entity}

ARCHITECTURE arch OF  {MAC_name}  IS
{MAC_signals}
{MAC_components}

BEGIN
  s_Xi <= Xi;
  s_Win <= Win;

  -- ----------------- MULTIPLIERS ------------------------------
  -- # multiplicadores
  loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : {multiplier_name}
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;

  -- # Registradores sai­da dos multiplicadores
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      s_mult_reg <= (OTHERS => '0');
    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        s_mult_reg <= s_mult;
      END IF;
    END IF;
  END PROCESS;
  -- --------------------- ADDERS --------------------------
  loop_Mult_signal : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult_array(i + 1) <= s_mult_reg(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)));
  END GENERATE;
  bias <= s_Win((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO (BITS * (NUM_INPUTS)));
  sbias <= resize(bias, sbias'length);
  ---------------------- EVEN (PAR) --------------------------
  even_inst : IF (NUM_INPUTS MOD 2) = 0 GENERATE -- it's even
    loop_adders_inst : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE

      sum_0_to_NUM_INPUTS_half_inst : IF i < (NUM_INPUTS/2) GENERATE -- i 0 to 1
        soma_i_inst : {adder_name} PORT MAP(
          A => mult_array((2 * i) + 1), -- mult 1,3,5, ...
          B => mult_array((2 * i) + 2), -- mult 2,4,6, ...
          S => sum_array(i + 1) -- sum 1,2,3, ...
        );
      END GENERATE;

      sum_half_to_NUM_INPUTS_inst : IF (i >= (NUM_INPUTS/2)) AND (i < (NUM_INPUTS - 1)) GENERATE -- i 2
        soma_i_inst : {adder_name} PORT MAP(
          A => sum_array_reg((2 * i) - NUM_INPUTS + 1), -- sum 1,3,5, ...
          B => sum_array_reg((2 * i) - NUM_INPUTS + 2), -- sum 2,4,6, ...
          S => sum_array(i + 1)
        );
      END GENERATE;

      sum_final_inst : IF i = (NUM_INPUTS - 1) GENERATE -- i 3
        soma_i_inst : {adder_name} PORT MAP(
          A => sum_array_reg(i),
          B => sbias,
          S => sum_array(i + 1)
        );
      END GENERATE;

    END GENERATE loop_adders_inst;
  END GENERATE even_inst;

  -- ------------------- ODD (IMPAR) -------------------------
  odd_inst : IF (NUM_INPUTS MOD 2) /= 0 GENERATE -- it's odd
    loop_adders_inst : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE

      -- i: 0 to 2 (NUM_INPUTS = 7)
      sum_0_to_NUM_INPUTS_half_inst : IF i < (((NUM_INPUTS - 1)/2)) GENERATE
        soma_i_inst : {adder_name} PORT MAP(
          A => mult_array((2 * i) + 1), -- mult 1,3,5 ...
          B => mult_array((2 * i) + 2), -- mult 2,4,6 ...
          S => sum_array(i + 1) -- sum 1,2,3 ...
        );
      END GENERATE;

      -- i: 3 (NUM_INPUTS = 7)
      sum_half_inst : IF (i = ((NUM_INPUTS - 1)/2)) GENERATE
        soma_i_inst : {adder_name} PORT MAP(
          A => mult_array((2 * i) + 1), -- mult 7
          B => sum_array_reg(1), -- sum_reg 1
          S => sum_array(i + 1) -- sum 4
        );
      END GENERATE;

      -- i: 4 to 5 (NUM_INPUTS = 7)
      sum_halfplus1_to_NUM_INPUTS_inst : IF (i > ((NUM_INPUTS - 1)/2)) AND (i < NUM_INPUTS - 1) GENERATE
        soma_i_inst : {adder_name} PORT MAP(
          A => sum_array_reg((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 2), -- sum_reg 2,4, ...
          B => sum_array_reg((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 3), -- sum_reg 3,5, ...
          S => sum_array(i + 1)
        );
      END GENERATE;

      sum_final_inst : IF i = (NUM_INPUTS - 1) GENERATE -- i: 6
        soma_i_inst : {adder_name} PORT MAP(
          A => sum_array_reg(i),
          B => sbias,
          S => sum_array(i + 1)
        );
      END GENERATE;

    END GENERATE loop_adders_inst;
  END GENERATE odd_inst;
  -- # Registradores saÃ­da dos adders
  PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      sum_array_reg <= (OTHERS => (OTHERS => '0'));

    ELSE
      IF (clk'event AND clk = '1') THEN --se tem evento de clock
        sum_array_reg <= sum_array;

      END IF;
    END IF;
  END PROCESS;
  -------------------------------------------------------------
  sum_all <= sum_array_reg(NUM_INPUTS);
  y <= sum_all((2 * BITS) - 1 DOWNTO BITS); --!! OVERFLOW estÃ¡ sem tratamento!!

END arch;
''')
# {MAC_Tree_TxtGen_NoBarriers_Logic(ReceiveStr_list=[signal_receive_string, f"{rst_space}{output_name} <= (OTHERS => '0');", multiplication_mantissa(
#     bits=bits, n_bin=n_bin, last_sum_name='sum_all',output_name = output_name, IO_type=IO_type, tab_space=clk_space)])}
    return vhd_txt
# print(MAC_Tree_NoBarriers_TxtGen_from_dict(MAC_name='MAC',
#                                  Include_MAC_type=False,
#

# print(MAC_Tree_Barriers_TxtGen_from_dict(MAC_name='MAC',
#                                Include_MAC_type=False,
#                                rst_space=3*4,
#                                clk_space=4*4,
#                                layer_dict=layer_dict_hidden))


# layer_dict = layer_dict_hidden
# num_inputs = layer_dict['Inputs_number']
num_inputs = 4
lista_mult = []
lista_soma = []
lista_soma_reg = []
lista_multplier_atribution = []
for i in range(1, num_inputs+1):
    lista_mult.append(f"mult{i}")
    lista_soma.append(f"soma{i}")
    lista_soma_reg.append(f"soma{i}_reg")
    lista_multplier_atribution.append(
        f"mult_{i} <= s_mult_reg(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))); -- 15 DOWNTO 0;")
lista_join = lista_mult + lista_soma_reg[:-1] + ['bias']
# print(f"num_inputs: {num_inputs}")
# print(lista_join)
adder_name = 'Adder'
port_map_adder_list = []
for i in range(0, int(len(lista_join)/2)):
    port_map_adder_list.append(
        f"{adder_name}{i}_inst: {adder_name} PORT MAP (A => {lista_join[(2*i)]}, B => {lista_join[(2*i)+1]}, S => {lista_soma[i]});")

port_map_adder = '\n'.join(map(str, port_map_adder_list))
print(f"port_map_adder: {port_map_adder}")


# ======================================================================================


def MAC_Tree_TxtGen_NoBarriers_Logic(ReceiveStr_list: list):
    """Função para gerar o texto
    Exemplo:
    print(MAC_Tree_Txt_Gen_Barriers_Logic()):

        sbias <= bias;
        sx1 <= x1;
        sx2 <= x2;
        sx3 <= x3;
        sw1 <= w1;
        sw2 <= w2;
        sw3 <= w3;

        sum_all <= ((signed(sx1)*signed(sw1)) + (signed(sx2)*signed(sw2)
                    ) + (signed(sx3)*signed(sw3))+ signed(sbias)); #MAC
        ------------------
        output <= sum_all(15 DOWNTO (8)); #saída truncada

    Args:
        ReceiveStr_list (list, optional): Textos de sinal ou multiplicação gerados através da função 'arvore_de_soma_strings()':
            s_sum,s_mult,signal_receive_string_MAC,rst_receive_string_MAC,clk_receive_string_MAC = arvore_de_soma_strings(
                num_inputs,bits,n_bin,IO_type,rst_space,clk_space)
            Defaults to [signal_receive_string_MAC, signal_receive_string_MAC, clk_receive_string_MAC].
    """

#   sbias <= bias;
    MAC_Tree_Txt = (f'''

{ReceiveStr_list[0]}
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
{ReceiveStr_list[1]}
		ELSE
			IF (clk'event AND clk = '1') THEN --se tem evento de clock
{ReceiveStr_list[2]}
			END IF;
		END IF;
	END PROCESS;

'''
                    )
    return MAC_Tree_Txt
# Exemplo desta está na função abaixo 'MAC_Tree_NoBarriers_TxtGen'


# s_sum, s_mult, signal_receive_string_MAC, rst_receive_string_MAC, clk_receive_string_MAC = arvore_de_soma_strings(
#     num_inputs=3, bits=8, n_bin=8, IO_type='signed', rst_space=3*4, clk_space=4*4)

# sum_all_string = MAC_Txt_Gen(IO_type='signed', num_inputs=3,
#                              receive_sum_all='sum_all', DEBUG=False)

# print(MAC_Tree_TxtGen_NoBarriers_Logic(
#     ReceiveStr_list=[signal_receive_string_MAC, sum_all_string, '']))
# ---------------------

def MAC_Tree_NoBarriers_TxtGen_from_dict(MAC_name='MAC',
                                         Include_MAC_type: bool = False,
                                         rst_space: int = 3,
                                         clk_space: int = 4,
                                         layer_dict: dict = layer_dict_hidden,
                                         DEBUG: bool = False) -> str:
    """Função para gerar o texto de todo o VHDL do MAC versão árvore, para uma versão com barreiras temporais de registradores entre cada camada da árvore de multiplicações e somas.

    Args:
        MAC_name (str, optional): Nome do arquivo VHDL. Defaults to 'MAC'.
        Include_MAC_type (bool, optional): Se você deseja que o nome contenha algumas descrições de parâmetros. Defaults to False.
        rst_space (int, optional): Espaço de indexação (apenas para organização visual), na parte de declaração quando acontece o 'reset'. Defaults to 3.
        clk_space (int, optional): Espaço de indexação (apenas para organização visual) na parte de declaração de cada ciclo de clock. Defaults to 4.
        layer_dict (dict, optional): dicionário da camada. Defaults to layer_dict_list[0].
    """
    mult_version = 0

    # pegando dados do dicionário
    num_inputs, bits, IO_type, Neuron_name, Include_MAC_type, MAC_type, Barriers, fx_activation, n_bin, input_mem_bits, output_mem_bits = get_neuron_data_from_LayerDict(
        layer_dict=layer_dict)

    output_name = dict_list_exceptNone(
        dict_slice=layer_dict['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)
    output_name = output_name[0][0]  # problema aqui que não está generalizado

    # Adiciona parâmetros no nome, caso (Include_MAC_type == True)
    # if (Include_MAC_type):
    MAC_name = vhd_name(MAC_name, bits, IO_type, num_inputs,
                        Barriers=Barriers, MAC_type=MAC_type, Include_MAC_type=Include_MAC_type,
                        mult_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0),
                        # Versão do modelo de multiplicador (pois podem existir melhorias em um modelo). Exemplo: mult_version = 4 --> v4
                        mult_version=mult_version,
                        adder_number=find_True_dict_split(
                            split_str='-', dict=layer_dict['Neuron_arch']['Adder'], position=0),     # análogo ao 'mult_number'
                        adder_version=0)

    x, w, sx, sw, sx_tb, sw_tb, val_x, val_w, val_x_tb, val_w_tb = all_inputs_signals(
        inputs_list=['x', 'w'], num_inputs=num_inputs, bits=bits, IO_type=IO_type, is_list=0)
    # signal_receive_string = signal_receive_input(num_inputs, 1)
    mult_number = find_True_dict_split(
        split_str='-', dict=layer_dict['Neuron_arch']['Multiplier'], position=0)
    multiplier_name = (f"mult{mult_number}_v{mult_version}")

    sum_all_string = MAC_Txt_Gen2(IO_type=IO_type, num_inputs=num_inputs,
                                  receive_sum_all='sum_all', Multiplier_name=multiplier_name, DEBUG=DEBUG)

    # signal_receive_string = signal_receive_string + "\n" + sum_all_string
    #  ---------- SINAIS ----------
    MAC_signals = (f'''
    ---------- SINAIS ----------
	SIGNAL sum_all : signed((2*BITS) - 1 DOWNTO 0);
  SIGNAL s_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);
    ''')
    rst_space = ['  ']*rst_space
    rst_space = ''.join(map(str, rst_space))

    Multiplier_component = (f'''  COMPONENT {multiplier_name} IS
    GENERIC (
      BITS : NATURAL := BITS
    );
    PORT (
      X : IN signed((BITS) - 1 DOWNTO 0);
      W : IN signed((BITS) - 1 DOWNTO 0);
      Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;''')
    MAC_components = '\n'.join(map(str, [Multiplier_component]))
    # ---------- TEXTO VHDL ----------

    mac_entity = entity(name=MAC_name,
                        bits=layer_dict['Neuron_arch']['Bit_WIDTH'],
                        num_inputs=layer_dict['Neuron_arch']['Inputs_number'],
                        IO_dict_list=[layer_dict['Neuron_arch']['IO']['shared_IO'],
                                      layer_dict['Neuron_arch']['IO']['unique_IO']],
                        remove_dict_items=[
                            'Wout : OUT signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);', 'update_weights'],
                        generic=True
                        )
    mac_entity = entity_to_component(
        entity_text=mac_entity,
        word=layer_dict['Neuron_arch']['IO']['unique_IO']['IN']['manual'][0],
        word_subs="Win : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);")
    vhd_txt = (f'''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

{mac_entity}

ARCHITECTURE arch OF  {MAC_name}  IS
{MAC_signals}
{MAC_components}

BEGIN
  s_Xi <= Xi;
  s_Win <= Win;
{MAC_Tree_TxtGen_NoBarriers_Logic(ReceiveStr_list=[sum_all_string,f"{rst_space}{output_name} <= (OTHERS => '0');", multiplication_mantissa(
    bits=bits, n_bin=n_bin, last_sum_name='sum_all',output_name = output_name, IO_type=IO_type, tab_space=clk_space)])}
END arch;
''')
# {MAC_Tree_TxtGen_NoBarriers_Logic(ReceiveStr_list=[signal_receive_string, f"{rst_space}{output_name} <= (OTHERS => '0');", multiplication_mantissa(
#     bits=bits, n_bin=n_bin, last_sum_name='sum_all',output_name = output_name, IO_type=IO_type, tab_space=clk_space)])}
    return vhd_txt
# print(MAC_Tree_NoBarriers_TxtGen_from_dict(MAC_name='MAC',
#                                  Include_MAC_type=False,
#                                  layer_dict=layer_dict_hidden))


def MAC_TxtGen(MAC_name='MAC',
               Include_MAC_type: bool = False,
               rst_space: int = 3*4,
               clk_space: int = 4*4,
               layer_dict: dict = layer_dict_hidden,
               Barriers: bool = True,
               #    download_vhd: bool = True,
               #    folder_create="",
               #    filename_with_type=".txt",
               #    path_level=False
               ) -> str:
    text = ''
    if Barriers:
        text = MAC_Tree_Barriers_TxtGen_from_dict2(MAC_name=MAC_name,
                                                   Include_MAC_type=Include_MAC_type,
                                                   rst_space=rst_space,
                                                   clk_space=clk_space,
                                                   layer_dict=layer_dict)
    else:
        text = MAC_Tree_NoBarriers_TxtGen_from_dict(MAC_name=MAC_name,
                                                    Include_MAC_type=Include_MAC_type,
                                                    rst_space=rst_space,
                                                    clk_space=clk_space,
                                                    layer_dict=layer_dict)
    # if download_vhd == True:
    #     # pegando dados do dicionário
    #     bits = layer_dict['Neuron_arch']['Bit_WIDTH']()
    #     n_bin = layer_dict['Neuron_arch']['Activation_fx']['Sigmoid']['Memory']['mantissa'](
    #     )
    #     num_inputs = layer_dict['Neuron_arch']['Inputs_number']()

    #     output_name = dict_list_exceptNone(
    #         dict_slice=layer_dict['Neuron_arch']['IO']['unique_IO']['OUT'], return_value_or_key='value', is_list=False)
    #     # problema aqui que não está generalizado
    #     output_name = output_name[0][0]

    #     path, path_soft = create_folder_neuron(
    #         bits,
    #         num_inputs,
    #         Neurons_hidden,
    #         Neurons_softmax,
    #         MAC_type,
    #         Barriers,
    #         path_level=False,
    #         create=True)
    #     download_TxtFile_As(Text=text,
    #                         folder_create="",
    #                         filename_with_type=f"{MAC_name}.vhd",
    #                         path_level=False)

    return text


# print(MAC_TxtGen(MAC_name='MAC',
#                  Include_MAC_type=False,
#                  rst_space=3*4,
#                  clk_space=4*4,
#                  layer_dict=layer_dict_hidden,
#                  Barriers=False
#                  ))

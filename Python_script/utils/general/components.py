from utils.general.txt_utils import replace_word


def mac_component(sum_name, x, w, bits, input_output_type, output_sum):

    MAC_component = (f'''
    COMPONENT {str(sum_name)} IS
        PORT (
            clk, rst : IN STD_LOGIC;
            bias: IN {input_output_type}({str(bits -1)} DOWNTO 0) ; -- offset 
            {x}
            {w}
            ------------------------------------------ 
            {output_sum}
        ); -- clk, rst, inputs, weigths, bias, output
    END COMPONENT;                            
    ''')
    return MAC_component


def rom_component(ROM_name, input_mem_bits, output_mem_bits):
    ROM_component = (f'''
	-- ROM 
	COMPONENT {ROM_name} IS
		PORT ( 
			address : IN STD_LOGIC_VECTOR ({str(input_mem_bits - 1)} DOWNTO 0);
			------------------------------------------
			data_out : OUT STD_LOGIC_VECTOR ({str(output_mem_bits - 1)}  DOWNTO 0)
		);
	-- input: address ({str(input_mem_bits)} bits)	
	-- output: data_out ({str(output_mem_bits)} bits)
	END COMPONENT;                     
	''')

    # print(ROM_component)
    return ROM_component

# ROM_component = rom_component(ROM_name,input_mem_bits, output_mem_bits)
# print(ROM_component)


def port_map_ROM(ROM_name: str,
                 input_mem_bits: int,
                 output_mem_bits: int):
    """Função para gerar o texto do PORT MAP da ROM (esta versão está meio 'hard coded' ainda, pois o nome dos sinais para mapeamento ainda estão fixos: out_reg_MAC e out_ROM_act). Exemplo de uso da função:

    port_map_ROM(	ROM_name = 'ROM_fx_8bitaddr_8width',
                                                    input_mem_bits= 8,
                                    output_mem_bits = 8)
     Output:
            U_ROM : ROM_fx_8bitaddr_8width PORT MAP(
                    STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
                    );
            -- input: address (8)
            -- output: data_out (8) 

---------------------------------------------
    Args:
                    ROM_name (str): _description_
                    input_mem_bits (int): _description_
                    output_mem_bits (int): _description_
    """

    PORT_MAP_ROM = (f'''
	U_ROM : {ROM_name} PORT MAP(
		STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
		);
	-- input: address ({str(input_mem_bits)})
	-- output: data_out ({str(output_mem_bits)})  
	''')
    # print(PORT_MAP_ROM)
    return (PORT_MAP_ROM)


# def port_map_ROM(ROM_name,input_mem_bits,output_mem_bits):
# PORT_MAP_ROM = (f'''
# U_ROM : {ROM_name} PORT MAP(
# STD_LOGIC_VECTOR(out_reg_MAC), out_ROM_act
# );
# -- input: address ({str(input_mem_bits)})
# -- output: data_out ({str(output_mem_bits)})
# ''')
# # print(PORT_MAP_ROM)
# return(PORT_MAP_ROM)
#
# PORT_MAP_ROM = port_map_ROM(ROM_name, input_mem_bits, output_mem_bits)
# print(PORT_MAP_ROM)


def port_map_MAC(sum_name, reg_x_sequence_string, reg_w_sequence_string):
    PORT_MAP_MAC = ('''
        -- MAC ja registra a saida \n'''
                    "	U_MAC : " + str(sum_name) + " PORT MAP(" '''
            clk, rst, \n'''
                    '	    	' + reg_x_sequence_string + '\n'
                    ' 	   	' + reg_w_sequence_string + ' \n'
                    "		reg_bias, \n"
                    "		out_reg_MAC);"
                    )
    print(PORT_MAP_MAC)


# name_adder = "adder_" + str(bits) + "bit_" + str(num_inputs) + "input"
# name_adder

def entity_to_component(entity_text: str, word: str = "ENTITY", word_subs: str = "COMPONENT"):
    component_txt = replace_word(
        text=entity_text, word=word, word_subs=word_subs)
    return component_txt

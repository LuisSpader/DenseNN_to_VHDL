


s_reg_x = "SIGNAL "+reg_x_sequence_string[:-1]+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "

s_reg_w = "SIGNAL "+reg_w_sequence_string[:-1]+": "+input_output_type+"("+str(bits -1)+" DOWNTO 0); "


def top_neuron_soft_txt(neuron_Sigmoid, bits, num_inputs, x, w, input_output_type, input_bit, MAC_component, ROM_component, s_reg_w, s_reg_x )

return (
    
'''
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

'''
"ENTITY  "+neuron_Sigmoid+" IS \n" 
"	-- GENERIC ( \n"
" -- 	input_bit:integer:="+ str(bits) + "; output_bit:integer:="+ str(bits) + ";	 n_input:integer:="+ str(num_inputs) + "\n"
"	-- );"'''
	PORT (
	clk, rst, update_weights : IN STD_LOGIC;'''
'	\n'
'	'+x+'\n'
'-- 	'+w+'\n'
"	bias: IN "+input_output_type+"(" +str(bits -1)+ " DOWNTO 0) ; -- offset \n"
"	------------------------------------------ \n"
" 	y: OUT " + input_output_type + "("+ str(bits - 1) + " DOWNTO 0) --output  result" '''
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 

'''
"ARCHITECTURE behavior of "+neuron_Sigmoid+" is		\n"
'' + MAC_component + ''
'' + ROM_component + ''
"\n"
"	SIGNAL out_reg_MAC : " + input_output_type + "(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"
# "	SIGNAL out_reg_MAC : STD_LOGIC_VECTOR(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"
"	SIGNAL out_ROM_act : STD_LOGIC_VECTOR("+ str(bits - 1) + " DOWNTO 0); --saida da ROM		\n"
"	SIGNAL reg_out_ROM_act : " + input_output_type + "("+ str(bits) + " - 1 DOWNTO 0); --reg saida da ROM		\n"

'	' + s_reg_x + ''
' 	' + s_reg_w + ' '
"	SIGNAL reg_bias : " + input_output_type + "("+ str(bits - 1) + " DOWNTO 0); "

'''
 BEGIN \n'''
'	' + PORT_MAP_MAC + '\n' 
'	' + PORT_MAP_ROM + '\n' 
'	' + NEURON_SOFT_INPUT_NET + '\n' 
""
" 	y <= " + input_output_type + "(reg_out_ROM_act);"
"\n"  
"END behavior;"
)

# init_text = 1450
# print(top_neuron_soft_txt[init_text : (init_text+2000) ]) #Separa em linhas
# print(top_neuron_soft_txt[init_text: ]) #Separa em linhas
print(top_neuron_soft_txt)




top_neuron_ReLU_txt = ('''LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

'''
"ENTITY  "+neuron_ReLU_name+" IS \n" 
"	-- GENERIC ( \n"
" -- 	input_bit:integer:="+ str(bits) + "; output_bit:integer:="+ str(bits) + ";	 n_input:integer:="+ str(num_inputs) + "\n"
"	-- );"'''
	PORT (
	clk, rst, update_weights : IN STD_LOGIC;'''
'	\n'
'	'+x+'\n'
'-- 	'+w+'\n'
"	bias: IN "+input_output_type+"(" +str(bits -1)+ " DOWNTO 0) ; -- offset \n"
"	------------------------------------------ \n"
" 	y: OUT " + input_output_type + "("+ str(bits - 1) + " DOWNTO 0) --output  result" '''
);
-- clk, rst, 
-- inputs, 
-- weigths, 
-- bias, 
-- output
end ENTITY; 

'''
"ARCHITECTURE behavior of "+neuron_ReLU_name+" is		\n"
'' + MAC_component + ''
# '' + ROM_component + ''
"\n"
"	SIGNAL out_reg_MAC : " + input_output_type + "(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"
# "	SIGNAL out_reg_MAC : STD_LOGIC_VECTOR(("+ str(bits - 1) + ") DOWNTO 0);	--reg da saida do MAC	\n"

'	' + s_reg_x + ''
' 	' + s_reg_w + ' '
"	SIGNAL reg_bias : " + input_output_type + "("+ str(bits - 1) + " DOWNTO 0); "
'''

 BEGIN \n'''
'	' + PORT_MAP_MAC + '\n' 
# '	' + PORT_MAP_ROM + '\n' 
'	' + NEURON_ReLU_INPUT_NET + '\n' 
'''
END behavior;'''
)

# init_text = 1450
# print(top_neuron_ReLU_txt[init_text : (init_text+2000) ]) #Separa em linhas
# print(top_neuron_ReLU_txt[init_text: ]) #Separa em linhas
print(top_neuron_ReLU_txt)
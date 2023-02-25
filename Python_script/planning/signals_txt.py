# #   SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out                  : signed(BITS - 1 DOWNTO 0); --todo
# #   SIGNAL c1_n0_W_out                                            : signed(BITS - 1 DOWNTO 0); --todo
# #   SIGNAL c2_n0_W_out, c2_n1_W_out                               : signed(BITS - 1 DOWNTO 0); --todo
# #
# # layer0		layer1		layer2		layer3
# # n0_out	    n0_out	    n0_out	    n0
# # n1_out			        n1_out	    n1
# # n2_out					            n2
# # n3

# [
#     ['c0_n0_W_out', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
#     ['c0_n1_W_out', 'c2_n1_W_out', 'c3_n1_W_out'],
#     ['c0_n2_W_out', 'c3_n2_W_out'],
#     ['c0_n3_W_out']
# ]
# #   c0_n0_W_out    => c0_n0_W_out,
# #   c0_n1_W_out    => c0_n1_W_out,
# #   c0_n2_W_out    => c0_n2_W_out

# #   c1_n0_W_in     => c0_n0_W_out,

# [
#     ['', 'c1_n0_W_out', 'c2_n0_W_out', 'c3_n0_W_out'],
#     ['', 'c2_n1_W_out', 'c3_n1_W_out'],
#     ['', 'c3_n2_W_out'],
#     ['c0_n3_W_out']
# ]
# # c2_n0_W_out => c1_n0_W_out;
# # c2_n1_W_out => c0_n1_W_out;
# [
#     ['c0_n0_W_out'],
#     ['c0_n1_W_out'],
#     ['c0_n2_W_out'],
#     ['c0_n3_W_out']
# ]
# # c1_n0_W_out = > c0_n0_W_out


# # ir dando append em uma outra lista em cada iteração
# # planificar ambas as listas
# # remover algo igual entre os 2
# # a lista tendo só 1 item, procurar isso em alguma linha do texto:
# #     a linha do texto que tiver isso, deve ser removida,
# #     a linha anterior, deve ser removida o último caractere
txt = "LIBRARY ieee;\nUSE ieee.std_logic_1164.ALL;\nUSE ieee.numeric_std.ALL;\nUSE work.parameters.ALL;\n\n  ENTITY  camada0_ReLU_4neuron_8bits_5n_signed IS\n  GENERIC (\n    BITS : NATURAL := BITS;\n    NUM_INPUTS : NATURAL := 5;\n    TOTAL_BITS : NATURAL := 40\n  );\n  PORT (\n      clk, rst, update_weights: IN STD_LOGIC;\n      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);\n      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in: IN signed(BITS - 1 DOWNTO 0);\n      ----------------------------------------------\n      c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out: OUT signed(7 DOWNTO 0);\n      c0_n0_W_out, c0_n1_W_out, c0_n2_W_out: OUT signed(BITS - 1 DOWNTO 0)\n  );\n  end ENTITY;\n\nARCHITECTURE arch OF  camada0_ReLU_4neuron_8bits_5n_signed  IS \nBEGIN\n\nneuron_inst_0: ENTITY work.neuron_ReLU_5n\n   PORT MAP (\n            ---------- Entradas ----------\n            -- ['IN']['STD_LOGIC'] \n            clk=> clk, \n            rst=> rst, \n            update_weights=> update_weights, \n            -- ['IN']['manual'] \n            IO_in=> IO_in, \n            W_in=> c0_n0_W_in, \n            ---------- Saidas ----------\n            -- ['OUT']['SIGNED'] \n            IO_out=> c0_n0_IO_out, \n            -- ['OUT']['manual'] \n            W_out=> c0_n0_W_out\n   );\n            \nneuron_inst_1: ENTITY work.neuron_ReLU_5n\n   PORT MAP (\n            ---------- Entradas ----------\n            -- ['IN']['STD_LOGIC'] \n            clk=> clk, \n            rst=> rst, \n            update_weights=> update_weights, \n            -- ['IN']['manual'] \n            IO_in=> IO_in, \n            W_in=> c0_n1_W_in, \n            ---------- Saidas ----------\n            -- ['OUT']['SIGNED'] \n            IO_out=> c0_n1_IO_out, \n            -- ['OUT']['manual'] \n            W_out=> c0_n1_W_out\n   );\n            \nneuron_inst_2: ENTITY work.neuron_ReLU_5n\n   PORT MAP (\n            ---------- Entradas ----------\n            -- ['IN']['STD_LOGIC'] \n            clk=> clk, \n            rst=> rst, \n            update_weights=> update_weights, \n            -- ['IN']['manual'] \n            IO_in=> IO_in, \n            W_in=> c0_n2_W_in, \n            ---------- Saidas ----------\n            -- ['OUT']['SIGNED'] \n            IO_out=> c0_n2_IO_out, \n            -- ['OUT']['manual'] \n            W_out=> c0_n2_W_out\n   );\n            \nneuron_inst_3: ENTITY work.neuron_ReLU_5n\n   PORT MAP (\n            ---------- Entradas ----------\n            -- ['IN']['STD_LOGIC'] \n            clk=> clk, \n            rst=> rst, \n            update_weights=> update_weights, \n            -- ['IN']['manual'] \n            IO_in=> IO_in, \n            W_in=> c0_n3_W_in, \n            ---------- Saidas ----------\n            -- ['OUT']['SIGNED'] \n            IO_out=> c0_n3_IO_out\n   );\n             \nEND ARCHITECTURE;\n"
print(txt)

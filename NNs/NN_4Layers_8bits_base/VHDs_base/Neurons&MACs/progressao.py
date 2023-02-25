# BITS = 8
# NUM_INPUTS = 7
# i = 0

# for i in range(0, NUM_INPUTS):
#     print(f"s_mult({((2 * BITS) * (i + 1)) - 1} DOWNTO {(2 * BITS) * i})")
# print("------------")

# for i in range(0, int(NUM_INPUTS/2)):
#     print(f"i = {i}")
#     text = f"A => s_mult({((2 * BITS) * 2*(i + 1)) -(2 * BITS)- 1} DOWNTO {(2 *BITS) * (2*i)})"

#     text2 = f"B => s_mult({((2 * BITS) * 2*(i + 1)) - 1} DOWNTO {(2 *BITS) * ((2*i) +1)})"

#     # text3 = f"S => s_add_mid({(((2 * BITS)) *(i + 1)) + i} DOWNTO {(2 *BITS) * (i) + i})"

#     text3 = f"S => s_add_mid({(((2 * BITS)) *(i + 1)) -1} DOWNTO {(2 *BITS) * (i) })"

#     print(text)
#     print(text2)
#     print(text3)
#     print("----")

# print(
#     f"SIGNAL s_add_mid : IN signed({(((2 * BITS) + 1) * NUM_INPUTS) - 1} DOWNTO 0);")

# even = ('''
# ''')

BITS = 8
NUM_INPUTS = 7
TOTAL_BITS = BITS * NUM_INPUTS
i = 0
print(f'''
  SIGNAL s_Xi : signed({TOTAL_BITS - 1} DOWNTO 0);
  SIGNAL s_Win : signed({(BITS * (NUM_INPUTS + 1)) - 1} DOWNTO 0);
  SIGNAL s_mult, s_mult_reg : signed({((2 * BITS) * (NUM_INPUTS)) - 1} DOWNTO 0);

  ------------- SINAIS 2 ------------
  SIGNAL bias : signed({BITS - 1} DOWNTO 0);
  SIGNAL last_sum, sbias : signed({2*BITS -1} DOWNTO 0);
  TYPE mult_array_type IS ARRAY (1 TO {NUM_INPUTS}) OF signed({(2 * BITS) - 1} DOWNTO 0);
  SIGNAL mult_array, sum_array, sum_array_reg : mult_array_type;
''')

print("========================================")

print(f'''
  bias <= s_Win({(BITS * (NUM_INPUTS + 1)) - 1} DOWNTO {(BITS * (NUM_INPUTS))});
  ''')
print(f'''
last_sum <= sum_array_reg({NUM_INPUTS}); --!! OVERFLOW estÃ¡ sem tratamento!!
  y <= last_sum({(2 * BITS) - 1} DOWNTO {BITS});''')

print(f"TOTAL_BITS: {BITS*NUM_INPUTS}")
for i in range(0, NUM_INPUTS):
    print(f'''
    i: {i}
    mult0_v0_inst_loop : Multiplier
    PORT MAP(
      X => s_Xi({(BITS * (i + 1)) - 1} DOWNTO {(BITS * (i))}),
      W => s_Win({(BITS * (i + 1)) - 1} DOWNTO {(BITS * (i))}),
      Y => s_mult({((2 * BITS) * (i + 1)) - 1} DOWNTO {((2 * BITS) * (i))})
    );
  END GENERATE;''')
print('---------')
for i in range(0, NUM_INPUTS):
    print(f'''
loop_Mult_signal : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult_array({i + 1}) <= s_mult_reg( {((2 * BITS) * (i + 1)) - 1} DOWNTO {((2 * BITS) * (i))});
  END GENERATE;
    ''')
print("========================================")


for i in range(0, NUM_INPUTS):
    print(f"i: {i}")
    if (NUM_INPUTS % 2) == 0:
        print(" --------- PAR --------- ")
        if i < ((NUM_INPUTS/2)):
            print("parte 1")
            print(f"A=> mult_array({(2 * i) + 1})")
            print(f"B=> mult_array({(2 * i) + 2})")
            print(f"S=> sum_array({i + 1})")
            print("---")

        if (i >= (NUM_INPUTS/2)) and (i < NUM_INPUTS - 1):
            print("parte 2")
            print(f"A=> sum_array_reg({(2*i) - NUM_INPUTS +1})")
            print(f"B=> sum_array_reg({2*i - NUM_INPUTS + 2})")
            print(f"S=> sum_array({i + 1})")
            print("---")

        if i == (NUM_INPUTS - 1):
            print("parte 3")
            print(f"A=> sum_array_reg({i})")
            print(f"B=> sbias")
            print(f"S=> sum_array({i + 1})")
            print("---")

    else:
        print(" --------- IMPAR --------- ")
        if i < ((NUM_INPUTS/2) - 1):
            print("parte 1")
            print(f"A=> mult_array({(2 * i) + 1})")
            print(f"B=> mult_array({(2 * i) + 2})")
            print(f"S=> sum_array({i + 1})")
            print("---")

        if (i == ((NUM_INPUTS - 1)/2)):
            print("parte 2")
            print(f"A=> mult_array({(2 * i) + 1})")
            print(f"B=> sum_array_reg({1})")
            print(f"S=> sum_array({i + 1})")
            print("---")

        if (i > ((NUM_INPUTS - 1)/2)) and (i < NUM_INPUTS - 1):
            print("parte 3")
            print(
                f"A=> sum_array_reg({((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 2)})")
            print(
                f"B=> sum_array_reg({((2 * (i - (((NUM_INPUTS - 1)/2) + 1))) + 3)})")
            print(f"S=> sum_array({i + 1})")
            print("---")

        if i == (NUM_INPUTS - 1):
            print("parte 4")
            print(f"A=> sum_array_reg({i})")
            print(f"B=> sbias")
            print(f"S=> sum_array({i + 1})")
            print("---")

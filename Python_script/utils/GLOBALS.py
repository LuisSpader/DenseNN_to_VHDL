from utils.components.Adders import Adders
from utils.components.Multipliers import Multipliers
from utils.SETTINGS import Port_map


class Testbench():
    def __init__(self) -> None:
        self.items = []
        # self.items = [
        #     ['clk, rst, update_weights:  STD_LOGIC;'],
        #     ['IO_in:  signed(TOTAL_BITS - 1 DOWNTO 0);\nc0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in:  signed(BITS - 1 DOWNTO 0);'],
        #     ['c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out:  signed(BITS -1 DOWNTO 0);']
        # ]
        # self.nomes = []
        # self.tipos = []
        self.signals = []
        self.IOs = []
        self.IO_assign_list = []

    def call_all_fix(self):
        self.trata_lista()

    def trata_lista(self) -> None:
        for i, item in enumerate(self.items):
            self.items[i] = list(map(str.splitlines, item))

        self.items = [item for sublist in self.items for item in sublist]
        self.items = [item for sublist in self.items for item in sublist]
        self.gen_SIGNALS()
        # print(items)

    def gen_SIGNALS(self):
        for item in self.items:
            self.signals.append(f"   SIGNAL {item}")
        self.gen_IOs()

    def gen_IOs(self):
        # criando lista de IOs (inputs & outputs)
        # IOs = []
        for i, item in enumerate(self.items):
            self.IOs.append(item.split(':'))  # separa nomes e tipo

        # cria uma sublista de itens, sendo a vírgula o fator de determina a divisão no texto para diferenciar cada entrada
        for i, item in enumerate(self.IOs):
            buff = item[0]
            if ',' in buff:
                x = buff.split(',')
                for j, jitem in enumerate(x):
                    x[j] = jitem.strip()
            # x = [ind for ind in x]
                self.IOs[i][0] = x

            # x = list(map(str.split(','), buff))
            # IOs[i][0] = x

        # print(self.IOs)
        # return IOs
        self.gen_IO_list()

    def gen_IO_list(self):
        # IO_assign_list = []
        for item in self.IOs:
            self.IO_assign_list.append(item[0])

    # flat_list = [item for sublist in IO_assign_list for item in sublist]
        flat_list = []
        for sublist in self.IO_assign_list:
            if isinstance(sublist, list):
                flat_list.extend(iter(sublist))
            else:
                flat_list.append(sublist)
        self.IO_assign_list = flat_list
        # print(IO_assign_list)


class Global_objects():
    def __init__(self) -> None:
        self.ADDERS = Adders()
        self.MULTIPLIERS = Multipliers()
        # self.PARAMS = Params()
        self.PM_MATRIX = Port_map()
        self.TESTBENCH = Testbench()


GLOBAL = Global_objects()


def reset_GLOBAL():
    # global GLOBAL
    GLOBAL = Global_objects()
    return GLOBAL

# items = [
#     ['clk, rst, update_weights:  STD_LOGIC;'],
#     ['IO_in:  signed(TOTAL_BITS - 1 DOWNTO 0);\nc0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in:  signed(BITS - 1 DOWNTO 0);'],
#     ['c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out:  signed(BITS -1 DOWNTO 0);']
# ]

# items = [
#     ['clk, rst, update_weights:  STD_LOGIC;'],
#     ['IO_in:  signed(TOTAL_BITS - 1 DOWNTO 0);\nc0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in:  signed(BITS - 1 DOWNTO 0);'],
#     ['c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out, c3_n3_IO_out:  signed(BITS -1 DOWNTO 0);']
# ]
# tratando a lista: separando linhas e deixando sem sublistas


# def trata_lista(items):
#     for i, item in enumerate(items):
#         items[i] = list(map(str.splitlines, item))

#     items = [item for sublist in items for item in sublist]
#     items = [item for sublist in items for item in sublist]

#     print(items)
#     return items


# items = trata_lista(items)

# # criando declarações de sinais do testbench


# def gen_SIGNALS(items):
#     signals = []
#     for i, item in enumerate(items):
#         signals.append(f"   SIGNAL {item}")


# gen_SIGNALS(items)


# def gen_IOs(items):
#     # criando lista de IOs (inputs & outputs)
#     IOs = []
#     for i, item in enumerate(items):
#         IOs.append(item.split(':'))  # separa nomes e tipo

#     # cria uma sublista de itens, sendo a vírgula o fator de determina a divisão no texto para diferenciar cada entrada
#     for i, item in enumerate(IOs):
#         buff = item[0]
#         if ',' in buff:
#             x = buff.split(',')
#             for j, jitem in enumerate(x):
#                 x[j] = jitem.strip()
#         # x = [ind for ind in x]
#             IOs[i][0] = x

#         # x = list(map(str.split(','), buff))
#         # IOs[i][0] = x

#     print(IOs)
#     return IOs


# IOs = gen_IOs(items)

# # criando lista de IOs, mas agora sem os tipos e sem sublistas, dessa forma fica fácil fazer o port_map do topo


# def gen_IO_list(IOs):
#     IO_assign_list = []
#     for i, item in enumerate(IOs):
#         IO_assign_list.append(item[0])

# # flat_list = [item for sublist in IO_assign_list for item in sublist]
#     flat_list = []
#     for sublist in IO_assign_list:
#         if isinstance(sublist, list):
#             for item in sublist:
#                 flat_list.append(item)
#         else:
#             flat_list.append(sublist)
#     IO_assign_list = flat_list
#     print(IO_assign_list)


# gen_IO_list(IOs)

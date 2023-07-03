from utils.components.Block_Arith import *
# from standard_dicts import layer_dict_hidden

# from Block_Arith import *


def add0(name, Bit_WIDTH, bit_width_multiplication):
    entity = (f'''
ENTITY {name} IS
    GENERIC (
        BITS : NATURAL := {Bit_WIDTH}
    );
    PORT (
        X : IN signed(({bit_width_multiplication}* BITS) - 1 DOWNTO 0);
        W : IN signed(({bit_width_multiplication}* BITS) - 1 DOWNTO 0);
        Y : OUT signed(({bit_width_multiplication}* BITS) - 1 DOWNTO 0)
    );
END ENTITY;''')
    signals = ''
    logic_text = "    Y <= X + W;"
    return {
        'entity': entity,
        'signals': signals,
        'logic_text': logic_text
    }


class Adder(Block_Arith):
    # adders_obj_list = []

    def __init__(self, layer_dict, create, PARAMS) -> None:
        super().__init__(layer_dict)
        self.Update_with_dict(layer_dict, create, PARAMS)  # updt da arch

    def Update_with_dict(self, layer_dict, create=False, PARAMS=None):
        self.layer_dict = layer_dict
        self.arch_id = adder_multiplier_number(
            layer_dict=self.layer_dict, type='Adder')
        if self.layer_dict['Neuron_arch']['Barriers']:
            self.bit_width_multiplication = 2
        # self.Set_arch(layer_dict)
        super().Update_with_dict(create, PARAMS)

    def Set_name(self):
        self.name = (f"add{self.arch_id}_v{self.arch_version}")

    def Set_arch(self):
        if self.arch_id == 0:
            result_dict = add0(
                self.name, self.layer_dict['Neuron_arch']['Bit_WIDTH'], self.bit_width_multiplication)
        else:
            result_dict = {
                'entity': '',
                'signals': '',
                'logic_text': ''}
            print(f"Arquitetura {self.arch_id} não cadastrada")

        self.entity = result_dict['entity']
        self.signals = result_dict['signals']
        self.logic_text = result_dict['logic_text']


class Adders:
    def __init__(self) -> None:
        self.adders_obj_list = []

    def New_obj(self, layer_dict, create, PARAMS):
        self.adders_obj_list.append(Adder(layer_dict, create, PARAMS))


# ADDERS = Adders()
# adder = Adder(layer_dict_hidden)
# print(adder.txt)

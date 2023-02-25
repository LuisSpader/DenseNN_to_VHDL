import os
from vhd_txt_utils import entity
from name import vhd_name


class VHD_obj:
    # construtor
    def __init__(self, name='vhd', bits=8, num_inputs=1, IO_dict=None, VHD_obj_list=None) -> None:
        self.libraries_list = None  # bibliotecas no começo do texto VHDL

        # ======================= ENTITY =======================
        # --------------------- PARAMETROS ---------------------
        self.bits = bits
        self.num_inputs = num_inputs

        if (IO_dict == None):  # caso não seja passado um dicionário
            self.IO_dict = standard_dict

        else:  # caso seja passado um dicionário
            self.IO_dict = IO_dict

        # ----------------------- OBJETO -----------------------
        self.entity = Entity(name=name, bits=bits,
                             num_inputs=num_inputs)  # OBJ

        # ==================== ARCHITECTURE ======================
        # --------------------- COMPONENTS ---------------------
        # listar todos os '.vhd' de hierarquia inferior que estarão contidos neste '.vhd'
        # self.components_obj_list = VHD_obj_list

        self.components = Components(VHD_obj_list)  # OBJ

        # ----------------------- SIGNALS ----------------------
        self.signals = None

        # ======================= OTHERS ========================
        self.component_txt = self.entity.text.replace(
            "ENTITY", "COMPONENT")  # componente próprio

        # entity
        # arch
        #   component
        #   signals
        # begin arch, end arch
        self.VHD_text = (f'''



''')


class Entity:
    def __init__(self, name='vhd', bits=8, num_inputs=1) -> None:
        # self.name = None
        self.bits = bits
        self.num_inputs = num_inputs
        self.IO_dict = standard_dict
        self.name = self.txt_name(name, bits, num_inputs, True)

        self.text = self.entity_txt()

    def txt_name(self, name: str, bits: int, num_inputs: int, include_parameters: bool = True) -> str:  # definindo nome
        if include_parameters == True:  # caso queira incluir os parâmetros no nome, ex: camada1_ReLU_3neuron_8bits_3n_signed
            return vhd_name(name,
                            bits=bits,
                            IO_type=True,
                            num_inputs=num_inputs,
                            Barriers=False,
                            MAC_type=False,
                            Include_MAC_type=False)
        else:  # caso não queira incluir os parâmetros no nome, ex: camada1
            return name

    def entity_txt(self) -> str:  # escrevendo texto da entity
        return entity(name=self.name,
                      bits=self.bits,
                      num_inputs=self.num_inputs,
                      IO_dict_list=[self.IO_dict['IO']['shared_IO'], self.IO_dict['IO']['unique_IO']])


class Components:  # aqui só terá o componente do próprio VHD (entity)
    def __init__(self, components_list: list) -> None:
        # self.text = replace_text(class_entity.text)
        self.list = components_list
        self.text = self.components_txt(self.list)

    def components_txt(self, components_list: list):
        """Função para unir os textos de cada componente em um grande texto para ser inserido na 'ARCHITECTURE'

        Args:
            components_list (list): lista de objetos 'VHD_obj' os quais serão usados para pegar o texto 'VHD_obj.component_txt' de cada um

        Returns:
            str: texto com a descrição de todos os componentes de hierarquia abaixo do '.vhd' atual
        """
        txt_list = []
        if components_list:
            for i in components_list:
                txt_list += '\n\n'+i.component_txt

        return ''.join(map(str, txt_list))


class Port_Map:
    pass


class Signals:
    pass


# logic
class Architecture:
    def __init__(self) -> None:
        self.port_map_text = ''
        self.logic_text = ''


standard_dict = {
    'IO': {  # INPUT & OUTPUT
        'shared_IO': {  # Entradas & saídas compartilhadas
            'IN': {  # ENTRADAS
                        'STD_LOGIC': ['clk', 'rst', 'update_weights'],
                        'STD_LOGIC_VECTOR': None,
                        'SIGNED': None,
                        'STD_LOGIC_num_inputs': None,
                        'STD_LOGIC_VECTOR_num_inputs': None,
                        'SIGNED_num_inputs': ['x']  # entradas Xi
            },
            'OUT': {  # SAÍDAS
                'STD_LOGIC': None,
                'STD_LOGIC_VECTOR': None,
                'SIGNED': None,
                'STD_LOGIC_VECTOR_num_inputs': None,
                'STD_LOGIC_num_inputs': None,
                'SIGNED_num_inputs': None
            }
        },
        'unique_IO': {  # Entradas únicas ao neurônio
            'IN': {  # ENTRADAS
                'STD_LOGIC': None,
                'STD_LOGIC_VECTOR': None,
                'SIGNED': ['bias'],
                'STD_LOGIC_num_inputs': None,
                'STD_LOGIC_VECTOR_num_inputs': None,
                'SIGNED_num_inputs': ['w']  # pesos Wi
            },
            'OUT': {  # SAÍDAS
                'STD_LOGIC': None,
                'STD_LOGIC_VECTOR': None,
                'SIGNED': ['y'],
                'STD_LOGIC_VECTOR_num_inputs': None,
                'STD_LOGIC_num_inputs': None,
                'SIGNED_num_inputs': None
            }
        }
    }
}


vhd2 = VHD_obj(name='vhd2', bits=6, num_inputs=3,
               IO_dict=None, VHD_obj_list=None)
vhd3 = VHD_obj(name='vhd3', bits=7, num_inputs=4,
               IO_dict=None, VHD_obj_list=None)
vhd = VHD_obj(name='vhd_neuron', bits=4, num_inputs=2, IO_dict=None,
              VHD_obj_list=[vhd2, vhd3])

print(" =========================== COMEÇO ============================= ")

# print(f"bits: {vhd.entity.bits}")
# print(f"num_inputs: {vhd.entity.num_inputs}")
# print(f"name: {vhd.entity.name}")
# print("\n")

print(" -------------------------- entity txt -------------------------- ")
print(vhd.entity.text)
print("\n")

print(" ======================== ARCHITECTURE ========================== ")
print(" ----------------------- COMPONENTS txt ------------------------- ")
print(vhd.components.text)
print("\n")

print(" ------------------------ SIGNALS txt ------------------------- ")

print("\n")

print(" ------------------------ LOGIC txt -------------------------- ")

print("\n")


# print(" =========================== OUTROS ============================= ")
# print(" ------------------------ component_txt ------------------------- ")
# print(vhd.component_txt)

# with open(f"./{vhd.entity.name}.vhd", "w") as writer :
#     writer.write(vhd.component_txt)
# with open(r"C:\Users\Jairo Luiz\OneDrive\Documentos\Luis Spader\Programming\NN_generator/POO_Neuron.vhd", "w") as writer:
#     writer.write(vhd.component_txt)


# ! para continuar: ouvir áudios

vhd = VHD_obj(name='vhd_neuron', bits=4, num_inputs=3, IO_dict=None,
              VHD_obj_list=None)

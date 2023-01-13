import os

# (hidden,softmax,MAC_type,Barriers,path_level,download )
################################################################################
# DEPENDENCIA DE VARIAVEL GLOBAL """bits e num_inputs"""
################################################################################


def create_folder_neuron(
    bits: int,
    num_inputs: int,
    hidden_layer_neurons: list,
    softmax_layer_neurons: list,
    gen_hidden: bool = True,
    gen_softmax: bool = True,
    MAC_type: bool = False,
    Barriers: bool = False,
    path: str = "./Neuron",
    create: bool = True
):  # https://docs.python.org/3/library/pathlib.html
    """Função para CRIAR DIRETÓRIOS E CRIAR AS PASTAS respectivas a estes diretórios dos neurônios. Temos até então alguns tipos de neurônios. Um exemplo:

    path, path_soft = create_folder_neuron(
        hidden_layer_neurons= ['ReLU','Leaky_ReLU'], #irá gerar 2 diretórios, um para cada uma dessas funções de ativação passadas na lista
        softmax_layer_neurons= ['Sigmoid'], #irá criar 1 diretório de camada 'softmax'
        MAC_type = 0, #combinacional
        Barriers = 0, #versões sem registradores entre as operações
        path_level= 1, # diretórios estarão em pasta paralela à pasta em que está o script
        create=1 # irá criar as pastas para cada diretório gerado
        )

        path: irá armazenar os diretórios dos neurônios do meio (hidden_layer_neurons)
        path_soft: irá armazenar os diretórios dos neurônios nda última camada (softmax_layer_neurons)

        Resultado será:
        path[0] = Relu: /home/murillo/ecl/redes_neurais/nn_generator/Neuron/HiddenLayer/Tree/NObarriers/ReLU/8bit/3n
        ----------------------
        path[1] = Leaky Relu: /home/murillo/ecl/redes_neurais/nn_generator/Neuron/HiddenLayer/Tree/NObarriers/Leaky_ReLU/8bit/3n
        ----------------------
        path_soft[0] = Softmax: /home/murillo/ecl/redes_neurais/nn_generator/Neuron/SoftmaxLayer/Tree/NObarriers/Sigmoid/8bit/3n

    Args:
        hidden_layer_neurons (list): Lista de nomes dos neurônios (1 para cada função de ativação), ex: ['ReLU','Leaky_ReLU'] ; neurônios da parte do meio, que possuem função de ativação ReLU ou Leaky ReLu por enquanto

        softmax_layer_neurons (list): Lista de nomes dos neurônios (1 para cada função de ativação), ex: ['Sigmoid','tangh'] ; neurônios da última camada, que possuem função de ativação não linear, por exemplo a Sigmóide

        MAC_type (bool): Tipo de MAC (multiplicação e acumulação) -> 0 = tree (combinacional) | 1 = Sequencial (multi ciclo)

        Barriers (bool): Se tem barreiras de registradores entre as operações (para aumentar a freq de clock) -> 0 = no Barriers | 1 = with register Barriers (pipeline)

        path_level (bool): Se quer criar as pastas na mesma pasta onde está o script ou uma pasta acima (para ficar em 
        pastas separadas) -> 0 = Same level path | 1 = Above path

        create (bool): parâmetro se quer gerar as pastas ou não (assim o script inteiro roda, porém não criamos a pasta quando desejarmos) -> 0 = Don't Create Folders  | 1 = Create Folders

    Returns:
        string: Retorna uma string com o diretorio completo para cada tipo de neuronio (se ele é hidden ou softmax, se tem barreira, qual sua função de ativação) e tbm de acordo com os outros parâmetros explicados anteriormente
    """

    path_dir = path
    path_hidden = [None] * len(hidden_layer_neurons)
    path_soft = [None] * len(softmax_layer_neurons)

    # ========= # MAC_type = False = combinational(tree:árvore) #===========#
    if MAC_type == False:
        if Barriers == False:  # False = no Barriers
            for i in range(0, len(hidden_layer_neurons)):
                path_hidden[i] = f"Tree/NObarriers/"

        else:  # 1 = with register Barriers (pipeline)
            for i in range(0, len(hidden_layer_neurons)):
                path_hidden[i] = f"Tree/BARRIERS/"

    # ----------------# MAC_type = 1 = Sequential #----------------#
    else:
        if Barriers == False:  # 0 = no Barriers
            for i in range(0, len(hidden_layer_neurons)):
                path_hidden[i] = f"Sequential/NObarriers/"
        else:  # 1 = with register Barriers (pipeline)
            # NAME_dir_MAC = "Sequential/shallow_barriers/"
            for i in range(0, len(hidden_layer_neurons)):
                path_hidden[i] = f"Sequential/BARRIERS/"

    # -------------------------------------------------------------------------------------------#
    # ======================== SOFTMAX LAYER ======================== #
    for i in range(0, len(softmax_layer_neurons)):
        path_soft[i] = f"{path_dir}/SoftmaxLayer/{path_hidden[i]}{softmax_layer_neurons[i]}/{bits}bit/{num_inputs}n"

    # ======================== HIDDEN LAYERS ======================== #
    for i in range(0, len(hidden_layer_neurons)):
        path_hidden[i] = f"{path_dir}/HiddenLayer/{path_hidden[i]}{hidden_layer_neurons[i]}/{bits}bit/{num_inputs}n"

    if create == True:  # CREATING FOLDERS
        path_others = path_soft[0].split('/')[0:3]
        # text_list can be an splitted text or a list of texts
        path_others = '/'.join(map(str, (path_others)))
        path_others = f"{path_others}/Others/"
        os.makedirs(f"{path_others}", exist_ok=True)  # softmax layer
        print(f"create_folder_neuron() -> Created: {path_others}")

        if gen_softmax:
            for i in range(0, len(softmax_layer_neurons)):
                os.makedirs(f"{path_soft[i]}", exist_ok=True)  # softmax layer
                print(f"create_folder_neuron() -> Created: {path_soft[i]}")

        if gen_hidden:
            for i in range(0, len(hidden_layer_neurons)):
                os.makedirs(f"{path_hidden[i]}", exist_ok=True)  # hidden layer
                print(f"create_folder_neuron() -> Created: {path_hidden[i]}")
            # print("Created Folders!!")
    return (path_hidden, path_soft)

# ---------------------------------------------------------------------------------------------------------


def create_folder(path_list, path_level, create):
    # path_level:   0 = Same level path       | 1 = Above path
    # create:       0 = Don't Create Folders  | 1 = Create Folders
    #
    #  https://docs.python.org/3/library/pathlib.html
    import os

    # ===================== DIR PATH LEVEL ===================== #
    if (path_level == 0):  # SAME LEVEL
        whole_dir = os.path.abspath('.')

    else:  # ABOVE FOLDER
        whole_dir = os.path.abspath('..')

    path = [None]*len(path_list)

    # ===================== Creating Folders ===================== #
    for i in range(0, len(path)):
        path[i] = f"{whole_dir}/{path_list[i]}"

    if (create == 1):  # CREATING FOLDERS
        for i in range(0, len(path)):
            os.makedirs(f"{path[i]}", exist_ok=True)   # hidden layer
            print(f"create_folder() ->  {path[i]}")

    return (path)

# ---------------------------------------------------------------------------------------------------------


def create_folder_path(path: str = './', create: bool = True):
    # path_level:   0 = Same level path       | 1 = Above path
    # create:       0 = Don't Create Folders  | 1 = Create Folders
    #
    #  https://docs.python.org/3/library/pathlib.html
    import os
    whole_dir = os.path.abspath('..')

    # ===================== Creating Folders ===================== #
    if (create == 1):  # CREATING FOLDERS
        os.makedirs(f"{path}/", exist_ok=True)   # hidden layer
        print(f"create_folder_path() ->  {path}/")

    return path

    # import os

    # if (create == 1):  # CREATING FOLDERS
    #     os.makedirs(f"{path}", exist_ok=True)   # hidden layer
    #     print(f"create_folder() ->  {path}")

    # return (path)


# path = "../NNsdsdssfsfsfsfsf"
# os.makedirs(f"{path}", exist_ok=True)   # hidden layer
# print(f"create_folder_path() ->  {path}")

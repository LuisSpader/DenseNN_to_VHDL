import zipfile
import os


def download_TxtFile_As(Text: str = "Text to download!",
                        folder_create: str = "",
                        filename_with_type: str = "texto.txt",
                        path_level: bool = False
                        ):
    """Função para salvar arquivos de texto em qualquer formato desejado '.vhd' ou '.txt' por exemplo.

    Args:
        Text (str, optional): Texto para salvar em formato desejado. Defaults to "Text to download!".
        folder_create (str, optional): Se deseja criar alguma pasta, coloque nome dela. Defaults to "".
        filename_with_type (str, optional): Nome do arquivo com seu tipo, exemplo: "texto.txt" ou "texto.vhd". Defaults to "texto.txt".
        path_level (bool, optional):  Se quer criar as pastas na mesma pasta onde está o arquivo chamador da função ou uma pasta acima (para ficar em 
        pastas separadas) -> False = Same level path | True = Above path. Defaults to False.
    """
    # ===================== DIR PATH LEVEL ===================== #
    if path_level == False:  # SAME LEVEL
        whole_dir = os.path.abspath(".")

    else:  # ABOVE FOLDER
        whole_dir = os.path.abspath("..")

    path = f"{whole_dir}/{folder_create}"

    os.makedirs(f"{path}", exist_ok=True)  # softmax layer
    print(f"Folder Created: {path}")

    with open(f"{path}{filename_with_type}", "w") as writer:
        writer.write(Text)


# download_TxtFile_As(Text="Text to download",
#                     folder_create="",
#                     filename_with_type=".txt",
#                     path_level=False)


def zipdir(path, ziph):
    # ziph is zipfile handle
    for root, dirs, files in os.walk(path):
        for file in files:
            ziph.write(os.path.join(root, file),
                       os.path.relpath(os.path.join(root, file),
                                       os.path.join(path, '..')))


def zipit(dir_list, zip_name):
    zipf = zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED)
    for dir in dir_list:
        zipdir(dir, zipf)
    zipf.close()
# dir_list = ['../NNs/Camadas/', '../Neuron']
# zip_name = 'NN.zip'
# zipit(dir_list, zip_name)

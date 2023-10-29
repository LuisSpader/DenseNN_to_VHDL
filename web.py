# import graphviz as graphviz
import time
from datetime import date
# import shutil
import streamlit as st
# import sys
# import os

# # Get the current directory of the script (web folder)
# current_dir = os.path.dirname(os.path.abspath(__file__))

# # Get the parent directory of the current directory (Python_script folder)
# parent_dir = os.path.dirname(os.path.dirname(current_dir))

# # Add the parent directory to the Python path
# sys.path.append(parent_dir)

from web.streamlit_parameters import *

# web_dict_hidden = copy.deepcopy(layer_dict_hidden)
# web_dict_softmax = copy.deepcopy(layer_dict_softmax)
# cd Python_script
# streamlit run web.py
# https://docs.streamlit.io/library/api-reference/
# https://www.ieee-lascas.org/
# https://www.overleaf.com/project/63221ad7270a475d8bd7db42

# n_width = st.sidebar.slider("Nmos width (nm)", 70, 210, 70)
# length = st.sidebar.slider("Nmos and Pmos length (nm)", 32, 40, 32)
# temperature = st.sidebar.slider("Temperature (°C)", -25, 100, -25)
# n_var = st.sidebar.slider("Nmos variability", 0.46, 0.59, 0.5166)
# p_var = st.sidebar.slider("Pmos variability", -0.5, -0.4, -0.4341)
# sdsds
st.title("Dense NN to VHDL Generator ")
st.info(
    '''This website generates Artificial Neural Networks (DNNs) with the VHDL hardware description language. 
        This DNN is a multi-layer Perceptron (MLP) with a sigmoid layer at the end.
        Set you preference parameters to generate a custom DNN''')
# st.markdown("##")
st.markdown("---")
IO_TYPE_STR = 'signed'

PATH = '../NN'
INCLUDE_PARAMETERS_ON_FOLDERNAME = False
DOWNLOAD_VHD = True  # True= para baixar || False = não baixar
DEAD_NEURONS = False  # gera neurônios mortos

INPUTS_NUMBER, BIT_WIDTH, NUMBER_OF_LAYERS, LAYER_NEURONS_NUMBER_LIST, BASE_DICT_HIDDEN, BASE_DICT_SOFTMAX = streamlit_parameters()

st.markdown("---")


def download_NN_as_Zip(dir_list: list, zip_name: str):
    GEN_TOP_LEVEL_HDL(
        INPUTS_NUMBER,
        BIT_WIDTH,
        IO_TYPE_STR,
        LAYER_NEURONS_NUMBER_LIST,
        BASE_DICT_HIDDEN,
        BASE_DICT_SOFTMAX,
        PATH,
        INCLUDE_PARAMETERS_ON_FOLDERNAME,
        DOWNLOAD_VHD, DEAD_NEURONS)

    # shutil.make_archive('NN', 'zip', '.')
    zipit(dir_list, f"{zip_name}.zip")

# def download_NN_streamlist():


def download_NN_streamlist(dir_list, zip_name):
    download_NN_as_Zip(dir_list, zip_name)

    with open(f"./{zip_name}.zip", "rb") as fp:
        btn = st.download_button(
            label="Download ZIP",
            data=fp,
            file_name=f"{zip_name}.zip",
            mime="application/zip",
            disabled=False
        )

# def network_flowchart():


def network_flowchart(NUMBER_OF_LAYERS, LAYER_NEURONS_NUMBER_LIST):
    c = [None]*NUMBER_OF_LAYERS
    neurons_text = ['']*NUMBER_OF_LAYERS
    for l in range(0, len(LAYER_NEURONS_NUMBER_LIST)):
        c[l] = "{"
        for n in range(0, LAYER_NEURONS_NUMBER_LIST[l]):
            neurons_text[l] = f"{neurons_text[l]} c{l}_n{n} "
        buffer = "{" + neurons_text[l] + "}"
        c[l] = buffer

    # c[0] = "{" + f"c{0}_n{0} c{0}_n{1} c{0}_n{2}" + "}"
    # c[1] = "{" + f"c{1}_n{0} c{1}_n{1}" + "}"
    # c[2] = "{" + f"c{2}_n{0} c{2}_n{1}" + "}"

    # iterando sobre neuronios da primeira camada
    inp_text = ""
    for n in range(0, LAYER_NEURONS_NUMBER_LIST[0]):
        inp_text = f"{inp_text} inp{l}_n{n} "
    inp_text_all = "{" + inp_text + "}"
    inp_text_all = f"{inp_text_all} -> {c[0]}"

    all_layers_txt = ""
    all_layers_txt = f"{c[0]}"

    for l in range(1, len(c)):
        all_layers_txt = f"{all_layers_txt} -> {c[l]}"

    graph_text = ('''
    digraph G {
        fontname="Helvetica,Arial,sans-serif"
        node [fontname="Helvetica,Arial,sans-serif"]
        edge [fontname="Helvetica,Arial,sans-serif"]
        graph [center=1 rankdir=LR]
        edge [dir= none]
        node [width=0.3 height=0.3 label=""]
        { node [shape=circle style=invis]
		''' + inp_text + '''
	    }
        ''' +
                  #   {node[shape=circle]
                  #    a b c d  # e f g h  i j k l m n o p  q r s t u v w x
                  #    }
                  '''
        { edge [color="#ff0000"]
            ''' + all_layers_txt + '''
        }
        { edge [color="#00faff"]
            ''' + inp_text_all + '''
        }
}
''')
    return graph_text


# -------------------

dir_list = ['../NN/']

today = date.today()
# now = datetime.now()
zip_name = 'NN_VHDL'
zip_name = f"{zip_name}_{NUMBER_OF_LAYERS}Layers_{today}_{BIT_WIDTH}Bits"

st.markdown("## Dou you want to download the VHDL files?")
st.markdown("First click on 'Generate NN' button")
col1, col2 = st.columns([2, 1])
with col1:
    download = st.button("Generate NN")
    if download:
        with st.spinner('Wait for it...'):
            time.sleep(5)
        st.success(
            "Done! Now click on 'Download Zip' button to download your VHDL DNN")
        graph_text = network_flowchart(
            NUMBER_OF_LAYERS, LAYER_NEURONS_NUMBER_LIST)
        st.graphviz_chart(graph_text, use_container_width=False)
        st.markdown("#")

with col2:
    if download:
        time.sleep(5)
        download_NN_streamlist(dir_list, zip_name)

with st.sidebar:
    st.markdown("---")
    st.markdown("#")

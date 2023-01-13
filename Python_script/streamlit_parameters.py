from plot_relu_leaky import plot_fx_activations
import streamlit as st
from All_NN_gen import *
import os


def streamlit_parameters():
    st.sidebar.markdown("# ANN Parameters")

    INPUTS_NUMBER = st.sidebar.number_input(label="First layer number of Inputs (int)",
                                            min_value=1,
                                            max_value=500,
                                            value=10
                                            #   step=1  # int
                                            )
    with st.sidebar.expander("See explanation"):
        st.write("""
            The parameter above defines how much inputs the first ANN Layer has.
            **You can see an example in the image below. 
            The blue edges are the inputs to the 1st Layer.**
        """)
        st.image("./images/Input_example.png")  # when running on server
        # st.image("../images/Input_example.png")  # when running local
    st.sidebar.markdown("---")
    BIT_WIDTH = st.sidebar.slider(label="Bit Width for Inputs, Weights ans Bias",
                                  min_value=1,
                                  max_value=16,
                                  value=8,
                                  step=1  # int
                                  )
    NUMBER_OF_LAYERS = st.sidebar.slider(label="Number of layers",
                                         min_value=1,
                                         max_value=20,
                                         value=3,
                                         step=1  # int
                                         )

    LAYER_NEURONS_NUMBER_LIST = [None]*NUMBER_OF_LAYERS

    for i in range(0, NUMBER_OF_LAYERS):
        LAYER_NEURONS_NUMBER_LIST[i] = st.sidebar.number_input(label=f"Number of Neurons in layer[{i}]", min_value=1, max_value=5000, value=10
                                                               )

    # NUMBER_OF_LAYERS = len(LAYER_NEURONS_NUMBER_LIST)
    BASE_DICT_HIDDEN = layer_dict_hidden
    BASE_DICT_SOFTMAX = layer_dict_softmax
    with st.container():
        st.container()
        col1, col2 = st.columns([4, 3])
        with col2:
            Include_MAC_type = st.checkbox(
                "Include MAC parameters on MAC.vhd? (good for organization, bad for customization)")
            BASE_DICT_HIDDEN['Neuron_arch']['Include_MAC_type'] = Include_MAC_type
            BASE_DICT_SOFTMAX['Neuron_arch']['Include_MAC_type'] = Include_MAC_type

            Barriers = st.checkbox(
                "Register Barriers on each MAC(Multiply and Acumulate tree) layer? (increases frequency)")
            with open("./images/Barriers2.png", "rb") as f:
                img_Barrier = f.read()
            with open("./images/NoBarriers2.png", "rb") as f:
                img_NoBarrier = f.read()
            # with open("../images/Barriers2.png", "rb") as f:
            #     img_Barrier = f.read()
            # with open("../images/NoBarriers2.png", "rb") as f:
            #     img_NoBarrier = f.read()

            if Barriers:
                st.image(img_Barrier)
            else:
                st.image(img_NoBarrier)

            BASE_DICT_HIDDEN['Neuron_arch']['Barriers'] = Barriers
            BASE_DICT_SOFTMAX['Neuron_arch']['Barriers'] = Barriers

        with col1:

            fx_activation_option = st.radio(
                'Select the Activation Function from the Hidden Layers',
                ('ReLU', 'Leaky ReLU'))

            # st.write('You selected:', option)
            if fx_activation_option == 'ReLU':
                BASE_DICT_HIDDEN['Neuron_arch']['Activation_fx']['ReLU'] = True
                BASE_DICT_HIDDEN['Neuron_arch']['Activation_fx']['Leaky_ReLU']['Using'] = False
                fig = plot_fx_activations(leaky_attenuation=2)
                st.plotly_chart(fig, use_container_width=True)

            else:
                BASE_DICT_HIDDEN['Neuron_arch']['Activation_fx']['ReLU'] = False
                BASE_DICT_HIDDEN['Neuron_arch']['Activation_fx']['Leaky_ReLU']['Using'] = True

                Leaky_attenuation = st.slider(label="Leaky attenuation (divides by 2^n)",
                                              min_value=1,
                                              max_value=8,
                                              value=2,
                                              step=1  # int
                                              )
                BASE_DICT_HIDDEN['Neuron_arch']['Activation_fx']['Leaky_ReLU']['Leaky_attenuation'] = Leaky_attenuation

                fig = plot_fx_activations(leaky_attenuation=Leaky_attenuation)
                st.plotly_chart(fig, use_container_width=True)

    return INPUTS_NUMBER, BIT_WIDTH, NUMBER_OF_LAYERS, LAYER_NEURONS_NUMBER_LIST, BASE_DICT_HIDDEN, BASE_DICT_SOFTMAX

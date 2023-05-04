





Qaware.MNIST_database -> Qaware.data_zoom -> Qaware.class_QAutocender(
    gen_QAutoencoder_models: model_folder, model.model
    (
        model.model -> tf_to_dict: tf_dict.json
        model.model + get_weights.py -> treat_arrays: weights_bin.txt, weights_bin_log.txt, neurons_bin.py
    ): tf_dict.json + model_folder(model_obj.model_predictions) -> load_model: tb_inputs, expected_results todo: CONFERIR SE SÃO AS PREDIÇÕES DO MODELO QUANTIZADO ->

    tf_dict.json -> dict_to_dense: NN_folder(same folder of saved model) generates VHDL
)


# todo: fazer 'tf_dict.json -> dict_to_dense (gera NN em VHDL) : assim ao gerar arquitetura de uma camada só, já geramos o VHDL e já testamos no ModelSim
# todo: investigar se o mapeamento dos pesos estão corretos em 'treat_arrays.py': analisar se o bias está 'indo primeiro' na saída -> COMPARAR COM ARQUITETURA RTL (investigar no ModelSim) -> testar com modelo de 1 camada só
# todo: salvar o JSON dos pesos na pasta do 'model_folder': float, int(2**(BIT_WIDTH)) e bin
# todo: unir tudo para funcionar de juma vez só tendo 2 opções: 1) começar desde o treinamento 2) começar utilizando modelo já treinado

# todo: make or find a simulator to get the expected results from the NN
# 1) Qaware.MNIST_database -> Qaware.data_zoom -> model_obj(class_QAutoencoder) ->  model_folder(gen_QAutoencoder_models) -> tf_dict.json(tf_to_dict) + weights_bin.txt(treat_arrays) ->  tb_inputs, expected_results(load_model) -> NN_folder(dict_to_dense)
# 2)                                                                                model_folder(gen_QAutoencoder_models) -> tf_dict.json(tf_to_dict) + weights_bin.txt(treat_arrays) ->  tb_inputs, expected_results(load_model) -> NN_folder(dict_to_dense)

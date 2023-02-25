- como são gerados os sinais de port map entre as camadas --> não foi feito ainda

- como são gerados os sinais nas camadas e nos neurônios
- remove_dict_items

===========
- neuronios Softmax n podem ter Wout
- port map do Top

============================
all_dense_layers_gen
	layer_gen
		layer_neurons_port_map_ALL
				layer_neurons_port_map
					**entity_port_map**
						**Neuron_port_map_IO_unique**	port_map_layers_to_top
							**port_map_dict**	port_map_layers_to_top --> ?? neuron_dict['shared_IO'][IO_type][port_type]
								 port_map_list = dict_list_exceptNone( dict_slice=neuron_dict['shared_IO'][IO_type][port_type], return_value_or_key='key', is_list=True)

									txt, port_map_l = input_sequences_number_choice(

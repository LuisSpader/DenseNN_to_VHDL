layer_dict_list = all_dense_layers_gen(
	--------- GERANDO DICTS base - --------
	for i in range(0, len(layer_dict_list)):
        		layer_dict_list[i]=copy.deepcopy(base_dict_hidden_layers)

	layer_dict_list[i]=layer_dict_gen_base(

	--------- GERANDO TEXTO DA CAMADA - -------- ************************
	layer_text=layer_gen(layer_dict_arg=layer_dict_list[i], ...

		--------- ENTIDADE CAMADA - -------- ***********************
		{entity2_layer_dict(layer_dict=output_dict,
				        remove_dict_items=[],
				        generic=True
				)}
		- -------- PORT MAP NEURÔNIOS - --------**
		# gerando texto port_map dos neurônios e atualizando as IO do 'layer'dict' (dicionário da camada)
    		port_map_txt, output_dict=layer_neurons_port_map_ALL(
     		   layer_dict_arg=output_dict,
     		   ID_camada=ID_camada,
     		   n_max=n_max)
			- ------
			    output_dict=layer_dict_arg
			    neuron_dict=output_dict['Neuron_arch']['IO']
			    neuron_vhd_name=output_dict['Neuron_arch']['Neuron_name']
			    number_of_neurons=output_dict['Neurons_number']
			    num_inputs=output_dict['Inputs_number']

			    # mapeamento de TODOS OS NEURÔNIOS da camada
			    port_map_txt, camada_inputs, camada_outputs=layer_neurons_port_map(
			        number_of_neurons=number_of_neurons,
			        vhd_name=neuron_vhd_name,
			        neuron_dict=neuron_dict,
			        num_inputs=num_inputs,
			        ID_camada=ID_camada,
			        n_max=n_max)

			- ----------------------------------------------layer_neurons_port_map()
				for j in range(0, number_of_neurons):
				        txt, camada_inputs, camada_outputs=(entity_port_map(
				            vhd_name=vhd_name,
				            i=j,
				            num_inputs=num_inputs,
				            neuron_dict=neuron_dict,
				            ID_camada=ID_camada))

				        txt_list.append(txt)
				        lista_camada_inputs.append(camada_inputs)
				        lista_camada_outputs.append(camada_outputs)

				    txt=''.join(map(str, txt_list))

				- ------------------------ entity_port_map()
                # Função para gerar o texto de todas as ATRIBUIÇÕES das entradas e saídas de um componente. Ou seja, serve para ser utilizado quando instanciamos um componente. Será utilizada quando queremos dentro de uma camada, instanciar múltiplos neurônios.
					Neuron_IN_port_map, Neuron_OUT_port_map, lista_camada_inputs, lista_camada_outputs=Neuron_port_map_IO_unique(
					        neuron_dict=neuron_dict,
					        num_inputs=num_inputs,
					        i=i,
					        ID_camada=ID_camada)
					    # adicionando espaço no início de cada linha (formatação de código)
					    inputs_txt=txt_add_space_begin(txt=Neuron_IN_port_map, space=6)
					    outputs_txt=txt_add_space_begin(txt=Neuron_OUT_port_map, space=6)

					    # criando texto
					    txt=(f"""
					{vhd_name.split('_')[0]}_inst_{i}{vhd_name_final_str}: ENTITY work.{vhd_name}
					   PORT MAP (
					            ---------- Entradas ----------
					{inputs_txt}
					            ---------- Saidas ----------
					{outputs_txt}
					   );
					            """)
                    - ----------------------------------------------------

                        # ========================= IN =================================
                            # ['IN']['STD_LOGIC'] - OK
                            x, lista_camada_inputs[0]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[0],
                                IO_type='IN',
                                port_type='STD_LOGIC',
                                num_inputs=1,
                                com_numero=False  # True: 'x' se torna 'x1, x2, ...'
                            )
                            if (x != ''):
                                Neuron_IN_port_map="-- ['IN']['STD_LOGIC'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x
                            # --------------------------------------------------
                            # ['IN']['STD_LOGIC_VECTOR'] - OK
                            x, lista_camada_inputs[1]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[1],
                                IO_type='IN',
                                port_type='STD_LOGIC_VECTOR',
                                num_inputs=1,  # colocar = 1 quando 'com_numero' = False
                                com_numero=False  # True: 'x' se torna 'x1, x2, ...'
                            )
                            if (x != ''):
                                Neuron_IN_port_map=Neuron_IN_port_map + \
                                    "-- ['IN']['STD_LOGIC_VECTOR'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x
                            # --------------------------------------------------

                            # ['IN']['SIGNED'] - OK
                            x, lista_camada_inputs[2]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[2],
                                IO_type='IN',
                                port_type='SIGNED',
                                num_inputs=1,  # colocar = 1 quando 'com_numero' = False
                                com_numero=False  # True: 'x' se torna 'x1, x2, ...'
                            )
                            if (x != ''):
                                Neuron_IN_port_map=Neuron_IN_port_map + \
                                    "-- ['IN']['SIGNED'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x

                            # --------------------------------------------------

                            # ['IN']['STD_LOGIC_num_inputs'] - OK
                            x, lista_camada_inputs[3]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[3],
                                IO_type='IN',
                                port_type='STD_LOGIC_num_inputs',
                                num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
                                com_numero=True  # True: 'x' se torna 'x1, x2, ...'
                            )
                            if (x != ''):
                                Neuron_IN_port_map=Neuron_IN_port_map + \
                                    "-- ['IN']['STD_LOGIC_num_inputs'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x
                            # --------------------------------------------------

                            # ['IN']['STD_LOGIC_VECTOR_num_inputs'] - OK
                            x, lista_camada_inputs[4]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[4],
                                IO_type='IN',
                                port_type='STD_LOGIC_VECTOR_num_inputs',
                                num_inputs=num_inputs,  # colocar = 1 quando 'com_numero' = False
                                com_numero=True  # True: 'x' se torna 'x1, x2, ...'
                            )
                            if (x != ''):
                                Neuron_IN_port_map=Neuron_IN_port_map + \
                                    "-- ['IN']['STD_LOGIC_VECTOR_num_inputs'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x
                            # --------------------------------------------------

                            # ['IN']['SIGNED_num_inputs'] -
                            x, lista_camada_inputs[5]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[5],
                                IO_type='IN',
                                port_type='SIGNED_num_inputs',
                                num_inputs=num_inputs,
                                com_numero=True  # True: 'x' se torna 'x1, x2, ...'
                            )
                            if (x != ''):
                                Neuron_IN_port_map=Neuron_IN_port_map + \
                                    "-- ['IN']['SIGNED_num_inputs'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x

                            # --------------------------------------------------

                            # ['IN']['manual'] -
                            x, lista_camada_inputs[6]=port_map_dict(
                                neuron_dict=neuron_dict,
                                ID_camada=ID_camada,
                                lista_camada_IO=lista_camada_inputs[6],
                                IO_type='IN',
                                port_type='manual',
                                num_inputs=1,
                                com_numero=False  # True: 'x' se torna 'x1, x2, ...'
                            )
                            print(
                                f"PORT_MAP_utils :: Neuron_port_map_IO_unique -> x: {x}")
                            print(
                                f"PORT_MAP_utils :: Neuron_port_map_IO_unique -> lista_camada_inputs[6]: {lista_camada_inputs[6]}")
                            if (x != ''):
                                Neuron_IN_port_map=Neuron_IN_port_map + \
                                    "-- ['IN']['manual'] \n"
                                Neuron_IN_port_map=Neuron_IN_port_map + x

                            - -----------------------------------------port_map_dict()
                            # Função para gerar o mapeamento PORT MAP de entradas ou saídas com base numa lista de dicionários. Também retorna uma lista com as IO (Inputs & Outputs). Esta função é apenas um 'quebra galho' da função Neuron_port_map_IO().
                            txt, port_map_l=input_sequences_number_choice(
                                # sequence_id=neuron_dict['shared_IO'][IO_type][port_type],
                                # port_map_list=neuron_dict['shared_IO'][IO_type][port_type],
                                sequence_id=port_map_list,
                                port_map_list=port_map_list,
                                port_map_is_str=False,
                                num_inputs=num_inputs,
                                list_or_string='list',
                                port_map=1,
                                new_line=1,
                                com_numero=com_numero  # True: 'x' se torna 'x1, x2, ...'
                            )
                            txt_port_map.append(txt)
                            lista_camada_IO=lista_camada_IO + [port_map_l]
== == == == == == == == == == == == == == == == == ==

topdict={
'Inputs_number': 3,
'bits': 8,
'IO_type': 'signed',
'Neurons_number': 4,
'Top_name': 'top',
'IO': {
'GENERIC': {
'BITS': < function < lambda > at 0x00000279279B2940 >,
'NUM_INPUTS': < function < lambda > at 0x00000279279B29D0 >,
'TOTAL_BITS': None},
'IN': {
'STD_LOGIC': ['clk', 'rst', 'update_weights'],
'STD_LOGIC_VECTOR': None,
'SIGNED': None,
'manual': ['Xi', 'c0_n0_Win', 'c0_n1_Win', 'c0_n2_Win']},
'OUT': {
'STD_LOGIC': None,
'STD_LOGIC_VECTOR': None,
'SIGNED': ['c1_n0_y', 'c1_n1_y', 'c1_n0_Wout', 'c1_n1_Wout'],
'manual': []
}
}}

   # array of layer_arrays
   for i in range(0, len(listdir), 2):
        print(f"{listdir[i]}, {listdir[i+1]}")
        layers_array.append(
            [np.load(f"{path}/{listdir[i]}"), np.load(f"{path}/{listdir[i+1]}")])  # [bias, weights]

    # layers_array = [
    #     [bias_array, weights_array], # layer0
    #     [bias_array, weights_array], # layer1
    #     [bias_array, weights_array], # layer2
    #     ...
    # ]

    # ---------------- treating weights_list ----------------
    flatten_weights(layers_array)

    neurons = neurons_list_gen_save(layers_array, path_log)

    # neurons = [
    #     [
    #         ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
    #         ['layer0_n1', 0.17614965, [...]],
    #         ['layer0_n2', 0.8049891, [...]],
    #         ['layer0_n3', 0.38902378, [...]]
    #     ],
    #     [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
    #     [[...], [...]],                         # 'layer2_n0', bias, [weights]
    #     [[...], [...], [...]],
    #     [[...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
    # ]

    # -------------------------------------------------

    neurons_joined_PortMap_structure = join_neurons_by_index(
        layers_array, neurons)

    # neurons_joined_PortMap_structure = [
    #     [['layer0_n0', -0.12465311, [-0.006545105017721653, ...]],
    #      ['layer1_n0', -0.098881, [0.12465202808380127, ...]],
    #      ['layer2_n0', -0.00024540332, [0.43135038018226624, ...]],
    #      ['layer3_n0', -0.0042404337, [0.6779475212097168, ...]],
    #      ['layer4_n0', 0.0, [-0.9987852573394775, ...]],
    #      ['layer5_n0', -0.18265386, [0.24596863985061646, ...]]
    #      ],
    #     [['layer0_n1', 0.17614965, [0.0708584263920784, ...]],
    #      ['layer1_n1', 0.30869168, [0.17154280841350555, ...]],
    #      [...],
    #      [...],
    #      [...],
    #      [...]
    #      ],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...]],
    #     ...
    # ]
    # -------------------------------------------------
    # getting max number of neurons in a layer from all NN layers
    max_number_of_layers = 0
    for neuron_level in neurons_joined_PortMap_structure:
        if len(neuron_level) > max_number_of_layers:
            max_number_of_layers = len(neuron_level)

    # creating 1 ghost neuron for each layer
    ghost_neuron_models, layers_num_sequence = create_ghost_neurons(neurons)
    # ghost_neuron_models = [
    #     ['layer0_model', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],
    #     ['layer1_model', 0, [0, 0, 0, 0]],
    #     ['layer2_model', 0, [0, 0, 0]],
    #     ['layer3_model', 0, [0, 0]],
    #     ['layer4_model', 0, [0, 0, 0]],
    #     ['layer5_model', 0, [0, 0, 0, 0]]
    #     ]

    # Add ghost neurons to layers with fewer neurons.
    neurons_with_ghosts = add_ghost_neurons(neurons_joined_PortMap_structure,
                                            max_number_of_layers, ghost_neuron_models, layers_num_sequence)
    print("ghosts done")

    # neurons_with_ghosts = [
    #     [
    #         ['layer0_n0', -0.12465311, [...]],  # 'layer0_n0', bias, [weights]
    #         ['layer0_n1', 0.17614965, [...]],
    #         ['layer0_n2', 0.8049891, [...]],
    #         ['layer0_n3', 0.38902378, [...]],
    #         ['layer0_n4', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],  # ghost
    #         ['layer0_n5', 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, ...]],  # ghost
    #         ...
    #     ],
    #     [[...], [...], [...]],                  # 'layer1_n0', bias, [weights]
    #     [
    #         ['layer0_n2', 0.8049891, [...]],    # 'layer2_n0', bias, [weights]
    #         ['layer1_n2', 0.14208536, [...]],
    #         ['layer3_n2', 0.0, [...]],
    #         ['layer4_n2', 0.0060660695, [...]],
    #         ['layer5_n2', 0.025634281, [...]],
    #         ['layer2_model', 0, [...]]          # ghost
    #     ],
    #     [[...], [...], [...]],
    #     [[...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...], [...], [...], [...], [...], ...]
    # ]

    # ----------------------------------------------------------------

    PM_matrix_list = convert_neuron_structure_to_PM_matrix(neurons_with_ghosts)

    # PM_matrix_list = [
    #     [
    #         [-0.18265386, [0.24596863985061646, ...]],      # layer5_n0
    #         [0.0, [-0.9987852573394775, ...]],              # layer4_n0
    #         [-0.0042404337, [0.6779475212097168,...]],      # layer3_n0
    #         [...],                                          # layer2_n0
    #         [...],                                          # layer1_n0
    #         [...]                                           # layer0_n0
    #     ],
    #     [[...], [...], [...], [...], [...]],                # next neuron
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     ...
    #     ]
    # ----------------------------------------------------------------

    # Transform the PM_matrix to a list of lists (weights and bias on same sublist).
    PM_matrix_list2 = prepare_PM_matrix(
        REVERSE_WEIGHTS, BIAS_ENDING, path_log, PM_matrix_list)

    print("PM_matrix_list2: done")

    # PM_matrix_list2 = [
    #     [ # neuron 0
    #         ['layer5_n0', [...]], # [bias, weights] float list
    #         ['layer4_n0', [...]],
    #         ['layer3_n0', [...]],
    #         ['layer2_n0', [...]],
    #         ['layer1_n0', [...]]
    #     ],
    #     [[...], [...], [...], [...], [...]],  # neuron 1
    #     [[...], [...], [...], [...], [...]],  # neuron 2
    #     [[...], [...], [...], [...], [...]],  # neuron 3
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     ...
    # ]
    # ----------------------------------------------------------------
    # Creating a binary list of lists with the weights and bias of each neuron

    fractional = BIT_WIDTH - 1
    rescale = 2**(BIT_WIDTH-1) if is_signed else 2**(BIT_WIDTH)
    PM_matrix_bin = copy.deepcopy(PM_matrix_list2)

    write_weights_log(path_log, BIT_WIDTH, is_signed,
                      fractional, rescale, PM_matrix_bin)

    print("PM_matrix_bin: done")

    # PM_matrix_bin = [
    #     [ # neuron 0
    #         ['layer5_n0', ['11101001', ...]], # [bias, weights] bin list
    #         ['layer4_n0', [...]],
    #         ['layer3_n0', [...]],
    #         ['layer2_n0', [...]],
    #         ['layer1_n0', [...]]
    #     ],
    #     [[...], [...], [...], [...], [...]],  # neuron 1
    #     [[...], [...], [...], [...], [...]],  # neuron 2
    #     [[...], [...], [...], [...], [...]],  # neuron 3
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     [[...], [...], [...], [...], [...]],
    #     ...
    # ]
    # ----------------------------------------------------------------

    save_neurons_to_file(path_log, neurons, BIT_WIDTH, is_signed, fractional)

    # ----------------------------------------------------------------

    PM_matrix_to_testbench = create_binary_neuron_list(PM_matrix_bin)

    print("PM_matrix_to_testbench: done")

    save_weights(save_path, NN_save_path, PM_matrix_to_testbench)

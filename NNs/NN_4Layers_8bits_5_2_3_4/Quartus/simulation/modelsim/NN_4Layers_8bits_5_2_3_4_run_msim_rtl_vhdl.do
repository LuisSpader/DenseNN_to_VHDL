transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/ROM_fx_8bitaddr_8width.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/parameters.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/mult0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/shift_reg_5n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/shift_reg_3n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/shift_reg_2n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/Reg.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/neuron_comb_Sigmoid_3n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/neuron_comb_ReLU_5n_8bit_signed_mult0_v0_add0_v0_out.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/neuron_comb_ReLU_5n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/neuron_comb_ReLU_2n_8bit_signed_mult0_v0_add0_v0_out.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/MAC_comb_5n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/MAC_comb_3n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Neuron/MAC_comb_2n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Layers/camada3_Sigmoid_4neuron_8bits_3n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Layers/camada2_ReLU_3neuron_8bits_2n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Layers/camada1_ReLU_2neuron_8bits_5n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Layers/camada0_ReLU_5neuron_8bits_5n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/top.vhd}

vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Quartus/../top_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  top_tb

do C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_4Layers_8bits_5_2_3_4/Quartus/do_wave.txt

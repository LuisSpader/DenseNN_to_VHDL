transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Quartus/db {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Quartus/db/mult_hb01.v}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/parameters.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/ReLU.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/mult0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/activation_fx.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/shift_reg_64n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/shift_reg_4n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/shift_reg_3n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/shift_reg_2n.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/Reg.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/neuron_comb_Sigmoid_4n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/neuron_comb_ReLU_64n_8bit_signed_mult0_v0_add0_v0_out.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/neuron_comb_ReLU_4n_8bit_signed_mult0_v0_add0_v0_out.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/neuron_comb_ReLU_3n_8bit_signed_mult0_v0_add0_v0_out.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/neuron_comb_ReLU_2n_8bit_signed_mult0_v0_add0_v0_out.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/MAC_comb_64n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/MAC_comb_4n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/MAC_comb_3n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Neuron/MAC_comb_2n_8bit_signed_mult0_v0_add0_v0.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Layers/camada5_Sigmoid_64neuron_8bits_4n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Layers/camada4_ReLU_4neuron_8bits_3n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Layers/camada3_ReLU_3neuron_8bits_2n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Layers/camada2_ReLU_2neuron_8bits_3n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Layers/camada1_ReLU_3neuron_8bits_4n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Layers/camada0_ReLU_4neuron_8bits_64n_signed.vhd}
vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/top.vhd}

vcom -93 -work work {C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Quartus/../tb_Files/top_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  top_tb

do C:/Users/luisa/OneDrive/Documentos/GitHub/DenseNN_to_VHDL/NNs/NN_6Layers_8bits_4_3_2_3_4_64/Quartus/do_wave.txt

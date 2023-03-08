onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate -color White /tb_top/rst
add wave -noupdate -color {Medium Spring Green} -radix binary /tb_top/IO_in
add wave -noupdate -color Magenta -radix decimal /tb_top/update_weights
add wave -noupdate -color Magenta -radix decimal /tb_top/c0_n0_W_in
add wave -noupdate -color Magenta -radix decimal /tb_top/c0_n1_W_in
add wave -noupdate -color Magenta -radix decimal /tb_top/c0_n2_W_in
add wave -noupdate -color Magenta -radix decimal /tb_top/c0_n3_W_in
add wave -noupdate -color Magenta -radix decimal /tb_top/c0_n4_W_in
add wave -noupdate -color Green -radix decimal /tb_top/c3_n0_IO_out
add wave -noupdate -color Green -radix decimal /tb_top/c3_n1_IO_out
add wave -noupdate -color Green -radix decimal /tb_top/c3_n2_IO_out
add wave -noupdate -color Green -radix decimal /tb_top/c3_n3_IO_out
add wave -noupdate -color Green /tb_top/buff_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 303
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {52500 ns}

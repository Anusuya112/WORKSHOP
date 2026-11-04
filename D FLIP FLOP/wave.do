onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /d_flipflop_tb/clk
add wave -noupdate /d_flipflop_tb/D
add wave -noupdate /d_flipflop_tb/Q
add wave -noupdate /d_flipflop_tb/uut/clk
add wave -noupdate /d_flipflop_tb/uut/D
add wave -noupdate /d_flipflop_tb/uut/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0} {{Cursor 2} {49090 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {52500 ps}

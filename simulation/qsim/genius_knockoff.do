onerror {quit -f}
vlib work
vlog -work work genius_knockoff.vo
vlog -work work genius_knockoff.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.genius_knockoff_vlg_vec_tst
vcd file -direction genius_knockoff.msim.vcd
vcd add -internal genius_knockoff_vlg_vec_tst/*
vcd add -internal genius_knockoff_vlg_vec_tst/i1/*
add wave /*
run -all

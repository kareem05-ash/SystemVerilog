# cd f:/GitHub/SystemVerilog/LABs
# vsim -c
# project new ./S1 work
# project addfile ./up_down_count.v
# project addfile ./up_down_count_tb.sv
vlib work
vlog up_down_count.v up_down_count_tb.sv
vsim -voptargs=+acc work.up_down_count_tb
add wave *
run -all
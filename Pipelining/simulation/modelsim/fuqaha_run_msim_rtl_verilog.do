transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/WriteBack_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/sign_extention (1).v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Register_File (1).v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/pipeline_TopLevel.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Mux3to_1_d.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Mux2_to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Memory_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/is_jump.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Hazard_Detection_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Global_History_Register.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/forwarding_Unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/fetch_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Excuation_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Direction_Predictor.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Decode_Cycle.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Control_pip.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Branch_Target_Buffer.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/ALUcontrol.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Alu (1).v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Adder32.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/datamem1.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/instmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/Zero.v}

vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining {C:/Users/ASUS/Desktop/comptition/Semicon-JoSDC-23/Pipelining/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
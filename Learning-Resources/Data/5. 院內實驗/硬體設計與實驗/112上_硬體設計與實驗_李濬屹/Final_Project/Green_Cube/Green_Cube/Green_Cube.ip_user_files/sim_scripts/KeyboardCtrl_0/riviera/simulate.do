onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+KeyboardCtrl_0 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.KeyboardCtrl_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {KeyboardCtrl_0.udo}

run -all

endsim

quit -force

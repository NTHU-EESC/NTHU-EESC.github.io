3_2a 
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB acout=0
*.option runlvl=5

*.SUBCKT hw3_2a Vb Vdd Vout
*.PININFO Vb:B Vdd:B
M4 Vout Vb net7 GND N_18 W=9u L=0.5u m=4
M3 net7 net13 GND GND N_18 W=9u L=0.5u m=4
M2 net13 Vb net11 GND N_18 W=9u L=0.5u m=1
M1 net11 net13 GND GND N_18 W=9u L=0.5u m=1
I0 VDD net13 4u
*.ends

******netlist******
*x0 Vb Vdd Vout hw3_2a

******source******
VDD VDD GND 1.8
Vb Vb GND DC=0.573
Vout Vout GND DC=0.295

******analysis******
.op
*.dc sweep vb 0 1.8 0.001
.dc vout 0 1.8 0.01
.tf v(Vout) vOUT

*.print i(MM4) slope=deriv('id(MM4)') par('1/slope')
*.print v(net13) i(MM4)
*.meas dc slope find deriv('i(MM4)') when i(MM4)=40.000u

*.alter
*.lib "cic018.l" FF

*.alter
*.lib "cic018.l" SS


.end


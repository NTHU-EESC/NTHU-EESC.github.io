
.prot
.lib "cic018.l" TT
.unprot
.option post

***** Netlist *****

M1 Vout Vbias Vin GND N_18 W=23.385u L=1u m=3
R1 VDD Vout 20k

***** Source *****
 
Vin Vin GND DC=0.5 AC=1
VDD VDD GND DC=1.8
Vbias Vbias GND DC=1

***** Analysis *****

.OP
.AC LIN 10000 10 100MEG
.tf V(Vout) Vin
.probe AC V(Vout)

.end

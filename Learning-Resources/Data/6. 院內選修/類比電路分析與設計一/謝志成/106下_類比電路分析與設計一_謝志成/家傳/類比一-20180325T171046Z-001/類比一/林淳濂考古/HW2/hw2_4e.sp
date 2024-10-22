
.prot
.lib "cic018.l" TT
.unprot
.option post

***** Netlist *****

M1 Vx Vin GND GND N_18 W=15.064u L=3u
M2 Vout Vbias Vx GND N_18 W=23.385u L=1u m=3
R1 VDD Vout 20k

***** Source *****
 
Vin Vin GND DC=0.35 AC=1
VDD VDD GND DC=1.8
Vbias Vbias GND DC=1
I1 VDD Vx DC=2u
I2 Vx GND DC=40u

***** Analysis *****

.OP
.AC LIN 10000 10 100MEG
.tf V(Vout) Vin
.probe AC V(Vout)

.end

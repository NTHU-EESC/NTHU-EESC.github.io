
.prot
.lib "cic018.l" TT
.unprot
.option post
.option acout=0

M1 Vout Vin GND GND N_18 W=2u L=4u
M2 Vout Vb VDD VDD P_18 W=2u L=4u

VDD VDD GND DC=1.8
Vin Vin GND DC=0.5 AC=1
Vb Vb GND DC=0.96126

.op
.tf V(Vout) Vin
.AC DEC 10000 1 1G
.noise V(Vout) Vin 10000

.end

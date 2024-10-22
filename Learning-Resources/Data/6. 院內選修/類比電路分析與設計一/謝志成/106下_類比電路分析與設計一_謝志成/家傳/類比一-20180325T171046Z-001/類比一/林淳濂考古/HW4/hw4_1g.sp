
.prot
.lib "cic018.l" TT
.unprot
.option post
.option acout=0

M1 Vx Vb1 GND GND N_18 W=5u L=2u
M2 VDD Vin Vx GND N_18 W=5u L=2u
M3 Vout Vx GND GND N_18 W=2u L=4u
M4 Vout Vb2 VDD VDD P_18 W=2u L=4u

VDD VDD GND DC=1.8
Vin Vin GND DC=1 AC=1
Vb1 Vb1 GND DC=0.4177
Vb2 Vb2 GND DC=0.96126

.op
.tf V(Vout) Vin
.AC DEC 10000 10 1G
.noise V(Vout) Vin 10000

.end

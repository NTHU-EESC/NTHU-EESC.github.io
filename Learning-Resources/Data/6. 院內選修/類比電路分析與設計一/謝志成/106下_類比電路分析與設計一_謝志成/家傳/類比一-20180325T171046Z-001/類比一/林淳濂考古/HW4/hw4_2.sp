
.prot
.lib "cic018.l" TT
.unprot
.option post
.option acout=0

M0 P Vb GND GND N_18 W=5u L=4u
M1 X Vin+ P GND N_18 W=5u L=4u
M2 Vout Vin- P GND N_18 W=5u L=4u
M3 X X VDD VDD P_18 W=5u L=4u
M4 Vout X VDD VDD P_18 W=5u L=4u

CL Vout GND 2p

Mc Vb Vb GND GND N_18 W=5u L=4u
Iref VDD Vb DC=5u

VDD VDD GND DC=1.8
Vin+ Vin+ GND DC=0.9 AC=0.5
Vin- Vin- GND DC=0.9 AC=0.5 180
*Vb Vb GND DC=0.5

.OP
.AC DEC 10000 10 1G
.pz V(Vout) Vin+

.end


.prot
.lib "cic018.l" TT
.unprot
.option post

***** Netlist *****

M1 Vx Vin VDD VDD P_18 W=8.28u L=1u m=2
M2 Vx V1 GND GND N_18 W=8.318u L=1u m=2
M3 Vout V2 Vx GND N_18 W=8.5u L=2u m=2
M4 Vout V3 Vy VDD P_18 W=8.5u L=1u m=2
M5 Vy V4 VDD VDD P_18 W=8.5u L=1u m=2

***** Source *****

Vin Vin GND DC=1.05 AC=1
VDD VDD GND DC=1.8
V1 V1 GND DC=0.5
V2 V2 GND DC=0.95
V3 V3 GND DC=1.15
V4 V4 GND DC=1.25

***** Analysis *****

.OP
.AC DEC 10000 10 20MEG
.probe AC V(Vout)
.tf V(Vout) Vin

.end

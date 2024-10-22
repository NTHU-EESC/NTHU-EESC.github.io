*3_2b
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB acout=0


M4 Vout Vb B GND N_18 W=2u L=1u m=4
M3 B Vx GND GND N_18 W=2u L=1u m=4
M2 Vx Vb VA GND N_18 W=2u L=1u m=1
M1 VA Vx GND GND N_18 W=2u L=1u m=1

M5 Vc Vb GND GND N_18 W=2u L=4.5u m=1
M6 Vb Vb Vc GND N_18 W=2u L=1.5u m=1
I0 VDD Vb 4u

Iref VDD Vx 4u
VDD VDD GND DC=1.8
*Vb Vb GND DC=0.7
Vout Vout GND DC=0.285

******analysis******
.op
*.dc Vb 0 1.8 0.01
.dc vout 0 0.3 0.01


.print ID(M4) 

.alter
.lib "cic018.l" FF

.alter
.lib "cic018.l" SS


.end



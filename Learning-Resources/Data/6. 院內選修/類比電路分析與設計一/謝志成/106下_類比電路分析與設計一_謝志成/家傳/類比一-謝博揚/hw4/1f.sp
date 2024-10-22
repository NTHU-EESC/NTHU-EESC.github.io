*1f

.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB
.option dccap=1 

*CS
M1 Vout1 Vin GND GND N_18 W=3.8u L=3.8u m=1
M2 Vout1 Vb1 VDD VDD P_18 W=3u L=3.8u m=1
*SF
M3 Vout2 Vb2 GND GND N_18 W=3u L=3u m=1
M4 VDD Vout1 Vout2 GND N_18 W=3u L=3u m=1

VDD VDD GND DC=1.8
Vb1 Vb1 GND DC=0.9
Vb2 Vb2 GND DC=0.45
Vin Vin GND DC=0.5 AC=1

.op
*.dc Vin 0 1.8 0.001
.noise V(Vout2) Vin 10000
.ac DEC 100 100 10G
.end






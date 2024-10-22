*1a

.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB
.option dccap=1 


*M2 Vout Vb VDD VDD P_18 W=3u L=3u m=1
*M1 Vout Vin GND GND N_18 W=3.2u L=3u m=1

M1 Vout Vin GND GND N_18 W=3.8u L=3.8u m=1
M2 Vout Vb VDD VDD P_18 W=3u L=3.8u m=1


VDD VDD GND DC=1.8
Vb Vb GND DC=0.9
Vin Vin GND DC=0.5 AC=1

.op
*.dc Vin 0 1.8 0.001
.noise V(Vout) Vin 10000
.ac DEC 100 10 10G
.end

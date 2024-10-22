*1b
.protect
.lib 'cic018.l' TT
.unprotect
.option post DCCAP=1 acout=0 ACCT

M2 Vout Vb GND GND N_18 W=3u L=3u m=1
M1 VDD Vin Vout GND N_18 W=3u L=3u m=1

VDD VDD GND DC=1.8
Vin Vin GND DC=1 AC=1
Vb Vb GND DC=0.45

.op
.dc Vin 0 1.8 0.001
.noise V(Vout) Vin 10000
.ac DEC 100 100 10G
.end

hw3_2b
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 
.param W1=3.5u L1=1u 

M1 net5 net17 gnd gnd N_18 W=3.5u L=1u m=42
M2 Vout Vbias net5 gnd N_18 W=3.5u L=1u m=42
M3 net20 net17 gnd gnd N_18 W=3.5u L=1u m=7
M4 net17 Vbias net20 gnd N_18 W=3.5u L=1u m=7
M5 net21 Vbias gnd gnd N_18 W=3.5u L=3u m=7
M6 Vbias Vbias net21 gnd N_18 W=3.5u L=1u m=7

I0 Vdd Vbias 20u
I1 Vdd net17 20u
Vout Vout gnd 0.3

.op
.dc Vout 0 0.4 0.0001

.end


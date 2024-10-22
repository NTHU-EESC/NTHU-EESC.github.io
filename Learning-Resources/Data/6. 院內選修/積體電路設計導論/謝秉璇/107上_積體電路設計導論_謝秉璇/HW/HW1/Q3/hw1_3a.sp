hw1_3a

.protect
.lib 'cic018.l' SF
.unprotect
.temp 25
.option post 
.param  vsg=0 vss=0 w1=0u

M1 Vout Vin gnd gnd N_18 W=0.25u L=0.18u m=1
M0 Vout Vin VDD VDD P_18 W=0.25u L=0.18u m=1
C0 Vout gnd 100.0f

Vin Vin Vss 0.9
Vss Vss 0 vss
VDD VDD Vss 1.8

.op

.end


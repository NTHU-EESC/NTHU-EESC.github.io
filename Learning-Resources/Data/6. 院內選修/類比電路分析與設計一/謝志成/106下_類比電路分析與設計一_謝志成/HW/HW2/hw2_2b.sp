hw2_2a

.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 
.param vss=0

M1 net16 Vin Vss Vss N_18 W=8.7u L=0.5u m=2
M2 Vout Vb1 net16 Vss N_18 W=7.7u L=0.5u m=2
M3 Vout Vb2 net15 Vdd P_18 W=8.7u L=0.5u m=2
M4 net15 Vb3 Vdd Vdd P_18 W=8.8u L=0.5u m=2

Vb3 Vb3 vss 1.15
Vb2 Vb2 vss 0.7
Vb1 Vb1 vss 0.58
Vin Vin vss 0.5
Vdd Vdd vss 1.8
Vss Vss 0 vss

.op
.tf V(Vout) Vin
.end


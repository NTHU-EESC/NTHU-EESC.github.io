hw3_2a
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 
.param W1=3.5u L1=1u  

M4 Vout Vb net9 gnd N_18 W=W1 L=L1 m=42
M3 net9 net11 gnd gnd N_18 W=W1 L=L1 m=42
M2 net11 Vb net17 gnd N_18 W=W1 L=L1 m=7
M1 net17 net11 gnd gnd N_18 W=W1 L=L1 m=7

Vb Vb gnd 0.6
vdd vdd gnd 1.8
Iref Vdd net11 20u
Vout Vout gnd 0.3

.op
.dc Vout 0 0.4 0.0001

.end


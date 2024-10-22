hw3_1b

.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 

M0 Vdd Vin Vout gnd N_18 W=5u L=1u m=1
M1 Vout Vb gnd gnd N_18 W=5u L=1u m=1

Vdd Vdd gnd DC=1.8
Vb Vb gnd DC=0.42
Vin Vin gnd DC=1 AC=1

.op
*.dc Vin 0 1.8 0.001
.tf V(Vout) Vin
.noise V(Vout) Vin 10000
.ac dec 10000 10 10000G

.end


hw4_1a

.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 


M0 Vout Vb Vdd Vdd P_18 W=2u L=4u m=1
M1 Vout Vin gnd gnd N_18 W=0.7u L=14u m=1

Vdd Vdd gnd DC=1.8
Vb Vb gnd DC=1.239743
Vin Vin GND DC=0.5 AC=1

.op
*.dc Vb 0 1.8 0.01
.noise V(Vout) Vin 10000
.tf V(Vout) Vin
.ac dec 100 10 10G

.end


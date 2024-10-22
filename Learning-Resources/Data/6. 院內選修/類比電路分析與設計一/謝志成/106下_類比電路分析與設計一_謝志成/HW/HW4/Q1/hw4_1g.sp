hw4_1g
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 

M2 Vout Vb2 Vdd Vdd P_18 W=2u L=4u m=1
M3 Vout net03 gnd gnd N_18 W=700.0n L=14u m=1
M1 net03 Vb1 gnd gnd N_18 W=5u L=1u m=1
M0 Vdd Vin net03 gnd N_18 W=5u L=1u m=1

Vdd Vdd gnd DC=1.8
Vb2 Vb2 gnd DC=1.239743
Vb1 Vb1 gnd DC=0.42
Vin Vin GND DC=1 AC=1

.op
.dc Vb1 0 1 0.01
.noise V(Vout) Vin 10000
.tf V(Vout) Vin
.ac dec 100 10 10G

.end



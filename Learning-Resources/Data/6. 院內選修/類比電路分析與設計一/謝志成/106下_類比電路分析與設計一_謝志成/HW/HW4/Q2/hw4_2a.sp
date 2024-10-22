hw4_2a
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post captab

M0 net19 Vb gnd gnd N_18 W=10u L=12u m=1
M1 net16 Vin+ net19 gnd N_18 W=10u L=12u m=1
M2 Vout Vin- net19 gnd N_18 W=10u L=12u m=1
M3 net16 net16 Vdd Vdd P_18 W=10u L=12u m=1
M4 Vout net16 Vdd Vdd P_18 W=10u L=12u m=1
CL Vout gnd 3p

Vdd Vdd gnd DC=1.8
Vin+ Vin+ gnd DC=0.9 AC=0.5 180
Vin- Vin- gnd DC=0.9 AC=0.5 0
Vb Vb gnd DC=0.5

.op
.ac dec 10 10 100x
*.dc Vin+ 0 1.8 0.01
.tf V(Vout) Vin+
.tf V(net19) Vin+
.probe V(Vout)
.pz V(Vout) Vin+
.pz V(Vout) Vin-
.plot ac gain=par("v(vout)/v(vin1)-v(vin2)")

.end


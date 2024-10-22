**1a
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB
.option dccap=1 

*DGSB
M1 GND Vin Vout Vout P_18 W=2u L=0.5u m=1
M2 Vout Vb VDD VDD P_18 W=2u L=0.5u m=1

Vin Vin GND 0
Vb Vb GND 1.2
VDD VDD GND DC=1.8

.dc Vin 0 1.8 0.01
.plot dc V(Vout)
.tf V(Vout) Vin
.end
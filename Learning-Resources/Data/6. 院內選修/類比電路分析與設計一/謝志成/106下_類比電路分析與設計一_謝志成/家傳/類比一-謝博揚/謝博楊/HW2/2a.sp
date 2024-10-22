*2a

.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB
.option dccap=1 

*DGSB
M1 Vout Vin GND GND N_18 W=4.19u L=1u
R0 VDD Vout 180K 

Vin Vin GND dc=0.45048 ac=1
VDD VDD GND DC=1.8


.ac DEC 10 1k 1G

*.print Vth(MM0)
.probe V(Vout)

.end

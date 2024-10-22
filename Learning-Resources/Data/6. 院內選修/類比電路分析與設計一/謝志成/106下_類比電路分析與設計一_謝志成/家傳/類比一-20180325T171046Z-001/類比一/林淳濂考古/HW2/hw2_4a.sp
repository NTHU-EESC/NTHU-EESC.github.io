
.prot
.lib "cic018.l" TT
.unprot
.option post

***** Netlist *****

M1 Vout Vin GND GND N_18 W=15.064u L=3u

***** Source *****

I1 VDD Vout DC=2u
Vin Vin GND DC=0.35 AC=1
VDD VDD GND DC=1.8

***** Analysis *****

.OP
.AC LIN 10000 10 100MEG
.tf V(Vout) Vin
.probe AC V(Vout)

.end

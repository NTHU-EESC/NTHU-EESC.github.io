
.prot
.lib "cic018.l" TT
.unprot
.option post

***** Netlist *****

M1 GND Vin Vout VDD P_18 W=10u L=3.5u
M2 Vout Vb VDD VDD P_18 W=9u L=3.5u

***** Source *****

Vin Vin GND
Vb Vb GND DC=1.325
VDD VDD GND DC=1.8

***** Analysis *****

.OP
.DC Vin 0 1.2 0.01
.print V(Vout)
.print deriv('V(Vout)')
.probe level_shift=par('V(Vout)-V(Vin)')

.end

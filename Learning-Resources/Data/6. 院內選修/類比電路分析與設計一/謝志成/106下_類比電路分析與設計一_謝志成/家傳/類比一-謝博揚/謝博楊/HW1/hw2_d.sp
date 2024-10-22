*2 nmos
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTA
.option dccap=1
****Netlist****
*DGSB
M1 VDD Vin Vout GND N_18 W=50u L=500.0n M=1
Vin Vin GND
VDD VDD GND 1.8
I1 Vout GND 5u
******Analysis****
.dc Vin 0 1.8 0.01
***************
.probe V(Vout)
.end

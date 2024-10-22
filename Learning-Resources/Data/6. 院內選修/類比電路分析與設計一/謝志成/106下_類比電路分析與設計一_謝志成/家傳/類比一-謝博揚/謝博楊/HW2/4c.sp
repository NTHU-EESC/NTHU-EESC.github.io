***4_c
.protect
.lib 'cic018.l' TT
.unprotect
.option post DCCAP=1 acout=0 ACCT
.option dccap=1 

M1 Vout Vb Vin GND N_18 W=15u L=1u m=1
R1 VDD Vout 20k

Vin Vin GND DC=0.5 AC=1
VDD VDD GND DC=1.8
Vb Vb GND DC=1.1

.OP
.AC DEC 10 1K 100meg
.plot V(Vout) 
.probe (Vth(m1))
.MEAS ac 'gain(mag)' max vm(Vout)
.end 

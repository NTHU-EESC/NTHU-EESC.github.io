***4_a
.protect
.lib 'cic018.l' TT
.unprotect
.option post DCCAP=1 acout=0 ACCT

.subckt CS GND Vin Vout
M1 Vout Vin GND GND N_18 W=7.5u L=3u m=1
.ends

X1 GND Vin Vout CS

VGS Vin GND DC=387.232m AC=1
VDD VDD GND DC=1.8
I1 VDD Vout 2u

.OP
.AC DEC 100M 0 1G
.plot V(Vout) VGS
.end 


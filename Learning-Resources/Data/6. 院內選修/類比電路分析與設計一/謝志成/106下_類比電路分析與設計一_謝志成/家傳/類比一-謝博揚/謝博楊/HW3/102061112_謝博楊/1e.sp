*3.1
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB acout=0

M3 VP Vb GND GND N_18 W=10u L=0.5u m=1
M2 Vout+ Vin- VP VP N_18 W=84u L=2.8u m=1
M1 Vout- Vin+ VP VP N_18 W=84u L=2.8u m=1

M4 Vb Vb GND GND N_18 W=10u L=0.5u m=1

R1 VDD Vout- 100K 
R0 VDD Vout+ 100K 

******source******
Iref VDD Vb 20u
VDD VDD 0 DC=1.8
Vin+ Vin+ 0 DC 0.9 AC 0.5 0
Vin- Vin- 0 DC 0.9 AC 0.5 180

******analysis******
.op
.ac dec 100 1 100meg
.probe vdb(Vout+,Vout-)
.print vdb(Vout+,Vout-)

.alter
.lib "cic018.l" FF

.alter
.lib "cic018.l" SS

.end



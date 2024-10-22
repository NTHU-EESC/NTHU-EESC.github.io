*3.1
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB acout=0

M3 VP Vb GND GND N_18 W=10u L=0.5u m=1
M2 Vout+ Vin- VP GND N_18 W=84u L=2.8u m=1
M1 Vout- Vin+ VP GND N_18 W=84u L=2.8u m=1


R1 VDD Vout- 100K 
R0 VDD Vout+ 100K 

******source******

VDD VDD 0 DC=1.8
Vcm Vcm 0 DC=0.9
Vin+ Vin+ Vcm AC 0.5 0
Vin- Vin- Vcm AC 0.5 180
Vb Vb 0 DC=0.49

******analysis******
.op
.ac dec 100 10M 100meg sweep Vcm 0.3 1.5 0.01
.probe vdb(Vout+,Vout-)
.print vdb(Vout+,Vout-)


.end



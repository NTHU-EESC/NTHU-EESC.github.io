*3.1 without Cp
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB acout=0


M3 VP Vb GND GND N_18 W=10u L=0.5u m=1
M2 Vout+ Vin- VP GND N_18 W=92.4u L=2.8u m=1
M1 Vout- Vin+ VP GND N_18 W=84u L=2.8u m=1


R1 VDD Vout- 100K 
R0 VDD Vout+ 100K 

******source******

VDD VDD 0 DC=1.8
Vin+ Vin+ 0 DC 0.9 AC=1
Vin- Vin- 0 DC 0.9 AC=1
Vb Vb 0 DC=0.49

****Acm with Cp
*.alter  
*Cp VP 0 100f
*Vin+ Vin+ 0 DC 0.9 AC=1
*Vin- Vin- 0 DC 0.9 AC=1

******analysis******
.op
.ac dec 100 1 1G
.probe vdb(Vout+,Vout-)
.print vdb(Vout+,Vout-)


*****Adm without Cp
.alter
Vin+ Vin+ 0 DC 0.9 AC=0.5 180
Vin- Vin- 0 DC 0.9 AC=0.5 0

*****Adm with Cp
*.alter
*Cp VP 0 100f
*Vin+ Vin+ 0 DC 0.9 AC=0.5 180
*Vin- Vin- 0 DC 0.9 AC=0.5 0

.end



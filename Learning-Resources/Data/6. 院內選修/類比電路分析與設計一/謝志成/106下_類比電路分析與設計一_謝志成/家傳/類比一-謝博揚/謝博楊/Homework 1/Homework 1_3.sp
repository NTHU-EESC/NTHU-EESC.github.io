//Homework 1-3
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post DCCAP=1 acout=0 ACCT
.inc 'ID_VGS.spi'
.param r='10e3' wi=20u vd=1.8 per='2e-6'

M1 drain gate GND GND N_18 W=3u L=300.0n m=1
VGS gate GND 
VDD drain GND DC=1.8

.dc VDD 0 1.8 0.01 sweep VGS 0 1.8 0.3
.probe Id(M1)

.alter
M1 drain gate GND GND N_18 W=3u L=3u m=1

.end

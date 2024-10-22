*Homework 2.1.a
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post DCCAP=1 acout=0 ACCT
.inc 'Hw2_1_a.spi'
*.param r='10e3' wi=20u vd=1.8 per='2e-6'

X0 GND Vin Vout common_source

VGS Vin GND DC=387.232m AC=1
VDD VDD GND DC=1.8
Iin VDD Vout 2u

.op
.dc VGS 0 1.8 0.01
.ac DEC 100 100 1G
.tf V(Vout) VGS
.end 




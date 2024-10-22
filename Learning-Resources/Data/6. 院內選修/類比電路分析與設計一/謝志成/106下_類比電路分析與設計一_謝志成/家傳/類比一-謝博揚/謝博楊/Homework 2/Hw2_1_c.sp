*Homework 2.1.c
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post DCCAP=1 acout=0 ACCT
.inc 'Hw2_1_c.spi'

X0 GND Vb Vin Vout common_gate

Vg Vb GND DC=1.1346
VDD VDD GND DC=1.8
RD VDD Vout 20k
Vi Vin GND DC=0.5 AC=1

.op
.ac DEC 100 100 1G
.tf v(Vout) Vi
.probe Id(MM1)
.end

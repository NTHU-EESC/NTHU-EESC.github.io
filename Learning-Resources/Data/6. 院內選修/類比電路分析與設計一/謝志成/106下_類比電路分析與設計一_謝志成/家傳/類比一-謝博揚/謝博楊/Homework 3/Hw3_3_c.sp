*Homework 3.3.c
.protect
.lib 'cic018.l' SF
.unprotect
.temp 25
.option post DCCAP=1 acout=0 ACCT
.inc 'Hw3_3_c.spi'
*.param r='10e3' wi=20u vd=1.8 per='2e-6'

X0 GND VDD Vout Vy Vin Voltage_generator

V0 Vy Vin DC=0 AC=1
Iref VDD Vy 1.15u
VDD VDD GND 1.8

.op
.ac DEC 100 100 1G
.tf v(Vout) V0
.end

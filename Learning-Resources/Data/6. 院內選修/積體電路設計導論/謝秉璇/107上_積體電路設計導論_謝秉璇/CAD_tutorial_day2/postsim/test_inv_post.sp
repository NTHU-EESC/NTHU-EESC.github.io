
.protect
.lib 'cic018.l' TT
.unprotect

.temp 25
.option post acout=0 runlvl=6

.include './inv.pex.spi'

*************** circuit description ***************
X1 IN VSS VDD OUT inv

vdd vdd gnd 1.8
vss vss gnd 0

Vin in gnd PULSE 0 1.8 10n 0.1n 0.1n '50n-0.2n' '100n' 

*************** simulation setting ***************
.op
.tran 0.1ns '500n'


.end

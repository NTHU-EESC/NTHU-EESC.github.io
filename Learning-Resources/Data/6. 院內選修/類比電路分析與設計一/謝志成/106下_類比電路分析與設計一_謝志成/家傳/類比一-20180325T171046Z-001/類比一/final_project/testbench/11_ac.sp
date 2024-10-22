AC response 

.protect
.lib 'cic018.l' TT
.unprotect
.option post acout=0 accurate
.include "My_op.spi" 

.param rload=25k cload=80p supplyp=1.8 supplyn=0 comon='supplyp/2'

Xop iref vdd vinn vinp vocm von vop vss AICopamp
rload1 von 0 rload
rload2 vop 0 rload
cload1 von 0 cload
cload2 vop 0 cload

vdd vdd 0 dc supplyp
vgnd vss 0 dc supplyn
vocm vocm 0 dc comon


vinp vinp 0 dc comon ac 0.5 0
vinn vinn 0 dc comon ac 0.5 180

Iref vdd iref 63u

.op
.ac dec 10 10 1g
.pz v(vop,von) vinp
.probe ac vdb(vop,von) vp(vop,von)

.meas ac dcgain_in_db max vdb(vop,von)
.meas ac dcgain max vm(vop,von)
.meas ac unity_frequency when vdb(vop,von)=0
.meas ac phase find vp(vop,von) at=unity_frequency
.meas ac phase_margin param='180+phase'
.alter
.lib 'cic018.l' FF
.alter
.lib 'cic018.l' SS
.alter
.lib 'cic018.l' SF
.alter
.lib 'cic018.l' FS
.end

hw1_1b
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 
.param vd=1.8 vg=0 vss=0 vsg=0

M2 Vdd Vg Vdd Vdd P_18 W=50u L=500.0n m=1

Vdd vdd 0 vd
Vss vss 0 vss
Vg vg vss 'vd-vsg'

.dc vsg -1.8 1.8 0.001
.probe DC ctot=par("lx18(M2)")

.end


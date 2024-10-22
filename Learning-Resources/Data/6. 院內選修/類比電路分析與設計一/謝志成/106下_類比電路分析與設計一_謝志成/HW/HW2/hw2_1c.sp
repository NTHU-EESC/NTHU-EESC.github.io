hw2_1c
.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 
.param vss=0 vsg=0

R0 Vdd Vout 10K 
M3 Vout Vbias Vin Vss N_18 W=25u L=0.5u m=1

Vin Vin Vss 0.9
Vdd Vdd Vss 1.8
Vss vss 0 vss
Vbias Vbias Vss 1.53

.op
*.dc Vsg 0 1.8 0.0001
.tf V(Vout) Vin
.probe I(R0)

.end


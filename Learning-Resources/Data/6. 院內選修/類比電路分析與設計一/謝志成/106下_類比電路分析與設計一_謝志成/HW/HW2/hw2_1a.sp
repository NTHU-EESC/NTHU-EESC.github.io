hw2_1a

.protect
.lib 'cic018.l' TT
.unprotect
.temp 25
.option post 
.param  vsg=0 vss=0

M0 Vout Vin Vss Vss N_18 W=5u L=3u m=1

I0 Vdd Vout 5u
Vin Vin Vss 0.476
Vss Vss 0 vss
Vdd Vdd Vss 1.8

.op
.tf V(Vout) Vin
*.dc vsg 0 1.8 0.001
.probe V(Vout)

.end


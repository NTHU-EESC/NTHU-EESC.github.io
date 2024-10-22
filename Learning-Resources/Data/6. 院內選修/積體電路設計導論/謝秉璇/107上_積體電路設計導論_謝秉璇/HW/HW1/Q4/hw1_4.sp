hw1_4
.protect
.lib 'cic018.l' SS
.unprotect
.temp 125
.option post 

C0 Vout gnd! 100.0f 
M1 Vout Vin gnd! gnd! N_18 W=0.25u L=0.18u m=1
M0 Vout Vin Vdd Vdd P_18 W=0.8002u L=0.18u m=1

Vdd Vdd 0 1.8
Vin Vin 0 pulse(0V 1.8 0 1n 2n 1n 10n)

.op
.tran 0.1n 50n
.meas tran tr trig v(Vin) val=0.9v td=0 rise=1 targ v(Vout) val=0.9v fall=1
.meas tran tr1 trig v(Vin) val=0.9v td=0 fall=2 targ v(Vout) val=0.9v rise=2

.end


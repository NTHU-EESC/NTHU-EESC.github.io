hw2_1a
.protect
.lib 'cic018.l' TT
.unprotect
.temp 	25
.option post 

Mp Vout in Vdd Vdd P_18 w=6.0654um l=0.2um m=1
Mn Vout in gnd gnd N_18 w=1.8um l=0.2um m=1

Vdd vdd gnd DC=1.8
Vin in gnd DC=0.9

.op
.dc Vin 0 1.8 0.01
.measure tran V_deriv find V(Vout) when deriv('V(Vout)')=-1

.end
 

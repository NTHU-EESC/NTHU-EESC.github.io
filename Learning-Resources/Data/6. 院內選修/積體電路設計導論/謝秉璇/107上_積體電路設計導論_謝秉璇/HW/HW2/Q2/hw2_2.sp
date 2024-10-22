hw2_2
.protect
.lib 'cic018.l' TT
.unprotect
.temp 	25
.option post 
.param Pw=52.4u Pl=0.2u Nw=1.8u Nl=0.2u

$ D G S B
Mpa p1 in Vdd Vdd P_18 w=Pw l=Pl m=1
Mpb p2 in p1 Vdd P_18 w=Pw l=Pl m=1
Mpc out in p2 Vdd P_18 w=Pw l=Pl m=1
Mna out in gnd gnd N_18 w=Nw l=Nl m=1
Mnb out in gnd gnd N_18 w=Nw l=Nl m=1
Mnc out in gnd gnd N_18 w=Nw l=Nl m=1

Vdd vdd gnd DC=1.8
Vin in gnd DC=0.9

.op
*.dc sweep Pw 0.5u 80u 0.01u $掃Pw2的值,並利用waveview找出0.9V的值
.dc Vin 0 1.8 0.01 

$'cross' Indicates that the point to be measured is the xth time to see this slope
.measure dc VIL FIND V(in) WHEN DERIV('V(out)')=-1 cross=1
.measure dc VIH FIND V(in) WHEN DERIV('V(out)')=-1 cross=2
.measure dc VOL FIND V(out) WHEN DERIV('V(out)')=-1 cross=2
.measure dc VOH FIND V(out) WHEN DERIV('V(out)')=-1 cross=1
.measure dc NML param='VIL-VOL'
.measure dc NMH param='VOH-VIH'

.end
 

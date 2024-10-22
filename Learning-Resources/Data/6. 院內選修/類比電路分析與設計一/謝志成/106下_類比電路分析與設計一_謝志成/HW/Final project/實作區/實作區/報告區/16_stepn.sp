closed-loop step response- 

.protect
.lib 'cic018.l' FF
.unprotect
.option post acout=0 accurate
.include "My_op.spi" 

.param rload=10k cload=80p supplyp=1.4 supplyn=0 comon='supplyp/2'

.param steph='comon+0.25'
.param stepl='comon-0.25'
                                                                                
Xop iref vdd vinn vinp vocm von vop vss AICop
rload1 von 0 rload
rload2 vop 0 rload
cload1 von 0 cload
cload2 vop 0 cload
rtest1 Vinn test2 100k
rtest2 Vinp test1 100k
rtest3 Vinn Vop 100k
rtest4 Vinp Von 100k
                                                                                
vdd vdd 0 dc supplyp
vgnd vss 0 dc supplyn
vocm vocm 0 dc comon

Vi1 test2 0 pulse(stepl steph 50ns 0 0 500.05us)
Vi2 test1 0 pulse(steph stepl 50ns 0 0 500.05us) 

Iref vdd iref 55u

.tran 1ns 500.05us

.probe tran vout=par('V(vop,von)') vin=par('V(test1,test2)') 
.meas tran final find v(vop,von) at 500.049us
.meas tran hlimit param='final*1.0001'
.meas tran llimit param='final*0.9999'
.meas tran htime when v(vop,von)=hlimit cross=last
.meas tran ltime when v(vop,von)=llimit cross=last
.meas tran pos_settling param='max(htime,ltime)-50n' 

.meas tran final1 find v(vop) at 500.049us
.meas tran hlimit1 param='final1*1.0001'
.meas tran llimit1 param='final1*0.9999'
.meas tran htime1 when v(vop)=hlimit1 cross=last
.meas tran ltime1 when v(vop)=llimit1 cross=last
.meas tran pos_settling1 param='max(htime1,ltime1)-50n' 

.meas tran final2 find v(von) at 500.049us
.meas tran hlimit2 param='final2*1.0001'
.meas tran llimit2 param='final2*0.9999'
.meas tran htime2 when v(von)=hlimit2 cross=last
.meas tran ltime2 when v(von)=llimit2 cross=last
.meas tran pos_settling2 param='max(htime2,ltime2)-50n' 

.meas tran SRn_time TRIG v(vop,von) VAL=0.4 FALL=1
+                   TARG v(vop,von) VAL=-0.4 FALL=1 
.meas tran SRn param='0.8/SRn_time'
.alter
.lib 'cic018.l' FF
.alter
.lib 'cic018.l' SS
.alter
.lib 'cic018.l' SF
.alter
.lib 'cic018.l' FS
.end

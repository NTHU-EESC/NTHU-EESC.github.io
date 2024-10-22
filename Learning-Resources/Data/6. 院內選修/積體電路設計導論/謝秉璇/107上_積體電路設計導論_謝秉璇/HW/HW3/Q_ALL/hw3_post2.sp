inv_chain_post
.protect
.lib 'cic018.l' TT
.unprotect

.temp 25
.option post acout=0 runlvl=6

.include './inv_chain2.pex.spi'

*************** circuit description ***************
X1 VSS VDD OUT1 OUT2 OUT3 OUT4 OUT5 OUT9 OUT6 OUT7 OUT8 inv_chain2

vdd vdd gnd 1.8
vss vss gnd 0
Cl out9 gnd 150p

.ic out9 1.8
*************** simulation setting ***************
.op
.tran 0.1ns 10u

*.meas tran pwr1 AVG POWER from=3.25u to=5.89u 

.end
*3a
.prot
.lib "cic018.l" TT
.unprot
.option post=1 ACCT CAPTAB

M1 net13 Vin VDD VDD P_18 W=12u L=0.5u m=1
M2 net13 V1 GND GND N_18 W=5u L=0.7u m=1
M3 Vout V2 net13 net13 N_18 W=4u L=0.7u m=1
M4 Vout V3 net21 net21 P_18 W=3u L=0.5u m=1
M5 net21 V4 VDD VDD P_18 W=10u L=0.7u m=1

VDD VDD 0 1.8
Vin Vin GND dc=1.1003 ac=1
V4 V4 GND dc=1.25
V3 V3 GND dc=1.15
V2 V2 GND dc=0.7
V1 V1 GND dc=0.61

.op
.dc Vin 0 1.8 0.00001
*.print v(vout) slope = deriv('v(vout)')
.ac dec 100 1k 1G
*.meas dc slope find deriv('v(vout)') when v(Vin)=1.1003
.MEAS ac 'gain(mag)' max vdb(Vout)

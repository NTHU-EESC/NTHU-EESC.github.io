
.prot
.lib "cic018.l" TT
.unprot
.option post
.option acout=0
.param Vdm='0'
.param Vcm='0.9'

***** Netlist *****

M1 Voutp Vinp VP GND N_18 W=5u L=1u
M2 Voutn Vinn VP GND N_18 W=5u L=1u
M3 VP Vb GND GND N_18 W=5u L=1u
RDp VDD Voutp 100k
RDn VDD Voutn 100k

***** Source *****

Vinp Vinp GND DC='Vcm+Vdm/2' AC=0.5
Vinn Vinn GND DC='Vcm-Vdm/2' AC=0.5 180
VDD VDD GND DC=1.8
Vb Vb GND DC=0.5475

***** Analysis *****

.OP
.AC DEC 10 10 1G sweep Vdm 0 0.05 0.001
.probe AC vdb(Voutp,Voutn)

.end


.prot
.lib "cic018.l" TT
.unprot
.option post
.option acout=0

***** Netlist *****

M1 Voutp Vinp VP GND N_18 W=5u L=1u
M2 Voutn Vinn VP GND N_18 W=5u L=1u
M3 VP Vb GND GND N_18 W=5u L=1u
M4 Vb Vb GND GND N_18 W=5u L=1u
RDp VDD Voutp 100k
RDn VDD Voutn 100k

***** Source *****

Vinp Vinp GND DC=0.9 AC=0.5
Vinn Vinn GND DC=0.9 AC=0.5 180
VDD VDD GND DC=1.8
*Vb Vb GND DC=0.5475
Iref VDD Vb DC=20u

***** Analysis *****

.OP
.AC DEC 10000 10 1G 
.probe AC Adm = par('V(Voutp)+V(Voutn)')
.probe AC vdb(Voutp,Voutn)

.alter
.prot
.lib "cic018.l" FF
.unprot
.alter
.prot
.lib "cic018.l" SS
.unprot

.end

************************************************************************
* Library Name: Lab1
* Cell Name:    divider
* View Name:    schematic
************************************************************************

$$$$$ div vdd vss clk s2b s3b s4b s5b s6b s7b s8b qr $$$$$
$$$$$ decorder vdd vss con1 con2 con3 dec1 dec2 dec3 dec4 dec5 dec6 dec7 dec8 $$$$$

.include './divider.spi'
.include './decorder.spi'

* Xtop con3 con2 con1 clk clk_out vdd vss
.subckt top_module s3 s2 s1 clk out vdd vss 

.param Wn=5u Wp=2u Ln=0.18u Lp=0.18u m1=1
.param Wns=1u Wps=2u ms=1
*************** circuit description ***************
X0 vdd vss s1 s2 s3 s1b s2b s3b s4b s5b s6b s7b s8b decorder
X1 vdd vss clk s1b s2b s3b s4b s5b s6b s7b s8b q div

$$$ mux $$$
Mnm1 clk s1bt outt vss N_18 W=1u L=Ln m=1
Mpm1 clk s1b  outt vdd P_18 W=1u L=Lp m=1 
Mnm2   q s1b  outt vss N_18 W=1u L=Ln m=1
Mpm2   q s1bt outt vdd P_18 W=1u L=Lp m=1 

$$$ one hot $$$
Mns1 s1bt s1b vss vss n_18 W=Wns L=Ln m=ms
Mps1 s1bt s1b vdd vdd p_18 W=Wps L=Lp m=ms

Mni out outt vss vss n_18 W=Wn L=Ln m=m1
Mpi out outt vdd vdd p_18 W=Wp L=Lp m=m1

.ends
 


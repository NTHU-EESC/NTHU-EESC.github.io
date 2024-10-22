************************************************************************
* Library Name: Lab1
* Cell Name:    top_module
* View Name:    schematic
************************************************************************

$$$$$ div vdd vss clk s2b s3b s4b s5b s6b s7b s8b qr $$$$$
$$$$$ decorder vdd vss con1 con2 con3 dec1 dec2 dec3 dec4 dec5 dec6 dec7 dec8 $$$$$

.include './divider.spi'
.include './decorder.spi'

* Xtop con3 con2 con1 clk clk_out vdd vss
.subckt top_module s3 s2 s1 clk out vdd vss 

.param Wn=1u Ln=0.18u Wp=2u Lp=0.18u m1=1
.param Wns=1u Wps=2u ms=1 Wnm=1u Wpm=1u
*************** circuit description ***************
X0 vdd vss s1 s2 s3 s1b s2b s3b s4b s5b s6b s7b s8b decorder
X1 vdd vss clk s2b s3b s4b s5b s6b s7b s8b q div

$$$ mux $$$
Mnm1   q  s1b out out n_18 W=Wnm L=Ln m=1
Mpm1 out s1bt   q   q p_18 W=Wpm L=Lp m=1
Mnm2 clk s1bt out out n_18 W=Wnm L=Ln m=1
Mpm2 out  s1b clk clk p_18 W=Wpm L=Lp m=1

$$$ one hot $$$
Mns1 s1bt s1b vss vss n_18 W=Wns L=Ln m=ms
Mps1 s1bt s1b vdd vdd p_18 W=Wps L=Lp m=ms

.ends
 

************************************************************************
* Library Name: Lab1
* Cell Name:    divider
* View Name:    schematic
************************************************************************

$$$$$ div vdd vss clk s2b s3b s4b s5b s6b s7b s8b qr $$$$$
$$$$$ decorder vdd vss con1 con2 con3 dec1 dec2 dec3 dec4 dec5 dec6 dec7 dec8 $$$$$
$$$$$ NAND2 vdd vss in1 in2 out $$$$$

.include './divider.spi'
.include './NAND2.spi'
.include './decorder.spi'

* Xtop con3 con2 con1 clk clk_out vdd vss
.subckt top_module s3 s2 s1 clk out vdd vss 

.param Wn=1u Ln=0.18u Wp=2u Lp=0.18u m1=1
.param Wns=1u Wps=2u ms=1
*************** circuit description ***************
X0 vdd vss s1 s2 s3 s1b s2b s3b s4b s5b s6b s7b s8b decorder
X1 vdd vss clk s2b s3b s4b s5b s6b s7b s8b out div

c1 out vss 1p

.ends
 

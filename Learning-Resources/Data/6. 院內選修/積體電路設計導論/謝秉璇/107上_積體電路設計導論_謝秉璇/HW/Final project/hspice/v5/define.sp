

**********************************************************************
**       Top Module Inclusion(You can only change this part)        **
**********************************************************************
$$$$$ top_module s3 s2 s1 clk out vdd vss $$$$$

.include "top_module.sp"                                          //put your top level .sp file name here
Xtop con3 con2 con1 clk clk_out vdd vss top_module              //enter your pins without adding or taking out any pin
Xinv_1 clk_in clki vdd vss / unit_inv
.param clk_freq = 0.5G                                            //enter the desired clock running frequency here


Mn1  c2 clki vss vss n_18 W=1u L=0.18u m=1
Mp1  c2 clki vdd vdd p_18 W=2u L=0.18u m=1
Mn2  c3   c2 vss vss n_18 W=1u L=0.18u m=1
Mp2  c3   c2 vdd vdd p_18 W=2u L=0.18u m=1
Mn3 clk   c3 vss vss n_18 W=1u L=0.18u m=1
Mp3 clk   c3 vdd vdd p_18 W=2u L=0.18u m=1

****************************End of Segment****************************




**********************************************************************
**                              ReadMe                              **
**********************************************************************

* "test_top.sp" + "define.sp" should be in same directory with your top-level circuit
* You are only allowed to edit "define.sp" to define your topest level and clock frequency
* To start testing, please run "test_top.sp" in Hspice
* You can either check "test_top.mt0" ~ "test_top.mt4" or transient waveform for result browsing
* output frequency : (freq_1 ~ freq_8) (in .mt file) should be at correct frequency
* (freq1_err ~ freq_8) : the output frequency vs correct calculatd frequency, the number should be very small if the generated output(from your circuit) is correct
* total_avg_pwr : the total average power calculated from each dividing interval(1~8)
* You can check the power during each divide-condition respectively by looking at pwr_1 ~ pwr_8

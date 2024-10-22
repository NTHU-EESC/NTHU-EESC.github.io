.subckt inv_chain vdd vss out1 out2 out3 out4 out5 out6 out7 out8 out9
Mn1 out1 out9 vss vss N_18 w=0.5u l=0.18u m=1
Mp1 out1 out9 vdd vdd P_18 w=1.5u l=0.18u m=1
Mn2 out2 out1 vss vss N_18 w=0.5u l=0.18u m=3
Mp2 out2 out1 vdd vdd P_18 w=1.5u l=0.18u m=3
Mn3 out3 out2 vss vss N_18 w=0.5u l=0.18u m=11
Mp3 out3 out2 vdd vdd P_18 w=1.5u l=0.18u m=11
Mn4 out4 out3 vss vss N_18 w=0.5u l=0.18u m=34
Mp4 out4 out3 vdd vdd P_18 w=1.5u l=0.18u m=34
Mn5 out5 out4 vss vss N_18 w=0.5u l=0.18u m=111
Mp5 out5 out4 vdd vdd P_18 w=1.5u l=0.18u m=111
Mn6 out6 out5 vss vss N_18 w=0.5u l=0.18u m=359
Mp6 out6 out5 vdd vdd P_18 w=1.5u l=0.18u m=359
Mn7 out7 out6 vss vss N_18 w=0.5u l=0.18u m=1163
Mp7 out7 out6 vdd vdd P_18 w=1.5u l=0.18u m=1163
Mn8 out8 out7 vss vss N_18 w=0.5u l=0.18u m=3773
Mp8 out8 out7 vdd vdd P_18 w=1.5u l=0.18u m=3773
Mn9 out9 out8 vss vss N_18 w=1.1u l=0.18u m=4999
Mp9 out9 out8 vdd vdd P_18 w=3.3u l=0.18u m=4999
.ends

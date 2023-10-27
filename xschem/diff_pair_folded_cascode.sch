v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 670 -160 770 -160 {
lab=#net1}
N 160 -70 160 70 {
lab=#net2}
N 340 -70 340 70 {
lab=#net3}
N 630 -220 630 -190 {
lab=Vdd}
N 810 -220 810 -190 {
lab=Vdd}
N 710 -260 710 -240 {
lab=Vdd}
N 160 130 160 160 {
lab=#net4}
N 160 160 340 160 {
lab=#net4}
N 340 130 340 160 {
lab=#net4}
N 250 160 250 190 {
lab=#net4}
N 250 250 250 270 {
lab=Vss}
N 160 100 340 100 {
lab=Vss}
N 250 100 250 110 {
lab=Vss}
N 610 -160 630 -160 {
lab=Vdd}
N 610 -200 610 -160 {
lab=Vdd}
N 610 -200 630 -200 {
lab=Vdd}
N 810 -160 830 -160 {
lab=Vdd}
N 830 -200 830 -160 {
lab=Vdd}
N 810 -200 830 -200 {
lab=Vdd}
N 180 220 210 220 {
lab=Vb1}
N 250 220 270 220 {
lab=Vss}
N 270 220 270 260 {
lab=Vss}
N 250 260 270 260 {
lab=Vss}
N 250 110 250 140 {
lab=Vss}
N 250 140 310 140 {
lab=Vss}
N 310 140 310 280 {
lab=Vss}
N 250 270 250 280 {
lab=Vss}
N 440 280 440 300 {
lab=Vss}
N 440 300 440 310 {
lab=Vss}
N 250 280 440 280 {
lab=Vss}
N 100 100 120 100 {
lab=vinp}
N 380 100 400 100 {
lab=vinm}
N 670 40 770 40 {
lab=Vb2}
N 630 -20 630 10 {
lab=#net2}
N 810 -20 810 10 {
lab=#net3}
N 610 40 630 40 {
lab=Vdd}
N 810 40 830 40 {
lab=Vdd}
N 830 0 830 40 {
lab=Vdd}
N 810 -50 810 -20 {
lab=#net3}
N 810 70 810 150 {
lab=vout}
N 630 210 630 270 {
lab=Vss}
N 630 270 630 280 {
lab=Vss}
N 440 280 630 280 {
lab=Vss}
N 610 180 630 180 {
lab=Vss}
N 610 180 610 230 {
lab=Vss}
N 610 230 630 230 {
lab=Vss}
N 810 210 810 280 {
lab=Vss}
N 630 280 810 280 {
lab=Vss}
N 810 180 830 180 {
lab=Vss}
N 830 180 830 230 {
lab=Vss}
N 810 230 830 230 {
lab=Vss}
N 810 110 850 110 {
lab=vout}
N 670 180 770 180 {
lab=Vb1}
N 630 70 630 150 {
lab=#net1}
N 630 -220 810 -220 {
lab=Vdd}
N 710 -240 710 -220 {
lab=Vdd}
N 200 220 200 350 {
lab=Vb1}
N 200 350 720 350 {
lab=Vb1}
N 720 180 720 350 {
lab=Vb1}
N 630 -130 630 -20 {
lab=#net2}
N 810 -130 810 -50 {
lab=#net3}
N 690 -160 690 100 {
lab=#net1}
N 630 100 690 100 {
lab=#net1}
N 610 -160 610 40 {
lab=Vdd}
N 830 -160 830 0 {
lab=Vdd}
N 340 -70 810 -70 {
lab=#net3}
N 160 -100 160 -70 {
lab=#net2}
N 160 -100 630 -100 {
lab=#net2}
N 740 40 740 70 {
lab=Vb2}
C {devices/iopin.sym} 710 -260 0 0 {name=p1 lab=Vdd}
C {devices/ipin.sym} 400 100 2 0 {name=p2 lab=vinm}
C {devices/ipin.sym} 100 100 0 0 {name=p3 lab=vinp}
C {devices/iopin.sym} 180 220 2 0 {name=p4 lab=Vb1}
C {devices/iopin.sym} 440 310 0 0 {name=p6 lab=Vss}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 140 100 0 0 {name=M1
L=L_M1
W=W_M1
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 360 100 0 1 {name=M2
L=L_M2
W=W_M2
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 790 -160 0 0 {name=M4
L=L_M4
W=W_M4
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 650 -160 0 1 {name=M3
L=L_M3
W=W_M3
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 230 220 0 0 {name=M9
L=L_M9
W=W_M9
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 790 40 0 0 {name=M6
L=L_M6
W=W_M6
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 650 40 0 1 {name=M5
L=L_M5
W=W_M5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 650 180 0 1 {name=M7
L=L_M7
W=W_M7
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 790 180 0 0 {name=M8
L=L_M8
W=W_M8
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {devices/iopin.sym} 740 70 1 0 {name=p7 lab=Vb2}
C {devices/opin.sym} 850 110 0 0 {name=p8 lab=vout}

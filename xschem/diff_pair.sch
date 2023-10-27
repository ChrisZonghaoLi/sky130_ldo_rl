v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 200 -150 300 -150 {
lab=#net1}
N 160 -120 160 20 {
lab=#net1}
N 340 -120 340 20 {
lab=vout}
N 160 -210 160 -180 {
lab=Vdd}
N 340 -210 340 -180 {
lab=Vdd}
N 160 -210 340 -210 {
lab=Vdd}
N 250 -230 250 -210 {
lab=Vdd}
N 160 -90 230 -90 {
lab=#net1}
N 230 -150 230 -90 {
lab=#net1}
N 160 80 160 110 {
lab=#net2}
N 160 110 340 110 {
lab=#net2}
N 340 80 340 110 {
lab=#net2}
N 250 110 250 140 {
lab=#net2}
N 250 200 250 220 {
lab=Vss}
N 160 50 340 50 {
lab=Vss}
N 250 50 250 60 {
lab=Vss}
N 140 -150 160 -150 {
lab=Vdd}
N 140 -190 140 -150 {
lab=Vdd}
N 140 -190 160 -190 {
lab=Vdd}
N 340 -150 360 -150 {
lab=Vdd}
N 360 -190 360 -150 {
lab=Vdd}
N 340 -190 360 -190 {
lab=Vdd}
N 180 170 210 170 {
lab=Vb}
N 250 170 270 170 {
lab=Vss}
N 270 170 270 210 {
lab=Vss}
N 250 210 270 210 {
lab=Vss}
N 340 -90 430 -90 {
lab=vout}
N 430 -90 470 -90 {
lab=vout}
N 250 60 250 90 {
lab=Vss}
N 250 90 310 90 {
lab=Vss}
N 310 90 310 230 {
lab=Vss}
N 250 220 250 230 {
lab=Vss}
N 440 230 440 250 {
lab=Vss}
N 440 250 440 260 {
lab=Vss}
N 250 230 440 230 {
lab=Vss}
N 100 50 120 50 {
lab=vinp}
N 380 50 400 50 {
lab=vinm}
C {devices/iopin.sym} 250 -230 0 0 {name=p1 lab=Vdd}
C {devices/ipin.sym} 400 50 2 0 {name=p2 lab=vinm}
C {devices/ipin.sym} 100 50 0 0 {name=p3 lab=vinp}
C {devices/iopin.sym} 180 170 2 0 {name=p4 lab=Vb}
C {devices/opin.sym} 470 -90 0 0 {name=p5 lab=vout}
C {devices/iopin.sym} 440 260 0 0 {name=p6 lab=Vss}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 140 50 0 0 {name=M1
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 360 50 0 1 {name=M2
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 320 -150 0 0 {name=M3
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 180 -150 0 1 {name=M4
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 230 170 0 0 {name=M5
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
model=nfet_g5v0d10v5
spiceprefix=X
}

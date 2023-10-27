v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 170 -20 190 -20 {
lab=Vdd}
N 190 -60 190 -20 {
lab=Vdd}
N 190 -60 290 -60 {
lab=Vdd}
N 590 -60 590 -30 {
lab=Vdd}
N 590 -80 590 -30 {
lab=Vdd}
N 590 -90 590 -80 {
lab=Vdd}
N 290 -60 360 -60 {
lab=Vdd}
N 360 -60 590 -60 {
lab=Vdd}
N 320 0 550 0 {
lab=#net1}
N 590 30 590 80 {
lab=Vreg}
N 590 80 590 160 {
lab=Vreg}
N 590 160 710 160 {
lab=Vreg}
N 170 20 220 20 {
lab=Vbn}
N 170 40 220 40 {
lab=Vss}
N 590 0 640 0 {
lab=Vdd}
N -150 0 -130 0 {
lab=Vfb}
N 640 -50 640 0 {
lab=Vdd}
N 590 -50 640 -50 {
lab=Vdd}
N -150 -20 -130 -20 {
lab=Vref}
N 330 0 330 80 {
lab=#net1}
N 330 80 370 80 {
lab=#net1}
N 430 80 470 80 {
lab=#net2}
N 530 80 590 80 {
lab=Vreg}
N 300 0 320 -0 {
lab=#net1}
N 170 0 300 0 {
lab=#net1}
C {devices/iopin.sym} 220 20 0 0 {name=p3 lab=Vbn}
C {devices/iopin.sym} 220 40 0 0 {name=p4 lab=Vss}
C {devices/opin.sym} 710 160 0 0 {name=p2 lab=Vreg}
C {devices/iopin.sym} -150 -20 2 0 {name=p5 lab=Vref}
C {devices/ipin.sym} 590 -90 0 0 {name=p1 lab=Vdd}
C {devices/iopin.sym} -150 0 2 0 {name=p6 lab=Vfb}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 570 0 0 0 {name=M8
L=L_pass
W=W_pass
nf=1
mult=M_pass
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/res.sym} 400 80 3 0 {name=Rfb
value=Rfb
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 500 80 3 0 {name=Cfb
m=1
value=Cfb
footprint=1206
device="ceramic capacitor"}
C {diff_pair_cascode.sym} 20 10 0 0 {name=x1}

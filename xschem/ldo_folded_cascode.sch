v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 400 10 420 10 {
lab=Vdd}
N 420 -30 420 10 {
lab=Vdd}
N 420 -30 520 -30 {
lab=Vdd}
N 820 -30 820 0 {
lab=Vdd}
N 820 -50 820 0 {
lab=Vdd}
N 820 -60 820 -50 {
lab=Vdd}
N 520 -30 590 -30 {
lab=Vdd}
N 590 -30 820 -30 {
lab=Vdd}
N 820 60 820 110 {
lab=Vreg}
N 820 110 820 190 {
lab=Vreg}
N 820 190 940 190 {
lab=Vreg}
N 820 30 870 30 {
lab=Vdd}
N 80 30 100 30 {
lab=Vref}
N 870 -20 870 30 {
lab=Vdd}
N 820 -20 870 -20 {
lab=Vdd}
N 80 10 100 10 {
lab=Vfb}
N 400 110 400 130 {
lab=Vss}
N 400 130 430 130 {
lab=Vss}
N 490 130 490 160 {
lab=Vss}
N 430 130 490 130 {
lab=Vss}
N 690 30 780 30 {
lab=#net1}
N 400 30 470 30 {
lab=Vb2}
N 400 70 470 70 {
lab=Vb1}
N 560 30 560 70 {
lab=#net1}
N 560 30 690 30 {
lab=#net1}
N 490 130 650 130 {
lab=Vss}
N 650 90 650 130 {
lab=Vss}
N 680 70 700 70 {
lab=#net2}
N 760 70 820 70 {
lab=Vreg}
N 560 70 620 70 {
lab=#net1}
N 400 50 560 50 {
lab=#net1}
N 400 90 400 110 {
lab=Vss}
C {devices/iopin.sym} 490 160 1 0 {name=p4 lab=Vss}
C {devices/opin.sym} 940 190 0 0 {name=p2 lab=Vreg}
C {devices/iopin.sym} 80 30 2 0 {name=p5 lab=Vref}
C {devices/ipin.sym} 820 -60 0 0 {name=p1 lab=Vdd}
C {devices/iopin.sym} 80 10 2 0 {name=p6 lab=Vfb}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 800 30 0 0 {name=M10
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
C {diff_pair_folded_cascode.sym} 250 50 0 0 {name=x1}
C {devices/iopin.sym} 470 30 0 0 {name=p7 lab=Vb2}
C {devices/iopin.sym} 470 70 0 0 {name=p8 lab=Vb1}
C {sky130_fd_pr/cap_mim_m3_1.sym} 730 70 3 0 {name=Cfb model=cap_mim_m3_1 W=10 L=10 MF=M_Cfb spiceprefix=X}
C {sky130_fd_pr/res_high_po_0p35.sym} 650 70 3 0 {name=Rfb
L=3
model=res_high_po_0p35
spiceprefix=X
mult=M_Rfb}

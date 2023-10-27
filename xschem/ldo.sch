v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 400 30 480 30 {
lab=#net1}
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
N 480 30 550 30 {
lab=#net1}
N 590 -30 820 -30 {
lab=Vdd}
N 550 30 780 30 {
lab=#net1}
N 820 60 820 110 {
lab=Vreg}
N 820 110 820 190 {
lab=Vreg}
N 820 190 940 190 {
lab=Vreg}
N 400 50 450 50 {
lab=Vb}
N 400 70 450 70 {
lab=Vss}
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
N 560 30 560 110 {
lab=#net1}
N 560 110 600 110 {
lab=#net1}
N 760 110 820 110 {
lab=Vreg}
N 600 110 610 110 {
lab=#net1}
N 670 110 690 110 {
lab=#net2}
N 750 110 760 110 {
lab=Vreg}
N 640 130 640 150 {
lab=Vss}
N 430 150 640 150 {
lab=Vss}
N 430 70 430 150 {
lab=Vss}
C {devices/iopin.sym} 450 50 0 0 {name=p3 lab=Vb}
C {devices/iopin.sym} 450 70 0 0 {name=p4 lab=Vss}
C {devices/opin.sym} 940 190 0 0 {name=p2 lab=Vreg}
C {devices/iopin.sym} 80 30 2 0 {name=p5 lab=Vref}
C {devices/ipin.sym} 820 -60 0 0 {name=p1 lab=Vdd}
C {diff_pair.sym} 250 40 0 0 {name=x1}
C {devices/iopin.sym} 80 10 2 0 {name=p6 lab=Vfb}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 800 30 0 0 {name=M6
L=L_pass
W=W_pass
nf=Nf_pass
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
C {sky130_fd_pr/cap_mim_m3_1.sym} 720 110 3 0 {name=Cfb model=cap_mim_m3_1 W=10 L=10 MF=M_Cfb spiceprefix=X}
C {sky130_fd_pr/res_high_po_0p35.sym} 640 110 3 0 {name=Rfb
L=3
model=res_high_po_0p35
spiceprefix=X
mult=M_Rfb}

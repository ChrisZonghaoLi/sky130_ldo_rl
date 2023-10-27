v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 310 -180 410 -180 {
lab=#net1}
N 270 -150 270 -10 {
lab=#net1}
N 450 -150 450 -10 {
lab=#net2}
N 270 -240 270 -210 {
lab=Vdd}
N 450 -240 450 -210 {
lab=Vdd}
N 270 -240 450 -240 {
lab=Vdd}
N 360 -260 360 -240 {
lab=Vdd}
N 270 -120 340 -120 {
lab=#net1}
N 340 -180 340 -120 {
lab=#net1}
N 270 50 270 80 {
lab=#net3}
N 270 80 450 80 {
lab=#net3}
N 450 50 450 80 {
lab=#net3}
N 360 80 360 110 {
lab=#net3}
N 360 170 360 190 {
lab=Vss}
N 270 20 450 20 {
lab=Vss}
N 360 20 360 30 {
lab=Vss}
N 250 -180 270 -180 {
lab=Vdd}
N 250 -220 250 -180 {
lab=Vdd}
N 250 -220 270 -220 {
lab=Vdd}
N 450 -180 470 -180 {
lab=Vdd}
N 470 -220 470 -180 {
lab=Vdd}
N 450 -220 470 -220 {
lab=Vdd}
N 210 20 230 20 {
lab=vinp}
N 490 20 510 20 {
lab=#net4}
N 290 140 320 140 {
lab=Vb}
N 360 140 380 140 {
lab=Vss}
N 380 140 380 180 {
lab=Vss}
N 360 180 380 180 {
lab=Vss}
N 450 -240 660 -240 {
lab=Vdd}
N 720 -240 720 -210 {
lab=Vdd}
N 720 -180 740 -180 {
lab=Vdd}
N 740 -220 740 -180 {
lab=Vdd}
N 720 -220 740 -220 {
lab=Vdd}
N 450 -120 540 -120 {
lab=#net2}
N 540 -180 540 -120 {
lab=#net2}
N 540 -180 620 -180 {
lab=#net2}
N 660 -240 720 -240 {
lab=Vdd}
N 620 -180 680 -180 {
lab=#net2}
N 720 -150 720 -10 {
lab=vout}
N 720 -10 720 110 {
lab=vout}
N 720 170 720 190 {
lab=Vss}
N 720 140 740 140 {
lab=Vss}
N 740 140 740 180 {
lab=Vss}
N 720 180 740 180 {
lab=Vss}
N 450 140 680 140 {
lab=Vb}
N 450 100 450 140 {
lab=Vb}
N 300 100 450 100 {
lab=Vb}
N 300 100 300 140 {
lab=Vb}
N 540 -120 560 -120 {
lab=#net2}
N 620 -120 640 -120 {
lab=#net5}
N 700 -120 720 -120 {
lab=vout}
N 720 0 760 -0 {
lab=vout}
N 360 30 360 60 {
lab=Vss}
N 360 60 420 60 {
lab=Vss}
N 420 60 420 200 {
lab=Vss}
N 360 190 360 200 {
lab=Vss}
N 360 200 720 200 {
lab=Vss}
N 720 190 720 200 {
lab=Vss}
N 550 200 550 220 {
lab=Vss}
N 550 220 550 230 {
lab=Vss}
C {sky130_fd_pr/nfet_01v8.sym} 250 20 0 0 {name=M1
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
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 470 20 2 0 {name=M2
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
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 430 -180 0 0 {name=M3
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 290 -180 0 1 {name=M4
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 340 140 0 0 {name=M5
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
model=nfet_01v8
spiceprefix=X
}
C {devices/iopin.sym} 360 -260 0 0 {name=p1 lab=Vdd}
C {devices/ipin.sym} 510 20 2 0 {name=p1 lab=vinm}
C {devices/ipin.sym} 210 20 0 0 {name=p1 lab=vinp}
C {devices/iopin.sym} 290 140 2 0 {name=p1 lab=Vb}
C {sky130_fd_pr/pfet_01v8.sym} 700 -180 0 0 {name=M6
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 700 140 2 1 {name=M7
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
model=nfet_01v8
spiceprefix=X
}
C {devices/res.sym} 590 -120 3 0 {name=R1
value=Rfb
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 670 -120 3 0 {name=C1
m=1
value=Cfb
footprint=1206
device="ceramic capacitor"}
C {devices/opin.sym} 760 0 0 0 {name=p1 lab=vout}
C {devices/iopin.sym} 550 230 0 0 {name=p1 lab=Vss}

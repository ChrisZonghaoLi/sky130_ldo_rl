v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 180 -420 280 -420 {
lab=#net1}
N 140 -390 140 -250 {
lab=#net1}
N 320 -390 320 -250 {
lab=vout}
N 140 -480 140 -450 {
lab=#net2}
N 320 -480 320 -450 {
lab=#net3}
N 140 -190 140 -160 {
lab=#net4}
N 140 -160 320 -160 {
lab=#net4}
N 320 -190 320 -160 {
lab=#net4}
N 230 -160 230 -130 {
lab=#net4}
N 230 -70 230 -50 {
lab=Vss}
N 140 -220 320 -220 {
lab=Vss}
N 230 -220 230 -210 {
lab=Vss}
N 120 -420 140 -420 {
lab=Vdd}
N 120 -460 120 -420 {
lab=Vdd}
N 320 -420 340 -420 {
lab=Vdd}
N 340 -460 340 -420 {
lab=Vdd}
N 160 -100 190 -100 {
lab=Vbn}
N 230 -100 250 -100 {
lab=Vss}
N 250 -100 250 -60 {
lab=Vss}
N 230 -60 250 -60 {
lab=Vss}
N 320 -360 410 -360 {
lab=vout}
N 410 -360 450 -360 {
lab=vout}
N 230 -210 230 -180 {
lab=Vss}
N 230 -180 290 -180 {
lab=Vss}
N 290 -180 290 -40 {
lab=Vss}
N 230 -50 230 -40 {
lab=Vss}
N 420 -40 420 -20 {
lab=Vss}
N 420 -20 420 -10 {
lab=Vss}
N 230 -40 420 -40 {
lab=Vss}
N 80 -220 100 -220 {
lab=vinp}
N 360 -220 380 -220 {
lab=vinm}
N 180 -580 280 -580 {
lab=#net2}
N 140 -640 140 -610 {
lab=Vdd}
N 320 -640 320 -610 {
lab=Vdd}
N 140 -640 320 -640 {
lab=Vdd}
N 230 -660 230 -640 {
lab=Vdd}
N 120 -580 140 -580 {
lab=Vdd}
N 120 -620 120 -580 {
lab=Vdd}
N 120 -620 140 -620 {
lab=Vdd}
N 320 -580 340 -580 {
lab=Vdd}
N 340 -620 340 -580 {
lab=Vdd}
N 320 -620 340 -620 {
lab=Vdd}
N 320 -550 320 -480 {
lab=#net3}
N 140 -550 140 -480 {
lab=#net2}
N 120 -580 120 -460 {
lab=Vdd}
N 340 -580 340 -460 {
lab=Vdd}
N 140 -520 210 -520 {
lab=#net2}
N 210 -580 210 -520 {
lab=#net2}
N 140 -340 210 -340 {
lab=#net1}
N 210 -420 210 -340 {
lab=#net1}
C {devices/ipin.sym} 380 -220 2 0 {name=p2 lab=vinm}
C {devices/ipin.sym} 80 -220 0 0 {name=p3 lab=vinp}
C {devices/iopin.sym} 160 -100 2 0 {name=p4 lab=Vbn}
C {devices/opin.sym} 450 -360 0 0 {name=p5 lab=vout}
C {devices/iopin.sym} 420 -10 0 0 {name=p6 lab=Vss}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 120 -220 0 0 {name=M1
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 340 -220 0 1 {name=M2
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 300 -420 0 0 {name=M3
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 160 -420 0 1 {name=M4
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
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 210 -100 0 0 {name=M7
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
C {devices/iopin.sym} 230 -660 0 0 {name=p7 lab=Vdd}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 300 -580 0 0 {name=M5
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
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 160 -580 0 1 {name=M6
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

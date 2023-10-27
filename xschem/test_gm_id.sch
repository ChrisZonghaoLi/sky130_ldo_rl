v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 320 -210 320 -160 {
lab=GND}
N 320 -320 360 -320 {
lab=GND}
N 360 -320 360 -270 {
lab=GND}
N 320 -270 360 -270 {
lab=GND}
N 250 -320 280 -320 {
lab=#net1}
N 320 -450 320 -410 {
lab=#net2}
N 320 -450 440 -450 {
lab=#net2}
N 440 -450 440 -410 {
lab=#net2}
N 440 -350 440 -320 {
lab=GND}
N 320 -410 320 -350 {
lab=#net2}
N 200 -190 200 -160 {
lab=GND}
N 320 -290 320 -210 {
lab=GND}
N 200 -320 200 -250 {
lab=#net1}
N 200 -320 250 -320 {
lab=#net1}
C {devices/gnd.sym} 320 -160 0 0 {name=l13 lab=GND}
C {devices/vsource.sym} 440 -380 0 0 {name=VDD value=VD}
C {devices/gnd.sym} 440 -320 0 0 {name=l1 lab=GND}
C {sky130_fd_pr/corner.sym} 0 -450 0 0 {name=CORNER only_toplevel=false corner=tt}
C {devices/code_shown.sym} 570 -450 0 0 {name=s1 only_toplevel=false 
value="

* some initial params
.param W_sweep=10
.param L_sweep=0.18
.param ID=10u
.param VD=1.8
.param VG=1
.param M_sweep=1

* high precision simulation
.options savecurrents
.OPTIONS maxord=1
.OPTIONS itl1=200
.OPTIONS itl2=200
.OPTIONS itl4=200

.control
* save all voltage and current
save all 
set filetype=ascii
set units=degrees

* save transistor gm
save @m.xm1.msky130_fd_pr__nfet_01v8_lvt[gm]
save @m.xm1.msky130_fd_pr__nfet_01v8_lvt[gds]
save @m.xm1.msky130_fd_pr__nfet_01v8_lvt[id]
let gm=@m.xm1.msky130_fd_pr__nfet_01v8_lvt[gm]
let gds=@m.xm1.msky130_fd_pr__nfet_01v8_lvt[gds]
let id=@m.xm1.msky130_fd_pr__nfet_01v8_lvt[id]

* parameteric sweep
dc VGS 0 2 0.2
plot gm
alterparam L_sweep=0.36
reset
dc VGS 0 2 0.2
plot gm
alterparam L_sweep=0.5
reset
dc VGS 0 2 0.2
plot gm
alterparam L_sweep=1
reset
dc VGS 0 2 0.2
plot gm

.endc
"}
C {devices/vsource.sym} 200 -220 0 0 {name=VGS value=VG}
C {devices/gnd.sym} 200 -160 0 0 {name=l2 lab=GND}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 300 -320 0 0 {name=M1
L=L_sweep
W=W_sweep
nf=1
mult=M_sweep
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}

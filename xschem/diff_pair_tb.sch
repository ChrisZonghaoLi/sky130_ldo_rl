v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 600 350 620 350 {
lab=GND}
N 620 350 620 370 {
lab=GND}
N 120 360 120 370 {
lab=GND}
N 120 290 120 300 {
lab=#net1}
N 190 290 300 290 {
lab=#net1}
N 600 290 620 290 {
lab=VDD}
N 620 270 620 290 {
lab=VDD}
N 330 570 330 580 {
lab=GND}
N 330 480 330 510 {
lab=VDD}
N 600 310 650 310 {
lab=vout}
N 680 420 680 430 {
lab=GND}
N 680 330 680 360 {
lab=#net2}
N 600 330 680 330 {
lab=#net2}
N 780 420 780 430 {
lab=GND}
N 650 310 810 310 {
lab=vout}
N 780 310 780 360 {
lab=vout}
N 250 370 250 390 {
lab=GND}
N 250 310 300 310 {
lab=#net3}
N 120 290 190 290 {
lab=#net1}
C {devices/gnd.sym} 620 370 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 250 390 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 120 330 0 0 {name=V1 value="dc Vcm ac 1"}
C {devices/gnd.sym} 120 370 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 620 270 0 0 {name=l4 lab=VDD}
C {devices/vsource.sym} 330 540 0 0 {name=V2 value=Vdd}
C {devices/gnd.sym} 330 580 0 0 {name=l5 lab=GND}
C {devices/vdd.sym} 330 480 0 0 {name=l6 lab=VDD}
C {devices/opin.sym} 810 310 0 0 {name=p1 lab=vout}
C {devices/vsource.sym} 680 390 0 0 {name=V3 value=Vb}
C {devices/gnd.sym} 680 430 0 0 {name=l7 lab=GND}
C {devices/code_shown.sym} 460 480 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {devices/capa.sym} 780 390 0 0 {name=C1
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 780 430 0 0 {name=l8 lab=GND}
C {devices/code_shown.sym} 460 560 0 0 {name=s2 only_toplevel=false 
value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/diff_pair_tb_vars.spice
"}
C {devices/vsource.sym} 250 340 0 0 {name=V4 value="dc Vcm"}
C {devices/code_shown.sym} 460 640 0 0 {name=s3 only_toplevel=false 
value="
.control
save all 
set filetype=ascii
set units=degrees

dc V1 0 3 0.01
plot v(vout)

ac dec 10 1 1e10
plot mag(v(vout))
plot vdb(vout)
plot ph(v(vout))

.endc
"}
C {diff_pair.sym} 450 320 0 0 {name=x1}

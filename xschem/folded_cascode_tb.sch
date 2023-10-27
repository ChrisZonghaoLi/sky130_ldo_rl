v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 480 150 500 150 {
lab=#net1}
N 480 130 500 130 {
lab=Vin}
N 320 350 320 360 {
lab=GND}
N 320 300 320 350 {
lab=GND}
N 320 180 320 240 {
lab=Vin}
N 320 130 320 180 {
lab=Vin}
N 320 130 480 130 {
lab=Vin}
N 440 350 440 360 {
lab=GND}
N 440 300 440 350 {
lab=GND}
N 440 150 440 240 {
lab=#net1}
N 440 150 480 150 {
lab=#net1}
N 1000 250 1000 260 {
lab=GND}
N 1000 200 1000 250 {
lab=GND}
N 800 130 1000 130 {
lab=#net2}
N 1000 130 1000 140 {
lab=#net2}
N 940 280 940 360 {
lab=GND}
N 870 240 870 250 {
lab=#net3}
N 870 310 870 390 {
lab=GND}
N 870 230 870 240 {
lab=#net3}
N 870 210 870 230 {
lab=#net3}
N 870 190 870 210 {
lab=#net3}
N 800 190 870 190 {
lab=#net3}
N 800 150 940 150 {
lab=#net4}
N 940 150 940 220 {
lab=#net4}
N 800 210 800 340 {
lab=GND}
N 800 340 870 340 {
lab=GND}
N 800 170 850 170 {
lab=Vout}
N 830 270 830 340 {
lab=GND}
N 830 170 830 210 {
lab=Vout}
C {sky130_fd_pr/corner.sym} 110 30 0 0 {name=CORNER only_toplevel=false corner=tt}
C {diff_pair_folded_cascode.sym} 650 170 0 0 {name=x2}
C {devices/gnd.sym} 320 360 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} 320 270 0 0 {name=Vin value="ac 1 dc 1.8"}
C {devices/gnd.sym} 440 360 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 440 270 0 0 {name=Vb value="dc 1.8"}
C {devices/gnd.sym} 1000 260 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 1000 170 0 0 {name=Vdd2 value="dc 2"}
C {devices/gnd.sym} 940 360 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} 940 250 0 0 {name=Vb2 value=Vb2}
C {devices/gnd.sym} 870 390 0 0 {name=l13 lab=GND}
C {devices/vsource.sym} 870 280 0 0 {name=Vb1 value=Vb1}
C {devices/opin.sym} 850 170 0 0 {name=p7 lab=Vout}
C {devices/code_shown.sym} 290 490 0 0 {name=s2 only_toplevel=false value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/ldo_folded_cascode_tb_vars.spice
"}
C {devices/code_shown.sym} 290 580 0 0 {name=s4 only_toplevel=false 
value="

.control
* high precision simulation
*.OPTIONS maxord=1
.OPTIONS itl1=200
.OPTIONS itl2=200
.OPTIONS itl4=200

* save all voltage and current
save all 
.options savecurrents
set filetype=ascii
set units=degrees

* AC
ac dec 10 1 10G
plot vdb(Vout) vp(Vout)

* DC sweep
dc Vin 0 3 0.01
plot v(Vin) v(Vout)

.endc
"}
C {devices/lab_pin.sym} 320 170 0 0 {name=p8 sig_type=std_logic lab=Vin}
C {devices/capa.sym} 830 240 0 0 {name=C1
m=1
value=20p
footprint=1206
device="ceramic capacitor"}

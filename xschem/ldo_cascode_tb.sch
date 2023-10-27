v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 770 -170 770 -90 {
lab=GND}
N 480 -230 650 -230 {
lab=#net1}
N 700 -230 700 -220 {
lab=#net1}
N 700 -160 700 -140 {
lab=GND}
N 480 -210 500 -210 {
lab=GND}
N 510 0 510 20 {
lab=GND}
N 480 -190 510 -190 {
lab=Vreg}
N 580 0 580 10 {
lab=GND}
N 510 10 580 10 {
lab=GND}
N 510 -190 580 -190 {
lab=Vreg}
N 580 -190 600 -190 {
lab=Vreg}
N 130 -80 130 -70 {
lab=GND}
N 650 -230 700 -230 {
lab=#net1}
N 130 -130 130 -80 {
lab=GND}
N 130 -250 130 -190 {
lab=Vdd}
N 130 -270 180 -270 {
lab=Vdd}
N 130 -270 130 -250 {
lab=Vdd}
N 510 -190 510 -160 {
lab=Vreg}
N 580 -190 580 -160 {
lab=Vreg}
N 580 -100 580 -90 {
lab=GND}
N 580 -30 580 0 {
lab=GND}
N 510 -100 510 0 {
lab=GND}
N 580 -90 580 -30 {
lab=GND}
N 580 -250 580 -190 {
lab=Vreg}
N 480 -270 770 -270 {
lab=Vref}
N 770 -270 770 -230 {
lab=Vref}
N 480 -250 580 -250 {
lab=Vreg}
C {devices/gnd.sym} 770 -90 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 770 -200 0 0 {name=Vref value="ac 0 dc Vref"}
C {devices/vsource.sym} 700 -190 0 0 {name=Vb value=Vbn}
C {devices/gnd.sym} 700 -140 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 500 -210 3 0 {name=l4 lab=GND}
C {devices/gnd.sym} 510 20 0 0 {name=l5 lab=GND}
C {devices/isource.sym} 580 -130 0 0 {name=IL value="dc IL PWL(0 0 50u 10m)"}
C {devices/opin.sym} 600 -190 0 0 {name=p7 lab=Vreg}
C {devices/gnd.sym} 130 -70 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} 130 -160 0 0 {name=Vdd value="ac 1 dc Vdd sin(0 Vamp f_Vdd)"}
C {devices/lab_pin.sym} 130 -250 0 0 {name=p8 sig_type=std_logic lab=Vdd}
C {devices/lab_pin.sym} 770 -250 2 0 {name=p9 sig_type=std_logic lab=Vref}
C {devices/code_shown.sym} 110 260 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {devices/code_shown.sym} 110 420 0 0 {name=s4 only_toplevel=false 
value="
.control
save all 
set filetype=ascii
set units=degrees

* DC sweep
dc Vdd 0 3 0.01
plot v(Vdd) v(Vreg)

* PSRR with max load
alter Vdd ac=1
alter Vref ac=0
ac dec 10 1 10G
plot vdb(Vreg)

* PSRR with min load
alter IL dc=100u
ac dec 10 1 10G
plot vdb(Vreg)

.endc
"}
C {devices/code_shown.sym} 110 340 0 0 {name=s2 only_toplevel=false value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/ldo_cascode_tb_vars.spice
"}
C {sky130_fd_pr/cap_mim_m3_1.sym} 510 -130 0 0 {name=CL model=cap_mim_m3_1 W=30 L=30 MF=M_CL spiceprefix=X}
C {ldo_cascode.sym} 330 -230 0 0 {name=x1}

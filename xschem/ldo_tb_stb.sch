v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -140 120 -140 130 {
lab=Vref}
N -140 190 -140 270 {
lab=GND}
N -430 130 -260 130 {
lab=#net1}
N -210 130 -210 140 {
lab=#net1}
N -210 200 -210 220 {
lab=GND}
N -430 150 -410 150 {
lab=GND}
N -400 440 -400 460 {
lab=GND}
N -430 170 -400 170 {
lab=VregQ}
N -330 440 -330 450 {
lab=GND}
N -400 450 -330 450 {
lab=GND}
N -400 170 -330 170 {
lab=VregQ}
N -330 170 -310 170 {
lab=VregQ}
N -780 280 -780 290 {
lab=GND}
N -260 130 -210 130 {
lab=#net1}
N -780 230 -780 280 {
lab=GND}
N -780 110 -780 170 {
lab=Vdd}
N -140 110 -140 120 {
lab=Vref}
N -430 110 -140 110 {
lab=Vref}
N -780 90 -730 90 {
lab=Vdd}
N -780 90 -780 110 {
lab=Vdd}
N -400 170 -400 200 {
lab=VregQ}
N -330 260 -330 340 {
lab=GND}
N -400 420 -400 440 {
lab=GND}
N -330 340 -330 440 {
lab=GND}
N -330 170 -330 200 {
lab=VregQ}
N -430 90 -380 90 {
lab=VregQ}
N -380 90 -380 170 {
lab=VregQ}
N 660 140 660 150 {
lab=#net2}
N 660 210 660 290 {
lab=GND}
N 370 150 540 150 {
lab=#net3}
N 590 150 590 160 {
lab=#net3}
N 590 220 590 240 {
lab=GND}
N 370 170 390 170 {
lab=GND}
N 400 460 400 480 {
lab=GND}
N 370 190 400 190 {
lab=Vreg}
N 470 460 470 470 {
lab=GND}
N 400 470 470 470 {
lab=GND}
N 400 190 470 190 {
lab=Vreg}
N 470 190 490 190 {
lab=Vreg}
N 20 300 20 310 {
lab=GND}
N 540 150 590 150 {
lab=#net3}
N 20 250 20 300 {
lab=GND}
N 20 130 20 190 {
lab=#net4}
N 660 130 660 140 {
lab=#net2}
N 370 130 660 130 {
lab=#net2}
N 20 110 70 110 {
lab=#net4}
N 20 110 20 130 {
lab=#net4}
N 400 190 400 220 {
lab=Vreg}
N 470 280 470 360 {
lab=GND}
N 400 440 400 460 {
lab=GND}
N 470 360 470 460 {
lab=GND}
N 470 190 470 220 {
lab=Vreg}
N 160 -20 180 -20 {
lab=GND}
N 170 20 190 20 {
lab=GND}
N 170 -20 170 20 {
lab=GND}
N 230 20 230 50 {
lab=VregQ}
N 240 -20 380 -20 {
lab=Vinj}
N 380 -20 380 -10 {
lab=Vinj}
N 380 -40 380 -20 {
lab=Vinj}
N 370 110 380 110 {
lab=#net5}
N -400 200 -400 220 {
lab=VregQ}
N -400 280 -400 430 {
lab=GND}
N 400 300 400 460 {
lab=GND}
N 400 220 400 240 {
lab=Vreg}
N 380 -170 410 -170 {
lab=#net6}
N 470 -170 520 -170 {
lab=Vreg}
N 580 -170 610 -170 {
lab=GND}
N 380 -170 380 -160 {
lab=#net6}
N 380 -160 380 -120 {
lab=#net6}
N 470 -130 500 -130 {
lab=Vreg}
N 500 -170 500 -130 {
lab=Vreg}
N 380 50 380 110 {
lab=#net5}
N 380 -120 380 -100 {
lab=#net6}
N 470 -130 470 190 {
lab=Vreg}
C {devices/gnd.sym} -140 270 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -140 160 0 0 {name=Vref value=Vref}
C {devices/vsource.sym} -210 170 0 0 {name=Vb value=Vb}
C {devices/gnd.sym} -210 220 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} -410 150 3 0 {name=l4 lab=GND}
C {devices/gnd.sym} -400 460 0 0 {name=l5 lab=GND}
C {devices/isource.sym} -330 230 0 0 {name=IL value=IL}
C {devices/opin.sym} -310 170 0 0 {name=p7 lab=VregQ}
C {devices/gnd.sym} -780 290 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} -780 200 0 0 {name=Vdd value=Vdd}
C {devices/lab_pin.sym} -780 110 0 0 {name=p8 sig_type=std_logic lab=Vdd}
C {ldo.sym} -580 130 0 0 {name=x1}
C {devices/lab_pin.sym} -140 110 2 0 {name=p9 sig_type=std_logic lab=Vref}
C {devices/code_shown.sym} 0 590 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {devices/code_shown.sym} 0 750 0 0 {name=s4 only_toplevel=false 
value="
.control
save all 
set filetype=ascii
set units=degrees

* Stability_Analysis using Ochoa's Z method
alter IL dc=100u
.param B=0
ac dec 10 1 10G
alterparam B=1
reset
ac dec 10 1 10G
let L = (ac1.i(Vt2) + ac2.i(Vt1)) / (ac1.i(Vt1) + ac2.i(Vt2))
let Lmag = db(L)
let Lph = vp(L)
plot Lmag Lph xlog
wrdata ldo_tb_loop_gain mag(L) vp(L)

.endc
"}
C {devices/code_shown.sym} 0 670 0 0 {name=s2 only_toplevel=false value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/ldo_tb_vars.spice
"}
C {devices/gnd.sym} 660 290 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} 660 180 0 0 {name=Vref1 value=Vref}
C {devices/vsource.sym} 590 190 0 0 {name=Vb2 value=Vb}
C {devices/gnd.sym} 590 240 0 0 {name=l8 lab=GND}
C {devices/gnd.sym} 390 170 3 0 {name=l9 lab=GND}
C {devices/gnd.sym} 400 480 0 0 {name=l10 lab=GND}
C {devices/isource.sym} 470 250 0 0 {name=IL1 value=IL}
C {devices/opin.sym} 490 190 0 0 {name=p1 lab=Vreg}
C {devices/gnd.sym} 20 310 0 0 {name=l11 lab=GND}
C {devices/vsource.sym} 20 220 0 0 {name=Vdd3 value="Vdd"}
C {ldo.sym} 220 150 0 0 {name=x2}
C {devices/gnd.sym} 160 -20 1 1 {name=l13 lab=GND}
C {devices/lab_pin.sym} 230 50 2 1 {name=p4 sig_type=std_logic lab=VregQ}
C {devices/vsource.sym} 380 20 2 1 {name=Vt1 value="dc 0 ac \{1-B\}"}
C {devices/vsource.sym} 380 -70 0 1 {name=Vt2 value="dc 0 ac \{B\}"}
C {devices/lab_pin.sym} 290 -20 1 1 {name=p2 sig_type=std_logic lab=Vinj}
C {devices/vcvs.sym} 210 -20 1 1 {name=E1 value=1}
C {sky130_fd_pr/cap_mim_m3_1.sym} -400 250 0 0 {name=C1 model=cap_mim_m3_1 W=30 L=30 MF=M_CL spiceprefix=X}
C {sky130_fd_pr/cap_mim_m3_1.sym} 400 270 0 0 {name=C2 model=cap_mim_m3_1 W=30 L=30 MF=M_CL spiceprefix=X}
C {devices/res.sym} 550 -170 3 0 {name=R1
value=200k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 440 -170 3 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 610 -170 3 0 {name=l2 lab=GND}

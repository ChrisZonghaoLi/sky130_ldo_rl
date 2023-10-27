v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 750 -270 750 -260 {
lab=Vref}
N 750 -200 750 -120 {
lab=GND}
N 460 -260 630 -260 {
lab=#net1}
N 680 -260 680 -250 {
lab=#net1}
N 680 -190 680 -170 {
lab=GND}
N 460 -240 480 -240 {
lab=GND}
N 490 -30 490 -10 {
lab=GND}
N 460 -220 490 -220 {
lab=Vreg}
N 560 -30 560 -20 {
lab=GND}
N 490 -20 560 -20 {
lab=GND}
N 490 -220 560 -220 {
lab=Vreg}
N 560 -220 580 -220 {
lab=Vreg}
N 110 -110 110 -100 {
lab=GND}
N 630 -260 680 -260 {
lab=#net1}
N 110 -160 110 -110 {
lab=GND}
N 110 -280 110 -220 {
lab=Vdd}
N 750 -280 750 -270 {
lab=Vref}
N 460 -280 750 -280 {
lab=Vref}
N 110 -300 160 -300 {
lab=Vdd}
N 110 -300 110 -280 {
lab=Vdd}
N 490 -220 490 -190 {
lab=Vreg}
N 560 -220 560 -190 {
lab=Vreg}
N 560 -130 560 -120 {
lab=GND}
N 560 -60 560 -30 {
lab=GND}
N 560 -120 560 -60 {
lab=GND}
N 460 -300 520 -300 {
lab=#net2}
N 560 -510 560 -370 {
lab=probe}
N 510 -430 560 -430 {
lab=probe}
N 430 -430 450 -430 {
lab=GND}
N 560 -290 560 -220 {
lab=Vreg}
N 560 -310 560 -290 {
lab=Vreg}
N 490 -130 490 -110 {
lab=GND}
N 490 -50 490 -30 {
lab=GND}
N 490 -110 490 -50 {
lab=GND}
N 560 -580 590 -580 {
lab=#net2}
N 520 -300 680 -300 {
lab=#net2}
N 680 -470 680 -300 {
lab=#net2}
N 680 -580 680 -470 {
lab=#net2}
N 560 -580 560 -570 {
lab=#net2}
N 590 -580 680 -580 {
lab=#net2}
C {devices/gnd.sym} 750 -120 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 750 -230 0 0 {name=Vref value=Vref}
C {devices/vsource.sym} 680 -220 0 0 {name=Vb value=Vb}
C {devices/gnd.sym} 680 -170 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 480 -240 3 0 {name=l4 lab=GND}
C {devices/gnd.sym} 490 -10 0 0 {name=l5 lab=GND}
C {devices/isource.sym} 560 -160 0 0 {name=IL value=IL}
C {devices/opin.sym} 580 -220 0 0 {name=p7 lab=Vreg}
C {devices/gnd.sym} 110 -100 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} 110 -190 0 0 {name=Vdd value=Vdd}
C {devices/lab_pin.sym} 110 -280 0 0 {name=p8 sig_type=std_logic lab=Vdd}
C {ldo.sym} 310 -260 0 0 {name=x1}
C {devices/lab_pin.sym} 750 -280 2 0 {name=p9 sig_type=std_logic lab=Vref}
C {devices/code_shown.sym} 90 230 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {devices/code_shown.sym} 90 390 0 0 {name=s4 only_toplevel=false 
value="

.nodeset v(Vreg)=1.8
.nodeset v(net2)=1.8

.control
save all 
set filetype=ascii
set units=degrees

* Stability_Analysis using Middlebrook and Tian's method
* http://education.ingenazure.com/ac-stability-analysis-ngspice/
* at min load
alter IL dc=10u
let runs=2
let run=0

alter @Vprobe1[acmag]=1
alter @Iprobe1[acmag]=0

dowhile run<runs
set run="$&run"
set temp=27

ac dec 10 1 10G

alter @Vprobe1[acmag]=0
alter @Iprobe1[acmag]=1

let run=run+1
end

let ip11 = ac1.i(Vprobe1)
let ip12 = ac1.i(Vprobe2)
let ip21 = ac2.i(Vprobe1)
let ip22 = ac2.i(Vprobe2)
let vprb1 = ac1.v(probe)
let vprb2 = ac2.v(probe)

*** Middlebrook
let mb = 1/(vprb1+ip22)-1 
*** Tian that is preferred
let av = 1/(1/(2*(ip11*vprb2-vprb1*ip21)+vprb1+ip21)-1) 

plot vdb(mb) vp(mb)
plot vdb(av) vp(av)

wrdata ldo_tb_loop_gain_minload mag(av) vp(av)

* at max load
reset all
alter IL dc=10m
let runs=2
let run=0

alter @Vprobe1[acmag]=1
alter @Iprobe1[acmag]=0

dowhile run<runs
set run="$&run"
set temp=27

ac dec 10 1 10G

alter @Vprobe1[acmag]=0
alter @Iprobe1[acmag]=1

let run=run+1
end

let ip11 = ac3.i(Vprobe1)
let ip12 = ac3.i(Vprobe2)
let ip21 = ac4.i(Vprobe1)
let ip22 = ac4.i(Vprobe2)
let vprb1 = ac3.v(probe)
let vprb2 = ac4.v(probe)

*** Middlebrook
let mb = 1/(vprb1+ip22)-1 
*** Tian that is preferred
let av = 1/(1/(2*(ip11*vprb2-vprb1*ip21)+vprb1+ip21)-1) 

plot vdb(mb) vp(mb)
plot vdb(av) vp(av)

wrdata ldo_tb_loop_gain_maxload mag(av) vp(av)

.endc
"}
C {devices/code_shown.sym} 90 310 0 0 {name=s2 only_toplevel=false value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/ldo_tb_vars.spice
"}
C {sky130_fd_pr/cap_mim_m3_1.sym} 490 -160 0 0 {name=CL model=cap_mim_m3_1 W=30 L=30 MF=M_CL spiceprefix=X}
C {devices/vsource.sym} 560 -540 2 0 {name=Vprobe2 value="dc 0"}
C {devices/vsource.sym} 560 -340 0 0 {name=Vprobe1 value="dc 0 ac 1"}
C {devices/isource.sym} 480 -430 3 0 {name=Iprobe1 value="dc 0 ac 0"}
C {devices/gnd.sym} 430 -430 1 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 560 -450 2 0 {name=p1 sig_type=std_logic lab=probe}

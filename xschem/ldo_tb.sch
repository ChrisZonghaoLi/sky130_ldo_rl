v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1500 670 1500 680 {
lab=Vref}
N 1500 740 1500 820 {
lab=GND}
N 1210 680 1380 680 {
lab=#net1}
N 1430 680 1430 690 {
lab=#net1}
N 1430 750 1430 770 {
lab=GND}
N 1210 700 1230 700 {
lab=GND}
N 1240 910 1240 930 {
lab=GND}
N 1210 720 1240 720 {
lab=Vreg}
N 1310 910 1310 920 {
lab=GND}
N 1240 920 1310 920 {
lab=GND}
N 1240 720 1310 720 {
lab=Vreg}
N 1310 720 1330 720 {
lab=Vreg}
N 860 830 860 840 {
lab=GND}
N 1380 680 1430 680 {
lab=#net1}
N 860 780 860 830 {
lab=GND}
N 860 660 860 720 {
lab=Vdd}
N 1500 660 1500 670 {
lab=Vref}
N 1210 660 1500 660 {
lab=Vref}
N 860 640 910 640 {
lab=Vdd}
N 860 640 860 660 {
lab=Vdd}
N 1240 720 1240 750 {
lab=Vreg}
N 1310 810 1310 820 {
lab=#net2}
N 1310 880 1310 910 {
lab=GND}
N 1240 810 1240 910 {
lab=GND}
N 2320 660 2320 670 {
lab=Vref1}
N 2320 730 2320 810 {
lab=GND}
N 2030 670 2200 670 {
lab=#net3}
N 2250 670 2250 680 {
lab=#net3}
N 2250 740 2250 760 {
lab=GND}
N 2030 690 2050 690 {
lab=GND}
N 2060 900 2060 920 {
lab=GND}
N 2030 710 2060 710 {
lab=Vreg1}
N 2130 900 2130 910 {
lab=GND}
N 2060 910 2130 910 {
lab=GND}
N 2060 710 2130 710 {
lab=Vreg1}
N 2130 710 2150 710 {
lab=Vreg1}
N 1680 820 1680 830 {
lab=GND}
N 2200 670 2250 670 {
lab=#net3}
N 1680 770 1680 820 {
lab=GND}
N 1680 650 1680 710 {
lab=Vdd1}
N 2320 650 2320 660 {
lab=Vref1}
N 2030 650 2320 650 {
lab=Vref1}
N 1680 630 1730 630 {
lab=Vdd1}
N 1680 630 1680 650 {
lab=Vdd1}
N 2060 710 2060 740 {
lab=Vreg1}
N 2130 710 2130 740 {
lab=Vreg1}
N 2130 800 2130 810 {
lab=GND}
N 2130 870 2130 900 {
lab=GND}
N 2130 810 2130 870 {
lab=GND}
N 2030 630 2090 630 {
lab=#net4}
N 2130 420 2130 560 {
lab=probe}
N 2080 500 2130 500 {
lab=probe}
N 2000 500 2020 500 {
lab=GND}
N 2130 640 2130 710 {
lab=Vreg1}
N 2130 620 2130 640 {
lab=Vreg1}
N 2060 800 2060 820 {
lab=GND}
N 2060 880 2060 900 {
lab=GND}
N 2060 820 2060 880 {
lab=GND}
N 2090 630 2250 630 {
lab=#net4}
N 2250 460 2250 630 {
lab=#net4}
N 2250 350 2250 460 {
lab=#net4}
N 2130 350 2130 360 {
lab=#net4}
N 1310 490 1310 750 {
lab=Vreg}
N 1210 640 1430 640 {
lab=Vreg}
N 1430 490 1430 640 {
lab=Vreg}
N 2130 350 2160 350 {
lab=#net4}
N 1310 490 1430 490 {
lab=Vreg}
N 2160 350 2250 350 {
lab=#net4}
C {devices/gnd.sym} 1500 820 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1500 710 0 0 {name=Vref value=Vref}
C {devices/vsource.sym} 1430 720 0 0 {name=Vb value=Vb}
C {devices/gnd.sym} 1430 770 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 1230 700 3 0 {name=l4 lab=GND}
C {devices/gnd.sym} 1240 930 0 0 {name=l5 lab=GND}
C {devices/isource.sym} 1310 780 0 0 {name=IL value="dc IL PULSE(10u IL 0 10n 10n 50u 100u 0)"}
C {devices/opin.sym} 1330 720 0 0 {name=p7 lab=Vreg}
C {devices/gnd.sym} 860 840 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} 860 750 0 0 {name=Vdd value="ac 1 dc Vdd "}
C {devices/lab_pin.sym} 860 660 0 0 {name=p8 sig_type=std_logic lab=Vdd}
C {ldo.sym} 1060 680 0 0 {name=x1}
C {devices/lab_pin.sym} 1500 660 2 0 {name=p9 sig_type=std_logic lab=Vref}
C {devices/code_shown.sym} 840 1330 0 0 {name=s4 only_toplevel=false 
value="
*.OPTIONS maxord=1
.OPTIONS itl1=200
.OPTIONS itl2=200
.OPTIONS itl4=200

.control
* save all voltage and current
save all 
.options savecurrents
set filetype=ascii
set units=degrees

* Loop stability
alter IL1 dc=10u
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
alter IL1 dc=10m
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

* DC sweep
dc Vdd 1 3 0.01
plot v(Vdd) v(Vreg)
wrdata ldo_tb_dc v(Vreg)

* Transient analysis with load regulation
* do not miss the space between the square bracket and number
tran 10n 100u
plot @Rdummy[i]
plot Vreg
wrdata ldo_tb_load_reg Vreg

* Transient analysis with line regulation
* at minimum load current 10uA
alter @IL[PULSE] [ 10u 10u 0 10n 10n 100u 100u 0 ]
alter @Vdd[PULSE] [ 2 3 0 1u 1u 25u 50u 0 ]
tran 10n 100u
plot Vdd
plot @Rdummy[i]
plot Vreg
wrdata ldo_tb_line_reg_minload Vreg

* at maximum load current 10mA
alter @IL[PULSE] [ 10m 10m 0 10n 10n 100u 100u 0 ]
tran 10n 100u
plot @Rdummy[i]
plot Vreg
wrdata ldo_tb_line_reg_maxload Vreg

* PSRR with max load
alter Vdd ac=1
alter Vprobe1 ac=0
ac dec 10 1 10G
plot vdb(Vreg)
wrdata ldo_tb_psrr_maxload mag(Vreg) vp(Vreg)

* PSRR with min load
alter IL dc=10u
ac dec 10 1 10G
plot vdb(Vreg)
wrdata ldo_tb_psrr_minload mag(Vreg) vp(Vreg)

* OP
op
let gmbs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gmbs]
let gm_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gm]
let gds_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gds]
let vdsat_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[vdsat]
let vth_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[vth]
let id_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[id]
let ibd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[ibd]
let ibs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[ibs]
let gbd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gbd]
let gbs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gbs]
let isub_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[isub]
let igidl_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[igidl]
let igisl_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[igisl]
let igs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[igs]
let igd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[igd]
let igb_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[igb]
let igcs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[igcs]
let vbs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[vbs]
let vgs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[vgs]
let vds_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[vds]
let cgg_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cgg]
let cgs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cgs]
let cgd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cgd]
let cbg_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cbg]
let cbd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cbd]
let cbs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cbs]
let cdg_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cdg]
let cdd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cdd]
let cds_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cds]
let csg_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[csg]
let csd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[csd]
let css_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[css]
let cgb_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cgb]
let cdb_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cdb]
let csb_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[csb]
let cbb_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[cbb]
let capbd_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[capbd]
let capbs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[capbs]
let qg_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[qg]
let qb_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[qb]
let qs_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[qs]
let qinv_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[qinv]
let qdef_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[qdef]
let gcrg_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gcrg]
let gtau_M1=@m.x1.x1.XM1.msky130_fd_pr__nfet_g5v0d10v5[gtau]

let gmbs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gmbs]
let gm_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gm]
let gds_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gds]
let vdsat_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[vdsat]
let vth_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[vth]
let id_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[id]
let ibd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[ibd]
let ibs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[ibs]
let gbd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gbd]
let gbs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gbs]
let isub_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[isub]
let igidl_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[igidl]
let igisl_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[igisl]
let igs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[igs]
let igd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[igd]
let igb_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[igb]
let igcs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[igcs]
let vbs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[vbs]
let vgs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[vgs]
let vds_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[vds]
let cgg_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cgg]
let cgs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cgs]
let cgd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cgd]
let cbg_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cbg]
let cbd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cbd]
let cbs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cbs]
let cdg_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cdg]
let cdd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cdd]
let cds_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cds]
let csg_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[csg]
let csd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[csd]
let css_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[css]
let cgb_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cgb]
let cdb_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cdb]
let csb_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[csb]
let cbb_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[cbb]
let capbd_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[capbd]
let capbs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[capbs]
let qg_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[qg]
let qb_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[qb]
let qs_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[qs]
let qinv_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[qinv]
let qdef_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[qdef]
let gcrg_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gcrg]
let gtau_M2=@m.x1.x1.XM2.msky130_fd_pr__nfet_g5v0d10v5[gtau]

let gmbs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gmbs]
let gm_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gm]
let gds_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gds]
let vdsat_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[vdsat]
let vth_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[vth]
let id_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[id]
let ibd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[ibd]
let ibs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[ibs]
let gbd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gbd]
let gbs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gbs]
let isub_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[isub]
let igidl_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[igidl]
let igisl_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[igisl]
let igs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[igs]
let igd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[igd]
let igb_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[igb]
let igcs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[igcs]
let vbs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[vbs]
let vgs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[vgs]
let vds_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[vds]
let cgg_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cgg]
let cgs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cgs]
let cgd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cgd]
let cbg_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cbg]
let cbd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cbd]
let cbs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cbs]
let cdg_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cdg]
let cdd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cdd]
let cds_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cds]
let csg_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[csg]
let csd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[csd]
let css_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[css]
let cgb_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cgb]
let cdb_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cdb]
let csb_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[csb]
let cbb_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[cbb]
let capbd_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[capbd]
let capbs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[capbs]
let qg_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[qg]
let qb_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[qb]
let qs_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[qs]
let qinv_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[qinv]
let qdef_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[qdef]
let gcrg_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gcrg]
let gtau_M3=@m.x1.x1.XM3.msky130_fd_pr__pfet_g5v0d10v5[gtau]

let gmbs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gmbs]
let gm_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gm]
let gds_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gds]
let vdsat_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[vdsat]
let vth_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[vth]
let id_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[id]
let ibd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[ibd]
let ibs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[ibs]
let gbd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gbd]
let gbs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gbs]
let isub_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[isub]
let igidl_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[igidl]
let igisl_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[igisl]
let igs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[igs]
let igd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[igd]
let igb_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[igb]
let igcs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[igcs]
let vbs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[vbs]
let vgs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[vgs]
let vds_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[vds]
let cgg_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cgg]
let cgs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cgs]
let cgd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cgd]
let cbg_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cbg]
let cbd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cbd]
let cbs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cbs]
let cdg_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cdg]
let cdd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cdd]
let cds_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cds]
let csg_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[csg]
let csd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[csd]
let css_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[css]
let cgb_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cgb]
let cdb_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cdb]
let csb_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[csb]
let cbb_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[cbb]
let capbd_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[capbd]
let capbs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[capbs]
let qg_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[qg]
let qb_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[qb]
let qs_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[qs]
let qinv_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[qinv]
let qdef_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[qdef]
let gcrg_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gcrg]
let gtau_M4=@m.x1.x1.XM4.msky130_fd_pr__pfet_g5v0d10v5[gtau]

let gmbs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gmbs]
let gm_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gm]
let gds_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gds]
let vdsat_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[vdsat]
let vth_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[vth]
let id_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[id]
let ibd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[ibd]
let ibs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[ibs]
let gbd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gbd]
let gbs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gbs]
let isub_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[isub]
let igidl_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[igidl]
let igisl_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[igisl]
let igs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[igs]
let igd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[igd]
let igb_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[igb]
let igcs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[igcs]
let vbs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[vbs]
let vgs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[vgs]
let vds_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[vds]
let cgg_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cgg]
let cgs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cgs]
let cgd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cgd]
let cbg_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cbg]
let cbd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cbd]
let cbs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cbs]
let cdg_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cdg]
let cdd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cdd]
let cds_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cds]
let csg_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[csg]
let csd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[csd]
let css_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[css]
let cgb_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cgb]
let cdb_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cdb]
let csb_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[csb]
let cbb_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[cbb]
let capbd_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[capbd]
let capbs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[capbs]
let qg_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[qg]
let qb_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[qb]
let qs_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[qs]
let qinv_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[qinv]
let qdef_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[qdef]
let gcrg_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gcrg]
let gtau_M5=@m.x1.x1.XM5.msky130_fd_pr__nfet_g5v0d10v5[gtau]

let gmbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gmbs]
let gm_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gm]
let gds_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gds]
let vdsat_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[vdsat]
let vth_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[vth]
let id_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[id]
let ibd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[ibd]
let ibs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[ibs]
let gbd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gbd]
let gbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gbs]
let isub_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[isub]
let igidl_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[igidl]
let igisl_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[igisl]
let igs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[igs]
let igd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[igd]
let igb_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[igb]
let igcs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[igcs]
let vbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[vbs]
let vgs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[vgs]
let vds_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[vds]
let cgg_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cgg]
let cgs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cgs]
let cgd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cgd]
let cbg_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cbg]
let cbd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cbd]
let cbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cbs]
let cdg_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cdg]
let cdd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cdd]
let cds_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cds]
let csg_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[csg]
let csd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[csd]
let css_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[css]
let cgb_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cgb]
let cdb_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cdb]
let csb_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[csb]
let cbb_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[cbb]
let capbd_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[capbd]
let capbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[capbs]
let qg_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[qg]
let qb_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[qb]
let qs_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[qs]
let qinv_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[qinv]
let qdef_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[qdef]
let gcrg_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gcrg]
let gtau_M6=@m.x1.XM6.msky130_fd_pr__pfet_g5v0d10v5[gtau]

write ldo_tb_op gmbs_M1 gm_M1 gds_M1 vdsat_M1 vth_M1 id_M1 ibd_M1 ibs_M1 gbd_M1 gbs_M1 isub_M1 igidl_M1 igisl_M1 igs_M1 igd_M1 igb_M1 igcs_M1 vbs_M1 vgs_M1 vds_M1 cgg_M1 cgs_M1 cgd_M1 cbg_M1 cbd_M1 cbs_M1 cdg_M1 cdd_M1 cds_M1 csg_M1 csd_M1 css_M1 cgb_M1 cdb_M1 csb_M1 cbb_M1 capbd_M1 capbs_M1 qg_M1 qb_M1 qs_M1 qinv_M1 qdef_M1 gcrg_M1 gtau_M1 gmbs_M2 gm_M2 gds_M2 vdsat_M2 vth_M2 id_M2 ibd_M2 ibs_M2 gbd_M2 gbs_M2 isub_M2 igidl_M2 igisl_M2 igs_M2 igd_M2 igb_M2 igcs_M2 vbs_M2 vgs_M2 vds_M2 cgg_M2 cgs_M2 cgd_M2 cbg_M2 cbd_M2 cbs_M2 cdg_M2 cdd_M2 cds_M2 csg_M2 csd_M2 css_M2 cgb_M2 cdb_M2 csb_M2 cbb_M2 capbd_M2 capbs_M2 qg_M2 qb_M2 qs_M2 qinv_M2 qdef_M2 gcrg_M2 gtau_M2 gmbs_M3 gm_M3 gds_M3 vdsat_M3 vth_M3 id_M3 ibd_M3 ibs_M3 gbd_M3 gbs_M3 isub_M3 igidl_M3 igisl_M3 igs_M3 igd_M3 igb_M3 igcs_M3 vbs_M3 vgs_M3 vds_M3 cgg_M3 cgs_M3 cgd_M3 cbg_M3 cbd_M3 cbs_M3 cdg_M3 cdd_M3 cds_M3 csg_M3 csd_M3 css_M3 cgb_M3 cdb_M3 csb_M3 cbb_M3 capbd_M3 capbs_M3 qg_M3 qb_M3 qs_M3 qinv_M3 qdef_M3 gcrg_M3 gtau_M3 gmbs_M4 gm_M4 gds_M4 vdsat_M4 vth_M4 id_M4 ibd_M4 ibs_M4 gbd_M4 gbs_M4 isub_M4 igidl_M4 igisl_M4 igs_M4 igd_M4 igb_M4 igcs_M4 vbs_M4 vgs_M4 vds_M4 cgg_M4 cgs_M4 cgd_M4 cbg_M4 cbd_M4 cbs_M4 cdg_M4 cdd_M4 cds_M4 csg_M4 csd_M4 css_M4 cgb_M4 cdb_M4 csb_M4 cbb_M4 capbd_M4 capbs_M4 qg_M4 qb_M4 qs_M4 qinv_M4 qdef_M4 gcrg_M4 gtau_M4 gmbs_M5 gm_M5 gds_M5 vdsat_M5 vth_M5 id_M5 ibd_M5 ibs_M5 gbd_M5 gbs_M5 isub_M5 igidl_M5 igisl_M5 igs_M5 igd_M5 igb_M5 igcs_M5 vbs_M5 vgs_M5 vds_M5 cgg_M5 cgs_M5 cgd_M5 cbg_M5 cbd_M5 cbs_M5 cdg_M5 cdd_M5 cds_M5 csg_M5 csd_M5 css_M5 cgb_M5 cdb_M5 csb_M5 cbb_M5 capbd_M5 capbs_M5 qg_M5 qb_M5 qs_M5 qinv_M5 qdef_M5 gcrg_M5 gtau_M5 gmbs_M6 gm_M6 gds_M6 vdsat_M6 vth_M6 id_M6 ibd_M6 ibs_M6 gbd_M6 gbs_M6 isub_M6 igidl_M6 igisl_M6 igs_M6 igd_M6 igb_M6 igcs_M6 vbs_M6 vgs_M6 vds_M6 cgg_M6 cgs_M6 cgd_M6 cbg_M6 cbd_M6 cbs_M6 cdg_M6 cdd_M6 cds_M6 csg_M6 csd_M6 css_M6 cgb_M6 cdb_M6 csb_M6 cbb_M6 capbd_M6 capbs_M6 qg_M6 qb_M6 qs_M6 qinv_M6 qdef_M6 gcrg_M6 gtau_M6 
.endc
"}
C {devices/code_shown.sym} 840 1250 0 0 {name=s2 only_toplevel=false value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/ldo_tb_vars.spice
"}
C {sky130_fd_pr/cap_mim_m3_1.sym} 1240 780 0 0 {name=CL model=cap_mim_m3_1 W=30 L=30 MF=M_CL spiceprefix=X}
C {devices/res.sym} 1310 850 0 0 {name=Rdummy
value=1
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 2320 810 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 2320 700 0 0 {name=Vref1 value=Vref}
C {devices/vsource.sym} 2250 710 0 0 {name=Vb1 value=Vb}
C {devices/gnd.sym} 2250 760 0 0 {name=l6 lab=GND}
C {devices/gnd.sym} 2050 690 3 0 {name=l8 lab=GND}
C {devices/gnd.sym} 2060 920 0 0 {name=l9 lab=GND}
C {devices/isource.sym} 2130 770 0 0 {name=IL1 value=IL}
C {devices/opin.sym} 2150 710 0 0 {name=p1 lab=Vreg1}
C {devices/gnd.sym} 1680 830 0 0 {name=l10 lab=GND}
C {devices/vsource.sym} 1680 740 0 0 {name=Vdd1 value=Vdd}
C {devices/lab_pin.sym} 1680 650 0 0 {name=p2 sig_type=std_logic lab=Vdd1}
C {ldo.sym} 1880 670 0 0 {name=x2}
C {devices/lab_pin.sym} 2320 650 2 0 {name=p3 sig_type=std_logic lab=Vref1}
C {sky130_fd_pr/cap_mim_m3_1.sym} 2060 770 0 0 {name=CL1 model=cap_mim_m3_1 W=30 L=30 MF=M_CL spiceprefix=X}
C {devices/vsource.sym} 2130 390 2 0 {name=Vprobe2 value="dc 0"}
C {devices/vsource.sym} 2130 590 0 0 {name=Vprobe1 value="dc 0 ac 1"}
C {devices/isource.sym} 2050 500 3 0 {name=Iprobe1 value="dc 0 ac 0"}
C {devices/gnd.sym} 2000 500 1 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 2130 480 2 0 {name=p4 sig_type=std_logic lab=probe}
C {sky130_fd_pr/corner.sym} 970 400 0 0 {name=CORNER only_toplevel=false corner=tt}

v {xschem version=3.1.0 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 640 310 660 310 {
lab=GND}
N 660 310 660 330 {
lab=GND}
N 160 320 160 330 {
lab=GND}
N 160 250 160 260 {
lab=#net1}
N 230 250 340 250 {
lab=#net1}
N 640 250 660 250 {
lab=VDD}
N 660 230 660 250 {
lab=VDD}
N 330 570 330 580 {
lab=GND}
N 330 480 330 510 {
lab=VDD}
N 640 270 690 270 {
lab=vout}
N 720 380 720 390 {
lab=GND}
N 720 290 720 320 {
lab=#net2}
N 640 290 720 290 {
lab=#net2}
N 820 380 820 390 {
lab=GND}
N 690 270 850 270 {
lab=vout}
N 820 270 820 320 {
lab=vout}
N 290 330 290 350 {
lab=GND}
N 290 270 340 270 {
lab=#net3}
N 160 250 230 250 {
lab=#net1}
C {devices/gnd.sym} 660 330 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 290 350 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 160 290 0 0 {name=V1 value="dc Vcm ac 1"}
C {devices/gnd.sym} 160 330 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 660 230 0 0 {name=l1 lab=VDD}
C {devices/vsource.sym} 330 540 0 0 {name=V2 value=1.8}
C {devices/gnd.sym} 330 580 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 330 480 0 0 {name=l1 lab=VDD}
C {devices/opin.sym} 850 270 0 0 {name=p1 lab=vout}
C {devices/vsource.sym} 720 350 0 0 {name=V3 value=Vb}
C {devices/gnd.sym} 720 390 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} 460 480 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {devices/code_shown.sym} 460 640 0 0 {name=s3 only_toplevel=false value="
.control
save all 
set filetype=ascii
set units=degrees

dc V1 0 1.8 0.01
plot v(vout)
wrdata two_stage_tb_vout_dc v(vout)

ac dec 10 1 1e10
plot mag(v(vout))
plot vdb(vout)
plot ph(v(vout))
wrdata two_stage_tb_vout_ac mag(v(vout)) ph(v(vout))

op
let gmbs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gmbs]
let gm_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gm]
let gds_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gds]
let vdsat_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[vdsat]
let vth_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[vth]
let id_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[id]
let ibd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[ibd]
let ibs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[ibs]
let gbd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gbd]
let gbs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gbs]
let isub_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[isub]
let igidl_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[igidl]
let igisl_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[igisl]
let igs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[igs]
let igd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[igd]
let igb_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[igb]
let igcs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[igcs]
let vbs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[vbs]
let vgs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[vgs]
let vds_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[vds]
let cgg_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cgg]
let cgs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cgs]
let cgd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cgd]
let cbg_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cbg]
let cbd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cbd]
let cbs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cbs]
let cdg_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cdg]
let cdd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cdd]
let cds_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cds]
let csg_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[csg]
let csd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[csd]
let css_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[css]
let cgb_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cgb]
let cdb_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cdb]
let csb_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[csb]
let cbb_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[cbb]
let capbd_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[capbd]
let capbs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[capbs]
let qg_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[qg]
let qb_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[qb]
let qs_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[qs]
let qinv_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[qinv]
let qdef_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[qdef]
let gcrg_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gcrg]
let gtau_M1=@m.x1.XM1.msky130_fd_pr__nfet_01v8[gtau]

let gmbs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gmbs]
let gm_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gm]
let gds_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gds]
let vdsat_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[vdsat]
let vth_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[vth]
let id_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[id]
let ibd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[ibd]
let ibs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[ibs]
let gbd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gbd]
let gbs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gbs]
let isub_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[isub]
let igidl_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[igidl]
let igisl_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[igisl]
let igs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[igs]
let igd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[igd]
let igb_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[igb]
let igcs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[igcs]
let vbs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[vbs]
let vgs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[vgs]
let vds_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[vds]
let cgg_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cgg]
let cgs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cgs]
let cgd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cgd]
let cbg_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cbg]
let cbd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cbd]
let cbs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cbs]
let cdg_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cdg]
let cdd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cdd]
let cds_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cds]
let csg_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[csg]
let csd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[csd]
let css_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[css]
let cgb_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cgb]
let cdb_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cdb]
let csb_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[csb]
let cbb_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[cbb]
let capbd_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[capbd]
let capbs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[capbs]
let qg_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[qg]
let qb_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[qb]
let qs_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[qs]
let qinv_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[qinv]
let qdef_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[qdef]
let gcrg_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gcrg]
let gtau_M2=@m.x1.XM2.msky130_fd_pr__nfet_01v8[gtau]

let gmbs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gmbs]
let gm_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gm]
let gds_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gds]
let vdsat_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[vdsat]
let vth_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[vth]
let id_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[id]
let ibd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[ibd]
let ibs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[ibs]
let gbd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gbd]
let gbs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gbs]
let isub_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[isub]
let igidl_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[igidl]
let igisl_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[igisl]
let igs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[igs]
let igd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[igd]
let igb_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[igb]
let igcs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[igcs]
let vbs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[vbs]
let vgs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[vgs]
let vds_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[vds]
let cgg_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cgg]
let cgs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cgs]
let cgd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cgd]
let cbg_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cbg]
let cbd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cbd]
let cbs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cbs]
let cdg_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cdg]
let cdd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cdd]
let cds_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cds]
let csg_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[csg]
let csd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[csd]
let css_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[css]
let cgb_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cgb]
let cdb_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cdb]
let csb_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[csb]
let cbb_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[cbb]
let capbd_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[capbd]
let capbs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[capbs]
let qg_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[qg]
let qb_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[qb]
let qs_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[qs]
let qinv_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[qinv]
let qdef_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[qdef]
let gcrg_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gcrg]
let gtau_M3=@m.x1.XM3.msky130_fd_pr__pfet_01v8[gtau]

let gmbs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gmbs]
let gm_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gm]
let gds_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gds]
let vdsat_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[vdsat]
let vth_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[vth]
let id_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[id]
let ibd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[ibd]
let ibs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[ibs]
let gbd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gbd]
let gbs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gbs]
let isub_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[isub]
let igidl_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[igidl]
let igisl_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[igisl]
let igs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[igs]
let igd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[igd]
let igb_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[igb]
let igcs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[igcs]
let vbs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[vbs]
let vgs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[vgs]
let vds_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[vds]
let cgg_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cgg]
let cgs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cgs]
let cgd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cgd]
let cbg_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cbg]
let cbd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cbd]
let cbs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cbs]
let cdg_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cdg]
let cdd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cdd]
let cds_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cds]
let csg_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[csg]
let csd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[csd]
let css_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[css]
let cgb_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cgb]
let cdb_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cdb]
let csb_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[csb]
let cbb_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[cbb]
let capbd_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[capbd]
let capbs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[capbs]
let qg_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[qg]
let qb_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[qb]
let qs_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[qs]
let qinv_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[qinv]
let qdef_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[qdef]
let gcrg_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gcrg]
let gtau_M4=@m.x1.XM4.msky130_fd_pr__pfet_01v8[gtau]

let gmbs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gmbs]
let gm_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gm]
let gds_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gds]
let vdsat_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[vdsat]
let vth_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[vth]
let id_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[id]
let ibd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[ibd]
let ibs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[ibs]
let gbd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gbd]
let gbs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gbs]
let isub_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[isub]
let igidl_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[igidl]
let igisl_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[igisl]
let igs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[igs]
let igd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[igd]
let igb_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[igb]
let igcs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[igcs]
let vbs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[vbs]
let vgs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[vgs]
let vds_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[vds]
let cgg_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cgg]
let cgs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cgs]
let cgd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cgd]
let cbg_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cbg]
let cbd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cbd]
let cbs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cbs]
let cdg_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cdg]
let cdd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cdd]
let cds_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cds]
let csg_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[csg]
let csd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[csd]
let css_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[css]
let cgb_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cgb]
let cdb_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cdb]
let csb_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[csb]
let cbb_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[cbb]
let capbd_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[capbd]
let capbs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[capbs]
let qg_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[qg]
let qb_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[qb]
let qs_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[qs]
let qinv_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[qinv]
let qdef_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[qdef]
let gcrg_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gcrg]
let gtau_M5=@m.x1.XM5.msky130_fd_pr__nfet_01v8[gtau]

let gmbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gmbs]
let gm_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gm]
let gds_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gds]
let vdsat_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[vdsat]
let vth_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[vth]
let id_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[id]
let ibd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[ibd]
let ibs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[ibs]
let gbd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gbd]
let gbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gbs]
let isub_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[isub]
let igidl_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[igidl]
let igisl_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[igisl]
let igs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[igs]
let igd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[igd]
let igb_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[igb]
let igcs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[igcs]
let vbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[vbs]
let vgs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[vgs]
let vds_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[vds]
let cgg_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cgg]
let cgs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cgs]
let cgd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cgd]
let cbg_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cbg]
let cbd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cbd]
let cbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cbs]
let cdg_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cdg]
let cdd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cdd]
let cds_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cds]
let csg_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[csg]
let csd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[csd]
let css_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[css]
let cgb_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cgb]
let cdb_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cdb]
let csb_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[csb]
let cbb_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[cbb]
let capbd_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[capbd]
let capbs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[capbs]
let qg_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[qg]
let qb_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[qb]
let qs_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[qs]
let qinv_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[qinv]
let qdef_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[qdef]
let gcrg_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gcrg]
let gtau_M6=@m.x1.XM6.msky130_fd_pr__pfet_01v8[gtau]

let gmbs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gmbs]
let gm_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gm]
let gds_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gds]
let vdsat_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[vdsat]
let vth_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[vth]
let id_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[id]
let ibd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[ibd]
let ibs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[ibs]
let gbd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gbd]
let gbs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gbs]
let isub_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[isub]
let igidl_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[igidl]
let igisl_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[igisl]
let igs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[igs]
let igd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[igd]
let igb_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[igb]
let igcs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[igcs]
let vbs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[vbs]
let vgs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[vgs]
let vds_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[vds]
let cgg_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cgg]
let cgs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cgs]
let cgd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cgd]
let cbg_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cbg]
let cbd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cbd]
let cbs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cbs]
let cdg_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cdg]
let cdd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cdd]
let cds_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cds]
let csg_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[csg]
let csd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[csd]
let css_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[css]
let cgb_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cgb]
let cdb_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cdb]
let csb_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[csb]
let cbb_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[cbb]
let capbd_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[capbd]
let capbs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[capbs]
let qg_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[qg]
let qb_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[qb]
let qs_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[qs]
let qinv_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[qinv]
let qdef_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[qdef]
let gcrg_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gcrg]
let gtau_M7=@m.x1.XM7.msky130_fd_pr__nfet_01v8[gtau]

print gmbs_M1 gm_M1 gds_M1 
write two_stage_tb_op gmbs_M1 gm_M1 gds_M1 vdsat_M1 vth_M1 id_M1 ibd_M1 ibs_M1 gbd_M1 gbs_M1 isub_M1 igidl_M1 igisl_M1 igs_M1 igd_M1 igb_M1 igcs_M1 vbs_M1 vgs_M1 vds_M1 cgg_M1 cgs_M1 cgd_M1 cbg_M1 cbd_M1 cbs_M1 cdg_M1 cdd_M1 cds_M1 csg_M1 csd_M1 css_M1 cgb_M1 cdb_M1 csb_M1 cbb_M1 capbd_M1 capbs_M1 qg_M1 qb_M1 qs_M1 qinv_M1 qdef_M1 gcrg_M1 gtau_M1 gmbs_M2 gm_M2 gds_M2 vdsat_M2 vth_M2 id_M2 ibd_M2 ibs_M2 gbd_M2 gbs_M2 isub_M2 igidl_M2 igisl_M2 igs_M2 igd_M2 igb_M2 igcs_M2 vbs_M2 vgs_M2 vds_M2 cgg_M2 cgs_M2 cgd_M2 cbg_M2 cbd_M2 cbs_M2 cdg_M2 cdd_M2 cds_M2 csg_M2 csd_M2 css_M2 cgb_M2 cdb_M2 csb_M2 cbb_M2 capbd_M2 capbs_M2 qg_M2 qb_M2 qs_M2 qinv_M2 qdef_M2 gcrg_M2 gtau_M2 gmbs_M3 gm_M3 gds_M3 vdsat_M3 vth_M3 id_M3 ibd_M3 ibs_M3 gbd_M3 gbs_M3 isub_M3 igidl_M3 igisl_M3 igs_M3 igd_M3 igb_M3 igcs_M3 vbs_M3 vgs_M3 vds_M3 cgg_M3 cgs_M3 cgd_M3 cbg_M3 cbd_M3 cbs_M3 cdg_M3 cdd_M3 cds_M3 csg_M3 csd_M3 css_M3 cgb_M3 cdb_M3 csb_M3 cbb_M3 capbd_M3 capbs_M3 qg_M3 qb_M3 qs_M3 qinv_M3 qdef_M3 gcrg_M3 gtau_M3 gmbs_M4 gm_M4 gds_M4 vdsat_M4 vth_M4 id_M4 ibd_M4 ibs_M4 gbd_M4 gbs_M4 isub_M4 igidl_M4 igisl_M4 igs_M4 igd_M4 igb_M4 igcs_M4 vbs_M4 vgs_M4 vds_M4 cgg_M4 cgs_M4 cgd_M4 cbg_M4 cbd_M4 cbs_M4 cdg_M4 cdd_M4 cds_M4 csg_M4 csd_M4 css_M4 cgb_M4 cdb_M4 csb_M4 cbb_M4 capbd_M4 capbs_M4 qg_M4 qb_M4 qs_M4 qinv_M4 qdef_M4 gcrg_M4 gtau_M4 gmbs_M5 gm_M5 gds_M5 vdsat_M5 vth_M5 id_M5 ibd_M5 ibs_M5 gbd_M5 gbs_M5 isub_M5 igidl_M5 igisl_M5 igs_M5 igd_M5 igb_M5 igcs_M5 vbs_M5 vgs_M5 vds_M5 cgg_M5 cgs_M5 cgd_M5 cbg_M5 cbd_M5 cbs_M5 cdg_M5 cdd_M5 cds_M5 csg_M5 csd_M5 css_M5 cgb_M5 cdb_M5 csb_M5 cbb_M5 capbd_M5 capbs_M5 qg_M5 qb_M5 qs_M5 qinv_M5 qdef_M5 gcrg_M5 gtau_M5 gmbs_M6 gm_M6 gds_M6 vdsat_M6 vth_M6 id_M6 ibd_M6 ibs_M6 gbd_M6 gbs_M6 isub_M6 igidl_M6 igisl_M6 igs_M6 igd_M6 igb_M6 igcs_M6 vbs_M6 vgs_M6 vds_M6 cgg_M6 cgs_M6 cgd_M6 cbg_M6 cbd_M6 cbs_M6 cdg_M6 cdd_M6 cds_M6 csg_M6 csd_M6 css_M6 cgb_M6 cdb_M6 csb_M6 cbb_M6 capbd_M6 capbs_M6 qg_M6 qb_M6 qs_M6 qinv_M6 qdef_M6 gcrg_M6 gtau_M6 gmbs_M7 gm_M7 gds_M7 vdsat_M7 vth_M7 id_M7 ibd_M7 ibs_M7 gbd_M7 gbs_M7 isub_M7 igidl_M7 igisl_M7 igs_M7 igd_M7 igb_M7 igcs_M7 vbs_M7 vgs_M7 vds_M7 cgg_M7 cgs_M7 cgd_M7 cbg_M7 cbd_M7 cbs_M7 cdg_M7 cdd_M7 cds_M7 csg_M7 csd_M7 css_M7 cgb_M7 cdb_M7 csb_M7 cbb_M7 capbd_M7 capbs_M7 qg_M7 qb_M7 qs_M7 qinv_M7 qdef_M7 gcrg_M7 gtau_M7 


.endc
"}
C {devices/capa.sym} 820 350 0 0 {name=C1
m=1
value=2p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 820 390 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} 460 560 0 0 {name=s2 only_toplevel=false 
value=".include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/two_stage_tb_vars.spice
"}
C {devices/vsource.sym} 290 300 0 0 {name=V4 value="dc Vcm"}
C {two_stage.sym} 490 280 0 0 {name=x1}

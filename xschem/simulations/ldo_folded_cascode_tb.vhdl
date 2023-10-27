-- sch_path: /fs1/eecg/tcc/lizongh2/sky130_ldo/xschem/ldo_folded_cascode_tb.sch
entity ldo_folded_cascode_tb is
port(
  Vreg : out std_logic ;
  Vreg1 : out std_logic
);
end ldo_folded_cascode_tb ;

architecture arch_ldo_folded_cascode_tb of ldo_folded_cascode_tb is

component ldo_folded_cascode 
port (
  Vdd : in std_logic ;
  Vfb : inout std_logic ;
  Vb3 : inout std_logic ;
  Vref : inout std_logic ;
  Vb2 : inout std_logic ;
  Vb1 : inout std_logic ;
  Vss : inout std_logic ;
  Vreg : out std_logic
);
end component ;


signal Vref : std_logic ;
signal net10 : std_logic ;
signal net11 : std_logic ;
signal net12 : std_logic ;
signal net13 : std_logic ;
signal Vdd : std_logic ;
signal Vdd1 : std_logic ;
signal Vref1 : std_logic ;
signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
signal net4 : std_logic ;
signal net5 : std_logic ;
signal net6 : std_logic ;
signal net7 : std_logic ;
signal net8 : std_logic ;
signal net9 : std_logic ;
signal GND : std_logic ;
signal probe : std_logic ;
begin
Vref : vsource
generic map (
   value => Vref
)
port map (
   p => Vref ,
   m => GND
);

IL : isource
generic map (
   value => dc IL PULSE(10u IL 0 10n 10n 50u 100u 0)
)
port map (
   p => Vreg ,
   m => net2
);

Vdd : vsource
generic map (
   value => ac 1 dc Vdd
)
port map (
   p => Vdd ,
   m => GND
);

CL : cap_mim_m3_1
generic map (
   model => cap_mim_m3_1 ,
   W => 30 ,
   L => 30 ,
   MF => M_CL ,
   spiceprefix => X
)
port map (
   c0 => Vreg ,
   c1 => GND
);

Rdummy : res
generic map (
   value => 1 ,
   footprint => 1206 ,
   device => resistor ,
   m => 1
)
port map (
   P => net2 ,
   M => GND
);

x1 : ldo_folded_cascode
port map (
   Vdd => Vdd ,
   Vfb => net7 ,
   Vb3 => net1 ,
   Vref => Vref ,
   Vb2 => net10 ,
   Vb1 => net11 ,
   Vss => GND ,
   Vreg => Vreg
);

Vref1 : vsource
generic map (
   value => Vref
)
port map (
   p => Vref1 ,
   m => GND
);

IL1 : isource
generic map (
   value => dc IL PULSE(10u IL 0 10n 10n 50u 100u 0)
)
port map (
   p => Vreg1 ,
   m => net4
);

Vdd2 : vsource
generic map (
   value => Vdd
)
port map (
   p => Vdd1 ,
   m => GND
);

CL1 : cap_mim_m3_1
generic map (
   model => cap_mim_m3_1 ,
   W => 30 ,
   L => 30 ,
   MF => M_CL ,
   spiceprefix => X
)
port map (
   c0 => Vreg1 ,
   c1 => GND
);

Rdummy1 : res
generic map (
   value => 1 ,
   footprint => 1206 ,
   device => resistor ,
   m => 1
)
port map (
   P => net4 ,
   M => GND
);

x2 : ldo_folded_cascode
port map (
   Vdd => Vdd1 ,
   Vfb => net6 ,
   Vb3 => net3 ,
   Vref => Vref1 ,
   Vb2 => net12 ,
   Vb1 => net13 ,
   Vss => GND ,
   Vreg => Vreg1
);

Vprobe2 : vsource
generic map (
   value => dc 0
)
port map (
   p => probe ,
   m => net5
);

Vprobe1 : vsource
generic map (
   value => dc 0 ac 1
)
port map (
   p => probe ,
   m => Vreg1
);

Iprobe1 : isource
generic map (
   value => dc 0 ac 0
)
port map (
   p => GND ,
   m => probe
);

Vb3 : vsource
generic map (
   value => Vb3
)
port map (
   p => net1 ,
   m => GND
);

Vb2 : vsource
generic map (
   value => Vb2
)
port map (
   p => net10 ,
   m => GND
);

Vb1 : vsource
generic map (
   value => Vb1
)
port map (
   p => net11 ,
   m => GND
);

Vb4 : vsource
generic map (
   value => Vb3
)
port map (
   p => net3 ,
   m => GND
);

Vb5 : vsource
generic map (
   value => Vb2
)
port map (
   p => net12 ,
   m => GND
);

Vb6 : vsource
generic map (
   value => Vb1
)
port map (
   p => net13 ,
   m => GND
);

R1 : res_xhigh_po_0p35
generic map (
   L => 20 ,
   model => res_xhigh_po_0p35 ,
   spiceprefix => X ,
   mult => 1
)
port map (
   M => net8 ,
   P => GND ,
   B => GND
);

R2 : res_xhigh_po_0p35
generic map (
   L => 20 ,
   model => res_xhigh_po_0p35 ,
   spiceprefix => X ,
   mult => 1
)
port map (
   M => net7 ,
   P => net8 ,
   B => GND
);

R3 : res_xhigh_po_0p35
generic map (
   L => 20 ,
   model => res_xhigh_po_0p35 ,
   spiceprefix => X ,
   mult => 1
)
port map (
   M => Vreg ,
   P => net7 ,
   B => GND
);

R4 : res_xhigh_po_0p35
generic map (
   L => 20 ,
   model => res_xhigh_po_0p35 ,
   spiceprefix => X ,
   mult => 1
)
port map (
   M => net9 ,
   P => GND ,
   B => GND
);

R5 : res_xhigh_po_0p35
generic map (
   L => 20 ,
   model => res_xhigh_po_0p35 ,
   spiceprefix => X ,
   mult => 1
)
port map (
   M => net6 ,
   P => net9 ,
   B => GND
);

R6 : res_xhigh_po_0p35
generic map (
   L => 20 ,
   model => res_xhigh_po_0p35 ,
   spiceprefix => X ,
   mult => 1
)
port map (
   M => net5 ,
   P => net6 ,
   B => GND
);

.include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/xschem/simulations/ldo_folded_cascode_tb_vars.spice


.nodeset v(Vreg)=1.8
.nodeset v(Vreg1)=1.8

.control
* high precision simulation
*.OPTIONS maxord=1
*.OPTIONS itl1=1000
*.OPTIONS itl2=1000
*.OPTIONS itl4=1000

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
set run=$&run
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

wrdata ldo_folded_cascode_tb_loop_gain_minload mag(av) vp(av)

* at max load
reset all
alter IL1 dc=10m
let runs=2
let run=0

alter @Vprobe1[acmag]=1
alter @Iprobe1[acmag]=0

dowhile run<runs
set run=$&run
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

wrdata ldo_folded_cascode_tb_loop_gain_maxload mag(av) vp(av)

* DC sweep
dc Vdd 0 3 0.01
plot v(Vdd) v(Vreg)
wrdata ldo_folded_cascode_tb_dc v(Vreg)

* Transient analysis with load regulation
* do not miss the space between the square bracket and number
tran 10n 100u
plot @Rdummy[i]
plot Vreg
wrdata ldo_folded_cascode_tb_load_reg Vreg

* Transient analysis with line regulation
* at minimum load current 10uA
*alter @IL[PULSE] [ 10u 10u 0 10n 10n 100u 100u 0 ]
*alter @Vdd[PULSE] [ 2 2.5 0 1u 1u 25u 50u 0 ]
*tran 10n 100u
*plot Vdd
*plot @Rdummy[i]
*plot Vreg
*wrdata ldo_folded_cascode_tb_line_reg_minload Vreg

* at maximum load current 10mA
*alter @IL[PULSE] [ 10m 10m 0 10n 10n 100u 100u 0 ]
*tran 10n 100u
*plot @Rdummy[i]
*plot Vreg
*wrdata ldo_folded_cascode_tb_line_reg_maxload Vreg


* PSRR with max load
alter Vdd ac=1
alter Vprobe1 ac=0
ac dec 10 1 10G
plot vdb(Vreg)
wrdata ldo_folded_cascode_tb_psrr_maxload mag(Vreg) vp(Vreg)

* PSRR with min load
alter IL dc=10u
ac dec 10 1 10G
plot vdb(Vreg)
wrdata ldo_folded_cascode_tb_psrr_minload mag(Vreg) vp(Vreg)

* OP
op
alter IL dc=10u 
.include /autofs/fs1.ece/fs1.eecg.tcc/lizongh2/sky130_ldo/python/ldo/simulations/ldo_folded_cascode_tb_dev_params.spice
.endc


end arch_ldo_folded_cascode_tb ;


-- expanding   symbol:  ldo_folded_cascode.sym # of pins=8
-- sym_path: /fs1/eecg/tcc/lizongh2/sky130_ldo/xschem/ldo_folded_cascode.sym
-- sch_path: /fs1/eecg/tcc/lizongh2/sky130_ldo/xschem/ldo_folded_cascode.sch
entity ldo_folded_cascode is
port (
  Vdd : in std_logic ;
  Vfb : inout std_logic ;
  Vb3 : inout std_logic ;
  Vref : inout std_logic ;
  Vb2 : inout std_logic ;
  Vb1 : inout std_logic ;
  Vss : inout std_logic ;
  Vreg : out std_logic
);
end ldo_folded_cascode ;

architecture arch_ldo_folded_cascode of ldo_folded_cascode is

component diff_pair_folded_cascode 
port (
  Vdd : inout std_logic ;
  Vb3 : inout std_logic ;
  Vb2 : inout std_logic ;
  vinp : in std_logic ;
  vinm : in std_logic ;
  vout : out std_logic ;
  Vb1 : inout std_logic ;
  Vss : inout std_logic
);
end component ;


signal net1 : std_logic ;
signal net2 : std_logic ;
begin
M10 : pfet_g5v0d10v5
generic map (
   L => L_pass ,
   W => W_pass ,
   nf => 1 ,
   mult => M_pass ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => Vreg ,
   G => net1 ,
   S => Vdd ,
   B => Vdd
);

x1 : diff_pair_folded_cascode
port map (
   Vdd => Vdd ,
   Vb3 => Vb3 ,
   Vb2 => Vb2 ,
   vinp => Vfb ,
   vinm => Vref ,
   vout => net1 ,
   Vb1 => Vb1 ,
   Vss => Vss
);

C1 : capa
generic map (
   m => 1 ,
   value => 1.0e-11 ,
   footprint => 1206 ,
   device => ceramic capacitor
)
port map (
   p => net2 ,
   m => Vreg
);

R1 : res
generic map (
   value => 10000 ,
   footprint => 1206 ,
   device => resistor ,
   m => 1
)
port map (
   P => net1 ,
   M => net2
);

end arch_ldo_folded_cascode ;


-- expanding   symbol:  diff_pair_folded_cascode.sym # of pins=8
-- sym_path: /fs1/eecg/tcc/lizongh2/sky130_ldo/xschem/diff_pair_folded_cascode.sym
-- sch_path: /fs1/eecg/tcc/lizongh2/sky130_ldo/xschem/diff_pair_folded_cascode.sch
entity diff_pair_folded_cascode is
port (
  Vdd : inout std_logic ;
  Vb3 : inout std_logic ;
  Vb2 : inout std_logic ;
  vinp : in std_logic ;
  vinm : in std_logic ;
  vout : out std_logic ;
  Vb1 : inout std_logic ;
  Vss : inout std_logic
);
end diff_pair_folded_cascode ;

architecture arch_diff_pair_folded_cascode of diff_pair_folded_cascode is


signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
signal net4 : std_logic ;
begin
M1 : nfet_g5v0d10v5
generic map (
   L => L_M1 ,
   W => W_M1 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => vinp ,
   S => net3 ,
   B => Vss
);

M2 : nfet_g5v0d10v5
generic map (
   L => L_M2 ,
   W => W_M2 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net2 ,
   G => vinm ,
   S => net3 ,
   B => Vss
);

M4 : pfet_g5v0d10v5
generic map (
   L => L_M4 ,
   W => W_M4 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net2 ,
   G => Vb2 ,
   S => Vdd ,
   B => Vdd
);

M3 : pfet_g5v0d10v5
generic map (
   L => L_M3 ,
   W => W_M3 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => Vb2 ,
   S => Vdd ,
   B => Vdd
);

M9 : nfet_g5v0d10v5
generic map (
   L => L_M9 ,
   W => W_M9 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net3 ,
   G => Vb1 ,
   S => Vss ,
   B => Vss
);

M6 : pfet_g5v0d10v5
generic map (
   L => L_M6 ,
   W => W_M6 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => vout ,
   G => Vb3 ,
   S => net2 ,
   B => Vdd
);

M5 : pfet_g5v0d10v5
generic map (
   L => L_M5 ,
   W => W_M5 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net4 ,
   G => Vb3 ,
   S => net1 ,
   B => Vdd
);

M7 : nfet_g5v0d10v5
generic map (
   L => L_M7 ,
   W => W_M7 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => net4 ,
   G => net4 ,
   S => Vss ,
   B => Vss
);

M8 : nfet_g5v0d10v5
generic map (
   L => L_M8 ,
   W => W_M8 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_g5v0d10v5 ,
   spiceprefix => X
)
port map (
   D => vout ,
   G => net4 ,
   S => Vss ,
   B => Vss
);

end arch_diff_pair_folded_cascode ;


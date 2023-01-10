variable		input_file string Graphene_Agar_water

units           real
boundary        p p p
newton          off
pair_style      lj/charmmfsw/coul/long 10 12
pair_modify     mix arithmetic
kspace_style    pppm 1e-6

atom_style      full
bond_style      harmonic
angle_style     charmm
dihedral_style  charmmfsw
special_bonds   charmm
improper_style  harmonic

read_data       ${input_file}.data

min_style       cg
minimize        0.0 1.0e-8 20000 100000

write_data      ${input_file}_minimized.data

variable		freq	     equal  1000
variable		restart_freq equal	${freq}*10

group	        G_Polymer	id	1:4048:1
fix             1 all nvt temp 300 300 100.0
fix	            2 G_Polymer   setforce 0 0 0

thermo          ${freq}
reset_timestep	0
thermo_style    custom time temp press etotal pe ke

dump            1 all dcd ${freq} ${input_file}_equilibrium.dcd
dump_modify     1 unwrap yes
restart			${restart_freq} ./restart/restart.*

run				1000000 # 1 ns

unfix           2
run				1000000 # 1 ns

# Bond Length
compute         1 all property/local batom1 batom2 btype
compute         2 all bond/local engpot dist
dump            2 all local ${freq} ./dump/dump.* c_1[*] c_2[*]

run				4000000 # 4 ns

write_data      ${input_file}_equilibrium.data
od_barrel = 9.6;
id_barrel = 5.3;
width_axle = 3.65;
depth_axle = 4.1;
technic_tolerance = 0.4;
thickness_technic_leg = 1.8 + technic_tolerance;
protrusion_technic_leg = 1.35 + technic_tolerance;


axle_length = 11;
middle_length = 2;
technic_length = 10;
$fn=72;

difference() {
union() {
//barrel
linear_extrude(technic_length+middle_length)
circle(d=od_barrel);
//appened an axle bit
translate([0,0,technic_length])
linear_extrude(axle_length+middle_length)
    square([width_axle,depth_axle], center = true);
}
//subtract a technics bit
linear_extrude(technic_length)
  polygon([
 [-thickness_technic_leg/2,thickness_technic_leg/2+protrusion_technic_leg],
 [thickness_technic_leg/2,thickness_technic_leg/2+protrusion_technic_leg],
 [thickness_technic_leg/2,thickness_technic_leg/2],
 [thickness_technic_leg/2+protrusion_technic_leg,thickness_technic_leg/2],
 [thickness_technic_leg/2+protrusion_technic_leg,-thickness_technic_leg/2],
 [thickness_technic_leg/2,-thickness_technic_leg/2],
 [thickness_technic_leg/2,-thickness_technic_leg/2-protrusion_technic_leg],
 [-thickness_technic_leg/2,-thickness_technic_leg/2-protrusion_technic_leg],
 [-thickness_technic_leg/2,-thickness_technic_leg/2],
 [-thickness_technic_leg/2-protrusion_technic_leg,-thickness_technic_leg/2],
 [-thickness_technic_leg/2-protrusion_technic_leg,thickness_technic_leg/2],
 [-thickness_technic_leg/2,thickness_technic_leg/2],



]);
}

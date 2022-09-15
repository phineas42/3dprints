
$fn=360;
in=25.4;

//These are good screw values for a #6 x 1-1/2" wood screw
screw_hole_diameter=9/64*in;
screw_head_diameter=9/32*in;

//Typical shank for a 1/4" bit driver
tool_access_diameter=13/32*in;

bracket_width=3/4*in;

clearance=4.25*in;
rod_hole_diameter=5/16*in;
thickness=1/4*in;

leg_length=clearance+3*rod_hole_diameter/2;

module screw_hole() {
            rotate([0,90,0]) {
            cylinder(h=thickness/2,d=screw_hole_diameter);
            translate([0,0,thickness/2])
                cylinder(h=thickness/2, d1=screw_hole_diameter, d2=screw_head_diameter);
            translate([0,0,thickness])
                cylinder(h=leg_length,d=tool_access_diameter);
        }
}

difference() {
    linear_extrude(bracket_width)
    difference() {
        union() {
            translate([0,-thickness])
                square([leg_length,thickness],center=false);
            translate([0,-leg_length])
                square([thickness,leg_length],center=false);
            polygon([
                [leg_length-sqrt(2*thickness*thickness),-thickness],
                [leg_length,-thickness],
                [thickness,-leg_length],
                [thickness,-leg_length+sqrt(2*thickness*thickness)]
            ]);
            polygon([
                [thickness,-thickness],
                [thickness+2*rod_hole_diameter,-thickness],
                [thickness,-thickness-2*rod_hole_diameter]
            ]);
            polygon([
                [clearance-3*rod_hole_diameter/2,-thickness],
                [clearance+rod_hole_diameter/2,-thickness],
                [clearance-3*rod_hole_diameter/2,-thickness-2*rod_hole_diameter]
            ]);
            polygon([
                [thickness,-(clearance-3*rod_hole_diameter/2)],
                [thickness+2*rod_hole_diameter,-(clearance-3*rod_hole_diameter/2)],
                [thickness,-(clearance+rod_hole_diameter/2)]
            ]);
        };
        translate([clearance,0])
            hull() {
                circle(d=rod_hole_diameter);
                translate([0,-rod_hole_diameter/2]) circle(d=rod_hole_diameter);
            }
    }
//screw holes
    translate([0,-(clearance-3*rod_hole_diameter/2)+tool_access_diameter/2,bracket_width/2])
        screw_hole();
    translate([0,-thickness-2*rod_hole_diameter-tool_access_diameter/2,bracket_width/2])
        screw_hole();

}
//convert two bearings into a spool roller
$fn=72; //TODO: convert this to 360 for production
hub_diameter=57.2; //spool hub inner diameter
bearing_diameter=22; //outer diameter of bearing
flange_height=8; //configurable
bearing_width=7;
total_diameter=hub_diameter+2*flange_height;
bore_diameter=8;
lip_width=0.4;
lip_height=0.6;
inner_length=62;
groove_diameter=8;
rail_width=10;
rail_thickness=2.5;
bearing_overlap=1.6; //lip width behind the bearing
taper_width=7; //how wide is the taper section behind the bearing.
taper_gap=(bearing_diameter-2*bearing_overlap)/2-bore_diameter/2; //how much to taper in radially
half_core_length=inner_length/2-taper_width;
module half_hub() {
    difference() {
        //create a cylinder for the outer ear, subtract spot for bearing.
        linear_extrude(bearing_width)
            difference() {
                circle(d=hub_diameter+2*flange_height);
                circle(d=bearing_diameter);
            };
        //cut out the ear flange
        translate([0,0,bearing_width])
            rotate_extrude()
                translate([total_diameter/2,0])
                    scale([2*flange_height,2*(bearing_width-rail_thickness)])
                        circle(d=1);
        //cut out some excess weight between bearing and hub
        translate([0,0,bearing_width])
            rotate_extrude()
                translate([bearing_diameter/2+rail_thickness+(hub_diameter/2-bearing_diameter/2-2*rail_thickness)/2,0,])
                    scale([hub_diameter/2-bearing_diameter/2-2*rail_thickness,2*(bearing_width-rail_thickness)])
                        circle(d=1);
    }
    //add a flange
    
    //continue rail surface for desired distance
    translate([0,0,bearing_width])
        linear_extrude(rail_width)
            difference() {
                circle(d=hub_diameter);
                circle(d=hub_diameter-2*rail_thickness);
            };
    //wall behind bearing
    translate([0,0,bearing_width])
        linear_extrude(rail_thickness)
            difference() {
                circle(d=bearing_diameter+2*rail_thickness);
                circle(d=bearing_diameter-2*bearing_overlap);
            }
    //shrink down to bore diameter
    rotate_extrude()
        translate([(bearing_diameter-2*bearing_overlap)/2,bearing_width+taper_width])
            intersection(){
                difference() {
                    scale([taper_gap,taper_width])
                        circle(r=1);
                    scale([taper_gap-rail_thickness,taper_width-rail_thickness])
                        circle(r=1);
                }
                translate([-total_diameter/2,-total_diameter/2]) square(total_diameter, center=true);
            }
    //inner core
    translate([0,0,bearing_width+taper_width])
    difference() {
        cylinder(h=half_core_length, d=bore_diameter+2*rail_thickness);
        cylinder(h=half_core_length, d=bore_diameter);
    }
            
}
difference() {
    union() {
        half_hub();
        %translate([0,0,2*(bearing_width+taper_width+half_core_length)])
            rotate([0,180,0])
                half_hub();
    }
    translate([-50,-100,0])
        cube(100,center=false);
}
//translate([0,0,bearing_width/2])
//difference() {
//    cylinder(h=inner_length,d=total_diameter-groove_diameter);
//    cylinder(h=inner_length,d=bearing_diameter);
//}
//mating roller
//convert two bearings into a spool roller
$fn=360; //TODO: convert this to 360 for production
hub_diameter=57.2; //spool hub inner diameter
bearing_diameter=22; //outer diameter of bearing
flange_height=8; //configurable
bearing_width=7;
total_diameter=hub_diameter+2*flange_height;
bore_diameter=8;
inner_length=62; //3d solutech spool measures 60.3mm A bit of tolerance is fine.
rail_width=10;
rail_thickness=2.5;
bearing_overlap=1.6; //lip width behind the bearing
bore_tolerance=0.8;
taper_width=7; //how wide is the taper section behind the bearing.
taper_gap=(bearing_diameter-2*bearing_overlap)/2-(bore_diameter+bore_tolerance)/2; //how much to taper in radially
half_core_length=inner_length/2+rail_thickness-bearing_width-taper_width;
tab_thickness=3;
tab_width=8.5;
tab_side_clearance=1;
tab_end_clearance=0.1;
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
                        square(1,center=true);
        //cut out some excess weight between bearing and hub
        translate([0,0,bearing_width])
            rotate_extrude()
                translate([bearing_diameter/2+rail_thickness+(hub_diameter/2-bearing_diameter/2-2*rail_thickness)/2,0,])
                    scale([hub_diameter/2-bearing_diameter/2-2*rail_thickness,2*(bearing_width-rail_thickness)])
                        circle(d=1);
            
        //mating_holes
        for(r=[90,270]) {
            linear_extrude(2*(bearing_width+taper_width+half_core_length))
                rotate([0,0,r])
                    translate([bearing_diameter/2+tab_thickness+rail_thickness,0,0])
                        square([tab_thickness*2,tab_width+tab_side_clearance],center=true);
        }
    }
    
    //continue rail surface for desired distance
    translate([0,0,bearing_width])
        linear_extrude(rail_width-bearing_width+rail_thickness)
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
    translate([0,0,bearing_width+taper_width]) {
        linear_extrude(half_core_length/2)
            difference() {
                circle(d=bore_diameter+bore_tolerance+2*rail_thickness);
                circle(d=bore_diameter+bore_tolerance);
            }
        for(r=[0,180])
            translate([0,0,half_core_length/2]) //extends beyond half-way
                linear_extrude(half_core_length)
                    difference() {
                        circle(d=bore_diameter+bore_tolerance+2*rail_thickness);
                        circle(d=bore_diameter+bore_tolerance);
                        for(r2=[45,225]) rotate([0,0,r2])
                            square(bore_diameter/2+bore_tolerance/2+rail_thickness);
                    }
    }
    //mating_sticks
    for(r=[0,180]) {
        rotate([0,0,r])
            translate([0,tab_width/2,0]) rotate([90,0,0]) linear_extrude(tab_width)
                difference() {
                    polygon([
                        [(bore_diameter+bore_tolerance)/2,bearing_width],
                        [(bore_diameter+bore_tolerance)/2,bearing_width+taper_width+3/2*half_core_length],
                        [bearing_diameter/2,bearing_width+taper_width+3/2*half_core_length],
                        [bearing_diameter/2+rail_thickness,bearing_width+taper_width+15/8*half_core_length],
                        [bearing_diameter/2+rail_thickness,bearing_width+taper_width+2*half_core_length+taper_width-rail_thickness],
                        [bearing_diameter/2+rail_thickness,2*(bearing_width+taper_width+half_core_length)+tab_end_clearance],
                        [bearing_diameter/2+rail_thickness-3/4*tab_thickness,2*(bearing_width+taper_width+half_core_length)+tab_end_clearance],
                        [bearing_diameter/2+rail_thickness,2*(bearing_width+taper_width+half_core_length)+tab_end_clearance+tab_thickness],
                        [bearing_diameter/2+rail_thickness+tab_thickness,2*(bearing_width+taper_width+half_core_length)+tab_end_clearance+tab_thickness],
                        [bearing_diameter/2+rail_thickness+tab_thickness,bearing_width+taper_width+3/2*half_core_length],
                        [bearing_diameter/2+rail_thickness+tab_thickness,0],
                        [bearing_diameter/2,0],
                        [bearing_diameter/2,bearing_width]
                    ]);
                    translate([taper_gap+(bore_diameter+bore_tolerance)/2,bearing_width+taper_width])
                        difference() {
                            translate([-total_diameter/2,-total_diameter/2]) square(total_diameter, center=true);
                            scale([taper_gap,taper_width]) circle(r=1);
                        }
                }
    }
}

translate([0,0,-rail_thickness])
difference() {
    union() {
        half_hub();
        %translate([0,0,2*(bearing_width+taper_width+half_core_length)])
            rotate([0,180,90])
                half_hub();
    }
    //translate([-50,-100,0])
    //    cube(100,center=false);
}
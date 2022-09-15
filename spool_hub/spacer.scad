//spacer
//mating roller
//convert two bearings into a spool roller
$fn=360; //TODO: convert this to 360 for production
bore_diameter=8;
rail_thickness=2.5;
bore_tolerance=0.8;
spacer_width=3*rail_thickness;
linear_extrude(spacer_width)
    difference() {
        circle(d=bore_diameter+bore_tolerance+2*rail_thickness);
        circle(d=bore_diameter+bore_tolerance);
    }

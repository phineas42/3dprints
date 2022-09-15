//convert a bearing into a pulley (or spool roller guide thingy)
//with the bevel enabled, you'll need to "pause at height" in your slicer
//with my values and slicer settings, it's a pause at layer 32, height 6.4. (bearing_width==7, lip_height==0.6, slicer layer height 0.2)
$fn=360;
bearing_diameter=22;
flange_height=4;
bearing_width=7;
total_diameter=bearing_diameter+2*flange_height;
bore_diameter=8;
lip_width=0.4;
lip_height=0.6;
difference() {
    linear_extrude(bearing_width)
        difference() {
            circle(d=total_diameter);
            circle(d=bearing_diameter);
        }
    translate([0,0,bearing_width/2])
        rotate_extrude()
            translate([total_diameter/2,0])
            circle(d=bearing_width-2);
}
module bevel() {
    bevel=[
        [bearing_diameter/2,0],
        [bearing_diameter/2-lip_width,0],
        [bearing_diameter/2,lip_height]];
    rotate_extrude()
        polygon(points=bevel);
}
/*
bevel();
translate([0,0,bearing_width])
    rotate([180,0,0])
        bevel();
*/

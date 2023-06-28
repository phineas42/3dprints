// This negative space can be combined with a Black+Decker to Ryobi adapter

internal_notch_offset = [0, 0, 0];
internal_notch_width = 10.25;
internal_notch_height = 2.505;
internal_notch_depth = 36; //34 after lower chamfer
internal_notch_translate = internal_notch_offset + [ -internal_notch_width/2, 0, -internal_notch_height];
internal_notch_chamfer = 1.000; //6 segments

slot_offset = [0, 0, -internal_notch_height];
slot_width = 15.75; //width before adding chamfer space
slot_height = 4.10;
slot_depth = 36;
slot_translate = slot_offset + [ -slot_width/2, 0, -slot_height];
//slot_width=17.875; //width at its widest point of the chamfer

external_notch_offset = slot_offset + [0, 0, -slot_height];
external_notch_width = 7.75;
external_notch_height = 22; //measured from bottom of slot
external_notch_depth = 36;
external_notch_translate = external_notch_offset + [ - external_notch_width/2, 0, -external_notch_height];

//90 degree chamfer arc of six segments
module arc() {
  intersection() {
    square();
    circle(r = 1, $fn=6*4);
  }
}

//negative chamfer arc
module narc() {
  difference() {
    square();
    circle(r = 1, $fn=6*4);
  }
}

//quarter_round module
module qr(d) {
  linear_extrude(d) arc();
}

//negative quarter round module
module nqr(d) {
  linear_extrude(d) narc();
}
module frame(width,height) {
  translate([width/2,0,height/2])rotate([0,90,180])qr(width);
  translate([-width/2,0,-height/2])rotate([0,-90,180])qr(width);
  translate([width/2,0,-height/2])rotate([0,0,180])qr(height);
  translate([-width/2,0,-height/2])rotate([0,0,-90])qr(height);
}
module nframe(width,height) {
    difference() {
        translate([-width/2,-1,-height/2])cube([width, 1, height]);
        frame(width, height);
    }
}

difference() {
  union() {
    translate(internal_notch_translate)
      cube([internal_notch_width,
            internal_notch_depth,
            internal_notch_height]);
        
    translate(slot_translate)
      cube([slot_width,
            slot_depth,
            slot_height]);

    translate(external_notch_translate)        
      cube([external_notch_width,
            external_notch_depth,
            external_notch_height]);
    //front chamfer frame
    translate(slot_offset+[0,1,-slot_height/2])
      nframe(slot_width+2,slot_height+2);
    //rear chamfer frame
      translate([0,slot_depth,0])
    rotate([0,0,180])
          translate(slot_offset+[0,1,-slot_height/2])
      nframe(slot_width+2,slot_height+2);
  }
  //lower right chamfer
  translate(external_notch_offset+[external_notch_width/2 -1,external_notch_depth,-(external_notch_height -1)])
    rotate([90,90,0])
      nqr(external_notch_depth);
  //lower left chamfer
  translate(external_notch_offset+[-(external_notch_width/2 -1),external_notch_depth,-(external_notch_height -1)])
    rotate([90,180,0])
      nqr(external_notch_depth);

}


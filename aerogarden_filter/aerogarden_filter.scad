mm=1;
in=25.4*mm;
$fn=72;
height=1.60*in;
width=1.83*in;
thickness=0.25*in;
x_hole_count=20;
y_hole_count=16;
inner_wall_width=0.6*mm;
x_outer_wall_width=2*mm;
x_wall_sum=2*x_outer_wall_width+(x_hole_count-1)*inner_wall_width;
x_hole_sum=width-x_wall_sum;
hole_diameter=x_hole_sum/x_hole_count;
echo("hole_diameter", hole_diameter);
x_first_hole_center=x_outer_wall_width+hole_diameter/2;
y_first_hole_center=x_first_hole_center+(height-width)/2-((y_hole_count-x_hole_count)/2)*(hole_diameter+inner_wall_width);

linear_extrude(thickness)
difference() {
  square([width, height]);
    for(yn=[1:y_hole_count])
      for(xn=[1:x_hole_count])
        translate([x_first_hole_center+(xn-1)*(hole_diameter+inner_wall_width), y_first_hole_center+(yn-1)*(hole_diameter+inner_wall_width), 0])
        circle(hole_diameter/2);
}

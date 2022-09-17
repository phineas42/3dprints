$fn=360;
size=25;
height=2;
linear_extrude(height)
square([size,size],center=true);

translate([size+10,0,0])
linear_extrude(height)
circle(d=size);


//measured diameter of rolling pin, measured at 2 points 90mm, 100mm end from one end.
diameter_90=39.7;
diameter_100=40.3;
diameter_largest=44.0;
//desired thickness input
rolling_thickness=20.0;

circle_diameter=rolling_thickness*2+diameter_largest;
ring_width=10;
$fn=360;
difference() {
linear_extrude(10)
  circle(d=circle_diameter);

linear_extrude(10,scale=diameter_100/diameter_90)
  circle(d=diameter_90);
}
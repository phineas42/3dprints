$fn=360;
ff=0.4; //fudge factor to provide tolerance on inner diameter
od=40.5; //outer diameter
idt=37.3; //inner diameter of teeth
odt=38.3; //outer diameter of teeth
teeth=6;
height=10.2; //overall height
tooth_height=height-1;
thickness=1.2; //thickness of end cap

//generate points for a cog with parameters
//ir: inner radius
//or: outer radius
//count: number of teeth
function cog(ir, or, count) = [
    for(a=[0:360])
        (a%(360/count)<(360/count/6)?ir:or)*[cos(a),sin(a)]
    ];

linear_extrude(height=height)
difference() {
    circle(d=od);
    circle(d=odt);
}
linear_extrude(height=tooth_height)
    difference() {
        circle(d=odt);
        polygon(cog(idt/2,odt/2,teeth));
    }
cylinder(h=thickness, d=odt);
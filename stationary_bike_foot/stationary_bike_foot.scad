$fn=360;
ff=0.4; //fudge factor to provide tolerance on inner diameter
id=38+ff; //inner diameter
idt=42.5; //inner diameter of teeth
odt=46; //outer diameter of teeth
teeth=18;
height=34; //overall height
thickness=4.0; //thickness of end cap (guessed)
//circle(ir);

//generate points for a cog with parameters
//ir: inner radius
//or: outer radius
//count: number of teeth
function cog(ir, or, count) = [
    for(a=[0:360])
        (a%(360/count)<(360/count/2)?ir:or)*[cos(a),sin(a)]
    ];

linear_extrude(height=height)
difference() {
    polygon(cog(idt/2,odt/2,teeth));
    circle(d=id);
};
cylinder(h=thickness, d=idt);
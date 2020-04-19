$inch = 25.4;


cube([96*$inch, 48*$inch, 3/4*$inch]);

translate([14*$inch,16*$inch,0]) {
    for (i=[0:2])  {
        translate([i*(27.5*$inch), 0,0]) {
            color("Red") cube([27*$inch, 32*$inch, $inch]);
        }
    }
}


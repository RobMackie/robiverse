$inch = 25.4;
$foot = $inch * 12;

color("white")  cube([8*$foot, 4*$foot, 1]);

translate([2*$foot,2*$foot,1]) {
    difference() {
        color("black") cylinder(r=19*$inch, h=0.03);
        translate([0,0,-0.01]) {
            cylinder(r=15*$inch, h=0.1);
        }
    }
}


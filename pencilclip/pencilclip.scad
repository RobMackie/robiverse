
$height=3;

$fn=16;
module shell (h, r, d) {
	hull() {
	    translate([0,0,0]) {
	       cylinder(r=r, h=h);
	    }
	    translate([d,d/6,0]) {
	       cylinder(r=r, h=h);
	    }
	    translate([d/6,d,0]) {
	       cylinder(r=r, h=h);
	    }
	}
}

translate([1,1,0]) {
    difference() {
        shell($height, 1, 5.5);
        translate([0.5,0.5,-1]) {
           shell($height+2, 0.9, 4);
        }
   }
}
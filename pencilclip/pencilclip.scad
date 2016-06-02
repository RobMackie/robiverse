
$height=3;
$rad=1;
$dist=15;

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
        shell($height, $rad, $dist);
        translate([0.5,0.5,-1]) {
           shell($height+2, 0.9*$rad, 0.85*$dist);
        }
   }
}
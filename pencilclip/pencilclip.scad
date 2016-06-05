
$height=6;
$rad=1;
$dist=15;
$inrad=3;
$indist = 5;
$frac = 0.2;

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

module pool_rack() {
	translate([1,1,0]) {
	    difference() {
	        shell($height, $rad, $dist);
	        translate([$inrad+($frac*$inrad), $inrad+($frac*$inrad), -1]) {
	           shell($height+2, $inrad, $indist);
	        }
	   }
	}
}

difference() {
    pool_rack();
	translate([-1.9,-1.9,0]) {
		scale(1.3) {
		   pool_rack();
		}
	}
}
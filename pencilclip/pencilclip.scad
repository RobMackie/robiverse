
$height=10;
$rad=1;
$dist=15;
$inrad=3;
$indist = 5;
$frac = 0.2;
$clip_h = 35;

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

module main_body() {
	difference() {
	    pool_rack();
		translate([-1.9,-1.9,0]) {
			scale(1.3) {
			   pool_rack();
			}
		}
	}
}

module spring() {
    translate([10,10,0]) {
       rotate([0,0,-45]) {
           translate([-3.7, 0, 0]) {
              union() {
			       hull() {
			          translate([0, 0, 0]) {
			              cylinder(r=0.5,h=$clip_h);
			          }
			          translate([$dist*.5, 0, 0]) {
			              cylinder(r=0.5,h=$clip_h);
			          }
			       }
                  translate([0,-0.5,$clip_h-2]) {
                      rotate([0,90,0]) {
                          cylinder(r=1, h=$dist*.5);
                      }
                  }
              }
           }
       }
    }
}

union() {
    main_body();
    spring();
}



















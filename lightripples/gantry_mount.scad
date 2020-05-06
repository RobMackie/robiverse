$fa=1;
$fs=1;



module build_it2() {
   cube([80,10,4]);
}

module build_it() {
	difference() {
		union() {
	      translate([10,0,0]) {
				cube([100, 10, 4]);
			   translate([50,5,-1]) {
				   cylinder(r=30, h=6);
				}
	      }
	      translate([0,4,0]) {
	          cube([15,2,4]);
	      }
	      translate([105,4,0]) {
	          cube([15,2,4]);
	      }
		}
	   translate([60,5,-2]) {
	      cylinder(r=22, h=8);
	   }
	}
}

$2d = 1;
if ($2d) {
    projection(cut=true) {
      /* translate([0,30,0]) rotate([0,0,0]) {
           build_it();
       } */
       translate([0,30,0]) rotate([0,0,0]) {
           build_it();
       }
    }
} else {
   translate([0,30,0]) rotate([0,0,0]) {
      build_it();
   }
}
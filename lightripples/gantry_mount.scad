$fa=1;
$fs=1;



module build_it() {
   cube([80,10,4]);
}

module build_it2() {
	difference() {
		union() {
	      translate([5,0,0]) {
				cube([100, 10, 4]);
			   translate([50,5,-1]) {
				   cylinder(r=30, h=6);
				}
	      }
	      translate([0,4,0]) {
	          cube([10,2,4]);
	      }
	      translate([100,4,0]) {
	          cube([10,2,4]);
	      }
		}
	   translate([55,5,-2]) {
	      cylinder(r=20, h=8);
	   }
	}
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
           build_it();
       }
    }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      build_it();
   }
}
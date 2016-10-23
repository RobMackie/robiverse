$fa=1;
$fs=1;



module build_it2() {
   cube([80,10,4]);
}

module containment_ring() {
   difference() {
		union() {
		   translate([55,55,0]) {
		       cylinder(r=60, h=2);
		   }
         translate([50,-15,0]) {
            cube([10,20,7]);
         }
         translate([54,-25,0]) {
            cube([2,15,7]);
         }
         translate([50,105,0]) {
            cube([10,20,7]);
         }
         translate([54,120,0]) {
            cube([2,15,9]);
         }
      }
      translate([55,55,-1]) {
	       cylinder(r=51, h=4);
      }
      translate([-2,53,-1]) {
         cube([5,1.6,4]);
      }
      translate([-2,56,-1]) {
         cube([5,1.6,4]);
      }
      translate([107,53,-1]) {
         cube([5,1.6,7]);
      }
      translate([107,56,-1]) {
         cube([5,1.6,7]);
      }
   }
}

module build_it() {
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
	      cylinder(r=22, h=8);
	   }
	}
}



$2d = 1;
if ($2d) {
    projection(cut=true) {
/*
		   translate([0,50,0]) rotate([0,0,0]) {
		      build_it();
		   }
*/
		   translate([30,70,0]) rotate([0,0,0]) {
		       containment_ring();
		   }
   }
} else {
   /*
   translate([0,50,0]) rotate([0,0,0]) {
		 build_it();
   }
   */
   translate([15,65,0]) rotate([0,0,0]) {
       containment_ring();
   }
}
$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

module arm() {
   translate([10,10,0]) {
      difference () {
	  	   hull() {
		      translate([0,0,0]) {
			      cylinder(r=10, h=5);
		      }
		      translate([250,0,0]) {
			      cylinder(r=10, h=5);
		      }
		      translate([125,50,0]) {
			      cylinder(r=10, h=5);
		      }
		   }
         translate([0,0,-1]) {
		  	   hull() {
			      translate([15,-8, 0]) {
				      cylinder(r=5, h=7);
			      }
			      translate([235,-8,0]) {
				      cylinder(r=5, h=7);
			      }
			      translate([125,25,0]) {
				      cylinder(r=5, h=7);
			      }
			   }
         }
         translate([125,50,-1]) {
            cylinder(r=2.5, h=7);
         }
         translate([0,0,-1]) {
            cylinder(r=2.5, h=7);
         }
         translate([250,0,-1]) {
            cylinder(r=2.5, h=7);
         }
      }
   }

}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
          arm();
       }
    }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      arm();
   }
}


$fa=1;
$fs=1;

$inch = 25.4;

module build_it() {
	difference() {
		union() {
		   translate([7*$inch,4*$inch,0]) {
	         cylinder(r=$inch * 4, h=4);
	      }
	      translate([0,0,0]) {
	         cube([7*$inch,8*$inch,4]);
	      }
		}
	   translate([7*$inch,4*$inch,-1]) {
	      cylinder(r=$inch * 2.95, h=6);
	   }
	}
}

$2d=1;

if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) {
          build_it();
       }
    }
} else {
    translate([0,0,0]) {
       build_it();
    }

}
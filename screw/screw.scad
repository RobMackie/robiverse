$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;
$fn=32;

$2d = 0;
//--------------------------------------------------
// foo

//--------------------------------------------------
module make_screw() {
    union() {
       // section 1
       hull() {
		    translate([0,0,0]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
		    translate([0,5,10]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
       }
       // section 2
       hull() {
		    translate([0,5,10]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
		    translate([5,0,20]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
       }
       // section 3
       hull() {
		    translate([5,0,20]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
		    translate([0,-5,30]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
       }
       // section 4
       hull() {
		    translate([0,-5,30]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
		    translate([-5,0,40]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
       }
       // section 5
       hull() {
		    translate([-5,0,40]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
		    translate([0,0,50]) {
		       rotate([0,0,0]) {
		          cylinder(r=10, h=1);
		       }
		    }
       }
    }
}



module make_parts() {
  make_screw();
}

//--------------------------------------------------
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
          make_parts();
       }
    }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      make_parts();
   }
}

$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$diameter=4.5;
$radius=4.1/2;

// $x_delta = 35.7 // too big
// $x_delta=34; // a bit tight
$x_delta=35;

$y_delta=64;

$fn=32;

module holes() {
   translate([0,0,-1]) {
       cylinder(r=$radius, h=10);
   }
   translate([$x_delta,0,-1]) {
       cylinder(r=$radius, h=10);
   } 
   translate([0,$y_delta,-1]) {
       cylinder(r=$radius, h=10);
   }
   translate([$x_delta, $y_delta,-1]) {
       cylinder(r=$radius, h=10);
   }
}


module base_plate () {

   difference() {
        cube([60, 80, $eigth]);
        translate([(60-$x_delta)/2, (80-$y_delta)/2,-1]) {
           holes();
        }
   }
}

module make_pattern() {
    for(a=[0,1,2,3]) {
	    for(b=[0,1,2]) {
	       translate([a*65, b*85,0]) rotate([0,0,0]) {
	          base_plate();
	       }
	    }
    }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
          make_pattern();
       }
    }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      make_pattern();
   }
}


// openscad = http://www.openscad.org/downloads.html

$2d = 0;  // Openscad directions:
          // set this to "$2d = 1;" to get a profile for a dxf
          // then go to menu option "Design" and choose
          // "Compile and Render" then when you get the flat
          // drawing, go to "Design" and choose export as dxf
          // or set "$2d = 0"; and "Export as STL"

// Conveniences:
$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;



$height=10;
$main_radius=50;
$pen_radius = 10.5/2;

$offset = $main_radius-$pen_radius/1.5;
$motor_radius = 27.44/2;

$fn=128;

module make_parts() {
	translate([0,0,0]) {
      union () {
	      difference () {
	         cylinder(r=$main_radius, h=$height);
	         translate([0,0,-1]) {
	            cylinder(r=$motor_radius, $height+2);
	         }
	         translate([$offset-4,-20,-1]) {
	            cylinder(r=$pen_radius, $height+2);
	         }
	         translate([0,$offset,-1]) {
	            cylinder(r=$pen_radius, $height+2);
	         }
	         translate([-$offset+4,-20,-1]) {
	            cylinder(r=$pen_radius, $height+2);
	         }
	         translate([-$offset+4,-10,-1]) {
	            cylinder(r=$pen_radius, $height+2);
	         }
	      }
         translate([-15,-40,10]) {
	         difference () {
	            cube([30,20,20]);
               translate([(30-26)/2,-1,0]) {
                  cube([26, 22, 17]);
               }
	         }
         }
      }
   }
}


if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
    }
} else {
    make_parts();
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}
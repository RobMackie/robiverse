$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$fn=128;

$in_radius = 35;
$out_radius = 100;

$tooth_count = 5;

$inner_tooth_r = 0.3 * (($in_radius * 3.14159)/$tooth_count);
$outer_tooth_r = 1.05 * (($out_radius * 3.14159)/$tooth_count);

module gear_plate() {
   difference() {
	   union() {
			cylinder(r=$out_radius, h=14);   
		   cylinder(r=$in_radius, h=14);
	   }
      translate([0,0,-1]) {
		    cylinder(r=3.175, h=18);
      }

      for (i = [1 : $tooth_count]) {
         rotate([0,0,i * 360/$tooth_count]) {
	         translate([0,-$out_radius*1.1, -1]) {
                hull() {
                	cylinder(r= $outer_tooth_r, h=18);
               	 	translate([0, ($out_radius-$in_radius), 0]) {
	                    cylinder(r= $inner_tooth_r, h=18);
	                }
                }
	         }
         }
      }
   }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([$out_radius,$out_radius,0]) rotate([0,0,0]) {
          gear_plate($plate_long, $plate_wide);
       }
    }
} else {
   translate([$out_radius, $out_radius,0]) rotate([0,0,0]) {
      gear_plate($plate_long, $plate_wide);
   }
}


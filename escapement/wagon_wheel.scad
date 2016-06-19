$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$fn=128;

$in_radius = 45;
$out_radius = 120;

$tooth_count = 11;

$inner_tooth_r = 0.5 * (($in_radius * 3.14159)/$tooth_count);
//.15 * ($out_radius - $in_radius);
$outer_tooth_r = 1.09 * (($out_radius * 3.14159)/$tooth_count);

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
	            // cube([10, $out_radius-$in_radius, 18]);
                difference() {
                	hull() {
	                	cylinder(r= $outer_tooth_r, h=18);
		                translate([0, ($out_radius-$in_radius), 0]) {
		                    cylinder(r= $inner_tooth_r, h=18);
		                }
	                }
                   translate([0,0,-1]) {
                       cylinder(r=40, h=20);
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
       translate([0,0,0]) rotate([0,0,0]) {
          gear_plate($plate_long, $plate_wide);
       }
    }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      gear_plate($plate_long, $plate_wide);
   }
}


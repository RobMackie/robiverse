// test

$fn=128;


// Cyndrical housing
$radius = 25.4*2;
$height = 25.4*2;
$wall_thick = 10;

// Rail  
//  5 mm for the material of the rail walls (walls touch at 5mm) + 5 for gap
$rail_width = 5 + 5;
$rail_depth = 16;
$rail_wall = 5;
$slot_clearance = 2;


module build_shell() {
	difference () {
	   cylinder(r=$radius, h=$height);
	   translate([0,0,-1]) {
	      cylinder(r=$radius-$wall_thick/2, h=$height+2);
	   }
	}
}

module build_rail() {
    difference() {
		translate([-$rail_width/2, -$rail_depth/2, 0]) {
          cube([$rail_width, $rail_depth, $height]);
       }
       translate([-($rail_width-$rail_wall)/2, -$rail_depth/4 -1,-1]) { 
          cube([$rail_width-$rail_wall,$rail_depth-$rail_wall+$rail_depth/4,$height+2]); 
       }
       // slot inverted 
       translate([-8,2,5]) {
          cube([$rail_width+8,$slot_clearance, $height-10]); 
       }
    }
}

module build_housing () {
   union() {
      build_shell();
      // -x direction rail
      translate([0,-$radius+$rail_depth-6,0]) {
         build_rail();
      }
      // counter-clockwise rail
      rotate([0,0,120]) {
      	translate([0,-$radius+$rail_depth-6,0]) {
	         build_rail();
	      }
      }
      // clockwise rail
      rotate([0,0,-120]) {
      	translate([0,-$radius+$rail_depth-6,0]) {
	         build_rail();
	      }
      }
   }
}


build_housing();

// test

$fn=128;


// Cyndrical housing
$radius = 25.4*2.5;
$height = 25.4*4.5;
$wall_thick = 10;

// Rail
$rail_width = 30;
$rail_depth = 20;
$rail_wall = 5;


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
    }

}

module build_housing () {
   union() {
      build_shell();
      // -x direction rail
      translate([0,-$radius+$rail_depth-8,0]) {
         build_rail();
      }
      // clockwise rail
      // counter-clockwise rail
   }
}


build_housing();

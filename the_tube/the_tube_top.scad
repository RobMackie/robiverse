// test

$fn=128;

$radius = 25.4*2.5;
$height = 25.4*4.5;
$wall_thick = 10;


module build_shell() {
	difference () {
	   cylinder(r=$radius, h=$height);
	   translate([0,0,-1]) {
	      cylinder(r=$radius-$wall_thick/2, h=$height+2);
	   }
	}
}

build_shell();

